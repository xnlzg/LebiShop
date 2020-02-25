using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Linq;
using Shop.Model;
using DB.LebiShop;
using LB.Tools;
using LB.DataAccess;
using System.Web.Script.Serialization;
using System.Collections.Specialized;

namespace Shop.Bussiness
{
    public class Basket : ShopPage
    {
        public decimal Weight = 0;//����������
        public decimal Volume = 0;//���������
        public decimal Money_Product = 0;//��Ʒ�ܽ��
        public decimal Money_Property = 0;//���Լ۸����ӳ����ޣ��ܺͽ��
        public decimal Money_Product_begin = 0;//δ�������ǰ����Ʒ�ܽ��
        public decimal Money_Cut = 0;//������
        public decimal Money_Give = 0;//�������
        //public decimal Money_Transport_One = 0;//�����˷�,
        //public bool IsTransportPriceOne = false;//�Ƿ񶨶��˷�,
        public decimal Money_Market = 0;//��Ʒ�г����ܽ��
        public int Count = 0;//��Ʒ����
        public decimal Point = 0;//��û�������
        public decimal Point_Product = 0;//��Ʒ��û�������
        public decimal Point_Free = 0;//���ͻ���
        public decimal Point_Buy = 0;//���ֻ��������������
        public List<Lebi_User_Product> Products; //���ﳵ��Ʒ
        public List<Lebi_User_Product> FreeProducts; //��Ʒ
        public List<Lebi_Promotion_Type> PromotionTypes;//���������Ĵ����
        public List<BasketShop> Shops;//����Ʒ�������̷��飬�������˷�
        public bool IsMutiCash = false;//�Ƿ���Ҫ�ֿ����㣨��Ӧ�̶����տ�������
        public int cashsupplierid = 0;//��ǰ���˵Ĺ�Ӧ��ID
        public decimal Money_Refund_VAT = 0;//����˰��
        public decimal Money_Refund_Fee = 0;//��˰������
        public decimal Money_Refund = 0;//��˰�ܶ�
        public decimal Money_Product_NOVAT = 0;//��Ʒ����˰
        public decimal OtherSite_Money_Refund = 0;//������վ��˰�ܶ�
        public decimal Money_Tax = 0; //˰��
        /// <summary>
        /// sid=0��ȡ��ȫ����Ӧ�̵���Ʒ
        /// </summary>
        /// <param name="type"></param>
        public Basket(int sid)
        {
            Products = Basket.UserProduct(CurrentUser, 142);

            PromotionTypes = new List<Lebi_Promotion_Type>();
            FreeProducts = new List<Lebi_User_Product>();
            Shops = new List<BasketShop>();
            List<BasketShop> tempShops = new List<BasketShop>();
            List<string> brandstring = new List<string>();
            foreach (Lebi_User_Product pro in Products)
            {
                try
                {
                    Lebi_Product product = B_Lebi_Product.GetModel(pro.Product_id);
                    if (product == null)
                        continue;
                    bool ishavebrand = false;
                    for (int i = 0; i < brandstring.Count(); i++)
                    {
                        if (brandstring[i].Contains(product.Brand_id.ToString() + ":"))
                        {
                            brandstring[i] += "," + pro.Product_id;
                            ishavebrand = true;
                            break;
                        }
                    }
                    if (!ishavebrand)
                    {
                        brandstring.Add(product.Brand_id.ToString() + ":" + pro.Product_id);
                    }
                    if (product.Type_id_ProductType == 324)//Ԥ����Ʒ
                        pro.Product_Price = product.Price_reserve;//Ԥ�����
                    else
                        pro.Product_Price = EX_Product.ProductPrice(product, CurrentUserLevel, CurrentUser, pro.count);//����
                    //<-{����Ʒ�Ʋ���˰��Ʒ�ܶ�  by lebi.kingdge 2015-08-22
                    Lebi_Brand brand = B_Lebi_Brand.GetModel(product.Brand_id);
                    if (brand != null)
                    {
                        if (brand.IsVAT == 0)
                            Money_Product_NOVAT += pro.Product_Price * pro.count;
                    }
                    //}->
                    Lebi_Supplier shop = B_Lebi_Supplier.GetModel(product.Supplier_id);
                    if (shop == null)
                    {
                        product.Supplier_id = 0;//�ݴ���Ʒ��Ӧ��ɾ��ʱ���̳Ƿ���
                        shop = new Lebi_Supplier();//��Ӫ��Ʒ
                    }
                    else
                    {
                        if (shop.IsSupplierTransport == 0)//�̳Ǵ����������
                        {
                            product.Supplier_id = 0;
                            shop = new Lebi_Supplier();//��Ӫ��Ʒ
                        }
                    }

                    BasketShop bshop = (from m in tempShops
                                        where m.Shop.id == product.Supplier_id
                                        select m).ToList().FirstOrDefault();
                    if (bshop == null)
                    {

                        if (product.Supplier_id == 0)
                        {
                            //shop = new Lebi_Supplier();//��Ӫ��Ʒ
                            bshop = new BasketShop();
                            bshop.Shop = shop;
                            bshop.Products = new List<Lebi_User_Product>();
                            tempShops.Add(bshop);

                        }
                        else
                        {
                            bshop = new BasketShop();
                            bshop.Shop = shop;
                            bshop.Products = new List<Lebi_User_Product>();
                            tempShops.Add(bshop);
                        }
                    }
                    (from m in tempShops
                     where m.Shop.id == product.Supplier_id
                     select m).ToList().FirstOrDefault().Products.Add(pro);
                }
                catch (System.NullReferenceException)
                {

                }
            }
            tempShops = tempShops.OrderBy(a => a.Shop.id).ToList();
            if (SYS.IsSupplierCash == "1")
            {
                if (sid == 0)
                    sid = RequestTool.RequestInt("sid");
                if (sid == 0)
                {
                    string tempid = CookieTool.GetCookieString("supplier");
                    int.TryParse(tempid, out sid);
                }
                cashsupplierid = sid;
                bool flag = false;
                foreach (BasketShop shop in tempShops)
                {
                    if (shop.Shop.IsCash == 1)
                        IsMutiCash = true;
                    if (shop.Shop.id == cashsupplierid)
                        flag = true;
                }
                if (!flag)
                {
                    try
                    {
                        cashsupplierid = tempShops.FirstOrDefault().Shop.id;
                    }
                    catch
                    {
                        cashsupplierid = 0;
                    }
                }

                if (sid > 0)
                {
                    //ֻ������ǰ���㹩Ӧ�̵�����
                    List<int> ids = new List<int>();
                    for (int i = 0; i < tempShops.Count; i++)
                    {
                        if (tempShops[i].Shop.id == cashsupplierid)
                            Shops.Add(tempShops[i]);
                    }

                }
                else
                {
                    Shops = tempShops;
                }
            }
            else
            {
                Shops = tempShops;
            }
            Products = new List<Lebi_User_Product>();
            for (int i = 0; i < Shops.Count; i++)
            {
                Shops[i] = SetMoneyAndPoint(CurrentUser, CurrentUserLevel, Shops[i]);
                Weight += Shops[i].Weight;
                Volume += Shops[i].Volume;
                Money_Product += Shops[i].Money_Product;
                Money_Product_begin += Shops[i].Money_Product_begin;
                Money_Property += Shops[i].Money_Property;
                Money_Cut += Shops[i].Money_Cut;
                Money_Give += Shops[i].Money_Give;
                Money_Market += Shops[i].Money_Market;
                Count += Shops[i].Count;
                Point += Shops[i].Point;
                Point_Buy += Shops[i].Point_Buy;
                Point_Product += Shops[i].Point_Product;
                Point_Free += Shops[i].Point_Free;
                FreeProducts.AddRange(Shops[i].FreeProducts);
                PromotionTypes.AddRange(Shops[i].PromotionTypes);
                Products.AddRange(Shops[i].Products);
            }
            //<-{��˰����  by lebi.kingdge 2015-08-22
            decimal Refund_MinMoney = 0;
            decimal Refund_VAT = 0;
            decimal.TryParse(SYS.Refund_MinMoney, out Refund_MinMoney);
            decimal.TryParse(SYS.Refund_VAT, out Refund_VAT);
            if (Refund_MinMoney > 0)
            {
                if ((Money_Product - Money_Product_NOVAT) > Refund_MinMoney)
                {
                    Money_Refund_VAT = (Money_Product - Money_Product_NOVAT) * Refund_VAT / 100;
                    Money_Refund_Fee = Refund_Fee(SYS.Refund_StepR, Money_Refund_VAT, Money_Product - Money_Product_NOVAT);
                    Money_Refund = Money_Refund_VAT - Money_Refund_Fee;
                }
                else
                {
                    Money_Refund = 0;
                    Money_Refund_VAT = 0;
                    Money_Refund_Fee = 0;
                }
                //ѭ��Ʒ�Ƽ����Ʒ����˰
                if (Refund_VAT > 0)
                {
                    foreach (string bran in brandstring)
                    {
                        string[] arr = bran.Split(':');
                        Lebi_Brand brand = B_Lebi_Brand.GetModel("id=" + arr[0] + " and IsVAT = 1");
                        if (brand != null)
                        {
                            decimal Brand_Money_Product = 0;
                            decimal OtherSite_Money_Refund_VAT = 0;
                            decimal OtherSite_Money_Refund_Fee = 0;
                            List<Lebi_User_Product> user_products = (from m in Products where ("," + arr[1] + ",").Contains("," + m.Product_id + ",") select m).ToList();
                            foreach (Lebi_User_Product user_product in user_products)
                            {
                                Brand_Money_Product += user_product.Product_Price * user_product.count;
                            }
                            if (Brand_Money_Product >= Refund_MinMoney)
                            {
                                OtherSite_Money_Refund_VAT = Brand_Money_Product * Refund_VAT / 100;
                                OtherSite_Money_Refund_Fee = Refund_Fee(SYS.Refund_StepR, OtherSite_Money_Refund_VAT, Brand_Money_Product);
                                OtherSite_Money_Refund += OtherSite_Money_Refund_VAT - OtherSite_Money_Refund_Fee;
                            }
                        }
                    }
                }
            }
            //}->
            //<-{˰�����  by lebi.kingdge 2017-02-17
            decimal TaxRate = 0;
            decimal.TryParse(SYS.TaxRate, out TaxRate);
            if (TaxRate > 0)
            {
                Money_Tax = Money_Product * TaxRate / 100;
            }
            //}->
        }
        //������˰������
        public static decimal Refund_Fee(string Refund_StepR, decimal Money_Refund_VAT, decimal Money_Product)
        {
            double Money_Refund_VAT_ = Convert.ToDouble(Money_Refund_VAT);
            try
            {
                if (Refund_StepR != null)
                {
                    List<BaseConfigStepR> stepRs = B_BaseConfig.StepR(Refund_StepR);
                    if (stepRs.Count > 0)
                    {
                        foreach (BaseConfigStepR stepR in stepRs)
                        {
                            if (Money_Product > stepR.S)
                            {
                                double R = Convert.ToDouble(stepR.R);
                                return Convert.ToDecimal(Math.Pow(Money_Refund_VAT_, R));
                            }
                        }
                    }
                }
            }
            catch
            {
                return 0;
            }
            return 0;
        }
        /// <summary>
        /// �����û���ƷList
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        public static List<Lebi_User_Product> UserProduct(Lebi_User CurrentUser, int t)
        {
            return EX_User.UserProduct(CurrentUser, t);
        }
        /// <summary>
        /// ��չ��ﳵ|�ղؼ�
        /// </summary>
        public static void Clear(Lebi_User CurrentUser, int t)
        {
            if (CurrentUser.id > 0)//�Ѿ���¼
            {
                B_Lebi_User_Product.Delete("user_id=" + CurrentUser.id + " and type_id_UserProductType=" + t + "");
            }
            else//δ��¼
            {
                string CookieName = "UserProduct" + t;
                NameValueCollection nv = new NameValueCollection();
                CookieTool.WriteCookie(CookieName, nv, 0);
            }
        }
        /// <summary>
        /// ��鹺�ﳵ�Ƿ��������ȯʹ������
        /// </summary>
        /// <param name="basket"></param>
        /// <param name="card"></param>
        /// <returns></returns>
        public static bool CheckCard(Basket basket, Lebi_Card card)
        {
            if (card.Time_Begin > System.DateTime.Now)
            {
                return false;
            }
            if (card.Time_End <= System.DateTime.Now)
            {
                card.Type_id_CardStatus = 204;
                B_Lebi_Card.Update(card);
                return false;
            }
            if ((basket.Money_Product - basket.Money_Cut) < card.Money_Buy)
                return false;
            if (card.Pro_Type_ids == "")
                return true;
            foreach (Lebi_User_Product p in basket.Products)
            {
                Lebi_Product pro = B_Lebi_Product.GetModel(p.Product_id);
                Lebi_Pro_Type type = EX_Product.TopProductType(pro);
                if (("," + card.Pro_Type_ids + ",").Contains("," + type.id + ","))
                    return true;
            }
            return false;
        }

