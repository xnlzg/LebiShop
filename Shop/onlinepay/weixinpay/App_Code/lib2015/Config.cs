﻿using System;
using System.Collections.Generic;
using System.Web;
using Shop.Model;using DB.LebiShop;
using Shop.Bussiness;
using LB.Tools;

namespace weixinpay
{
    /**
    * 	配置账号信息
    */
    public class WxPayConfig
    {
        //=======【基本信息设置】=====================================
        /* 微信公众号信息配置
        * APPID：绑定支付的APPID（必须配置）
        * MCHID：商户号（必须配置）
        * KEY：商户支付密钥，参考开户邮件设置（必须配置）
        * APPSECRET：公众帐号secert（仅JSAPI支付的时候需要配置）
        */
        public string APPID = "";
        public string MCHID = "";
        public string KEY = "";
        //public string APPSECRET = "";

        //=======【证书路径设置】===================================== 
        /* 证书路径,注意应该填写绝对路径（仅退款、撤销订单时需要）
        */
        public const string SSLCERT_PATH = "cert/apiclient_cert.p12";
        public const string SSLCERT_PASSWORD = "1233410002";



        //=======【支付结果通知url】===================================== 
        /* 支付结果通知回调url，用于商户接收支付结果
        */
        public string NOTIFY_URL = "";

        //=======【商户系统后台机器IP】===================================== 
        /* 此参数可手动配置也可在程序中自动获取
        */
        public static string IP = HttpContext.Current.Request.ServerVariables.Get("Local_Addr").ToString();


        //=======【代理服务器设置】===================================
        /* 默认IP和端口号分别为0.0.0.0和0，此时不开启代理（如有需要才设置）
        */
        //public const string PROXY_URL = "http://10.152.18.220:8080";
        public const string PROXY_URL = "http://0.0.0.0:0";
        //=======【上报信息配置】===================================
        /* 测速上报等级，0.关闭上报; 1.仅错误时上报; 2.全量上报
        */
        public const int REPORT_LEVENL = 1;

        //=======【日志级别】===================================
        /* 日志等级，0.不输出日志；1.只输出错误信息; 2.输出错误和正常信息; 3.输出错误信息、正常信息和调试信息
        */
        public const int LOG_LEVENL = 0;



        public WxPayConfig(Lebi_Order order)
        {
            //SystemLog.Add("weixinpay-WxPayConfig" + "where : " + where);
            Lebi_OnlinePay onlinepay = Shop.Bussiness.Money.GetOnlinePay(order, "weixinpay");
            if (onlinepay == null)
            {
                Log.Add("在线支付接口 weixinpay 配置错误");
                return;
            }
            Shop.Bussiness.Site site = new Shop.Bussiness.Site();
            B_BaseConfig bconfig = new B_BaseConfig();
            BaseConfig SYS = bconfig.LoadConfig();
            MCHID = onlinepay.UserName;
            KEY = onlinepay.UserKey;
            APPID = onlinepay.Appid;
            //SystemLog.Add("weixinpay-WxPayConfig" + "MCHID : " + MCHID + "，KEY : " + KEY + "，APPID : " + APPID);
            //APPSECRET = onlinepay.Appkey;
            //IP = HttpContext.Current.Request.ServerVariables.Get("Local_Addr");
            NOTIFY_URL = "http://" + RequestTool.GetRequestDomain() + site.WebPath + "/onlinepay/weixinpay/payNotifyUrl.aspx";
        }
    }
}