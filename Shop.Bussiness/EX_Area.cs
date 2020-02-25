using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

using System.Text.RegularExpressions;
using System.Linq;
using Shop.Model;using DB.LebiShop;
using LB.Tools;
using LB.DataAccess;
using System.Web.Script.Serialization;

namespace Shop.Bussiness
{
    public class EX_Area
    {
        /// <summary>
        /// ����һ��AREA�����и�id�������Լ���
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static string Parentids_Get(int area_id)
        {
            string ids = "";
            Lebi_Area area = B_Lebi_Area.GetModel(area_id);
            if (area != null)
            {
                ids = area.Parentid.ToString();
                if (area.Parentid > 0)
                {
                    ids += "," + Parentids_Get(area.Parentid);
                }
            }
            return ids;
        }
        /// <summary>
        /// ����һ��AREA�����һ����id�������Լ���
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static int Parentids_Get(int area_id, int path)
        {
            int id = 0;
            Lebi_Area area = B_Lebi_Area.GetModel(area_id);
            if (area == null)
            {
                return area_id;
            }
            else
            {
                id = area.Parentid;
                if (area.Parentid > 0)
                {
                    id = Parentids_Get(area.Parentid, path);
                }
            }
            return id;
        }
        /// <summary>
        /// �������͵���ȡ�����乫˾��������Ӧ�˷�
        /// </summary>
        public static List<Lebi_Transport_Price> TransportPrices_Get(int area_id, int supplierid)
        {

            Lebi_Area area = B_Lebi_Area.GetModel(area_id);
            if (area == null)
            {
                return new List<Lebi_Transport_Price>();
            }
            List<Lebi_Transport_Price> trans = null;//���͵�������ǰ���������乫˾�Լ��۸�
            trans = TransportPrice(area, trans, supplierid);
            foreach (Lebi_Transport_Price p in trans)
            {
                Lebi_Transport t = B_Lebi_Transport.GetModel(p.Transport_id);
                if (t != null)
                    p.Sort = t.Sort;
            }
            trans = trans.OrderByDescending(a => a.Sort).ToList();
            return trans;

        }
        /// <summary>
        /// �ݹ鴦���˷Ѽ۸�
        /// </summary>
        /// <param name="area"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        private static List<Lebi_Transport_Price> TransportPrice(Lebi_Area area, List<Lebi_Transport_Price> trans, int supplierid)
        {
            if (trans == null)
            {
                trans = B_Lebi_Transport_Price.GetList("Area_id=" + area.id + " and Supplier_id=" + supplierid + "", "");
            }
            else
            {
                string pids = "";
                List<Lebi_Transport_Price> models = B_Lebi_Transport_Price.GetList("Area_id=" + area.id + " and Supplier_id=" + supplierid + "", "");
                foreach (Lebi_Transport_Price model in models)
                {
                    //�ų������Ĺ�ϵ
                    //�������ӣ��������б��е����
                    bool flag = false;
                    foreach (Lebi_Transport_Price tran in trans)
                    {
                        pids = EX_Area.Parentids_Get(tran.Area_id);
                        pids = "," + pids + ",";
                        if (pids.Contains("," + model.Area_id + ",") && model.Transport_id == tran.Transport_id)
                            flag = true;
                    }
                    if (!flag)
                        trans.Add(model);
                }
            }
            if (area.Parentid > 0)
            {
                area = B_Lebi_Area.GetModel(area.Parentid);
                if (area != null)
                    trans = TransportPrice(area, trans, supplierid);
            }
            return trans;
        }
        /// <summary>
        /// ���ص�������Ŀ¼
        /// </summary>
        /// <param name="area_id"></param>
        /// <param name="deep">Ŀ¼���</param>
        /// <returns></returns>
        public static string GetAreaName(int area_id, int deep)
        {
            string res = "";
            deep--;
            Lebi_Area area = B_Lebi_Area.GetModel(area_id);
            if (area == null)
                return res;
            res = area.Name;
            if (deep > 0)
                res = GetAreaName(area.Parentid, deep) + " " + res;
            return res;
        }
        public static string GetAreaNameDesc(int area_id, int deep)
        {
            string res = "";
            deep--;
            Lebi_Area area = B_Lebi_Area.GetModel(area_id);
            if (area == null)
                return res;
            res = area.Name;
            if (deep > 0)
            {
                Lebi_Area areacheck = B_Lebi_Area.GetModel(area.Parentid);
                if (areacheck != null)
                    res = res + ",";
                res = res + GetAreaNameDesc(area.Parentid, deep);
            }
            return res;
        }
        public static string GetAreaNameNoPath(int area_id, int deep)
        {
            string res = "";
            deep--;
            Lebi_Area area = B_Lebi_Area.GetModel(area_id);
            if (area == null)
                return res;
            res = area.Name;
            if (area.Parentid > 0 && deep > 0)
            {
                res = GetAreaNameNoPath(area.Parentid, deep);
                return res;
            }
            DateTime dt = System.DateTime.Now.Date.AddDays(0 - System.DateTime.Now.Day);
            return res;
        }
        /// <summary>
        /// ����ȫ������Ŀ¼
        /// </summary>
        /// <param name="area_id"></param>
        /// <returns></returns>
        public static string GetAreaName(int area_id)
        {
            return GetAreaName(area_id, 999);
        }
        /// <summary>
        /// ���ص�������Ŀ¼
        /// </summary>
        /// <param name="area_id"></param>
        /// <param name="deep">Ŀ¼��� 0</param>
        /// <param name="loop">��ʾ�㼶</param>
        /// <returns></returns>
        public static string GetAreaName(int area_id, int deep, int loop)
        {
            string res = "";
            loop++;
            Lebi_Area area = B_Lebi_Area.GetModel(area_id);
            if (area == null)
                return res;
            res = area.Name;
            if (area.Parentid > 0 && loop < 5)
            {
                res = GetAreaName(area.Parentid, deep, loop);
            }
            return res;
        }
        /// <summary>
        /// ��ȡָ�����乫˾��ָ������ļ۸�
        /// </summary>
        /// <returns></returns>
        public static Lebi_Transport_Price GetAreaPrice(int transport_id, int area_id, int supplierid)
        {
            Lebi_Transport_Price price = B_Lebi_Transport_Price.GetModel("Transport_id=" + transport_id + " and Area_id=" + area_id + " and Supplier_id=" + supplierid + "");
            if (price == null)
            {
                Lebi_Area area = B_Lebi_Area.GetModel(area_id);
                if (area != null)
                {
                    if (area.Parentid > 0)
                        return GetAreaPrice(transport_id, area.Parentid, supplierid);
                    return null;
                }
                return null;
            }
            return price;
        }
        /// <summary>
        /// ��֤�����������˷������Ƿ�ƥ��
        /// </summary>
        /// <returns></returns>
        public static bool CheckAreaPrice(Lebi_Transport_Price price, int area_id)
        {
            if (price == null)
                return false;
            Lebi_Transport_Price p = GetAreaPrice(price.Transport_id, area_id, price.Supplier_id);
            if (p != null)
            {
                if (p.id == price.id)
                    return true;
                return false;
            }
            return false;
        }

