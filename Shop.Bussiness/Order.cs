using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Text.RegularExpressions;
using System.Linq;
using Shop.Model;using DB.LebiShop;
using LB.Tools;
using LB.DataAccess;
using System.Web.Script.Serialization;
using System.Collections.Specialized;

namespace Shop.Bussiness
{
    public delegate void OrderCreateEventHandler(List<Lebi_Order> orders);
    public delegate void OrderCompleteEventHandler(Lebi_Order order);
    public delegate void OrderCompleteCancalEventHandler(Lebi_Order order);
    public delegate void OrderConfirmEventHandler(Lebi_Order order);
    public delegate void OrderCancalEventHandler(Lebi_Order order);
    public delegate void OrderPaidEventHandler(Lebi_Order order);
    public delegate void OrderPaidCancalEventHandler(Lebi_Order order);
    public delegate void OrderDeleteBeforeEventHandler(Lebi_Order order);
    public delegate void OrderReceivedEventHandler(Lebi_Order order);
    public class Order
    {
        #region �����¼�
        public static event OrderCreateEventHandler OrderCreateEvent;
        protected static void OrderCreate(List<Lebi_Order> orders)
        {
            if (OrderCreateEvent != null)
            {
                OrderCreateEvent(orders);
            }
        }
        public static event OrderCompleteEventHandler OrderCompleteEvent;
        protected static void OrderComplete(Lebi_Order order)
        {
            if (OrderCompleteEvent != null)
            {
                OrderCompleteEvent(order);
            }
        }
        public static event OrderCompleteCancalEventHandler OrderCompleteCancalEvent;
        protected static void OrderCompleteCancal(Lebi_Order order)
        {
            if (OrderCompleteCancalEvent != null)
            {
                OrderCompleteCancalEvent(order);
            }
        }
        public static event OrderConfirmEventHandler OrderConfirmEvent;
        protected static void OrderConfirm(Lebi_Order order)
        {
            if (OrderConfirmEvent != null)
            {
                OrderConfirmEvent(order);
            }
        }
        public static event OrderCancalEventHandler OrderCancalEvent;
        protected static void OrderCancal(Lebi_Order order)
        {
            if (OrderCancalEvent != null)
            {
                OrderCancalEvent(order);
            }
        }
        public static event OrderPaidEventHandler OrderPaidEvent;
        protected static void OrderPaid(Lebi_Order order)
        {
            if (OrderPaidEvent != null)
            {
                OrderPaidEvent(order);
            }
        }
        public static event OrderPaidCancalEventHandler OrderPaidCancalEvent;
        protected static void OrderPaidCancal(Lebi_Order order)
        {
            if (OrderPaidCancalEvent != null)
            {
                OrderPaidCancalEvent(order);
            }
        }
        public static event OrderDeleteBeforeEventHandler OrderDeleteBeforeEvent;
        protected static void OrderDeleteBefore(Lebi_Order order)
        {
            if (OrderDeleteBeforeEvent != null)
            {
                OrderDeleteBeforeEvent(order);
            }
        }
        public static event OrderReceivedEventHandler OrderReceivedEvent;
        protected static void OrderReceived(Lebi_Order order)
        {
            if (OrderReceivedEvent != null)
            {
                OrderReceivedEvent(order);
            }
        }
        #endregion
        /// <summary>
        /// �����Ѿ�ȷ�ϣ����ﳵ��Ʒ���ɶ���
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        public static List<Lebi_Order> CreateOrder(Lebi_User user, Basket basket, Lebi_User_Address shouhuo, Lebi_BillType billtype, Lebi_Currency CurrentCurrency, Lebi_Site currentsite, Lebi_Language CurrentLanguage, out Lebi_Order ordergroup)
        {
            try
            {
                //<-{��ȡ����ID
                int DT_id = ShopPage.GetDT();
                //->
                BaseConfig SYS = ShopCache.GetBaseConfig();
                decimal TaxRate = 0;
                decimal.TryParse(SYS.TaxRate, out TaxRate);
                ordergroup = new Lebi_Order();
                Lebi_Pay pay = B_Lebi_Pay.GetModel(user.Pay_id);
                if (pay == null)
                    pay = new Lebi_Pay();
                Lebi_OnlinePay onlinepay = B_Lebi_OnlinePay.GetModel(user.OnlinePay_id);
                if (onlinepay == null)
                    onlinepay = new Lebi_OnlinePay();
                if (billtype == null)
                    billtype = new Lebi_BillType();
                if (basket.Shops.Count > 1)
                {
                    ordergroup.Code = CreateOrderCode();
                    ordergroup.Money_Pay = 0;
                    ordergroup.User_id = user.id;
                    ordergroup.Pay_id = pay.id;
                    ordergroup.Pay = pay.Name;
                    ordergroup.OnlinePay_id = onlinepay.id;
                    ordergroup.OnlinePay = onlinepay.Name;
                    ordergroup.Type_id_OrderType = 215;
                    ordergroup.Currency_Code = CurrentCurrency.Code;
                    ordergroup.Currency_ExchangeRate = CurrentCurrency.ExchangeRate;
                    ordergroup.Currency_id = CurrentCurrency.id;
                    ordergroup.Currency_Msige = CurrentCurrency.Msige;
                    ordergroup.Site_id = currentsite.id;
                    ordergroup.Site_id_pay = currentsite.id;
                    B_Lebi_Order.Add(ordergroup);
                    ordergroup.id = B_Lebi_Order.GetMaxId();
                }
                int billtype_id = RequestTool.RequestInt("billtype_id", 0);
                List<Lebi_Order> orders = new List<Lebi_Order>();
                foreach (BasketShop shop in basket.Shops)
                {
                    Lebi_Transport_Price tprice = B_Lebi_Transport_Price.GetModel("id in (" + user.Transport_Price_id + ") and Supplier_id=" + shop.Shop.id + "");
                    Lebi_Transport transport = B_Lebi_Transport.GetModel(tprice.Transport_id);
                    Lebi_Order order = new Lebi_Order();
                    order.Code = CreateOrderCode();
                    order.Money_Product = shop.Money_Product;
                    if (shop.IsTransportPriceOne)
                        order.Money_Transport = shop.Money_Transport_One;
                    else
                        order.Money_Transport = EX_Area.GetYunFei(shop.Products, tprice, shop.Money_Product);
                    order.Money_Cut = shop.Money_Cut;
                    order.Money_Give = shop.Money_Give;
                    order.Money_Market = shop.Money_Market;
                    order.Money_Property = shop.Money_Property;
                    order.Money_Bill = order.Money_Product * billtype.TaxRate;
                    order.Money_Tax = order.Money_Product * TaxRate / 100;
                    if (pay.Code == "OfflinePay")
                    {
                        order.Money_OnlinepayFee = (shop.Money_Product + order.Money_Transport - shop.Money_Cut + order.Money_Bill + order.Money_Property + order.Money_Tax) * pay.FeeRate / 100;
                    }
                    else
                    {
                        order.Money_OnlinepayFee = 0;
                    }
                    order.Money_Order = shop.Money_Product + order.Money_Transport - shop.Money_Cut + order.Money_Bill + order.Money_Property + order.Money_OnlinepayFee + order.Money_Tax;
                    if (SYS.IntOrderMoney == "1")
                    {
                        order.Money_Order = (int)order.Money_Order;
                    }
                    order.Money_Pay = order.Money_Order;
                    order.Weight = shop.Weight;
                    order.Volume = shop.Volume;
                    order.Transport_Mark = EX_Area.GerYunFeiMark(shop.Weight, shop.Volume, tprice, shop.Money_Product);
                    //order.PayType = "";
                    order.Point_Free = shop.Point_Free;
                    order.Point_Product = shop.Point_Product;
                    order.Point = shop.Point_Product + shop.Point_Free;
                    order.T_Address = shouhuo.Address;
                    order.T_Area_id = shouhuo.Area_id;
                    order.T_Email = shouhuo.Email;
                    order.T_MobilePhone = shouhuo.MobilePhone;
                    order.T_Name = shouhuo.Name;
                    order.T_Phone = shouhuo.Phone;
                    order.T_Postalcode = shouhuo.Postalcode;
                    order.Transport_id = tprice.Transport_id;
                    order.Transport_Name = transport.Name;
                    order.Transport_Code = transport.Code;
                    order.User_id = user.id;
                    order.User_UserName = user.UserName;
                    order.User_NickName = user.NickName;
                    order.Type_id_OrderType = 211;//������
                    order.BillType_id = billtype.id;
                    order.BillType_Name = billtype.Name;
                    order.BillType_TaxRate = billtype.TaxRate;
                    order.Currency_Code = CurrentCurrency.Code;
                    order.Currency_ExchangeRate = CurrentCurrency.ExchangeRate;
                    order.Currency_id = CurrentCurrency.id;
                    order.Currency_Msige = CurrentCurrency.Msige;
                    order.Order_id = ordergroup.id;

                    order.Pay_id = pay.id;
                    order.Pay = pay.Name;
                    order.Supplier_id = shop.Shop.id;
                    order.OnlinePay_id = onlinepay.id;
                    order.OnlinePay_Code = onlinepay.Code;
                    order.OnlinePay = onlinepay.Name;
                    order.Site_id = currentsite.id;
                    order.Site_id_pay = currentsite.id;
                    order.Point_Buy = shop.Point_Buy;//��ȥ����

                    foreach (Lebi_Promotion_Type t in shop.PromotionTypes)
                    {
                        if (order.Promotion_Type_ids == "")
                        {
                            order.Promotion_Type_ids = t.id.ToString();
                            order.Promotion_Type_Name = t.Name;
                        }
                        else
                        {
                            order.Promotion_Type_ids += "," + t.id.ToString();
                            order.Promotion_Type_Name += Language.ComboString(order.Promotion_Type_Name, t.Name);
                        }
                    }
                    if (shop.Shop.IsCash == 1 && basket.IsMutiCash && order.Supplier_id > 0)
                    {
                        order.IsSupplierCash = 1;
                    }
                    order.Language_id = CurrentLanguage.id;
                    B_Lebi_Order.Add(order);
                    order.id = B_Lebi_Order.GetMaxId("User_id =" + user.id + "");
                    //����Ʊ
                    CreateBill(order, billtype, user);
                    //���������� 
                    CreateOrderProPerty(order, user);
                    //��������Ʒ
                    decimal Money_Cost = 0;//�����ɱ���
                    List<Lebi_User_Product> ups = shop.Products;
                    Lebi_Order_Product opro = new Lebi_Order_Product();
                    opro.Order_Code = order.Code;
                    opro.Order_id = order.id;
                    Lebi_UserLevel userlevel = B_Lebi_UserLevel.GetModel(user.UserLevel_id);
                    decimal Money_Product_NOVAT = 0;//Ʒ�Ʋ���˰��Ʒ�ܶ�
                    foreach (Lebi_User_Product up in ups)
                    {
                        //Lebi_Product pro = B_Lebi_Product.GetModel(up.Product_id);
                        Lebi_Product pro = B_Lebi_Product.GetModel(up.Product_id);
                        if (pro.Type_id_ProductType != 323)
                        {
                            //<-{����Ʒ�Ʋ���˰��Ʒ�ܶ�  by lebi.kingdge 2015-08-22
                            Lebi_Brand brand = B_Lebi_Brand.GetModel(pro.Brand_id);
                            if (brand != null)
                            {
                                if (brand.IsVAT == 0)
                                    Money_Product_NOVAT += EX_Product.ProductPrice(pro, userlevel, user) * up.count;
                            }
                            //}->
                        }
                        opro.Count = up.count;
                        opro.Count_Shipped = 0;
                        opro.ImageBig = pro.ImageBig;
                        opro.ImageMedium = pro.ImageMedium;
                        opro.ImageOriginal = pro.ImageOriginal;
                        opro.ImageSmall = pro.ImageSmall;
                        opro.Price = EX_Product.ProductPrice(pro, userlevel, user);
                        opro.Price_Cost = pro.Price_Cost;
                        opro.Product_id = pro.id;
                        opro.Product_Name = pro.Name;
                        opro.Weight = pro.Weight;
                        opro.Product_Number = pro.Number;
                        opro.ProPerty_Price = up.ProPerty_Price;
                        opro.Money = opro.Price * opro.Count * up.Discount / 100;

                        switch (pro.Type_id_ProductType)
                        {
                            case 321: //��ʱ����
                                opro.Type_id_OrderProductType = 253;
                                break;
                            case 322: //�Ź�
                                opro.Type_id_OrderProductType = 254;
                                break;
                            case 323: //���ֻ���
                                opro.Type_id_OrderProductType = 255;
                                opro.Point_Buy_one = pro.Price_Sale;
                                break;
                            case 324: //Ԥ����Ʒ
                                opro.Type_id_OrderProductType = 256;
                                opro.Price_Reserve = pro.Price_reserve;
                                break;
                            default:
                                opro.Type_id_OrderProductType = 251;
                                break;
                        }

                        opro.User_id = user.id;
                        opro.Time_Add = System.DateTime.Now;
                        opro.Product_Number = pro.Number;
                        opro.Supplier_id = pro.Supplier_id;
                        opro.IsSupplierTransport = pro.IsSupplierTransport;
                        opro.Point_Product = up.Product_Point;
                        opro.Pointagain = up.Pointagain;
                        opro.Discount = up.Discount;//�ۿ� �ٷֱ���ʽ
                        decimal zbiji = shop.Money_Product * opro.Count;
                        decimal bili = 0;
                        if (zbiji > 0)
                            bili = opro.Money / zbiji;//����Ʒռ�������ı���
                        opro.Point_Give_one = Math.Round(up.Product_Point * up.Pointagain + shop.Point_Free * bili, 2);
                        opro.Money_Card312_one = 0;
                        opro.Money_Give_one = Math.Round(shop.Money_Give * bili, 2);
                        opro.ProPerty134 = up.ProPerty134;
                        opro.PackageRate = pro.PackageRate;
                        opro.NetWeight = pro.NetWeight;
                        opro.Units_id = pro.Units_id;
                        opro.Volume = (pro.VolumeH * pro.VolumeL * pro.VolumeW) / 1000000;
                        B_Lebi_Order_Product.Add(opro);
                        //pro.Count_Sales = pro.Count_Sales + up.count;  //����ɶ���״̬��������ʵ���� by lebi.kingdge 2007-02-17
                        if (ShopCache.GetBaseConfig().ProductStockFreezeTime == "orderadd")
                        {
                            ////������
                            //EX_Product.ProductStock_Freeze(pro, up.count);
                            //���¿��
                            EX_Product.ProductStock_Change(pro, (0 - opro.Count), 302, order);
                        }
                        B_Lebi_Product.Update(pro);
                        if (pro.Product_id > 0)
                        {
                            var pro1 = B_Lebi_Product.GetModel(pro.Product_id);
                            pro1.Count_Sales += pro.Count_Sales_Show;
                            B_Lebi_Product.Update(pro1);

                        }
                        Money_Cost += opro.Count * opro.Price_Cost;
                    }
                    //������Ʒ
                    foreach (Lebi_User_Product up in shop.FreeProducts)
                    {
                        Lebi_Product pro = B_Lebi_Product.GetModel(up.Product_id);
                        opro.Count = up.count;
                        opro.Count_Shipped = 0;
                        opro.ImageBig = pro.ImageBig;
                        opro.ImageMedium = pro.ImageMedium;
                        opro.ImageOriginal = pro.ImageOriginal;
                        opro.ImageSmall = pro.ImageSmall;
                        opro.Price = pro.Price;
                        opro.Price_Cost = pro.Price_Cost;
                        opro.Product_id = pro.id;
                        opro.Product_Name = pro.Name;
                        opro.Weight = pro.Weight;
                        opro.Product_Number = pro.Code;
                        opro.Supplier_id = pro.Supplier_id;
                        opro.Money = 0;
                        opro.Product_Number = pro.Number;
                        opro.Type_id_OrderProductType = 252;
                        opro.IsSupplierTransport = pro.IsSupplierTransport;
                        //opro.Money_Card312
                        opro.ProPerty134 = up.ProPerty134;
                        opro.PackageRate = pro.PackageRate;
                        opro.NetWeight = pro.NetWeight;
                        opro.Units_id = pro.Units_id;
                        opro.Volume = (pro.VolumeH * pro.VolumeL * pro.VolumeW) / 1000000;
                        B_Lebi_Order_Product.Add(opro);
                        if (ShopCache.GetBaseConfig().ProductStockFreezeTime == "orderadd")
                        {
                            ////������
                            //EX_Product.ProductStock_Freeze(pro, up.count);
                            //���¿��
                            EX_Product.ProductStock_Change(pro, (0 - opro.Count), 302, order);
                        }
                        Money_Cost += opro.Count * opro.Price_Cost;
                    }
                    //д����Ʒ�ɱ���� by kingdge
                    order.Money_Cost = Money_Cost;
                    //<-{��˰����  by lebi.kingdge 2015-08-22
                    decimal Money_Refund_VAT = 0;//����˰��
                    decimal Money_Refund_Fee = 0;//��˰������
                    decimal Refund_MinMoney = 0;
                    decimal Refund_VAT = 0;
                    decimal.TryParse(SYS.Refund_MinMoney, out Refund_MinMoney);
                    decimal.TryParse(SYS.Refund_VAT, out Refund_VAT);
                    if (shop.Money_Product < Refund_MinMoney)
                    {
                        Money_Refund_VAT = 0;
                        Money_Refund_Fee = 0;
                    }
                    else
                    {
                        Money_Refund_VAT = (shop.Money_Product - Money_Product_NOVAT) * Refund_VAT / 100;
                        if ((shop.Money_Product - Money_Product_NOVAT) > Refund_MinMoney)
                        {
                            Money_Refund_Fee = Basket.Refund_Fee(SYS.Refund_StepR, Money_Refund_VAT, shop.Money_Product - Money_Product_NOVAT);
                        }
                        else
                        {
                            Money_Refund_VAT = 0;
                        }
                    }
                    order.Refund_VAT = Money_Refund_VAT;
                    order.Refund_Fee = Money_Refund_Fee;
                    B_Lebi_Order.Update(order);
                    //��ȯ����
                    CardAndUserMoneyPay(order, user);
                    //�۳�����
                    if (order.Point_Buy > 0)
                    {
                        //�����û�����
                        Random ran = new Random();
                        string PayNo = order.Code + DateTime.Now.ToString("HHmmss") + System.DateTime.Now.Millisecond + ran.Next(100000, 999999);
                        Point.AddPoint(user, 0 - order.Point_Buy, 171, order, null, order.Code, PayNo);

                    }
                    orders.Add(order);

                    //��չ��ﳵ
                    //Basket.Clear(user, 142);
                    foreach (Lebi_User_Product up in shop.Products)
                    {
                        B_Lebi_User_Product.Delete(up.id);
                    }
                }
                OrderCreate(orders);//�����¼�
                string ids = "";
                foreach (Lebi_Order order in orders)
                {
                    ids += order.id + ",";
                }

                orders = B_Lebi_Order.GetList("id in (" + ids + "0)", "");
                foreach (Lebi_Order order in orders)
                {
                    //�����ʼ�
                    Email.SendEmail_ordersubmit(user, order);
                    //���Ͷ���
                    SMS.SendSMS_ordersubmit(user, order);
                }
                return orders;
            }
            catch (Exception e)
            {
                SystemLog.Add(e.ToString());
                List<Lebi_Order> orders = new List<Lebi_Order>();
                ordergroup = new Lebi_Order();
                return orders;
            }
        }
        /// <summary>
        /// ���ɶ�����
        /// </summary>
        /// <returns></returns>
        public static string CreateOrderCode()
        {
            string str = System.DateTime.Now.ToString("yyMMddHHmmss") + System.DateTime.Now.Millisecond;
            return str;
        }
        /// <summary>
        /// ����ɾ��
        /// </summary>
        /// <param name="order"></param>
        public static void OrderDelete(Lebi_Order order)
        {
            if (order.IsInvalid != 1)
                return;
            OrderDeleteBefore(order);
            SystemLog.Add(RequestTool.GetConfigKey("IsDelFalse").ToLower());
            if (RequestTool.GetConfigKey("IsDelFalse").ToLower() == "true")
            {
                order.IsDel = 1;
                B_Lebi_Order.Update(order);
                Common.ExecuteSql("update Lebi_Order_Product set IsDel=1 where Order_id = " + order.id);

            }
            else
            {
                B_Lebi_Order.Delete("id = " + order.id + "");
                B_Lebi_Order_Product.Delete("Order_id = " + order.id + "");
                B_Lebi_Order_Log.Delete("Order_id = " + order.id + "");
                B_Lebi_Comment.Delete("TableName = 'Order' and Keyid = " + order.id + "");
                B_Lebi_Transport_Order.Delete("Order_id = " + order.id + "");
            }

            //B_Lebi_User_BuyMoney.Delete("Order_id = " + model.id + "");
            //������Ʒ������
            List<Lebi_Product> pros = B_Lebi_Product.GetList("id in (select Product_id from Lebi_Order_Product where Order_id=" + order.id + ")", "");

            foreach (Lebi_Product pro in pros)
            {
                EX_Product.Reset_Count_Freeze(pro);
            }
        }
        /// <summary>
        /// ��ӷ�Ʊ
        /// </summary>
        /// <param name="billtype"></param>
        public static void CreateBill(Lebi_Order order, Lebi_BillType billtype, Lebi_User user)
        {
            if (ShopCache.GetBaseConfig().BillFlag == "0")
                return;
            if (billtype.Type_id_BillType != 150)
            {
                Lebi_Bill bill = new Lebi_Bill();
                int billtitletype = RequestTool.RequestInt("billtitletype", 0);
                string bill_content = RequestTool.RequestSafeString("bill_content");
                string billtitle = RequestTool.RequestSafeString("billtitle");
                if (billtitletype == 1)
                    billtitle = "����";
                bill.BillType_id = billtype.id;
                bill.Company_Address = RequestTool.RequestSafeString("Company_Address");
                bill.Company_Bank = RequestTool.RequestSafeString("Company_Bank");
                bill.Company_Bank_User = RequestTool.RequestSafeString("Company_Bank_User");
                bill.Company_Code = RequestTool.RequestSafeString("Company_Code");
                bill.Company_Name = RequestTool.RequestSafeString("Company_Name");
                bill.Company_Phone = RequestTool.RequestSafeString("Company_Phone");
                bill.Content = bill_content;
                bill.Money = order.Money_Product;
                bill.Order_Code = order.Code;
                bill.Order_id = order.id;
                bill.TaxRate = billtype.TaxRate;
                bill.Title = billtitle;
                bill.Type_id_BillStatus = 161;//δ����
                bill.Type_id_BillType = billtype.Type_id_BillType;
                bill.User_id = user.id;
                bill.User_UserName = user.UserName;
                B_Lebi_Bill.Add(bill);
            }
        }
        /// <summary>
        /// ��ȯ|�û�����Ĵ���
        /// </summary>
        /// <param name="order"></param>
        /// <param name="CurrentUser"></param>
        public static void CardAndUserMoneyPay(Lebi_Order order, Lebi_User CurrentUser)
        {
            //<-{������ˮ�ţ�����ƥ���ʽ���ϸ��¼ by lebi.kingdge 2018.8.20
            Random ran = new Random();
            order.PayNo = order.Code + System.DateTime.Now.Millisecond + ran.Next(100000, 999999);
            B_Lebi_Order.Update(order);
            //}->
            decimal money_pay = order.Money_Pay;
            //==========================================================================
            //���㿨ȯ����������
            string usermoneytype = RequestTool.RequestString("usermoneytype");//1����ȯ2���￨3���
            if (usermoneytype.Contains("1") && money_pay > 0)//����ȯ
            {
                string pay312 = RequestTool.RequestString("pay312");
                if (pay312 != "")
                {
                    List<Lebi_Card> cs = B_Lebi_Card.GetList("User_id=" + CurrentUser.id + " and id in (lbsql{" + pay312 + "})", "id asc");
                    foreach (Lebi_Card c in cs)
                    {
                        if (money_pay <= 0)
                            break;
                        decimal money_use = money_pay > c.Money_Last ? c.Money_Last : money_pay;
                        money_pay = money_pay - money_use;
                        c.Type_id_CardStatus = 202;
                        c.Order_Code = order.Code;
                        c.Order_id = order.id.ToString();
                        c.Money_Last = 0;
                        B_Lebi_Card.Update(c);
                        order.UseCardCode312 += "," + c.Code;
                        order.Money_UseCard312 += money_use;
                    }
                    List<Lebi_Order_Product> ops = B_Lebi_Order_Product.GetList("Order_id=" + order.id + " and Type_id_OrderProductType=251", "");
                    foreach (Lebi_Order_Product op in ops)
                    {
                        decimal bili = op.Money / order.Money_Product / op.Count;//����Ʒ�涩�����ı���
                        op.Money_Card312_one = Math.Round(order.Money_UseCard312 * bili, 2);
                        B_Lebi_Order_Product.Update(op);
                    }
                }
            }
            if (usermoneytype.Contains("2") && money_pay > 0)//���￨
            {
                string pay311 = RequestTool.RequestString("pay311");
                if (pay311 != "")
                {
                    string moneycardcode = RequestTool.RequestString("moneycardcode");
                    string moneycardpwd = RequestTool.RequestString("moneycardpwd");
                    Lebi_Card card = B_Lebi_Card.GetModel("Code='" + moneycardcode + "' and Type_id_CardStatus in (201,203)");
                    List<Lebi_Card> cs = B_Lebi_Card.GetList("User_id=" + CurrentUser.id + " and id in (lbsql{" + pay311 + "})", "id asc");
                    if (card != null)
                    {
                        if (card.Password == moneycardpwd)
                        {
                            bool flag = false;
                            foreach (Lebi_Card c in cs)
                            {
                                if (c.id == card.id)
                                    flag = true;
                            }
                            if (flag == false)
                                cs.Add(card);
                        }
                    }
                    foreach (Lebi_Card c in cs)
                    {
                        if (money_pay <= 0)
                            break;
                        decimal money_use = money_pay > c.Money_Last ? c.Money_Last : money_pay;
                        money_pay = money_pay - money_use;

                        c.Order_Code += "," + order.Code;
                        c.Order_id += "," + order.id.ToString();
                        c.Money_Last = c.Money_Last - money_use;
                        if (c.Money_Last > 0)
                            c.Type_id_CardStatus = 203;
                        else
                            c.Type_id_CardStatus = 202;
                        B_Lebi_Card.Update(c);
                        order.UseCardCode311 += "," + c.Code;
                        order.Money_UseCard311 += money_use;
                    }
                }
            }
            if (usermoneytype.Contains("3") && money_pay > 0 && CurrentUser.Money > 0)//����
            {
                decimal money_use = money_pay > CurrentUser.Money ? CurrentUser.Money : money_pay;
                money_pay = money_pay - money_use;
                Money.AddMoney(CurrentUser, 0 - money_use, 192, order, null, "", "");
                order.Money_UserCut = money_use;
            }
            order.Money_Pay = money_pay;
            if (order.Money_Pay == 0)//ȫ�����֧��
            {
                order.Pay_id = 0;
                order.Pay = Bussiness.Language.GetTag("�˻����");
                PaySuccess(order, "");
                //order.IsPaid = 1;
                //order.Time_Paid = System.DateTime.Now;
            }
            order.Money_Paid = order.Money_UserCut + order.Money_UseCard311;// +order.Money_UseCard312;
            B_Lebi_Order.Update(order);
        }
        /// <summary>
        /// ���ݶ�����Ʒ���¼��㶩��
        /// </summary>
        /// <param name="order"></param>
        public static void ResetOrder(Lebi_Order order)
        {
            BaseConfig SYS = ShopCache.GetBaseConfig();
            order.Money_Product = 0;
            order.Weight = 0;
            order.Point = order.Point_Free;
            List<Lebi_Order_Product> pros = B_Lebi_Order_Product.GetList("Order_id=" + order.id + "", "");
            Lebi_User user = B_Lebi_User.GetModel(order.User_id);
            Lebi_UserLevel CurrentUserLevel = B_Lebi_UserLevel.GetModel(user.UserLevel_id);
            if ((order.Type_id_OrderType == 218 && order.Order_id > 0) || order.Type_id_OrderType == 212)
            {
                //�˻���
                foreach (Lebi_Order_Product pro in pros)
                {

                    order.Money_Product += pro.Price * pro.Count;
                    order.Money_Cost += pro.Price_Cost * pro.Count;
                    order.Weight += pro.Weight * pro.Count;
                    order.Point += pro.Point_Product * pro.Count;
                }
                order.Money_Product = 0 - order.Money_Product;
                order.Money_Cost = 0 - order.Money_Cost;
                order.Money_Order = order.Money_Product + order.Money_Property;
                order.Money_Pay = order.Money_Order;
                order.Money_Give = 0 - order.Money_Pay;
                order.Point = 0 - order.Point;
            }
            else
            {
                foreach (Lebi_Order_Product pro in pros)
                {
                    decimal price = 0;
                    Lebi_Product product = B_Lebi_Product.GetModel(pro.Product_id);

                    if (product.Type_id_ProductType == 324)//Ԥ����Ʒ
                        price = product.Price_reserve;//Ԥ�����
                    else
                        price = EX_Product.ProductPrice(product, CurrentUserLevel, user, pro.Count);//����

                    order.Money_Product += price * pro.Count;
                    order.Money_Cost += pro.Price_Cost * pro.Count;
                    order.Weight += pro.Weight * pro.Count;
                    order.Point += pro.Point_Product * pro.Count;
                }
                order.Money_Bill = order.Money_Product * order.BillType_TaxRate;
                Lebi_Transport_Price p = B_Lebi_Transport_Price.GetModel(order.Transport_Price_id);
                if (p != null)
                {
                    order.Money_Transport = EX_Area.GetYunFei(order.Weight, order.Volume, p, order.Money_Product);

                }
                order.Money_Order = order.Money_Product + order.Money_Transport + order.Money_Bill + order.Money_Property + order.Money_Tax - order.Money_Transport_Cut - order.Money_Cut;
                if (SYS.IntOrderMoney == "1")
                {
                    order.Money_Order = (int)order.Money_Order;
                }
                order.Money_Pay = order.Money_Order - order.Money_fromorder - order.Money_UseCard311 - order.Money_UseCard312 - order.Money_Paid;
                //���·�Ʊ��¼
                if (order.Money_Order > 0)
                {
                    Lebi_Bill bill = B_Lebi_Bill.GetModel("Order_id=" + order.id + "");
                    if (bill != null)
                    {
                        if (bill.Money != order.Money_Order)
                        {
                            bill.Money = order.Money_Order;
                            B_Lebi_Bill.Update(bill);
                        }
                    }
                }
            }
            B_Lebi_Order.Update(order);
        }
        /// <summary>
        /// һ�������������
        /// </summary>
        /// <param name="ordercode"></param>
        /// <returns></returns>
        public static bool PaySuccess(string ordercode)
        {
            Lebi_Order order = B_Lebi_Order.GetModel("Code=lbsql{'" + ordercode + "'}");
            return PaySuccess(order);
        }
        public static bool PaySuccess(string ordercode, string outcode)
        {
            Lebi_Order order = B_Lebi_Order.GetModel("Code=lbsql{'" + ordercode + "'}");
            return PaySuccess(order, outcode);
        }
        public static bool PaySuccess(int id)
        {
            Lebi_Order order = B_Lebi_Order.GetModel(id);
            return PaySuccess(order);
        }
        public static bool PaySuccess(Lebi_Order order, string outcode = "")
        {
            if (order == null)
                return false;
            if (order.IsPaid != 0)
                return false;
            Lebi_User user = B_Lebi_User.GetModel(order.User_id);
            if (user == null)
                return false;
            if ((order.Money_Order - order.Money_Paid) > order.Money_Pay)
            {
                Log.Add("���У�����[" + (order.Money_Pay + order.Money_Paid) + "]", "Order", order.id.ToString(), user, "");
                return false;
            }
            if (outcode=="" || outcode == "ERP")
            {
                //<-{������ˮ�ţ�����ƥ���ʽ���ϸ��¼ by lebi.kingdge 2018.8.20
                Random ran = new Random();
                order.PayNo = order.Code + System.DateTime.Now.Millisecond + ran.Next(100000, 999999);
                B_Lebi_Order.Update(order);
                //}->
            }
            order.IsPaid = 1;
            //order.IsVerified = 1;
            order.Time_Paid = System.DateTime.Now;
            SystemLog.Add(order.Code + "����ɹ�-�Ѿ����¶���");
            if (order.Type_id_OrderType == 215)
            {
                //���¶������ڵĶ���
                List<Lebi_Order> ors = B_Lebi_Order.GetList("Order_id=" + order.id + " and Type_id_OrderType=211", "");
                foreach (Lebi_Order or in ors)
                {
                    or.Time_Paid = System.DateTime.Now;
                    or.IsPaid = 1;
                    B_Lebi_Order.Update(or);
                    //���������ʷ
                    Lebi_User_BuyMoney model = new Lebi_User_BuyMoney();
                    model.Description = "";
                    model.Money = or.Money_Product;
                    model.Order_Code = or.Code;
                    model.Order_id = or.id;
                    model.User_id = user.id;
                    B_Lebi_User_BuyMoney.Add(model);
                    if (ShopCache.GetBaseConfig().IsOpenPaidOrderConfirm == "1" && or.IsVerified == 0)
                    {
                        //�Զ�ȷ�϶���
                        Order_Confirm(or);
                    }
                    //�޸Ķ����ڵ�Ԥ����Ʒ����״̬Ϊ�Ѹ���
                    List<Lebi_Order_Product> ops = B_Lebi_Order_Product.GetList("Order_id=" + order.id + " and Type_id_OrderProductType=256", "");
                    bool IsWeikuan = false;
                    foreach (Lebi_Order_Product op in ops)
                    {
                        if (op.IsStockOK == 0)
                            op.IsPaidReserve = 1;
                        if (op.IsStockOK == 1)
                        {
                            op.IsPaid = 1;
                            op.Time_Paid = DateTime.Now;

                        }
                        B_Lebi_Order_Product.Update(op);
                        if (op.IsPaid == 1)
                            IsWeikuan = true;
                    }
                    if (IsWeikuan)
                        Log.Add("β���ɹ�", "Order", order.id.ToString(), user, "" + Language.Content(order.Pay, user.Language));
                    else
                        Log.Add("����ɹ�", "Order", order.id.ToString(), user, "" + Language.Content(order.Pay, user.Language));
                    PaySuccess_FenPeiHuoKuan(or);
                }
            }
            else
            {
                if (order.Type_id_OrderType == 214)
                {
                    //��ֵ����
                    //Money.AddMoney(user, order.Money_Pay, 191, null, "", "");   //�����ⲿͳһ����
                    order.IsCompleted = 1;
                    if (order.Order_id > 0)
                    {
                        Lebi_Order co = B_Lebi_Order.GetModel(order.Order_id);
                        if (co != null)
                        {
                            if (order.Money_Pay >= co.Money_Pay)
                            {
                                //���³�ֵ������������˶������Զ��ۿ�
                                Money.AddMoney(user, 0 - co.Money_Pay, 192, order, null, order.Code + "����", "");
                                PaySuccess(co);
                            }
                        }
                    }
                }
                else
                {
                    //���ﶩ��
                    //���������ʷ
                    if (outcode == "ERP")
                    {
                        if (!EX_Admin.Power("checkout_super", "0����"))
                        {
                            if (user.Money < order.Money_Pay)
                            {
                                SystemLog.Add(order.Code + "������㣡");
                                return false;
                            }
                        }
                    }
                    //<-{�ʽ���ϸ�пۿ� by lebi.kingdge 20180619
                    if (user != null)
                    {
                        Money.AddMoney(user, 0 - order.Money_Pay, 192, order, null, Shop.Bussiness.Language.Tag("����ɹ�", user.Language) + " " + order.Code, Shop.Bussiness.Language.Tag("����ɹ�", user.Language) + " " + order.Code);
                    }
                    //}->
                    //<-{����ʽ���ϸ���Ƿ������Ѽ�¼ by lebi.kingdge 2018.8.21
                    if (order.Money_Order > 0) { 
                        decimal money_pay = 0;
                        string _money_pay = B_Lebi_User_Money.GetValue("sum(money)", "Order_id = " + order.id + " and Order_PayNo = '" + order.PayNo + "' and (Type_id_MoneyType = 192 or Type_id_MoneyType = 195)");
                        money_pay = Convert.ToDecimal(_money_pay);
                        if ((0 - money_pay) < (order.Money_Order-order.Money_Paid))
                        {
                            Log.Add("δ֧��[�ʽ���ϸУ�����]", "Order", order.id.ToString(), user, "");
                            return false;
                        }
                    }
                    //}->
                    Lebi_User_BuyMoney model = new Lebi_User_BuyMoney();
                    model.Description = "";
                    model.Money = order.Money_Product;
                    model.Order_Code = order.Code;
                    model.Order_id = order.id;
                    model.User_id = user.id;
                    B_Lebi_User_BuyMoney.Add(model);
                    if (ShopCache.GetBaseConfig().IsOpenPaidOrderConfirm == "1" && order.IsVerified == 0)
                    {
                        //�Զ�ȷ�϶���
                        Order_Confirm(order);
                    }
                    SystemLog.Add(order.Code + "����ɹ�-��ʼ�������");
                    PaySuccess_FenPeiHuoKuan(order);
                }
            }
            //���Ͷ���
            SystemLog.Add(order.Code + "����ɹ�-��ʼ���Ͷ���");
            SMS.SendSMS_orderpaid(user, order);
            SystemLog.Add(order.Code + "����ɹ�-��ʼ�����¼�");
            order.Money_Paid = order.Money_Paid + order.Money_Pay;
            B_Lebi_Order.Update(order);
            //�޸Ķ����ڵ�Ԥ����Ʒ����״̬Ϊ�Ѹ���
            List<Lebi_Order_Product> ops0 = B_Lebi_Order_Product.GetList("Order_id=" + order.id + " and Type_id_OrderProductType=256", "");
            bool IsWeikuan0 = false;
            foreach (Lebi_Order_Product op in ops0)
            {
                if (op.IsStockOK == 0)
                    op.IsPaidReserve = 1;
                if (op.IsStockOK == 1)
                {
                    op.IsPaid = 1;
                    op.Time_Paid = DateTime.Now;

                }
                B_Lebi_Order_Product.Update(op);
                if (op.IsPaid == 1)
                    IsWeikuan0 = true;
            }
            string payname = Language.Content(order.Pay, user.Language);
            if (outcode != "")
            {
                if (IsWeikuan0)
                {
                    Log.Add("β���ɹ�", "Order", order.id.ToString(), user, payname);
                }
                else
                {
                    Log.Add("����ɹ�", "Order", order.id.ToString(), user, payname);
                }
            }
            OrderPaid(order);//�����¼�
            return true;
        }
        /// <summary>
        /// ��������ɹ���������
        /// </summary>
        public static void PaySuccess_FenPeiHuoKuan(Lebi_Order or)
        {
            try
            {
                if (or.Supplier_id == 0)
                    return;
                Lebi_Supplier CurrentSupplier = B_Lebi_Supplier.GetModel(or.Supplier_id);
                if (CurrentSupplier == null)
                    return;
                Lebi_Supplier_Money money = new Lebi_Supplier_Money();
                if (or.IsSupplierCash == 1)
                {
                    if (or.Money_UserCut > 0)
                    {
                        if (or.Type_id_OrderType == 211)//������
                        {
                            money.Money = or.Money_UserCut;
                        }
                        else if (or.Type_id_OrderType == 212)//�˻���
                        {
                            money.Money = 0 - or.Money_UserCut;
                        }
                        money.Order_Code = or.Code;
                        money.Order_id = or.id;
                        money.Supplier_id = CurrentSupplier.id;
                        money.User_UserName = CurrentSupplier.UserName;
                        money.Type_id_MoneyStatus = 183;//�����ʽ�
                        money.Type_id_SupplierMoneyType = 341;
                        money.Supplier_SubName = CurrentSupplier.SubName;
                        B_Lebi_Supplier_Money.Add(money);
                    }
                    return;
                }
                if (or.Type_id_OrderType == 211)//������
                {
                    //if (CurrentSupplier.Type_id_SupplierType == 431)//һ�㹩Ӧ��
                    if (CurrentSupplier.IsSupplierTransport == 0)//�̳Ǵ�����
                    {
                        money.Money = or.Money_Product - or.Money_Cost;
                    }
                    else
                    {
                        //��Ʒ���+�˷�-�����˷�-����ȯ-����ת�ƽ��-������
                        money.Money = or.Money_Product + or.Money_Transport + or.Money_Property - or.Money_Transport_Cut - or.Money_UseCard312 - or.Money_fromorder - or.Money_Cut;
                    }
                }
                else if (or.Type_id_OrderType == 212)//�˻���
                {
                    money.Money = 0 - or.Money_Give;
                }
                money.Order_Code = or.Code;
                money.Order_id = or.id;
                money.Supplier_id = CurrentSupplier.id;
                money.User_UserName = CurrentSupplier.UserName;
                money.Type_id_MoneyStatus = 183;//�����ʽ�
                money.Type_id_SupplierMoneyType = 341;
                money.Supplier_SubName = CurrentSupplier.SubName;
                B_Lebi_Supplier_Money.Add(money);
            }
            catch (Exception ex)
            {
                SystemLog.Add("������" + or.Code + "��������쳣��" + ex.Message);
            }
        }
        /// <summary>
        /// ����֧�����
        /// </summary>
        /// <param name="ordercode"></param>
        public static void OnlinePaySuccess(string Code, string ordercode, string outcode = "",  bool jumpflag = true)
        {
            Lebi_Order order = B_Lebi_Order.GetModel("Code=lbsql{'" + ordercode + "'}");
            if (order == null)
                return;
            // <-{����һ�ֶ�����⣬����ȡ������֧��״̬���ظ���ֵ by Lebi.kingdge 2018.12.23
            if (!string.IsNullOrEmpty(order.PayNo))
            {
                Lebi_User_Money usermoney = B_Lebi_User_Money.GetModel("Order_id = "+ order.id + " and Type_id_MoneyType = 191 and Admin_id = 0");
                if (usermoney != null)
                {
                    return;
                }
            }
            // }->
            if (order.IsPaid == 0)
            {
                Lebi_Pay pay = B_Lebi_Pay.GetModel("Code='OnlinePay'");
                if (pay != null)
                {
                    order.Pay_id = pay.id;
                    order.Pay = pay.Name;
                }
                if (Code != "")
                {
                    Lebi_OnlinePay onlinepay = Shop.Bussiness.Money.GetOnlinePay(order, Code);
                    if (onlinepay != null)
                    {
                        order.OnlinePay_id = onlinepay.id;
                        order.OnlinePay_Code = onlinepay.Code;
                        order.OnlinePay = onlinepay.Name;
                    }
                }else
                {
                    Lebi_OnlinePay onlinepay = B_Lebi_OnlinePay.GetModel(order.OnlinePay_id);
                    if (onlinepay != null)
                    {
                        order.OnlinePay_Code = onlinepay.Code;
                        order.OnlinePay = onlinepay.Name;
                    }
                }
                //<-{������ˮ�ţ�����ƥ���ʽ���ϸ��¼ by lebi.kingdge 2018.8.20
                Random ran = new Random();
                order.PayNo = order.Code + System.DateTime.Now.Millisecond + ran.Next(100000, 999999);
                B_Lebi_Order.Update(order);
                //}->
                if (string.IsNullOrEmpty(outcode))
                {
                    outcode = "00000000";
                }
                //<-{�����ʽ���ϸ by lebi.kingdge 20180620
                Lebi_User user = B_Lebi_User.GetModel(order.User_id);
                if (user != null)
                {
                    Money.AddMoney(user, order.Money_Pay, 191, order, null, Language.Content(order.Pay, user.Language) + " " + order.Code, Language.Content(order.Pay, user.Language) + " " + order.Code);
                }
                //}->
                PaySuccess(order, outcode);
                SystemLog.Add(order.Code + "����ɹ�-��ʼ��ת");
            }
            if (jumpflag)
            {
                //<-{��ת����ݸ���֪ͨҳ�� by lebi.kingdge 2018.6.28
                if (!string.IsNullOrEmpty(order.KeyCode))
                {
                    HttpContext.Current.Response.Redirect(Site.Instance.WebPath.TrimEnd('/') + "/OrderQuickPay/return.aspx?k=" + order.KeyCode);
                    return;
                }
                //}->
                Lebi_Site site = B_Lebi_Site.GetModel(order.Site_id_pay);
                if (site == null)
                    HttpContext.Current.Response.Redirect(Site.Instance.WebPath.TrimEnd('/') + "/user/Orders.aspx");
                else
                {
                    Lebi_Language lang = B_Lebi_Language.GetModel(order.Language_id);
                    string path = "";
                    if (lang != null)
                        path = lang.Path.TrimEnd('/');
                    if (order.Supplier_id == 0)
                    {
                        if (site.Domain == "")
                            HttpContext.Current.Response.Redirect(Site.Instance.WebPath.TrimEnd('/') + site.Path.TrimEnd('/') + path + "/user/Orders.aspx");
                        else
                        {
                            HttpContext.Current.Response.Redirect(Site.Instance.WebPath.TrimEnd('/') + path + "/user/Orders.aspx");
                        }
                    }
                    else
                    {
                        if (site.Domain == "")
                            HttpContext.Current.Response.Redirect(Site.Instance.WebPath.TrimEnd('/') + site.Path.TrimEnd('/') + path + "/supplier/order/money.aspx");
                        else
                        {
                            HttpContext.Current.Response.Redirect(Site.Instance.WebPath.TrimEnd('/') + path + "/supplier/order/money.aspx");
                        }
                    }
                }
            }
        }
        /// <summary>
        /// �����ջ�-��������Ʒȫ���ջ����
        /// </summary>
        /// <param name="order"></param>
        public static void Received(Lebi_Order order)
        {
            order.IsReceived_All = 1;
            order.Time_Received = System.DateTime.Now;
            B_Lebi_Order.Update(order);
            Order.ReceivedSuccess_HuoKuanOK(order);
            OrderReceived(order);
        }
        /// <summary>
        /// �����ջ�ȷ�Ϻ�ȫ�����������Ч
        /// </summary>
        public static void ReceivedSuccess_HuoKuanOK(Lebi_Order or)
        {

            if (or.IsReceived_All != 1)
                return;
            Lebi_Supplier CurrentSupplier = B_Lebi_Supplier.GetModel(or.Supplier_id);
            if (CurrentSupplier == null)
                return;
            List<Lebi_Supplier_Money> moneys = B_Lebi_Supplier_Money.GetList("Type_id_SupplierMoneyType=341 and Type_id_MoneyStatus=183 and Order_id=" + or.id + "", "");
            foreach (Lebi_Supplier_Money money in moneys)
            {
                money.Type_id_MoneyStatus = 181;
                B_Lebi_Supplier_Money.Update(money);
            }
            EX_Supplier.UpdateUserMoney(CurrentSupplier);
        }
        /// <summary>
        /// ����״̬
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public static string OrderStatus(Lebi_Order order, string LanuageCode, int showcolor = 0)
        {
            string res = Language.Tag("�����", LanuageCode);
            if (showcolor == 1)
                res = "<span style=\"color:#0000ff\">" + Language.Tag("�����", LanuageCode) + "</span>";
            if (order.IsInvalid == 0)
            {
                if (order.IsCompleted == 0)
                {
                    if (order.IsReceived == 0)
                    {
                        if (order.IsShipped == 0)
                        {
                            if (order.IsPaid == 0)
                            {
                                if (order.IsVerified == 0)
                                {
                                    if (showcolor == 1)
                                        res = "<span style=\"color:#ff0000\">" + Language.Tag("δȷ��", LanuageCode) + "</span>";
                                    else
                                        res = Language.Tag("δȷ��", LanuageCode);
                                }
                                else
                                {
                                    res = Language.Tag("��ȷ��", LanuageCode);
                                }
                            }
                            else
                            {
                                if (showcolor == 1)
                                    res = "<span style=\"color:#FF8000\">" + Language.Tag("�Ѹ���", LanuageCode) + "</span>";
                                else
                                    res = Language.Tag("�Ѹ���", LanuageCode);
                            }
                        }
                        else
                        {
                            if (order.IsShipped_All == 0)
                                if (showcolor == 1)
                                    res = "<span style=\"color:#20FF20\">" + Language.Tag("���ַ���", LanuageCode) + "</span>";
                                else
                                    res = Language.Tag("���ַ���", LanuageCode);
                            else
                                if (showcolor == 1)
                                res = "<span style=\"color:#17BA17\">" + Language.Tag("�ѷ���", LanuageCode) + "</span>";
                            else
                                res = Language.Tag("�ѷ���", LanuageCode);
                        }
                    }
                    else
                    {
                        if (order.IsReceived_All == 0)
                            if (showcolor == 1)
                                res = "<span style=\"color:#FF20FF\">" + Language.Tag("�����ջ�", LanuageCode) + "</span>";
                            else
                                res = Language.Tag("�����ջ�", LanuageCode);
                        else
                            if (showcolor == 1)
                            res = "<span style=\"color:#BA17BA\">" + Language.Tag("���ջ�", LanuageCode) + "</span>";
                        else
                            res = Language.Tag("���ջ�", LanuageCode);
                    }
                }
            }
            else
            {
                if (showcolor == 1)
                    res = "<span style=\"color:#ABD0BC\">" + Language.Tag("��ȡ��", LanuageCode) + "</span>";
                else
                    res = Language.Tag("��ȡ��", LanuageCode);
            }
            if (order.IsRefund == 2)
            {
                if (showcolor == 1)
                    res = "<span style=\"color:#800000\">" + Language.Tag("����ȡ��", LanuageCode) + "</span>";
                else
                    res = Language.Tag("����ȡ��", LanuageCode);
            }
            if (order.IsRefund == 2 && order.IsInvalid == 1)
            {
                if (showcolor == 1)
                    res = "<span style=\"color:#800000\">" + Language.Tag("��ȡ��", LanuageCode) + "</span>";
                else
                    res = Language.Tag("��ȡ��", LanuageCode);
            }
            return res;
        }
        /// <summary>
        /// ���㶩����һ����Ʒ�����ջ�����
        /// </summary>
        /// <param name="order_id"></param>
        /// <param name="product_id"></param>
        /// <returns></returns>
        public static int GetCount_ShouHuo(int order_id, int product_id)
        {
            int count = 0;
            List<Lebi_Transport_Order> models = B_Lebi_Transport_Order.GetList("Order_id=" + order_id + " and Type_id_TransportOrderStatus=223", "");
            foreach (Lebi_Transport_Order model in models)
            {
                List<TransportProduct> tps = EX_Area.GetTransportProduct(model);
                foreach (TransportProduct tp in tps)
                {
                    if (product_id == tp.Product_id)
                        count = count + tp.Count;
                }
            }
            return count;
        }
        /// <summary>
        /// ���㶩��ָ�����ڼ�״̬�Ķ������
        /// </summary>
        /// <param name="dateFrom"></param>
        /// <param name="dateTo"></param>
        /// <param name="status"></param>
        /// <returns></returns>
        public static decimal GetMoney_Order(string dateFrom, string dateTo, string status)
        {
            decimal money = 0;
            string where = "";
            if (dateFrom != "" && dateTo != "")
            {
                where = "Time_Add>='" + dateFrom + "' and Time_Add<='" + dateTo + " 23:59:59'";
            }
            if (status != "")
            {
                if (dateFrom != "" && dateTo != "")
                {
                    where += " and ";
                }
                where += status;
            }
            List<Lebi_Order> models = B_Lebi_Order.GetList(where, "");
            foreach (Lebi_Order model in models)
            {
                money = money + model.Money_Order;
            }
            return money;
        }
        public static decimal GetMoney_Order(string dateFrom, string dateTo, string status, int hour)
        {
            decimal money = 0;
            string where = "";
            if (dateFrom != "" && dateTo != "")
            {
                where = "Time_Add>='" + dateFrom + " " + hour + ":0:0' and Time_Add<='" + dateTo + " " + hour + ":59:59'";
            }
            if (status != "")
            {
                if (dateFrom != "" && dateTo != "")
                {
                    where += " and ";
                }
                where += status;
            }
            List<Lebi_Order> models = B_Lebi_Order.GetList(where, "");
            foreach (Lebi_Order model in models)
            {
                money = money + model.Money_Order;
            }
            return money;
        }
        /// <summary>
        /// ���㶩��ָ�����ڼ�״̬�Ķ�������
        /// </summary>
        /// <param name="dateFrom"></param>
        /// <param name="dateTo"></param>
        /// <param name="status"></param>
        /// <returns></returns>
        public static int GetCount_Order(string dateFrom, string dateTo, string status)
        {
            int count = 0;
            string where = "";
            if (dateFrom != "" && dateTo != "")
            {
                where = "Time_Add>='" + dateFrom + "' and Time_Add<='" + dateTo + " 23:59:59'";
            }
            if (status != "")
            {
                if (dateFrom != "" && dateTo != "")
                {
                    where += " and ";
                }
                where += status;
            }
            count = B_Lebi_Order.Counts(where);
            return count;
        }
        public static int GetCount_Order(string dateFrom, string dateTo, string status, int hour)
        {
            int count = 0;
            string where = "";
            if (dateFrom != "" && dateTo != "")
            {
                where = "Time_Add>='" + dateFrom + " " + hour + ":0:0' and Time_Add<='" + dateTo + " " + hour + ":59:59'";
            }
            if (status != "")
            {
                if (dateFrom != "" && dateTo != "")
                {
                    where += " and ";
                }
                where += status;
            }
            count = B_Lebi_Order.Counts(where);
            return count;
        }

