using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
using System.IO;
using System.IO.Compression;

using Shop.Model;using DB.LebiShop;
using LB.Tools;
using LB.DataAccess;

namespace Shop.Bussiness
{
    public class Event
    {
        /// <summary>
        /// ��ʼ���¼�
        /// </summary>
        public static void Initialization()
        {
            Shop.Bussiness.Order.OrderCreateEvent += new OrderCreateEventHandler(OrderCreate);
            Shop.Bussiness.Order.OrderCompleteCancalEvent += new OrderCompleteCancalEventHandler(OrderCompleteCancal);
            Shop.Bussiness.Order.OrderCompleteEvent += new OrderCompleteEventHandler(OrderComplete);
            Shop.Bussiness.Order.OrderConfirmEvent += new OrderConfirmEventHandler(OrderConfirm);
            Shop.Bussiness.Order.OrderCancalEvent += new OrderCancalEventHandler(OrderCancal);
            Shop.Bussiness.Order.OrderPaidCancalEvent += new OrderPaidCancalEventHandler(OrderPaidCancal);
            Shop.Bussiness.Order.OrderPaidEvent += new OrderPaidEventHandler(OrderPaid);
            Shop.Bussiness.Order.OrderDeleteBeforeEvent += new OrderDeleteBeforeEventHandler(OrderDelete);
            Shop.Bussiness.Order.OrderReceivedEvent += new OrderReceivedEventHandler(OrderReceived);
            Shop.Bussiness.EX_User.UserRegisterEvent += new UserRegisterEventHandler(UserRegister);
            Shop.Bussiness.EX_User.UserLoginEvent += new UserLoginEventHandler(UserLogin);
            Shop.Bussiness.EX_User.UserLoginEvent += new UserLoginEventHandler(UserLogin);
            Shop.Bussiness.TimeWork.AutoActionEvent_10m += new AutoActionEventHandler(AutoAction_10m);
            Shop.Bussiness.TimeWork.AutoActionEvent_1m += new AutoActionEventHandler(AutoAction_1m);
            Shop.Bussiness.EX_Supplier.SupplierRegisterEvent += new SupplierRegisterEventHandler(SupplierRegister);
            Shop.Bussiness.EX_User.UserInfoEditEvent += new UserInfoEditEventHandler(UserInfoEdit);

            Shop.Bussiness.EX_Product.StockChangeEvent += new StockChangeEventHandler(StockChange);
        }
        /// <summary>
        /// ȡ��ȫ���������
        /// </summary>
        /// <returns></returns>
        public static List<PluginConfig> GetPluginConfigALL()
        {
            List<PluginConfig> ps = new List<PluginConfig>();

            string path = System.Web.HttpRuntime.AppDomainAppPath + "/config/";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            DirectoryInfo mydir = new DirectoryInfo(path);
            FileInfo[] files = mydir.GetFiles();
            foreach (FileInfo f in files)
            {
                try
                {
                    string xmlpath = path + f.Name;
                    PluginConfig model = new PluginConfig();
                    model = (PluginConfig)SerializationHelper.Load(model.GetType(), xmlpath);
                    ps.Add(model);
                    //Response.Write(model.Assembly);
                }
                catch
                {
                    continue;
                }
            }
            return ps;
        }
        /// <summary>
        /// ȡ�ò������
        /// </summary>
        /// <returns></returns>
        public static List<PluginConfig> GetPluginConfig()
        {
            List<PluginConfig> ps = new List<PluginConfig>();

            string path = System.Web.HttpRuntime.AppDomainAppPath + "/config/";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            DirectoryInfo mydir = new DirectoryInfo(path);
            FileInfo[] files = mydir.GetFiles();
            foreach (FileInfo f in files)
            {
                try
                {
                    string xmlpath = path + f.Name;
                    PluginConfig model = new PluginConfig();
                    model = (PluginConfig)SerializationHelper.Load(model.GetType(), xmlpath);
                    if (!("," + ShopCache.GetBaseConfig().PluginUsed + ",").Contains("," + model.Assembly + ","))
                        continue;
                    ps.Add(model);
                    //Response.Write(model.Assembly);
                }
                catch
                {
                    continue;
                }
            }
            return ps;
        }
        /// <summary>
        /// ���������¼�
        /// </summary>
        /// <param name="orders"></param>
        public static void OrderCreate(List<Lebi_Order> orders)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "OrderCreateEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(List<Lebi_Order>) });
                        methodInfo.Invoke(type, new object[] { orders });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ���û�ע���¼�
        /// </summary>
        /// <param name="orders"></param>
        public static void UserRegister(Lebi_User user)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "UserRegisterEvent")
                        continue;
                    try
                    {
                        ///Assembly assembly = Assembly.LoadFile(AppDomain.CurrentDomain.BaseDirectory + "bin/" + model.Assembly + ".dll");
                        //Type type = assembly.GetType(cof.classname);
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_User) });
                        methodInfo.Invoke(type, new object[] { user });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// �༭�û�ע���¼�
        /// </summary>
        /// <param name="orders"></param>
        public static void UserInfoEdit(Lebi_User user)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "UserInfoEditEvent")
                        continue;
                    try
                    {
                        ///Assembly assembly = Assembly.LoadFile(AppDomain.CurrentDomain.BaseDirectory + "bin/" + model.Assembly + ".dll");
                        //Type type = assembly.GetType(cof.classname);
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_User) });
                        methodInfo.Invoke(type, new object[] { user });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// �û���¼�¼�
        /// </summary>
        /// <param name="orders"></param>
        public static void UserLogin(Lebi_User user)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "UserLoginEvent")
                        continue;
                    try
                    {
                        ///Assembly assembly = Assembly.LoadFile(AppDomain.CurrentDomain.BaseDirectory + "bin/" + model.Assembly + ".dll");
                        //Type type = assembly.GetType(cof.classname);
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_User) });
                        methodInfo.Invoke(type, new object[] { user });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// �̼�ע���¼�
        /// </summary>
        /// <param name="orders"></param>
        public static void SupplierRegister(Lebi_Supplier user)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "SupplierRegisterEvent")
                        continue;
                    try
                    {
                        ///Assembly assembly = Assembly.LoadFile(AppDomain.CurrentDomain.BaseDirectory + "bin/" + model.Assembly + ".dll");
                        //Type type = assembly.GetType(cof.classname);
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_Supplier) });
                        methodInfo.Invoke(type, new object[] { user });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ��������¼�
        /// OrderCompleteEventHandler
        /// </summary>
        /// <param name="orders"></param>
        public static void OrderComplete(Lebi_Order order)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "OrderCompleteEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_Order) });
                        methodInfo.Invoke(type, new object[] { order });
                    }
                    catch (Exception ex)
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��" + "\r\n" + ex.ToString());
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ������ɳ����¼�
        /// OrderCompleteCancalEventHandler
        /// </summary>
        /// <param name="orders"></param>
        public static void OrderCompleteCancal(Lebi_Order order)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "OrderCompleteCancalEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_Order) });
                        methodInfo.Invoke(type, new object[] { order });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ��������¼�
        /// OrderConfirmEventHandler
        /// </summary>
        /// <param name="orders"></param>
        public static void OrderConfirm(Lebi_Order order)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "OrderConfirmEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_Order) });
                        methodInfo.Invoke(type, new object[] { order });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ������˳����¼�
        /// OrderCancalEventHandler
        /// </summary>
        /// <param name="orders"></param>
        public static void OrderCancal(Lebi_Order order)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "OrderCancalEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_Order) });
                        methodInfo.Invoke(type, new object[] { order });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ���������¼�
        /// OrderPaidEventHandler
        /// </summary>
        /// <param name="orders"></param>
        public static void OrderPaid(Lebi_Order order)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "OrderPaidEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_Order) });
                        methodInfo.Invoke(type, new object[] { order });
                    }
                    catch (Exception ex)
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��:" + ex.ToString());
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ����������¼�
        /// OrderPaidCancalEventHandler
        /// </summary>
        /// <param name="orders"></param>
        public static void OrderPaidCancal(Lebi_Order order)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "OrderPaidCancalEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_Order) });
                        methodInfo.Invoke(type, new object[] { order });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ����ɾ���¼�
        /// OrderDeleteBeforeEventHandler
        /// </summary>
        /// <param name="orders"></param>
        public static void OrderDelete(Lebi_Order order)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "OrderDeleteBeforeEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_Order) });
                        methodInfo.Invoke(type, new object[] { order });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ����ȫ���ջ�
        /// </summary>
        public static void OrderReceived(Lebi_Order order)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    if (cof.eventname != "OrderReceivedEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { typeof(Lebi_Order) });
                        methodInfo.Invoke(type, new object[] { order });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        continue;
                    }
                }
            }

        }
        /// <summary>
        /// �Զ��¼�-10����
        /// AutoActionEventHandler
        /// </summary>
        /// <param name="orders"></param>
        public static void AutoAction_10m()
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    //SystemLog.Add(cof.eventname);
                    if (cof.eventname != "AutoActionEvent"|| cof.eventname != "AutoActionEvent_10m")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { });
                        methodInfo.Invoke(type, new object[] { });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        //SystemLog.Add(ex.Message);
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// �Զ��¼�-1����
        /// AutoActionEventHandler
        /// </summary>
        /// <param name="orders"></param>
        public static void AutoAction_1m()
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    //SystemLog.Add(cof.eventname);
                    if (cof.eventname != "AutoActionEvent_1m")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname, new Type[] { });
                        methodInfo.Invoke(type, new object[] { });
                    }
                    catch
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        //SystemLog.Add(ex.Message);
                        continue;
                    }
                }
            }
        }
        /// <summary>
        /// ���䶯�¼�
        /// ProductStockChangeEventHandler
        /// </summary>
        public static void StockChange(Lebi_Product product, int count, int Freeze, string log)
        {
            List<PluginConfig> ps = GetPluginConfig();
            foreach (PluginConfig model in ps)
            {
                foreach (PluginConfig.eventconfig cof in model.EventConfigs)
                {
                    //SystemLog.Add(cof.eventname);
                    if (cof.eventname != "ProductStockChangeEvent")
                        continue;
                    try
                    {
                        Type type = Type.GetType("" + cof.classname + "," + cof.spacename + "", false, true);
                        MethodInfo methodInfo = type.GetMethod(cof.methodname);
                        methodInfo.Invoke(type, new object[] { product, count, Freeze, log });
                    }
                    catch (Exception ex)
                    {
                        SystemLog.Add(model.Assembly + "���¼�" + cof.eventname + "ע��ʧ��");
                        SystemLog.Add(ex.ToString());
                        continue;
                    }
                }
            }
        }
    }
}