        /// <summary>
        /// �����˷�
        /// </summary>
        /// <param name="weight"></param>
        /// <param name="volume"></param>
        /// <param name="price"></param>
        /// <param name="ordermoney"></param>
        /// <returns></returns>
        public static decimal GetYunFei(decimal weight, decimal volume, Lebi_Transport_Price price, decimal ordermoney)
        {
            if (price == null)
                price = new Lebi_Transport_Price();
            decimal res = 0;
            if (ordermoney >= price.OrderMoney && price.OrderMoney > 0)//���㶩�����Ҫ��
                return price.Price_OrderMoneyOK;
            if (price.IsOnePrice == 1)//�����˷�
                return price.Price;
            else
            {
                Lebi_Transport transport = B_Lebi_Transport.GetModel(price.Transport_id);
                if (transport == null)
                    return 0;
                decimal money = price.Price;
                if (transport.Type_id_TransportType == 331)
                {

                    //����ʽ����
                    JavaScriptSerializer jss = new JavaScriptSerializer();
                    List<KeyValue> kvs = jss.Deserialize<List<KeyValue>>(price.Container);
                    string ids = "";
                    foreach (KeyValue kv in kvs)
                    {
                        if (ids == "")
                            ids = kv.K;
                        else
                            ids += "," + kv.K;
                    }
                    int count = 0;//��Ҫ�Ļ�������
                    decimal cprice = 0;//ʹ�õĻ���۸�
                    if (ids != "")
                    {
                        List<Lebi_Transport_Container> conts = B_Lebi_Transport_Container.GetList("id in (lbsql{" + ids + "})", "Volume desc");
                        //�ж�ʹ���ĸ�����
                        Lebi_Transport_Container UseCont = new Lebi_Transport_Container();
                        foreach (Lebi_Transport_Container cont in conts)
                        {
                            if (volume / 100 / 100 / 100 > cont.Volume)
                            {
                                UseCont = cont;
                                break;
                            }
                        }
                        if (UseCont.id == 0)
                            UseCont = conts.FirstOrDefault();
                        UseCont.Weight = UseCont.Weight * 1000 * 1000;//��λת��Ϊ��
                        UseCont.Volume = UseCont.Volume * 100 * 100 * 100;//��λת��Ϊ��������
                        KeyValue kv = (from m in kvs
                                       where m.K == UseCont.id.ToString()
                                       select m).ToList().FirstOrDefault();
                        cprice = Convert.ToDecimal(kv.V);
                        if (weight > UseCont.Weight)
                        {
                            //����������
                            count = (int)(weight / UseCont.Weight);
                            if (weight % UseCont.Weight > 0)
                                count++;

                        }
                        else
                        {
                            //���������
                            count = (int)(volume / UseCont.Volume);
                            if (volume % UseCont.Volume > 0)
                                count++;
                        }
                    }
                    count = count == 0 ? 1 : count;
                    money = money + cprice * count;
                }
                else
                { //������ʽ����
                    int wei = (int)weight + 1;
                    if (weight > price.Weight_Start)
                    {
                        try
                        {
                            decimal step = (weight - price.Weight_Start) / price.Weight_Step;
                            step = Math.Ceiling(step);
                            money = money + step * price.Price_Step;
                        }
                        catch (DivideByZeroException)
                        {
                            // money = money; 
                        }
                    }
                }

                res = money;
            }
            return res;
        }
        public static decimal GetYunFei(List<Lebi_User_Product> pros, Lebi_Transport_Price price)
        {
            return GetYunFei(pros, price, 0);
        }
        public static decimal GetYunFei(List<Lebi_User_Product> pros, Lebi_Transport_Price price, decimal ordermoney = 0)
        {
            decimal weight = 0;
            decimal tiji = 0;
            foreach (Lebi_User_Product pro in pros)
            {
                Lebi_Product product = B_Lebi_Product.GetModel(pro.Product_id);
                if (product == null)
                    continue;
                weight = weight + product.Weight * pro.count;//����������λ����
                tiji = tiji + product.VolumeL * product.VolumeH * product.VolumeW * pro.count;//���������λ����������
            }
            return GetYunFei(weight, tiji, price, ordermoney);
        }
        /// <summary>
        /// ���ݶ�����Ʒ�����˷�
        /// </summary>
        /// <param name="pros"></param>
        /// <param name="price"></param>
        /// <returns></returns>
        public static decimal GetYunFei(List<Lebi_Order_Product> pros, Lebi_Transport_Price price)
        {
            decimal weight = 0;
            decimal tiji = 0;
            decimal money = 0;
            foreach (Lebi_Order_Product pro in pros)
            {
                Lebi_Product product = B_Lebi_Product.GetModel(pro.Product_id);
                if (product == null)
                    continue;
                weight = weight + product.Weight * pro.Count;
                tiji = tiji + product.VolumeL * product.VolumeH * product.VolumeW * pro.Count;//���������λ����������
                money = money + pro.Price * pro.Count;
            }
            return GetYunFei(weight, tiji, price, money);
        }

