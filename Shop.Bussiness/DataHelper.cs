using System;
using System.Web;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Reflection;
using Shop.Model;
using Shop.Tools;
using Shop.DataAccess;

namespace Shop.Bussiness
{
    /// <summary>
    /// ���ݷ�����
    /// </summary>
    public class DataHelper : System.Web.UI.Page
    {

        private static string Ref;
        public DataHelper()
        {
        }

        #region ���䷽ʽ�����ݸ��·���
        public static string Execute(string Target, string KeyName, string KeyValue, string Action,bool IsAdmin)
        {
            Ref = RequestTool.GetUrlReferrerNoParas();
            string Msg = "";
            Action = Action.ToLower();
            if (Msg == "")
            {
                switch (Action)
                {
                    case "add":
                        Msg = Save(Target, KeyName, KeyValue, Action, IsAdmin);
                        break;
                    case "update":
                        Msg = Save(Target, KeyName, KeyValue, Action, IsAdmin);
                        break;
                    case "del":
                        Msg = Delete(Target, KeyName, KeyValue, IsAdmin);
                        break;
                }
            }
            return Msg;
        }

        public static string Execute(string Target, string KeyName, string KeyValue, string Action)
        {

            return Execute(Target, KeyName, KeyValue, Action, false);
        }
        public static string Execute(string Target, string KeyName, string Action)
        {

            return Execute(Target, KeyName, "", Action,false);
        }

        //ɾ������
        public static string Delete(string TableName, string KeyName, string KeyValue, bool IsAdmin)
        {

            PropertyInfo property = null;
            List<string> ids = new List<string>();

            if (KeyValue != "")
            {
                ids = StringTool.SplitStringList(KeyValue, ",");
            }
            else
            {
                if (HttpContext.Current.Request[KeyName] != null)//�ύ�����������ֵ
                {
                    ids = StringTool.SplitStringList(RequestTool.GetFormString(KeyName), ",");
                }
                else
                {
                    return "��������";
                }
            }
            if (!string.IsNullOrEmpty(TableName) && ids.Count > 0)
            {
                Type modelType = BLLBase.GetObjectType(TableName);
                Type bllType = BLLBase.GetBLLObjectType(TableName);
                MethodInfo methodInfo = bllType.GetMethod("Delete");
                object Newobj = Activator.CreateInstance(bllType);
                if (methodInfo != null)
                {
                    object objid = null;
                    foreach (string id in ids)
                    {
                        property = modelType.GetProperty(KeyName);
                        if (property != null)
                        {
                            objid = GetTypeValue(property.PropertyType.Name, Convert.ToString(id));
                            //if (TableName != "CZ_Log" && IsAdmin)
                                //LOG.Instance.AddLog(TableName, id, "ɾ��", "", Ref, 0);//��Ӳ�����¼
                        }
                        object[] paras = new object[] { objid };
                        var execute = methodInfo.Invoke(Newobj, paras);
                    }

                }
            }
            else
            {
                return "��������";
            }
            return "OK";
        }
        /// <summary>
        /// �������
        /// </summary>
        /// <param name="KeyName">������</param>
        /// <param name="TableName">���ݱ�����</param>
        /// <returns></returns>
        public static string Save(string TableName, string KeyName, string KeyValue, string Action, bool IsAdmin)
        {
            string Msg = "";
            string Key = KeyValue;//����ID
            Type bllType = BLLBase.GetBLLObjectType(TableName);
            MethodInfo methodInfo = null;
            Type modelType = BLLBase.GetObjectType(TableName);
            object Newobj = Activator.CreateInstance(bllType);
            PropertyInfo property = null;
            if (bllType == null || modelType == null)
            {
                Msg = "δ�ҵ����ʵķ���";

            }
            else
            {
                //-------------------------------------------------------------------------------

                bool FlagAdd = true;
                object model = null;

                object id = Key;

                if (Key == "")
                {
                    id = HttpContext.Current.Request[KeyName];
                    Key = (string)id;
                }


                if (Action == "update")//�޸ĵķ���
                {
                    //����ύ������ֵ���Ͷ�MODEL��ֵ

                    methodInfo = bllType.GetMethod("GetModel");
                    if (methodInfo != null)
                    {
                        property = modelType.GetProperty(KeyName);
                        if (property != null)
                        {
                            id = GetTypeValue(property.PropertyType.Name, Convert.ToString(id));
                        }
                        model = methodInfo.Invoke(Newobj, new object[] { id });
                        FlagAdd = false;
                    }


                }
                else//if(Action == "Add")
                {
                    FlagAdd = true;
                }
                //------------------------------------------------------------------------------

                if (FlagAdd)
                    model = Activator.CreateInstance(modelType);
                if (model == null)
                {
                    Msg = "�����쳣��δ�ܰ�����ʵ��";
                }
                else
                {
                    //Set New value
                    var postData = HttpContext.Current.Request.Form.AllKeys;

                    foreach (var paras in postData)
                    {
                        property = modelType.GetProperty(paras);
                        if (property != null)
                        {

                            object v = GetFormTypeValue(property.PropertyType.Name, paras);
                            property.SetValue(model, Convert.ChangeType(v, property.PropertyType, CultureInfo.CurrentCulture), null);

                        }
                    }
                    if (FlagAdd)
                    {
                        methodInfo = bllType.GetMethod("Add");

                        object[] saveParas = new object[] { model };
                        var execute = methodInfo.Invoke(Newobj, saveParas);

                        string newid = Common.GetValue("select Max(" + KeyName + ") from " + TableName + "");//ȡ������ID�����¼�¼��ID
                        Key = newid;
                        //if (IsAdmin)
                        //LOG.Instance.AddLog(TableName, newid, "���", "", Ref, 0);//��Ӳ�����¼
                    }
                    else
                    {
                        methodInfo = bllType.GetMethod("Update");
                        object[] saveParas = new object[] { model };
                        var execute = methodInfo.Invoke(Newobj, saveParas);
                        //if (IsAdmin)
                        //LOG.Instance.AddLog(TableName, id.ToString(), "����", "", Ref, 0);//��Ӳ�����¼
                    }



                    Msg = "OK";
                }

            }
            Msg = "{err:'" + Msg + "',ID:'" + Key + "'}";
            return Msg;
        }


