﻿using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using Shop.Model;using DB.LebiShop;
using Shop.Bussiness;
using LB.Tools;
namespace Com.Alipay.batch
{
    /// <summary>
    /// 功能：服务器异步通知页面
    /// 版本：3.3
    /// 日期：2012-07-10
    /// 说明：
    /// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
    /// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
    /// 
    /// ///////////////////页面功能说明///////////////////
    /// 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
    /// 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。
    /// 该页面调试工具请使用写文本函数logResult。
    /// 如果没有收到该页面返回的 success 信息，支付宝会在24小时内按一定的时间策略重发通知
    /// </summary>
    public partial class notify_url : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Lebi_OnlinePay pay = B_Lebi_OnlinePay.GetModel("Code='alipaybatch'");
            if (pay == null)
            {
                Response.Write("参数错误");
                Response.End();
                return;
            }

            SortedDictionary<string, string> sPara = GetRequestPost();

            if (sPara.Count > 0)//判断是否有带返回参数
            {
                Notify aliNotify = new Notify();
                bool verifyResult = aliNotify.Verify(sPara, Request.Form["notify_id"], Request.Form["sign"]);

                if (verifyResult)//验证成功
                {
                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //请在这里加上商户的业务逻辑程序代码
                    string batch_no = RequestTool.RequestSafeString("batch_no");
                    Lebi_Cash_alipay cash = B_Lebi_Cash_alipay.GetModel("Code='" + batch_no + "'");
                    if (cash != null)
                    {
                        //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                        //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表

                        //批量付款数据中转账成功的详细信息
                        //格式为：流水号^收款方账号^收款
                        //账号姓名^付款金额^成功标识(S)^
                        //成功原因(null)^支付宝内部流水号
                        //^完成时间。
                        //每条记录以“ |”间隔
                        string success_details = RequestTool.RequestString("success_details");
                        //批量付款数据中转账失败的详细信息
                        string fail_details = RequestTool.RequestString("fail_details");

                        string[] arr = success_details.Split('|');
                        foreach (string temp in arr)
                        {
                            string[] item = temp.Split('^');
                            Lebi_Cash model = B_Lebi_Cash.GetModel("id=" + item[0] + "");
                            if (model != null)
                            {
                                model.Type_id_CashStatus = 402;
                                B_Lebi_Cash.Update(model);
                            }
                        }

                        cash.Time_Paid = System.DateTime.Now;
                        cash.IsPaid = 1;
                        cash.result_no = fail_details;
                        cash.result_yes = success_details;
                        B_Lebi_Cash_alipay.Update(cash);

                        //判断是否在商户网站中已经做过了这次通知返回的处理
                        //如果没有做过处理，那么执行商户的业务程序
                        //如果有做过处理，那么不执行商户的业务程序
                    }
                    Response.Write("success");  //请不要修改或删除

                    //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                }
                else//验证失败
                {
                    Response.Write("fail");
                }
            }
            else
            {
                Response.Write("无通知参数");
            }
        }

        /// <summary>
        /// 获取支付宝POST过来通知消息，并以“参数名=参数值”的形式组成数组
        /// </summary>
        /// <returns>request回来的信息组成的数组</returns>
        public SortedDictionary<string, string> GetRequestPost()
        {
            int i = 0;
            SortedDictionary<string, string> sArray = new SortedDictionary<string, string>();
            NameValueCollection coll;
            //Load Form variables into NameValueCollection variable.
            coll = Request.Form;

            // Get names of all forms into a string array.
            String[] requestItem = coll.AllKeys;

            for (i = 0; i < requestItem.Length; i++)
            {
                sArray.Add(requestItem[i], Request.Form[requestItem[i]]);
            }

            return sArray;
        }
    }
}