        /// <summary>
        /// ��Ӷ������� Lebi.Kingdge 2014-10-10
        /// </summary>
        public static void CreateOrderProPerty(Lebi_Order order, Lebi_User user)
        {
            Lebi_Order_ProPerty Order_ProPerty = new Lebi_Order_ProPerty();
            string ProPertyid = RequestTool.RequestSafeString("ProPertyid");
            string[] ProPertyids = ProPertyid.Split(',');
            for (int i = 0; i < ProPertyids.Count(); i++)
            {
                if (RequestTool.RequestInt("Property135" + ProPertyids[i], 0) > 0)
                {
                    List<Lebi_ProPerty> ProPerty135 = B_Lebi_ProPerty.GetList("parentid = " + int.Parse(ProPertyids[i]) + "", "Sort desc");
                    Lebi_ProPerty ProPerty = B_Lebi_ProPerty.GetModel(int.Parse(ProPertyids[i]));
                    Lebi_ProPerty ProPertylist = B_Lebi_ProPerty.GetModel(RequestTool.RequestInt("Property135" + ProPertyids[i], 0));
                    Order_ProPerty.ProPertyParentid = int.Parse(ProPertyids[i]);
                    if (ProPerty != null)
                    {
                        Order_ProPerty.ProPertyName = ProPerty.Name;
                    }
                    if (ProPerty135.Count == 0)
                    {
                        Order_ProPerty.ProPertyid = 0;
                        Order_ProPerty.ProPertyValue = RequestTool.RequestSafeString("Property135" + ProPertyids[i]);
                    }
                    else
                    {
                        Order_ProPerty.ProPertyid = RequestTool.RequestInt("Property135" + ProPertyids[i], 0);
                        if (ProPertylist != null)
                        {
                            Order_ProPerty.ProPertyValue = ProPertylist.Name;
                        }
                    }
                    Order_ProPerty.Order_Code = order.Code;
                    Order_ProPerty.Order_id = order.id;
                    Order_ProPerty.User_id = user.id;
                    Order_ProPerty.User_UserName = user.UserName;
                    Order_ProPerty.Time_Add = System.DateTime.Now;
                    B_Lebi_Order_ProPerty.Add(Order_ProPerty);
                }
            }
        }
        #region ��������
        /// <summary>
        /// ȡ����������Ч������
        /// </summary>
        /// <param name="order"></param>
        public static void Order_Cancal(Lebi_Order order, int isadmin = 0)
        {
            order.IsInvalid = 1;
            order.Time_Completed = System.DateTime.Now;
            order.IsVerified = 0;
            B_Lebi_Order.Update(order);
            List<Lebi_Order_Product> models = B_Lebi_Order_Product.GetList("Order_id=" + order.id + "", "");
            switch (order.Type_id_OrderType)
            {
                case 211://�����������������
                    if (order.IsPaid == 0)
                    {
                        //if (order.Flag == 1)
                        //{
                        //    foreach (Lebi_Order_Product model in models)
                        //    {
                        //        Lebi_Product pro = B_Lebi_Product.GetModel(model.Product_id);
                        //        EX_Product.Reset_Count_Freeze(pro);//���㶳����

                        //    }
                        //}
                        foreach (Lebi_Order_Product model in models)
                        {
                            Lebi_Product pro = B_Lebi_Product.GetModel(model.Product_id);
                            //�޸Ķ�����
                            if (ShopCache.GetBaseConfig().ProductStockFreezeTime == "orderadd")
                            {
                                //EX_Product.ProductStock_Freeze(pro, 0 - (model.Count - model.Count_Shipped));
                                //���¿��
                                EX_Product.ProductStock_Change(pro, (model.Count - model.Count_Shipped), 302, order, "ȡ������");
                            }
                            //EX_Product.Reset_Count_Freeze(pro);//���㶳����
                        }
                        order.IsRefund = 1;
                        order.Time_Refund = System.DateTime.Now;
                    }
                    if (isadmin == 1)
                    {
                        //<-{����ע��������Order_Pay_Cancal(order) 2018.6.20 by lebi.kingdge
                        //if (order.IsPaid == 1)
                        //{
                        //    Lebi_User user = B_Lebi_User.GetModel(order.User_id);
                        //    if (user != null)
                        //    {
                        //        if (order.Money_Paid == 0)//����3.7ǰ�ɰ汾
                        //            order.Money_Paid = order.Money_Pay + order.Money_UserCut;
                        //        Money.AddMoney(user, order.Money_Paid, 195, null, Shop.Bussiness.Language.Content("ȡ������", user.Language) + " " + order.Code, Shop.Bussiness.Language.Content("ȡ������", user.Language) + " " + order.Code);
                        //    }
                        //    //����Ӧ�̶����������Ѿ��������״̬�޸�Ϊ��Ч
                        //    if (order.Supplier_id > 0)
                        //    {
                        //        List<Lebi_Supplier_Money> smoneys = B_Lebi_Supplier_Money.GetList("Order_id=" + order.id + "", "");
                        //        foreach (Lebi_Supplier_Money smoney in smoneys)
                        //        {
                        //            smoney.Type_id_MoneyStatus = 182;
                        //            smoney.Remark += ",����ȡ��";
                        //            B_Lebi_Supplier_Money.Update(smoney);
                        //        }
                        //    }
                        //    order.IsPaid = 0;
                        //}
                        //}->
                        Order_Pay_Cancal(order);
                        foreach (Lebi_Order_Product model in models)
                        {
                            Lebi_Product pro = B_Lebi_Product.GetModel(model.Product_id);
                            //�޸Ķ�����
                            if (ShopCache.GetBaseConfig().ProductStockFreezeTime == "orderadd")
                            {
                                //EX_Product.ProductStock_Freeze(pro, 0 - (model.Count - model.Count_Shipped));
                                //���¿��
                                EX_Product.ProductStock_Change(pro, (model.Count - model.Count_Shipped), 302, order, "ȡ������");
                            }
                            //EX_Product.Reset_Count_Freeze(pro);//���㶳����

                        }
                        order.IsRefund = 1;
                        order.Time_Refund = System.DateTime.Now;
                    }
                    break;
                case 212://�˻����޸�ԭ���˻�����
                    if (order.Flag == 1)
                    {
                        foreach (Lebi_Order_Product model in models)
                        {
                            Lebi_Order_Product op = B_Lebi_Order_Product.GetModel("Order_id=" + model.Order_id + " and Product_id=" + model.Product_id + " and Type_id_OrderProductType=251");
                            if (op != null)
                            {
                                op.Count_Return = op.Count_Return - model.Count;
                                B_Lebi_Order_Product.Update(op);
                            }
                        }
                    }
                    break;
            }

            Agent.AgentMoneyDelete(order);//������Ӷ��ɾ��
            OrderCancal(order);//�����¼�
        }
        /// <summary>
        /// ����Ч������Ϊ��Ч����
        /// </summary>
        /// <param name="order"></param>
        public static void Order_Confirm(Lebi_Order order, out string res)
        {
            res = "";
            if (order.IsVerified == 1)
            {
                return;
            }
            order.Time_Verified = System.DateTime.Now;
            order.IsInvalid = 0;
            order.IsVerified = 1;
            order.IsRefund = 0;
            order.Flag = 1;
            B_Lebi_Order.Update(order);
            List<Lebi_Order_Product> models = B_Lebi_Order_Product.GetList("Order_id=" + order.id + "", "");
            switch (order.Type_id_OrderType)
            {
                case 211://��������������
                    if (ShopCache.GetBaseConfig().ProductStockFreezeTime == "orderadd")
                    {
                        foreach (Lebi_Order_Product model in models)
                        {
                            Lebi_Product pro = B_Lebi_Product.GetModel(model.Product_id);
                            //EX_Product.ProductStock_Freeze(pro, (model.Count - model.Count_Shipped));//�޸Ķ�����
                            //���¿��
                            EX_Product.ProductStock_Change(pro, 0 - (model.Count - model.Count_Shipped), 302, order, "����Ч������Ϊ��Ч����");
                        }
                    }
                    if (ShopCache.GetBaseConfig().ProductStockFreezeTime == "" || ShopCache.GetBaseConfig().ProductStockFreezeTime == "orderconfirm")
                    {
                        foreach (Lebi_Order_Product model in models)
                        {
                            Lebi_Product pro = B_Lebi_Product.GetModel(model.Product_id);
                            EX_Product.ProductStock_Change(pro, 0 - (model.Count - model.Count_Shipped), 302, order, "����Ч������Ϊ��Ч����");
                            //EX_Product.Reset_Count_Freeze(pro);//���㶳����
                        }
                    }
                    break;
                case 212://�˻����޸�ԭ���˻�����
                    foreach (Lebi_Order_Product model in models)
                    {
                        Lebi_Order_Product op = B_Lebi_Order_Product.GetModel("Order_id=" + order.Order_id + " and Product_id=" + model.Product_id + " and Type_id_OrderProductType=251");
                        if (op != null)
                        {
                            //op.Count_Return = op.Count_Return + model.Count;
                            if (op.Count_Return > op.Count_Received)
                            {
                                res = "�˻��������ܴ����ջ�����";
                                return;
                            }
                            B_Lebi_Order_Product.Update(op);
                        }
                    }
                    break;
            }

            //����Ӷ��
            Agent agent = new Agent(order);
            agent.Operation();

            OrderConfirm(order);//�����¼�
        }
        public static void Order_Confirm(Lebi_Order order)
        {
            string res = "";
            Order_Confirm(order, out res);
        }
        /// <summary>
        /// ��˶���-ȡ��
        /// </summary>
        /// <param name="order"></param>
        public static void Order_Check_Cancal(Lebi_Order order)
        {
            order.IsVerified = 0;
            B_Lebi_Order.Update(order);
            List<Lebi_Order_Product> ops = B_Lebi_Order_Product.GetList("Order_id=" + order.id + "", "");
            foreach (Lebi_Order_Product op in ops)
            {
                Lebi_Product pro = B_Lebi_Product.GetModel(op.Product_id);
                if (pro != null)
                {
                    //EX_Product.Reset_Count_Freeze(pro);
                    if (ShopCache.GetBaseConfig().ProductStockFreezeTime == "orderconfirm")
                    {
                        EX_Product.ProductStock_Change(pro, (op.Count - op.Count_Shipped), 302, order, "��˶���-ȡ��");
                        //EX_Product.Reset_Count_Freeze(pro);//���㶳����
                    }
                }
            }
            Agent.AgentMoneyDelete(order);//������Ӷ��ɾ��}

        }
        /// <summary>
        /// ��������-ȡ��ȷ��
        /// </summary>
        /// <param name="order"></param>
        public static void Order_Pay_Cancal(Lebi_Order order)
        {
            if (order.IsPaid == 0)
            {
                return;
            }
            //<-{������ˮ�ţ�����ƥ���ʽ���ϸ��¼ by lebi.kingdge 2018.8.20
            Random ran = new Random();
            order.PayNo = order.Code + System.DateTime.Now.Millisecond + ran.Next(100000, 999999);
            B_Lebi_Order.Update(order);
            //}->
            //<-{����Ѹ�����ص�Ԥ����˻� by lebi.kingdge 20151018
            Lebi_User user = B_Lebi_User.GetModel(order.User_id);
            if (user != null)
            {
                if (order.Money_fanxianpay != 0)
                {
                    Money.AddMoney(user, order.Money_fanxianpay, 195, order, null, Shop.Bussiness.Language.Tag("ȡ������", user.Language) + " " + order.Code, Shop.Bussiness.Language.Tag("ȡ������", user.Language) + " " + order.Code);
                }
                else
                {
                    Money.AddMoney(user, order.Money_Paid, 191, order, null, Shop.Bussiness.Language.Tag("ȡ������", user.Language) + " " + order.Code, Shop.Bussiness.Language.Tag("ȡ������", user.Language) + " " + order.Code);
                }
                //<-{����ʽ���ϸ���Ƿ������Ѽ�¼ by lebi.kingdge 2018.8.21
                decimal money_pay = 0;
                string _money_pay = B_Lebi_User_Money.GetValue("sum(money)", "Order_id = " + order.id + " and Order_PayNo = '" + order.PayNo + "' and (Type_id_MoneyType = 191 or Type_id_MoneyType = 195)");
                money_pay = Convert.ToDecimal(_money_pay);
                if (money_pay < order.Money_Order)
                {
                    Log.Add("ȡ��֧��ʧ��[�ʽ���ϸУ�����]", "Order", order.id.ToString(), user, "");
                    return;
                }
                //}->
            }
            //}->
            List<Lebi_Order_Product> models = B_Lebi_Order_Product.GetList("Order_id=" + order.id + "", "");
            //�޸Ķ����ڵ�Ԥ����Ʒ����״̬Ϊδ����
            List<Lebi_Order_Product> ops = B_Lebi_Order_Product.GetList("Order_id=" + order.id + " and IsReserve=1", "");
            foreach (Lebi_Order_Product op in ops)
            {
                if (op.IsPaid == 1)
                {
                    op.IsPaid = 0;
                }
                else
                {
                    op.IsPaidReserve = 0;
                }
                B_Lebi_Order_Product.Update(op);
            }
            //����Ӧ�̶����������Ѿ��������״̬�޸�Ϊ��Ч
            if (order.Supplier_id > 0)
            {
                List<Lebi_Supplier_Money> smoneys = B_Lebi_Supplier_Money.GetList("Order_id=" + order.id + "", "");
                foreach (Lebi_Supplier_Money smoney in smoneys)
                {
                    smoney.Type_id_MoneyStatus = 182;
                    smoney.Remark += ",����ȡ��";
                    B_Lebi_Supplier_Money.Update(smoney);
                }
            }
            //order.Time_Paid = System.DateTime.Now;
            order.IsPaid = 0;
            //order.Money_Paid = order.Money_Paid - order.Money_Pay;
            order.Money_Pay = order.Money_Order;
            order.Money_Paid = 0;
            order.Money_UserCut = 0; //���֧��������� by lebi.kingdge 2018.7.30
            order.Money_fanxianpay = 0;
            B_Lebi_Order.Update(order);
            Agent.AgentMoneyDelete(order);//������Ӷ��ɾ��}
            OrderPaidCancal(order);//�����¼�
        }
        /// <summary>
        /// �������
        /// </summary>
        /// <param name="order"></param>
        public static void Order_Completed(Lebi_Order order)
        {
            if (string.IsNullOrEmpty(order.PayNo))
            {
                Random ran = new Random();
                order.PayNo = Order.CreateOrderCode() + System.DateTime.Now.Millisecond + ran.Next(100000, 999999);
            }
            List<Lebi_Order_Product> models = B_Lebi_Order_Product.GetList("Order_id=" + order.id + "", "");
            foreach (Lebi_Order_Product model in models)
            {
                Lebi_Product pro = B_Lebi_Product.GetModel(model.Product_id);
                EX_Product.Reset_Count_Freeze(pro);//���㶳����
            }
            order.Time_Completed = System.DateTime.Now;
            order.IsCompleted = 1;
            B_Lebi_Order.Update(order);

            Lebi_User user = B_Lebi_User.GetModel(order.User_id);
            user.Count_Order_OK = user.Count_Order_OK + 1;
            user.Money_xiaofei = UserOrderMoney(user);
            user.Money_Order = user.Money_xiaofei;
            user.Money_Product = UserOrderMoney_Product(user);
            user.Money_Transport = UserOrderMoney_Transtport(user);
            user.Money_Bill = UserOrderMoney_Bill(user);
            B_Lebi_User.Update(user);
            //�����û��ֽ�--�����˻�
            if (order.Money_Give != 0 && order.Type_id_OrderType == 211)
            {
                Money.AddMoney(user, order.Money_Give, 195, order, null, "", "");
            }
            //�����û�����
            if (order.Point != 0)
            {
                //Lebi_User_Point point = new Lebi_User_Point();
                //point.Type_id_PointStatus = 171;
                //point.Point = order.Point;
                //point.Remark = order.Code;
                //point.Time_Update = DateTime.Now;
                //point.User_id = user.id;
                //point.User_RealName = user.RealName;
                //point.User_UserName = user.UserName;
                //B_Lebi_User_Point.Add(point);
                //EX_User.UpdateUserPoint(user);
                Point.AddPoint(user, order.Point, 171, order, null, order.Code, order.PayNo);
            }
            if (order.Type_id_OrderType == 211 || order.Type_id_OrderType == 212)//���ﵥ���˻�������Ӷ����Ч
            {
                Agent agent = new Agent(order);
                agent.AgentMoneyOK();
            }
            OrderComplete(order);
        }
        /// <summary>
        /// �������-ȡ��
        /// </summary>
        /// <param name="order"></param>
        public static void Order_Completed_Cancal(Lebi_Order order)
        {
            List<Lebi_Order_Product> models = B_Lebi_Order_Product.GetList("Order_id=" + order.id + "", "");
            foreach (Lebi_Order_Product model in models)
            {
                Lebi_Product pro = B_Lebi_Product.GetModel(model.Product_id);
                EX_Product.Reset_Count_Freeze(pro);//���㶳����
            }
            //order.Time_Paid = System.DateTime.Now;
            order.IsCompleted = 0;
            B_Lebi_Order.Update(order);
            Lebi_User user = B_Lebi_User.GetModel(order.User_id);
            user.Count_Order_OK = user.Count_Order_OK - 1;
            user.Money_xiaofei = UserOrderMoney(user);
            user.Money_Order = user.Money_xiaofei;
            user.Money_Product = UserOrderMoney_Product(user);
            user.Money_Transport = UserOrderMoney_Transtport(user);
            user.Money_Bill = UserOrderMoney_Bill(user);
            B_Lebi_User.Update(user);
            if (order.Money_Give != 0 && order.Type_id_OrderType == 211)
            {
                Money.AddMoney(user, 0 - order.Money_Give, 195, order, null, "", "");
            }
            //�����û�����
            if (order.Point != 0)
            {
                //Lebi_User_Point point = new Lebi_User_Point();
                //point.Type_id_PointStatus = 171;
                //point.Point = 0 - order.Point;
                //point.Remark = order.Code;
                //point.Time_Update = DateTime.Now;
                //point.User_id = user.id;
                //point.User_RealName = user.RealName;
                //point.User_UserName = user.UserName;
                //B_Lebi_User_Point.Add(point);
                //EX_User.UpdateUserPoint(user);
                Point.AddPoint(user, 0 - order.Point, 171, order, null, order.Code, order.PayNo);
            }

            if (order.Type_id_OrderType == 211 || order.Type_id_OrderType == 212)//���ﵥ���˻�������Ӷ����Ч
            {
                Agent agent = new Agent(order);
                agent.AgentMoneyCancal();
            }
            OrderCompleteCancal(order);
        }
        /// <summary>
        /// һ��Ա�Ķ����ܶ�
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static decimal UserOrderMoney(Lebi_User user)
        {
            string res_ = Common.GetValue("select sum(Money_Order) from Lebi_Order where User_id=" + user.id + " and IsCompleted=1");
            decimal res = 0;
            decimal.TryParse(res_, out res);
            return res;
        }
        /// <summary>
        /// һ��Ա�Ķ����ܶ�-��Ʒ
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static decimal UserOrderMoney_Product(Lebi_User user)
        {
            string res_ = Common.GetValue("select sum(Money_Product) from Lebi_Order where User_id=" + user.id + " and IsCompleted=1");
            decimal res = 0;
            decimal.TryParse(res_, out res);
            return res;
        }
        /// <summary>
        /// һ��Ա�Ķ����ܶ�-�˷�
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static decimal UserOrderMoney_Transtport(Lebi_User user)
        {
            string res_ = Common.GetValue("select sum(Money_Transport+Money_Transport_Cut) from Lebi_Order where User_id=" + user.id + " and IsCompleted=1");
            decimal res = 0;
            decimal.TryParse(res_, out res);
            return res;
        }
        /// <summary>
        /// һ��Ա�Ķ����ܶ�-˰��
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static decimal UserOrderMoney_Bill(Lebi_User user)
        {
            string res_ = Common.GetValue("select sum(Money_Bill) from Lebi_Order where User_id=" + user.id + " and IsCompleted=1");
            decimal res = 0;
            decimal.TryParse(res_, out res);
            return res;
        }
        /// <summary>
        /// ��ȡ����
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Lebi_Order GetOrder(int id)
        {
            Lebi_Order order = B_Lebi_Order.GetModel("id = " + id);
            if (order == null)
                order = new Lebi_Order();
            return order;
        }
        /// <summary>
        /// �ж϶����Ƿ����ȡ��
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public static bool CancelOrder(Lebi_Order order)
        {
            //Lebi_Pay pay = B_Lebi_Pay.GetModel(order.Pay_id);
            //if (pay == null)
            //    pay = new Lebi_Pay();
            if ((order.IsInvalid == 0 && order.IsRefund == 0) && (order.IsShipped == 0 && order.IsShipped_All == 0) && order.IsReceived == 0 && order.IsReceived_All == 0)
            {
                return true;
            }
            return false;
        }
        #endregion
        #region ����֧��
        /// <summary>
        /// �����û���Ϣ
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Lebi_OnlinePay GetOnlinePay(int id)
        {
            Lebi_OnlinePay pay = B_Lebi_OnlinePay.GetModel(id);
            if (pay == null)
            {
                pay = new Lebi_OnlinePay();
            }
            return pay;
        }
        #endregion
    }


}