        /// <summary>
        /// ����˷ѱ�ע
        /// </summary>
        /// <param name="weight"></param>
        /// <param name="volume"></param>
        /// <param name="price"></param>
        /// <param name="ordermoney"></param>
        /// <returns></returns>
        public static string GerYunFeiMark(decimal weight, decimal volume, Lebi_Transport_Price price, decimal ordermoney = 0)
        {
            string res = "";
            if (price.IsOnePrice == 1 && ordermoney >= price.OrderMoney)//���㶩�����Ҫ��
                return "";
            else
            {
                Lebi_Transport transport = B_Lebi_Transport.GetModel(price.Transport_id);
                decimal money = price.Price;
                if (transport.Type_id_TransportType == 331)
                {

                    //����ʽ����
                    JavaScriptSerializer jss = new JavaScriptSerializer();
                    List<KeyValue> kvs = jss.Deserialize<List<KeyValue>>(price.Container);
                    string ids = "";
                    foreach (KeyValue kv in kvs)
                    {
                        if (ids == "")
                            ids = kv.K;
                        else
                            ids += "," + kv.K;
                    }
                    int count = 0;//��Ҫ�Ļ�������
                    decimal cprice = 0;//ʹ�õĻ���۸�
                    if (ids != "")
                    {
                        List<Lebi_Transport_Container> conts = B_Lebi_Transport_Container.GetList("id in (lbsql{" + ids + "})", "Volume desc");
                        //�ж�ʹ���ĸ�����
                        Lebi_Transport_Container UseCont = new Lebi_Transport_Container();
                        foreach (Lebi_Transport_Container cont in conts)
                        {
                            if (volume / 100 / 100 / 100 > cont.Volume)
                            {
                                UseCont = cont;
                                break;
                            }
                        }
                        if (UseCont.id == 0)
                            UseCont = conts.FirstOrDefault();
                        UseCont.Weight = UseCont.Weight * 1000 * 1000;//��λת��Ϊ��
                        UseCont.Volume = UseCont.Volume * 100 * 100 * 100;//��λת��Ϊ��������
                        KeyValue kv = (from m in kvs
                                       where m.K == UseCont.id.ToString()
                                       select m).ToList().FirstOrDefault();
                        cprice = Convert.ToDecimal(kv.V);
                        if (weight > UseCont.Weight)
                        {
                            //����������
                            count = (int)(weight / UseCont.Weight);
                            if (weight % UseCont.Weight > 0)
                                count++;

                        }
                        else
                        {
                            //���������
                            count = (int)(volume / UseCont.Volume);
                            if (volume % UseCont.Volume > 0)
                                count++;
                        }
                        count = count == 0 ? 1 : count;
                        res = UseCont.Name + "��" + count;
                    }
                }
                else
                {
                }
            }
            return res;
        }
        /// <summary>
        /// �������䷽ʽ������ѡ��
        /// </summary>
        /// <param name="sid"></param>
        /// <returns></returns>
        public static string TransportOption(int sid)
        {
            string res = "";
            List<Lebi_Transport> trans = B_Lebi_Transport.GetList("", "Sort desc");
            foreach (Lebi_Transport model in trans)
            {
                res += "<option value=\"" + model.id + "\" " + (sid == model.id ? "selected" : "") + " >" + model.Name + "</option>";
            }
            return res;
        }
        /// <summary>
        /// ���ؿ��100��������
        /// </summary>
        /// <param name="to"></param>
        /// <returns></returns>
        public static KuaiDi100 GetKuaiDi100(Lebi_Transport_Order torder)
        {
            string json;
            KuaiDi100 log = new KuaiDi100();
            BaseConfig conf = ShopCache.GetBaseConfig();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            if (torder.Type_id_TransportOrderStatus == 223)
            {
                json = torder.Log;
                log = jss.Deserialize<KuaiDi100>(json);
            }
            else
            {

                try
                {
                    string url = "http://www.kuaidi100.com/api?id=" + conf.KuaiDi100 + "&com=" + torder.Transport_Code + "&nu=" + torder.Code + "&show=0&muti=1";
                    json = HtmlEngine.CetHtml(url);
                    log = jss.Deserialize<KuaiDi100>(json);
                    switch (log.state)
                    {
                        case "1":
                            torder.Type_id_TransportOrderStatus = 221;
                            break;
                        case "2":
                            torder.Type_id_TransportOrderStatus = 222;
                            break;
                        case "3":
                            torder.Type_id_TransportOrderStatus = 223;
                            try
                            {
                                torder.Time_Received = Convert.ToDateTime(log.data.FirstOrDefault().time);
                            }
                            catch
                            {
                                torder.Time_Received = System.DateTime.Now;
                            }
                            break;
                        case "4":
                            torder.Type_id_TransportOrderStatus = 224;
                            break;
                        //default:
                        //    //torder.Type_id_TransportOrderStatus = 220;
                        //    break;

                    }
                    if (log.message != "ok")
                    {
                        //û�гɹ���ȡ��json����
                        url = "http://www.kuaidi100.com/applyurl?key=" + conf.KuaiDi100 + "&com=" + torder.Transport_Code + "&nu=" + torder.Code;
                        string html = HtmlEngine.CetHtml(url);
                        //html = HtmlEngine.CetHtml(html);
                        torder.HtmlLog = html;
                    }
                    torder.Log = json;
                    B_Lebi_Transport_Order.Update(torder);
                    UpdateShouHuoCount(torder);
                }
                catch (Exception)
                {
                    log = new KuaiDi100();
                }
            }
            if (log == null)
                log = new KuaiDi100();
            if (log.data == null)
                log.data = new List<KuaiDi100.KuaiDi100data>();
            return log;
        }
        /// <summary>
        /// �ջ�ȷ�Ϻ󣬸��¶�����Ʒ���ջ�����
        /// </summary>
        /// <param name="torder"></param>
        public static void UpdateShouHuoCount(Lebi_Transport_Order torder)
        {
            if (torder.Type_id_TransportOrderStatus != 223)
                return;
            Lebi_Order order = B_Lebi_Order.GetModel(torder.Order_id);
            if (order == null)
                return;
            List<Lebi_Order_Product> ops = B_Lebi_Order_Product.GetList("Order_id=" + torder.Order_id + "", "");
            List<Lebi_Transport_Order> torders = B_Lebi_Transport_Order.GetList("Order_id=" + torder.Order_id + " and Type_id_TransportOrderStatus=223", "");
            //bool shouhuoall = true;
            foreach (Lebi_Order_Product op in ops)
            {
                //op.Count_Received = 0;
                foreach (Lebi_Transport_Order to in torders)
                {
                    foreach (TransportProduct p in GetTransportProduct(to))
                    {
                        if (p.Product_id == op.Product_id)
                        {
                            op.Count_Received = op.Count_Received + p.Count;
                            if (op.Count_Shipped < op.Count_Received)
                                op.Count_Received = op.Count_Shipped;
                            break;
                        }
                    }
                }
                //if (op.Count_Received < op.Count_Shipped)
                //    shouhuoall = false;
                B_Lebi_Order_Product.Update(op);//�����ջ�����
            }
            order.IsReceived = 1;
            order.IsReceived_All = 1;
            ops = B_Lebi_Order_Product.GetList("Order_id=" + torder.Order_id + "", "");
            foreach (Lebi_Order_Product op in ops)
            {
                if (op.Count_Received < op.Count_Shipped)
                    order.IsReceived_All = 0;
            }
            order.Time_Received = System.DateTime.Now;
            B_Lebi_Order.Update(order);
            if (order.IsReceived_All == 1)//ȫ���ջ����
                Order.Received(order);
        }

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
        /// <summary>
        /// ����һ�������µ������ӵ���
        /// </summary>
        /// <param name="tid"></param>
        /// <returns></returns>
        public static string Area_ids(int tid)
        {
            string ids = tid.ToString();
            List<Lebi_Area> ts = B_Lebi_Area.GetList("Parentid=" + tid + "", "");
            foreach (Lebi_Area t in ts)
            {
                ids += "," + Area_ids(t.id);
            }
            return ids;
        }
    }

}