        /// <summary>
        /// ��������
        /// </summary>
        /// <param name="Products">��Ʒ��Ϣ</param>
        /// <param name="CurrentUser">������</param>
        /// <param name="shop">��Ӧ�̣�Ϊ�ձ�ʾ��Ӫ��Ʒ</param>
        /// <param name="basketshop"></param>
        public static BasketShop SetMoneyAndPoint(Lebi_User CurrentUser, Lebi_UserLevel CurrentUserLevel, BasketShop basketshop)
        {
            string pids = "0";
            decimal Money_Product_begin = 0;
            int Count = 0;
            decimal Weight = 0;//����������
            decimal Volume = 0;//���������

            int Money_Transport_One = 0;
            bool IsTransportPriceOne = false;
            decimal Money_Market = 0;
            decimal Money_Cut = 0;
            decimal Money_Give = 0;
            decimal Point_Free = 0;//���ͻ���
            decimal Point_Product = 0;//��Ʒ��õĻ���
            decimal Point = 0;//��õĻ�������
            decimal Point_Buy = 0;//���ֻ����������
            decimal Money_Product = 0;
            decimal Money_Property = 0;
            List<Lebi_User_Product> FreeProducts = new List<Lebi_User_Product>();
            List<Lebi_Promotion_Type> PromotionTypes = new List<Lebi_Promotion_Type>();
            if (CurrentUserLevel == null)
                CurrentUserLevel = B_Lebi_UserLevel.GetModel(CurrentUser.UserLevel_id);
            List<Lebi_User_Product> Products = basketshop.Products;
            Lebi_Supplier shop = basketshop.Shop;
            foreach (Lebi_User_Product pro in Products)
            {
                Lebi_Product product = B_Lebi_Product.GetModel(pro.Product_id);
                if (product == null)
                    continue;
                pro.Discount = 100;
                pro.Pointagain = 1;
                //pro.Product_Price = EX_Product.ProductPrice(product, CurrentUserLevel,pro.count);//����
                if (CurrentUserLevel.MoneyToPoint > 0)
                    pro.Product_Point = pro.Product_Price * CurrentUserLevel.MoneyToPoint + pro.Product_Point;//������Ʒ�ɵõĻ���
                pids += "," + pro.Product_id;
                Money_Product_begin = Math.Round(Money_Product_begin + pro.Product_Price * pro.count, 2);
                Count = Count + pro.count;
                Money_Market = Money_Market + EX_Product.ProductMarketPrice(product) * pro.count;  //���ݷ���  2018.3.8 by lebi.kingdge
                Money_Property = Money_Property + pro.ProPerty_Price * pro.count;
                Money_Product = Money_Product + pro.Product_Price * pro.count;
                Weight = Weight + product.Weight * pro.count;
                Volume = Volume + product.VolumeH * product.VolumeL * product.VolumeW * pro.count;
                Point_Product = Point_Product + Math.Round(pro.Product_Point * pro.count,2);
                Point = Point_Product + Point_Free;
                //320һ����Ʒ321��ʱ����322�Ź�323���ֻ���
                if (product.Type_id_ProductType == 323 && product.Time_Expired > System.DateTime.Now)
                {
                    Point_Buy = Point_Buy + product.Price_Sale * pro.count;
                }
            }

            List<Lebi_Promotion_Type> cps = Promotion.CurrentPromotionType();
            if (shop == null)
                shop = new Lebi_Supplier();
            foreach (Lebi_Promotion_Type cp in cps)
            {
                //����Ƿ����̵�������
                if (cp.Type_id_PromotionType == 421)
                {
                    if (shop.id > 0)
                        continue;
                }
                if (cp.Type_id_PromotionType == 422)
                {
                    if (shop.id != cp.Supplier_id)
                        continue;
                }
                //����Ա���
                if (!("," + cp.UserLevel_ids + ",").Contains("," + CurrentUserLevel.id + ","))
                    continue;

                bool flag = true;
                string where = "1=1";
                List<Lebi_User_Product> sps = null;
                foreach (Lebi_Promotion p in Promotion.GetPromotion(cp.id))//ֻƥ��һ������
                {
                    flag = true;
                    if (p.Case804 == "")
                        p.Case804 = "0";
                    if (p.Case805 == "")
                        p.Case805 = "0";
                    //��֤�������:801
                    if (p.IsCase801 == 1)
                    {
                        if (Money_Product_begin < p.Case801)
                        {
                            flag = false;
                            continue;
                        }
                    }
                    //��֤������Ʒ����:802

                    if (p.IsCase802 == 1)
                    {
                        if (Count < p.Case802)
                        {
                            flag = false;
                            continue;
                        }
                    }
                    //��֤��Ʒ����:804
                    if (p.IsCase804 == 1)
                    {
                        where += " and Pro_Type_id in (" + p.Case804 + ")";
                        if (B_Lebi_Product.Counts("id in (" + pids + ") and Pro_Type_id in (" + p.Case804 + ")") == 0)
                        {
                            flag = false;
                            continue;
                        }
                    }
                    //��֤������Ʒ:805
                    if (p.IsCase805 == 1)
                    {
                        where += "and id in (" + p.Case805 + ")";
                        if (B_Lebi_Product.Counts("id in (" + pids + ") and id in (" + p.Case805 + ")") == 0)
                        {
                            flag = false;
                            continue;
                        }
                    }
                    //��֤��Ʒ����:803
                    if (p.IsCase803 == 1)
                    {
                        string tids = "0";
                        //ȡ�����ﳵ�У���������ˮƽ�ߵ���Ʒ
                        foreach (Lebi_User_Product up in Products)
                        {
                            if (up.count >= p.Case803)
                            {
                                tids += "," + up.Product_id;
                            }
                        }
                        if (tids == "0")
                        {
                            flag = false;
                            continue;
                        }
                        where += " and id in (" + tids + ")";
                        if (B_Lebi_Product.Counts(where) == 0)
                        {
                            flag = false;
                            continue;
                        }
                    }
                    //��֤������ָ����Ʒ����:806
                    if (p.IsCase806 == 1)
                    {
                        if (p.Case804 == "" && p.Case805 == "")//δ�������������Ļ���ֱ��ʧ��
                        {
                            flag = false;
                            continue;
                        }
                        int count = 0;
                        //���㹺�ﳵ�а�����Ʒ������
                        foreach (Lebi_User_Product up in Products)
                        {
                            if (("," + p.Case804 + ",").Contains("," + up.Pro_Type_id + ",") || ("," + p.Case805 + ",").Contains("," + up.Product_id + ","))
                            {
                                count = count + up.count;
                            }
                        }
                        if (count < p.Case806)
                        {
                            flag = false;
                            continue;
                        }

                    }
                    //����������
                    if (flag)
                    {
                        //ȡ����֤�ɹ���ָ����Ʒ
                        sps = B_Lebi_User_Product.GetList("User_id=" + CurrentUser.id + " and type_id_UserProductType=142 and Product_id in (select id from [Lebi_Product] where " + where + ")", "");

                        //���㶨���˷�901
                        if (p.IsRule901 == 1)
                        {
                            Money_Transport_One = p.Rule901;
                            IsTransportPriceOne = true;
                        }
                        //�����ۿ�902
                        if (p.IsRule902 == 1)
                        {
                            foreach (Lebi_User_Product pro in Products)
                            {
                                pro.Discount = pro.Discount * p.Rule902 / 100;
                            }
                        }
                        //����ָ����Ʒ�ۿ�903
                        if (p.IsRule903 == 1)
                        {
                            if (sps != null)
                            {
                                foreach (Lebi_User_Product pro in Products)
                                {
                                    foreach (Lebi_User_Product sp in sps)
                                    {
                                        if (pro.id == sp.id)
                                            pro.Discount = pro.Discount * p.Rule903 / 100;
                                    }
                                }

                            }
                        }
                        //���������904
                        if (p.IsRule904 == 1)
                        {
                            Money_Cut = p.Rule904;
                        }
                        //���㷵�����905
                        if (p.IsRule905 == 1)
                        {
                            Money_Give = p.Rule905;
                        }
                        //�������ͻ���906
                        if (p.IsRule906 == 1)
                        {
                            Point_Free = p.Rule906;
                        }
                        //���㷭������907
                        if (p.IsRule907 == 1)
                        {
                            foreach (Lebi_User_Product pro in Products)
                            {
                                pro.Pointagain = pro.Pointagain + p.Rule907;
                            }
                        }
                        //����ָ����Ʒ�ۿ۷�������908
                        if (p.IsRule908 == 1)
                        {
                            if (sps != null)
                            {
                                foreach (Lebi_User_Product pro in Products)
                                {
                                    foreach (Lebi_User_Product sp in sps)
                                    {
                                        if (pro.id == sp.id)
                                            pro.Pointagain = pro.Pointagain + p.Rule908;
                                    }
                                }

                            }
                        }
                        //������Ʒ909
                        if (p.IsRule909 == 1)
                        {
                            //��ʱ����
                        }
                        //����ָ����Ʒ910
                        if (p.IsRule910 == 1)
                        {
                            if (sps != null)
                            {

                                foreach (Lebi_User_Product sp in sps)
                                {

                                    sp.count = p.Rule910;
                                    sp.Product_Price = 0;
                                    sp.Product_Point = 0;
                                    sp.Pointagain = 0;
                                    sp.Discount = 0;
                                    FreeProducts.Add(sp);

                                }

                            }
                        }
                        //��N��ָ����Ʒ����
                        if (p.IsRule912 == 1 && p.IsCase803 == 1 && p.Case803 > 0)
                        {
                            foreach (Lebi_User_Product pro in Products)
                            {
                                foreach (Lebi_User_Product sp in sps)
                                {
                                    if (pro.id == sp.id)
                                    {
                                        if (pro.count > p.Case803)
                                        {
                                            int n = sp.count / p.Case803;
                                            Money_Cut = Money_Cut + pro.Product_Price * (100 - p.Rule912) / 100 * n;
                                        }
                                    }
                                }
                            }

                        }
                        //���¼���۸����,

                        Money_Product = 0;
                        Point_Product = 0;
                        Point = 0;
                        foreach (Lebi_User_Product pro in Products)
                        {
                            Money_Product += Math.Round(pro.Product_Price * pro.count * pro.Discount / 100, 2);
                            Point_Product += Math.Round(pro.Product_Point * pro.count * pro.Pointagain);
                            Point = Point_Product + Point_Free;
                        }

                        break;//��֤�ɹ�������֤
                    }
                }
                if (flag)
                    PromotionTypes.Add(cp);
            }
            basketshop = new BasketShop();
            basketshop.FreeProducts = FreeProducts;
            basketshop.Money_Cut = Money_Cut;
            basketshop.Money_Give = Money_Give;
            basketshop.Money_Market = Money_Market;
            basketshop.Money_Product = Money_Product;
            basketshop.Money_Product_begin = Money_Product_begin;
            basketshop.Money_Transport = 0;
            basketshop.Point = Point;
            basketshop.Point_Free = Point_Free;
            basketshop.Point_Buy = Point_Buy;
            basketshop.Point_Product = Point_Product;
            basketshop.Products = Products;
            basketshop.PromotionTypes = PromotionTypes;
            basketshop.Shop = shop;
            basketshop.Volume = Volume;
            basketshop.Weight = Weight;
            basketshop.IsTransportPriceOne = IsTransportPriceOne;
            basketshop.Money_Transport_One = Money_Transport_One;
            basketshop.Count = Count;
            basketshop.Money_Property = Money_Property;
            return basketshop;

        }

    }

}