        /// <summary>
        /// ����MODEL���������ͣ��Բ���������Ӧת��
        /// </summary>
        /// <param name="typeName"></param>
        /// <param name="Value"></param>
        /// <returns></returns>
        private static object GetTypeValue(string typeName, string Value)
        {
            typeName = typeName.ToLower();
            object v = null;
            switch (typeName)
            {
                case "int32":
                    v = TypeParseHelper.StrToInt(Value, 0);
                    break;
                case "int64":
                    v = TypeParseHelper.StrToLong(Value, 0);
                    break;
                case "boolean":
                    v = TypeParseHelper.StrToBool(Value, false);
                    break;
                case "decimal":
                    v = TypeParseHelper.StrToDecimal(Value, 0);
                    break;
                case "float":
                    v = TypeParseHelper.StrToFloat(Value, 0);
                    break;
                case "datetime":
                    v = TypeParseHelper.StrToDateTime(Value, DateTime.MinValue);
                    break;
                default:
                    v = Convert.ToString(Value);
                    break;
            }
            return v;
        }
        /// <summary>
        /// ����MODEL���������ͣ���ȡ�������Բ���������Ӧת��
        /// </summary>
        /// <param name="typeName"></param>
        /// <param name="Value"></param>
        /// <returns></returns>
        private static object GetFormTypeValue(string typeName, string paras)
        {
            typeName = typeName.ToLower();
            object v = null;
            switch (typeName)
            {
                case "int32":
                    v = RequestTool.GetFormInt(paras, 0);
                    break;
                case "int64":
                    v = RequestTool.GetFormLong(paras, 0);
                    break;
                case "boolean":
                    v = RequestTool.RequestBool(paras);
                    break;
                case "decimal":
                    v = RequestTool.GetFormDecimal(paras, 0);
                    break;
                case "float":
                    v = RequestTool.GetFormFloat(paras, 0);
                    break;
                case "datetime":
                    v = RequestTool.GetFormDataTime(paras, DateTime.MinValue);
                    //v = RequestTool.GetERPDataTime(paras, DateTime.MinValue);

                    break;
                default:
                    v = RequestTool.GetFormString(paras);
                    break;
            }
            return v;
        }
        #endregion
    }

}