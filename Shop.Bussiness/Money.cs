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
    public class Money
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="user"></param>
        /// <param name="money"></param>
        /// <param name="type"></param>
        /// <param name="admin"></param>
        /// <param name="description"></param>
        /// <param name="remark"></param>
        /// <param name="fanxian">�Ƿ�������ֿ�����</param>
        public static void AddMoney(Lebi_User user, decimal money, int type, Lebi_Administrator admin, string description, string remark, bool fanxian = true)
        {
            AddMoney(user,money,type,null,admin,description,remark,fanxian);
        }
        public static void AddMoney(Lebi_User user, decimal money, int type, Lebi_Order order, Lebi_Administrator admin, string description, string remark, bool fanxian = true)
        {
            if (money == 0)
                return;
            if (type == 192 || type == 193)
            {
                if (money > 0)
                {
                    money = 0 - money;
                }
            }
            Lebi_User_Money mo = new Lebi_User_Money();
            if (admin != null)
            {
                mo.Admin_id = admin.id;
                mo.Admin_UserName = admin.UserName;
            }
            mo.Money = money;
            mo.Type_id_MoneyStatus = 181;
            mo.Type_id_MoneyType = type;
            mo.User_id = user.id;
            mo.User_UserName = user.UserName;
            mo.User_RealName = user.RealName;
            mo.Description = description;
            mo.Remark = remark;
            if (order != null)
            {
                mo.Order_id = order.id;
                mo.Order_Code = order.Code;
                mo.Order_PayNo = order.PayNo;
            }
            //string money_ = B_Lebi_User_Money.GetValue("sum(Money)", "User_id=" + user.id + " and Type_id_MoneyStatus=181");
            //decimal Money = 0;
            //Decimal.TryParse(money_, out Money);
            if (type == 195)//����
            {
                user.Money_fanxian = user.Money_fanxian + money;
            }
            if (type == 192 && fanxian == true)//����
            {

                user.Money_fanxian = user.Money_fanxian + money;
                if (user.Money_fanxian < 0)
                    user.Money_fanxian = 0;
            }
            user.Money = user.Money + money;
            B_Lebi_User.Update(user);
            mo.Money_after = user.Money;
            mo.Money_fanxian_after = user.Money_fanxian;
            B_Lebi_User_Money.Add(mo);
            //���Ͷ���
            SMS.SendSMS_balance(user);
            //APP����
            APP.Push_balance(user);
        }
        /// <summary>
        /// ���»�Ա�ʽ�
        /// </summary>
        /// <param name="user"></param>
        public static void UpdateUserMoney(Lebi_User user)
        {
            string money = B_Lebi_User_Money.GetValue("sum(Money)", "User_id=" + user.id + " and Type_id_MoneyStatus=181");
            decimal Money = 0;
            Decimal.TryParse(money, out Money);
            user.Money = Money;
            B_Lebi_User.Update(user);
        }

        /// <summary>
        /// ������߸���ӿڲ���MODEL
        /// </summary>
        /// <param name="code"></param>
        /// <param name="order"></param>
        public static Lebi_OnlinePay GetOnlinePay(Lebi_Order order, string code)
        {
            if (order == null)
                return null;
            string where = "Code='" + code + "'";
            if (string.IsNullOrEmpty(order.KeyCode))
            {
                if (order.IsSupplierCash == 0 && order.Language_id > 0)
                    where += " and ','+Language_ids+',' like '%," + order.Language_id + ",%'";
            }
            Lebi_OnlinePay pay = B_Lebi_OnlinePay.GetModel(where);
            string log = "";
            if (pay == null)
            {
                pay = B_Lebi_OnlinePay.GetModel("Code='" + code + "'");
            }
            if (pay == null)
            {
                log = "����֧���ӿ� " + code + " ���ô���";
                Log.Add(log);
            }
            else
            {
                if (order.IsSupplierCash == 1)
                {
                    Lebi_Supplier supplier = B_Lebi_Supplier.GetModel(order.Supplier_id);
                    if (supplier == null)
                    {
                        supplier = new Lebi_Supplier();
                        log = "����֧���ӿ� " + code + " ���ô���[��Ӧ��ID:" + order.Supplier_id + "]";
                        Log.Add(log);
                        return pay;
                    }
                    Lebi_OnlinePay supplierpay = B_Lebi_OnlinePay.GetModel("Code='" + code + "' and Supplier_id=" + supplier.id + "");
                    if (supplierpay == null)
                    {
                        log = "����֧���ӿ� " + code + " ���ô���[��Ӧ��:" + supplier.SubName + ",ID:" + order.Supplier_id + "]";
                        Log.Add(log);
                        return pay;
                    }
                    supplierpay.TypeName = pay.TypeName;
                    supplierpay.Url = pay.Url;
                    supplierpay.Code = pay.Code;
                    supplierpay.Currency_Code = pay.Currency_Code;
                    supplierpay.Currency_id = pay.Currency_id;
                    supplierpay.Currency_Name = pay.Currency_Name;
                    return supplierpay;

                }
            }
            return pay;
        }
        public static Lebi_OnlinePay GetOnlinePay(string ordercode, string paycode)
        {
            Lebi_Order order = B_Lebi_Order.GetModel("Code=lbsql{'" + ordercode + "'}");
            return GetOnlinePay(order, paycode);
        }
    }
}

