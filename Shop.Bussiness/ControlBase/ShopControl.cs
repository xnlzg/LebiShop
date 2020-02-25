using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Reflection;
using System.Globalization;
using Shop.Model;
using Shop.Tools;
using System.Linq;
using System.Collections.Specialized;
using System.Web.Script.Serialization;

namespace Shop.Bussiness
{
    /// <summary>
    /// ǰ̨ҳ���ֱ�Ӻ�̨�ļ�
    /// </summary>

    public class ShopControl : System.Web.UI.UserControl
    {
        protected string reqPage = "";//��ǰҳ��ĵ�ַ
        protected string refPage = "";//��Դҳ��ĵ�ַ
        protected string Table = "";
        protected string Where = "";
        protected string Order = "";
        protected int PageSize = 1;
        protected int page = 1;
        protected int RecordCount = 0;

        //protected int CurrentLanguageID = 0;
        //protected string CurrentLanguage = "";
        protected Lebi_Language CurrentLanguage_ = null;
        protected Lebi_Theme CurrentTheme_ = null;
        protected Lebi_User CurrentUser;
        protected Lebi_UserLevel CurrentUserLevel;
        //protected Lebi_Currency CurrentCurrency;
        protected BaseConfig SYS;
        protected string WebPath;
        protected ShopControl()
        {
            SYS = ShopCache.GetBaseConfig();
            //CurrentLanguage_ = B_Lebi_Language.GetList("Code='CN'", "").FirstOrDefault();
            //CurrentTheme_ = new Lebi_Theme();
            CurrentUser = EX_User.CurrentUser();
            CurrentUserLevel = B_Lebi_UserLevel.GetModel("id=" + CurrentUser.UserLevel_id + "");
            if (CurrentUserLevel == null)
            {
                CurrentUserLevel = B_Lebi_UserLevel.GetList("", "Grade desc").FirstOrDefault();
                if (CurrentUserLevel == null)
                {
                    CurrentUserLevel = new Lebi_UserLevel();
                    Log.Add("��Ա��������", "User_id=" + CurrentUser.id.ToString());
                }
            }
            WebPath = RequestTool.GetConfigKey("WebPath");
            WebPath = WebPath == "/" ? "" : WebPath;
            if (WebPath != "")
            {
                int h = WebPath.Length;
                if (WebPath.LastIndexOf("/") == h - 1)
                    WebPath = WebPath.Remove(h - 1);
            }
        }
        #region ������ҳ��
        /// <summary>
        /// ����·��
        /// </summary>
        protected string LanguagePath
        {
            get
            {
                string lang = CurrentLanguage.Path;
                if (lang == "/")
                    lang = "";
                return lang;
            }
        }
        /// <summary>
        /// ��ǰҳ��
        /// </summary>
        protected Lebi_Theme_Page CurrentPage;
        /// <summary>
        /// ��ǰ����
        /// </summary>
        protected Lebi_Theme CurrentTheme
        {
            get
            {
                if (CurrentTheme_ != null)
                    return CurrentTheme_;
                if (Session["CurrentTheme"] != null)
                    return Session["CurrentTheme"] as Lebi_Theme;
                return new Lebi_Theme();
            }
        }
        /// <summary>
        /// ��ǰ����
        /// </summary>
        protected Lebi_Currency CurrentCurrency
        {
            get
            {
                return Language.CurrentCurrency(CurrentLanguage);
            }
        }
        /// <summary>
        /// ��ǰ����
        /// </summary>
        protected Lebi_Language CurrentLanguage
        {
            get
            {
                if (CurrentLanguage_ != null)
                    return CurrentLanguage_;
                if (Session["CurrentLanguage"] != null)
                    return Session["CurrentLanguage"] as Lebi_Language;
                return B_Lebi_Language.GetList("Code='CN'", "").FirstOrDefault();
            }
        }
        /// <summary>
        /// ��������
        /// </summary>
        /// <param name="code"></param>
        public void LoadTheme(string tcode, string pcode)
        {
            CurrentTheme_ = B_Lebi_Theme.GetList("Code='" + tcode + "'", "").FirstOrDefault();
            CurrentLanguage_ = B_Lebi_Language.GetList("Code='" + CurrentTheme.Language + "'", "").FirstOrDefault();
            Session["CurrentTheme"] = CurrentTheme_;//session��Ҫ��Ϊ��Щû��LoadTheme������ҳ�����ģ���ajax
            Session["CurrentLanguage"] = CurrentLanguage_;
            CurrentPage = B_Lebi_Theme_Page.GetModel("Code='" + pcode + "'");

        }
        /// <summary>
        /// ����ǰ̨ͼƬ
        /// </summary>
        /// <param name="imageold"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public string ProImg(string imageold, string type)
        {
            string ret = "";
            int width = 0;
            int height = 0;
            switch (type.ToLower())
            {
                case "small":
                    width = CurrentTheme.ImageSmall_Width;
                    height = CurrentTheme.ImageSmall_Height;
                    break;
                case "medium":
                    width = CurrentTheme.ImageMedium_Width;
                    height = CurrentTheme.ImageMedium_Height;
                    break;
                case "big":
                    width = CurrentTheme.ImageBig_Width;
                    height = CurrentTheme.ImageBig_Height;
                    break;
            }
            ret = imageold.Replace("w$h", width + "$" + height);
            if (!ImageHelper.IsExists(ret))
            {
                switch (type.ToLower())
                {
                    case "small":
                        width = SYS.ImageBigWidth;
                        height = SYS.ImageSmallHeight;
                        break;
                    case "medium":
                        width = SYS.ImageMediumWidth;
                        height = SYS.ImageMediumHeight;
                        break;
                    case "big":
                        width = SYS.ImageBigWidth;
                        height = SYS.ImageBigHeight;
                        break;
                }
            }
            ret = imageold.Replace("w$h", width + "$" + height);
            return ret;
        }
        /// <summary>
        /// ����ͼƬ·��
        /// </summary>
        /// <param name="img"></param>
        /// <returns></returns>
        public string Image(string img)
        {
            return WebPath + img;
        }
        #endregion
        #region ����url
        public string URL(string code, string para)
        {
            return ThemeUrl.GetURL(code, para, "", CurrentTheme, CurrentLanguage);
        }
        public string URL(string code, int para)
        {
            return ThemeUrl.GetURL(code, para.ToString(), "", CurrentTheme, CurrentLanguage);
        }
        public string URL(string code, string para, string url)
        {
            return ThemeUrl.GetURL(code, para, url, CurrentTheme, CurrentLanguage);
        }
        public string URL(string code, int para, string url)
        {
            return ThemeUrl.GetURL(code, para.ToString(), url, CurrentTheme, CurrentLanguage);
        }
        #endregion
        #region ������ȡ
        public int Rint(string KeyName)
        {
            return RequestTool.RequestInt(KeyName, 0);
        }
        public string Rstring(string KeyName)
        {
            return StringTool.HtmlFiltrate(RequestTool.RequestString(KeyName));
        }
        public string Rstring_Para(string para)
        {
            string key = "&" + CurrentPage.PageParameter;
            key = RegexTool.GetRegValue(key, @"&(.*?)=\{" + para + @"\}");
            return Rstring(key);
        }
        public int Rint_Para(string para)
        {
            string key = "&" + CurrentPage.PageParameter;
            key = RegexTool.GetRegValue(key, @"&(.*?)=\{" + para + @"\}");
            return Rint(key);
        }
        /// <summary>
        /// ���ݽ����뷵�ؽ��
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public Lebi_Node Node(string code)
        {
            return NodePage.GetNodeByCode(code);

        }
        #endregion
        #region ����HTML
        public string RemoveHtml(string strIn)
        {
            strIn = StringTool.FilterAll(strIn);

            return strIn;
        }
        public string Sub(string strIn, int len)
        {
            if (strIn.Length > len)
            {
                strIn = strIn.Substring(0, len);
            }
            return strIn;
        }
        #endregion
        #region �����ҳ
        public string Pager(string para)
        {
            return Shop.Bussiness.Pager.GetPaginationStringForWeb("?page={0}" + para, page, PageSize, RecordCount, CurrentLanguage);
        }
        public string Pager()
        {
            return Pager("");
        }
        #endregion
        #region ����
        /// <summary>
        /// ҳ�����
        /// </summary>
        public void PageError()
        {
            Response.Write("��������");
            Response.End();
        }
        /// <summary>
        /// ��������
        /// </summary>
        /// <param name="content"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        public string Lang(string content)
        {
            return Language.Content(content, CurrentLanguage.Code);
        }
        /// <summary>
        /// �������Ա�ǩ
        /// </summary>
        /// <param name="content"></param>
        /// <returns></returns>
        public string Tag(string content)
        {
            return Language.Tag(content, CurrentLanguage.Code);
        }
        /// <summary>
        /// ����ϵͳ��������
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public string TypeName(int id)
        {
            return Tag(EX_Type.TypeName(id));
        }
        public Lebi_Product GetProduct(int id)
        {
            return EX_Product.GetProduct(id);
        }
        public string[,] ProductProperty(Lebi_Product pro)
        {
            return EX_Product.Property(pro, CurrentLanguage);
        }
        #endregion
        #region ���ҽ�����
        /// <summary>
        /// ��ʽ�������ϵ�ǰ���ҷ���
        /// </summary>
        /// <param name="money"></param>
        /// <returns></returns>
        public string FormatMoney(decimal money, Lebi_Currency currency)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<span class=\"lebimoney\">");
            sb.Append("<font class=\"msige\">" + currency.Msige + "</font>");
            sb.Append("<font class=\"money_1\">" + (money * currency.ExchangeRate).ToString("0.00") + "</font>");
            sb.Append("<font class=\"money_0\" style=\"display:none;\">" + money + "</font>");
            sb.Append("</span>");
            return sb.ToString();
            //return  CurrentCurrency.  + "" + money.ToString("0.00");
        }
        public string FormatMoney(decimal money)
        {
            return FormatMoney(money, CurrentCurrency);
        }
        public string FormatMoney(string money)
        {
            return FormatMoney(Convert.ToDecimal(money));
        }
        public decimal ProductPrice(Lebi_Product pro)
        {
            return EX_Product.ProductPrice(pro, CurrentUserLevel);
        }
        #endregion
        #region meta��ǩ
        virtual public string ThemePageMeta(string code, string tag)
        {
            return ThemePageMeta(code, tag, "");
        }
        virtual public string ThemePageMeta(string code, string tag, string defaultstr)
        {
            if (defaultstr != "")
                return defaultstr;
            Lebi_Theme_Page model = B_Lebi_Theme_Page.GetModel("Code='" + code + "'");
            if (model == null)
                return "";
            switch (tag.ToLower())
            {
                case "description":
                    if (Lang(model.SEO_Description) == "")
                        return SYS.Description;
                    else
                        return Lang(model.SEO_Description);
                case "keywords":
                    if (Lang(model.SEO_Keywords) == "")
                        return SYS.Keywords;
                    else
                        return Lang(model.SEO_Keywords);
                default:
                    if (Lang(model.SEO_Title) == "")
                        return SYS.Title;
                    else
                        return Lang(model.SEO_Title);

            }
        }
        #endregion
        #region ��Ʒ�������
        /// <summary>
        /// ��Ʒ�����ѯҳ��Ĺ��ɸѡ����
        /// sel ��ʽΪ 
        /// ����id_��id����ɫid������id  �� 14_0,47_22
        /// </summary>
        /// <param name="pro"></param>
        /// <param name="sel"></param>
        /// <returns></returns>
        public string Categoryhref(int pid, int id, string sel)
        {
            if (sel == "")
                return pid + "_" + id;

            string reg = @"" + pid + "_[\\d]*";
            int count = RegexTool.GetRegCount(sel, reg);
            if (count > 0)
            {
                sel = RegexTool.ReplaceRegValue(sel, reg, pid + "_" + id);
            }
            if (count == 0)
            {
                sel += "," + pid + "_" + id;
            }
            return sel;
        }
        /// <summary>
        /// ��Ʒ�����ѯҳ��-����ɸѡ��񷵻ز�ѯ����
        /// </summary>
        /// <param name="sel"></param>
        /// <returns></returns>
        public string Categorywhere(string sel)
        {
            if (sel == "")
                return "";
            string where = "";
            string[] arr = sel.Split(',');
            for (int i = 0; i < arr.Length; i++)
            {
                int id = 0;
                string id_ = RegexTool.GetRegValue(arr[i], @"[\d]*_([\d]*)");
                int.TryParse(id_, out id);
                if (id > 0)
                {
                    where += " and Property like '%" + id + "%'";
                }

            }
            return where;
        }
        /// <summary>
        /// ����ĳ����Ʒ�����£�������id�����
        /// ���ŷָ�
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public string Categoryid(int id)
        {
            string str = id.ToString();
            List<Lebi_Pro_Type> ts = B_Lebi_Pro_Type.GetList("Parentid=" + id + "", "Sort desc");
            foreach (Lebi_Pro_Type t in ts)
            {
                str += "," + Categoryid(t.id);
            }
            return str;
        }
        /// <summary>
        /// ĳ����Ʒ�����·��
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public string[,] Categorypath(int id)
        {
            string str = Categorypath_ids(id);
            string[] arr = str.Split(',');
            string[,] res = new string[arr.Length, 2];
            for (int i = 0; i < arr.Length; i++)
            {
                Lebi_Pro_Type model = B_Lebi_Pro_Type.GetModel(int.Parse(arr[i]));
                int j = arr.Length - i - 1;
                res[j, 0] = model.id.ToString();
                res[j, 1] = Lang(model.Name);
            }
            return res;
        }
        public string Categorypath_ids(int id)
        {
            Lebi_Pro_Type model = B_Lebi_Pro_Type.GetModel(id);
            string str = model.id.ToString();
            if (model.Parentid > 0)
                str += "," + Categorypath_ids(model.Parentid);
            return str;
        }
        #endregion
        #region ���ﳵ�ղؼ����
        /// <summary>
        /// ���ﳵ��Ʒ����
        /// </summary>
        /// <returns></returns>
        public int Basket_Product_Count()
        {
            int count = 0;
            List<Lebi_User_Product> models = Basket_Product();
            foreach (Lebi_User_Product model in models)
            {
                count = count + model.count;
            }
            return count;
        }
        #endregion
        #region ���ﳵ��Ʒ�ܼ۸�
        /// <summary>
        /// ���ﳵ��Ʒ�ܼ۸�
        /// </summary>
        /// <returns></returns>
        public decimal Basket_Product_Price()
        {
            decimal price = 0;
            List<Lebi_User_Product> models = Basket_Product();
            foreach (Lebi_User_Product model in models)
            {
                Lebi_Product pro = B_Lebi_Product.GetModel(model.Product_id);
                if (pro != null)
                    price = price + pro.Price;
            }
            return price;
        }
        #endregion
        #region ���ﳵ��Ʒ
        /// <summary>
        /// ���ﳵ��Ʒ
        /// </summary>
        /// <returns></returns>
        public List<Lebi_User_Product> Basket_Product()
        {
            return Basket.UserProduct(CurrentUser, 142);
        }
        #endregion
        #region �ղؼ���Ʒ����
        /// <summary>
        /// �ղؼ���Ʒ����
        /// </summary>
        /// <returns></returns>
        public int Like_Product_Count()
        {
            return Like_Product().Count;
        }
        #endregion
        #region �ղؼ���Ʒ
        /// <summary>
        /// �ղؼ���Ʒ
        /// </summary>
        /// <returns></returns>
        public List<Lebi_User_Product> Like_Product()
        {
            return Basket.UserProduct(CurrentUser, 141);
        }
        public int Count_NewMessage()
        {
            if (CurrentUser.id > 0)
            {
                return B_Lebi_Message.Counts("User_id_to=" + CurrentUser.id + " and IsRead=0");
            }
            else
            {
                return 0;
            }
        }
        public int Count_NewComment()
        {
            if (CurrentUser.id > 0)
            {
                return B_Lebi_Order_Product.Counts("User_id=" + CurrentUser.id + " and IsCommented=0");
            }
            else
            {
                return 0;
            }
        }
        #endregion
        #region ����״̬
        /// <summary>
        /// ����״̬
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public string OrderStatus(Lebi_Order order)
        {
            string res = "�����";
            if (order.IsInvalid == 0)
            {
                if (order.IsCompleted == 0)
                {
                    if (order.IsReceived == 0)
                    {
                        if (order.IsShipped == 0)
                        {
                            //res = "��ȷ��";
                            if (order.IsPaid == 0)
                            {
                                res = "�ȴ�����";
                            }
                            else
                            {
                                res = "�ȴ�����";
                            }
                            //if (order.IsVerified == 0)
                            //{
                            //    res = "δȷ��";
                            //}
                            //else
                            //{

                            //}
                        }
                        else
                        {
                            if (order.IsShipped_All == 0)
                                res = "���ַ���";
                            else
                                res = "�ѷ���";
                        }
                    }
                    else
                    {
                        if (order.IsReceived_All == 0)
                            res = "�����ջ�";
                        else
                            res = "���ջ�";
                    }
                }
            }
            else
            {
                res = "��ȡ��";
            }
            return Tag(res);
        }
        #endregion
        #region �˻�����״̬
        /// <summary>
        /// �˻�����״̬
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public string ReturnStatus(Lebi_Order order)
        {
            string res = "�����";
            if (order.IsInvalid == 0)
            {
                if (order.IsCompleted == 0)
                {
                    if (order.IsReceived == 0)
                    {
                        if (order.IsShipped == 0)
                        {
                            res = "�ȴ�����";
                            //if (order.IsVerified == 0)
                            //{
                            //    res = "δȷ��";
                            //}
                            //else
                            //{

                            //}
                        }
                        else
                        {
                            if (order.IsShipped_All == 0)
                                res = "���ַ���";
                            else
                                res = "�ѷ���";
                        }
                    }
                    else
                    {
                        if (order.IsReceived_All == 0)
                            res = "�����ջ�";
                        else
                            res = "���ջ�";
                    }
                }
            }
            else
            {
                res = "��ȡ��";
            }
            return Tag(res);
        }
        #endregion
        #region ���ػ��˵��е���Ʒ����
        /// <summary>
        /// ���ػ��˵��е���Ʒ����
        /// </summary>
        /// <param name="torder"></param>
        /// <returns></returns>
        public static List<TransportProduct> GetTransportProduct(Lebi_Transport_Order torder)
        {
            List<TransportProduct> tps = new List<TransportProduct>();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            try
            {
                tps = jss.Deserialize<List<TransportProduct>>(torder.Product);
            }
            catch (Exception)
            {
                tps = new List<TransportProduct>();
            }
            return tps;
        }
        #endregion
        #region ģ����
        public void Advertisement(string code)
        {
            Lebi_Theme_Advert model = B_Lebi_Theme_Advert.GetModel("Code='" + code + "' and Theme_id=" + CurrentTheme.id + "");
            if (model == null)
                return;
            if (model.Content == "")
            {
                model.Content = "${<a href=\"{%URL%}\"><img src=\"{%Image%}\" title=\"{%Title%}\" width=\"{%Width%}\" height=\"{%Height%}\" /></a>}$";
            }
            string vv = Shop.Bussiness.Theme.DoAdvertCodeConvert(model.Content, model, CurrentLanguage, CurrentTheme);
            Response.Write(vv);
        }
        #endregion
    }

}