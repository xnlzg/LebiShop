﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.P_UserProfile" validateRequest="false"%>


<%@ Import Namespace="Shop.Bussiness" %>
<%@ Import Namespace="Shop.Model" %>
<%@ Import Namespace="DB.LebiShop" %>
<%@ Import Namespace="System.Collections.Generic" %>
<% LoadPage("wangdayu523@163.com_37",1,"EN","P_UserProfile"); %>

<!DOCTYPE html PUBliC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<title><%=ThemePageMeta("P_UserProfile","title")%></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
<meta name="keywords" content="<%=ThemePageMeta("P_UserProfile","keywords")%>" />
<meta name="description" content="<%=ThemePageMeta("P_UserProfile","description")%>" />
<meta name="CurrenctCurrency" content="<%=CurrentCurrency.Code %>" />
<meta name="CurrenctCurrencyMsige" content="<%=CurrentCurrency.Msige %>" />
<meta name="CurrentExchangeRate" content="<%=CurrentCurrency.ExchangeRate %>" />
<meta name="CurrentLanguage" content="<%=CurrentLanguage.Code %>" />
<meta name="generator" content="LebiShop V<%=SYS.Version+"."+SYS.Version_Son %>" />
<meta name="copyright" content="2003-<%=DateTime.Now.Year %> lebi.cn" />
<link rel="shortcut icon" href="/theme/newdefault/images/favicon.ico"/>
<link rel="bookmark" href="/theme/newdefault/images/favicon.ico"/> 
<script type="text/javascript">
    var path = "<%=WebPath %>";
    var sitepath = "/";
    var langpath = "/EN/";
</script>
<script src="/Theme/system/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/Theme/system/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/Theme/system/js/main.js" type="text/javascript"></script>
<script src="<%=WebPath %>/ajax/js.aspx" type="text/javascript"></script>
<script src="/Theme/system/js/my97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/Theme/system/js/msclass.js" type="text/javascript"></script>
<script src="/Theme/system/js/prettyphoto/jquery.prettyphoto.js" type="text/javascript"></script>
<script src="/theme/newdefault/js/<%=CurrentLanguage.Code %>.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/Theme/system/css/system.css" />
<link rel="stylesheet" type="text/css" href="/Theme/system/js/jqueryuicss/redmond/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="/Theme/system/js/prettyphoto/css/prettyPhoto.css" />
<link rel="stylesheet" type="text/css" href="/theme/newdefault/css/css.css" />
<link rel="stylesheet" type="text/css" href="/theme/newdefault/css/<%=CurrentLanguage.Code %>.css" />
<link rel="stylesheet" type="text/css" href="/theme/newdefault/css/weiyu.css" />
<script src="/theme/newdefault/js/all-jquery.js" type="text/javascript"></script>
<script type="text/javascript">
    var bForcepc = fGetQuery("dv") == "pc";
    function fBrowserRedirect() {
        var sUserAgent = navigator.userAgent.toLowerCase();
        var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
        var bIsMidp = sUserAgent.match(/midp/i) == "midp";
        var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
        var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
        var bIsAndroid = sUserAgent.match(/android/i) == "android";
        var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
        var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
        if (bIsIphoneOs || bIsAndroid) {
            var sUrl = location.href;
            if (!bForcepc) {
                window.location.href = sUrl.replace("/<%=SYS.Domain%>/", "/<%=SYS.Domain%>/m/");
            }
        }
        if (bIsMidp || bIsUc7 || bIsUc || bIsCE || bIsWM) {
            var sUrl = location.href;
            if (!bForcepc) {
                window.location.href = sUrl.replace("/<%=SYS.Domain%>/", "/<%=SYS.Domain%>/m/");
            }
        }
    }
    function fGetQuery(name) {//获取参数值
        var sUrl = window.location.search.substr(1);
        var r = sUrl.match(new RegExp("(^|&)" + name + "=([^&]*)(&|$)"));
        return (r == null ? null : unescape(r[2]));
    }
    fBrowserRedirect();
</script>
 

</head>
<body>

<div class="head">
    <div class="top">
        <div class="center clearfix">
            <ul class="sns">
            	
                <li><a href="https://www.youtube.com/channel/UCuP7zVB_1u94BzaLCcMXYZA?view_as=subscriber" class="youtube" target="_blank"></a></li>
                
                <li><a href="https://plus.google.com/u/0/107335425411617972609/posts/p/pub" class="google" target="_blank"></a></li>
                <li><a href="https://twitter.com/crw_bathrooms" class="twitter" target="_blank"></a></li>
                <li><a href="https://www.facebook.com/profile.php?id=100009518509235&pnref=story" class="facebook" target="_blank"></a></li>
                <span class="userstatus" id="userstatus"><a href="<%=URL(" P_Register", "" ) %>"><%=Tag("免费注册")%></a> ┊ <a href="<%=URL(" P_Login", "" ) %>"><%=Tag("登录")%></a> </a></span>
            </ul>
            <ul>
                <li>

<div class="shoppingcart" id="basketstatus" >
</div>
<script type="text/javascript">    LoadPage(path + '/inc/basketstatus.aspx', 'basketstatus');</script>
</li>
                <li>

<div class="language">
    <ul class="droplanguage">
        <li class="language_li"><a class="noclick"><span>Site Language：</span><s><%if (CurrentLanguage.ImageUrl!=""){%><img src="<%=Image(CurrentLanguage.ImageUrl) %>" /><%}%><%=CurrentLanguage.Name %></s></a><dl
            class="language_li_content">
            <%List<DB.LebiShop.Lebi_Language> rWSls=Languages();RecordCount=rWSls.Count;int rWSl_index=1;
foreach (DB.LebiShop.Lebi_Language rWSl in rWSls){%>
            <dd <%if (rWSl_index==RecordCount){%>class="last" <%} %>>
                <a href="javascript:SetLanguage(<%=rWSl.id%>,'<%=rWSl.Code%>','<%=rWSl.Path%>');"><%if (rWSl.ImageUrl!=""){%><img src="<%=Image(rWSl.ImageUrl) %>" /><%}%><%=rWSl.Name%></a></dd>
            <%rWSl_index++;}%>
        </dl>
        </li>
    </ul>
</div>
</li>
                <li>

<%if(SYS.IsMutiCurrencyShow=="0"){ %>
<div class="currency">
    <ul class="dropcurrency">
        <li class="currency_li"><a class="noclick"><span>Currency：</span><s><%=CurrentCurrency.Code %></s></a><dl
            class="currency_li_content">
            <%Table="Lebi_Currency";Where="";Order="Sort desc";PageSize=20;pageindex=Rint("page");RecordCount=B_Lebi_Currency.Counts(Where);int JmWM_index=1;
List<Lebi_Currency> JmWMs = B_Lebi_Currency.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_Currency JmWM in JmWMs){%>
            <dd <%if (JmWM_index==RecordCount){%>class="last" <%} %>>
                <a href="javascript:SetCurrency(<%=JmWM.id%>,'<%=JmWM.Code%>',<%=JmWM.ExchangeRate%>,'<%=JmWM.Msige%>','<%=JmWM.DecimalLength%>');"><%=JmWM.Code%></a></dd>
            <%JmWM_index++;}%>
        </dl>
        </li>
    </ul>
</div>
<%} %>

</li>
                <li><a href="<%=site.GatherUrl%>"><%=Tag("集运系统")%></a></li>
            </ul>
        </div>
    </div>
    <script type="text/javascript">        LoadPage(path + '/inc/userstatus.aspx', 'userstatus');</script>
    <div class="head-main">
        <h1 class="logo">
           

<a href="/EN/"><img src="<%=Image(Lang(SYS.Logoimg)) %>" alt="<%=Lang(SYS.Name)%>" title="<%=Lang(SYS.Name)%>" /></a>
</h1>
        <div class="search">
            

<script type="text/javascript">
    $(function () {
        blurInput('#keyword', '<%if (Rstring("Keyword")!=""){ %><%=Rstring("Keyword")%><%}else{%><%Table="Lebi_Searchkey";Where="Type=1";Order="Sort desc,id desc";PageSize=1;pageindex=1;RecordCount=B_Lebi_Searchkey.Counts(Where);int RVJK_index=1;
List<Lebi_Searchkey> RVJKs = B_Lebi_Searchkey.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_Searchkey RVJK in RVJKs){%><%=Lang(RVJK.Name)%><%RVJK_index++;}%><%} %>');
        $(".searchform .button").click(function(){
            var typename = $('#searchtype').attr('typename');
            var url = "";
            if (typename=="product")
            {
                var url = "<%=URL("P_Search","[key]") %>";
            }
            if (typename=="shop")
            {
                url = "<%=URL("P_ShopSearch","[key]") %>";
            }
            location.href = url.replace("[key]",escape($("#keyword").val()));
            return false;
        });
        $(".searchform dd a").click(function(){
            $(".searchform dl span").text($(this).text());
            $(".searchform dl span").attr("typename",$(this).attr("typename"));
            $(".searchform dd").hide();
        });
        $(".searchform-type").hover(function () {
            $(".searchform dd").show();
        }, function () {
            $(".searchform dd").hide();
        });
    });		
</script>
<div class="searchform">
<div class="searchform-type">
<dl>
    <dt><span id="searchtype" typename="product">Product</span><em class="ico-jtb"></em></dt>
    <dd>
        <a typename="product" href="javascript:void(0)">Product</a>
        <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
        <a typename="shop" href="javascript:void(0)">shop</a>
        <%}%>
    </dd>
</dl>
</div>
<input id="keyword" value="" type="text" name="keyword" onfocus="if (this.value != '') {this.value = '';}" />
<input type="button" value="Search" class="button" />
</div>

            

<div class="searchkeyword">
<%Table="Lebi_Searchkey";Where="";Order="Sort desc,id desc";PageSize=5;pageindex=1;RecordCount=B_Lebi_Searchkey.Counts(Where);int ERpC_index=1;
List<Lebi_Searchkey> ERpCs = B_Lebi_Searchkey.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_Searchkey ERpC in ERpCs){%>
<%if (ERpC.Type==1){ %><a href="<%=URL("P_Search",""+Lang(ERpC.Name)+"") %>"><%}else{ %><a href="<%=ERpC.URL%>" target="_blank"><%} %><span><%=Lang(ERpC.Name)%></span></a>
<%ERpC_index++;}%>
</div>

        </div>
        <div class="toplink"> 
            <a href="<%=URL("P_UserCenter","") %>">
                <img src="/theme/newdefault/images/topIco1.png">My Account</a>
            <a href="<%=URL("P_Basket","") %>">
                <img src="/theme/newdefault/images/topIco2.png">Shopping Cart</a>
        </div>
    </div>
</div>
  <div class="mainNav">
    <div class="mainNav-con">
      <div class="allnav">
        <h2 class="title">
          <a href="<%=URL("P_AllProductCategories", "")%>">All Categories</a><i class="title-icon"></i>
        </h2>
        <div class="allnav-show">
          <ul id="nav">
            <%
                        int ic0=0;
            foreach(Lebi_Pro_Type c0 in EX_Product.ShowTypes(0,CurrentSite.id))
            {
            ic0++;
            if(ic0>10)
            continue;
            %>
            <li id="mainCate-1" class="mainCate">
              <h3>
                <i class="nav-icon">
                  <%if(c0.ImageSmall!=""){ %>
                    <img src="<%=c0.ImageSmall %>" alt="<%=Lang(c0.Name) %>" style="width:18px;height:18px;" /><%} %></i><a href="<%=URL("P_ProductCategory",""+c0.id+"") %>"><%=Lang(c0.Name) %></a>
              </h3>
              <div class="subCate">
                <h4>
                  <a href="<%=URL("P_ProductCategory",""+c0.id+"") %>"><%=Lang(c0.Name) %> >></a>
                </h4>
                <ul>
                  <%
                                    int ic1=0;
                  foreach(Lebi_Pro_Type c1 in EX_Product.ShowTypes(c0.id,CurrentSite.id))
                  {
                  %>
                  <li>
                    <a href="<%=URL("P_ProductCategory",""+c1.id+"") %>"><%=Lang(c1.Name) %></a>
                  </li>
                  <%} %>
                </ul>
                <div class="nav-pic">
                  <img src="/theme/newdefault/images/w-ad.jpg" width="365" height="154" />
                </div>
              </div>
            </li>
            <%} %>
          </ul>
        </div>
      </div>
      
      <div class="other-menu">
        

<%Table="Lebi_Page";Where="Node_id="+Node("HeadMenu").id+" and ','+Language_ids+',' like '%," + CurrentLanguage.id + ",%'";Order="Sort desc";PageSize=10;pageindex=1;RecordCount=B_Lebi_Page.Counts(Where);int thNN_index=1;
List<Lebi_Page> thNNs = B_Lebi_Page.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_Page thNN in thNNs){%>
<a class="menu" href="<%=URL("","",thNN.url)%>" target="<%=thNN.target%>"><span style="color:<%=thNN.NameColor%>"><%=thNN.Name%></span></a> 
<%thNN_index++;}%>

      </div>
    </div>
  </div>
<script type="text/javascript">
$(document).ready(function(){
$('.allnav').mousemove(function(){
$(this).find('.allnav-show').slideDown("1000");//you can give it a speed
});
$('.allnav').mouseleave(function(){
$(this).find('.allnav-show').slideUp("fast");
});
});
jQuery("#nav").slide({
type:"menu", //效果类型
titCell:".mainCate", // 鼠标触发对象
targetCell:".subCate", // 效果对象，必须被titCell包含
delayTime:0, // 效果时间
triggerTime:0, //鼠标延迟触发时间
defaultPlay:false,//默认执行
returnDefault:true//返回默认
});
$(document).ready(function(){
$('.allnav').mousemove(function(){
$(this).find('.allnav-show').slideDown("1000");//you can give it a speed
});
$('.allnav').mouseleave(function(){
$(this).find('.allnav-show').slideUp("fast");
});
});
</script>

<div class="body clearfix">
    <div class="location"><div class="path"><%=path%></div></div>
    <div class="bodyside clearfix">
        

<div class="mbox clearfix">
    <div class="mt">
        <h2>Control Panel</h2>
    </div>
    <div class="mc usermenu clearfix">
        <ul>
            <li><a href="<%=URL("P_UserOrders","")%>"><span>My Order</span></a></li>
            <%if(SYS.IsClosetuihuo=="0"){ %>
            <li><a href="<%=URL("P_UserReturn","")%>"><span>Return Order</span></a></li>
            <%} %>
            <li><a href="<%=URL("P_UserCard","")%>"><span>my vouchers</span></a></li>
            <li><a href="<%=URL("P_UserPoint","")%>"><span>Points Log</span></a></li>
            <li><a href="<%=URL("P_UserMoney","")%>"><span>Money Log</span></a></li>
            <li><a href="<%=URL("P_UserProfile","")%>"><span>Profile</span></a></li>
            <li><a href="<%=URL("P_UserAccount","")%>"><span>Bind account</span></a></li>
            <li><a href="<%=URL("P_UserChangePassword","")%>"><span>Change Password</span></a></li>
            <li><a href="<%=URL("P_UserQuestion","")%>"><span>Security Question</span></a></li>
            <li><a href="<%=URL("P_UserAddress","")%>"><span>Consignee Address</span></a></li>
            <li><a href="<%=URL("P_UserBank","")%>"><span>Receivable Account</span></a></li>
            <li><a href="javascript:LoginOut();"><span>Sign Out</span></a></li>
        </ul>
    </div>
</div>
<div class="mbox clearfix">
    <div class="mt">
        <h2>Product Highlights</h2>
    </div>
    <div class="mc usermenu clearfix">
        <ul>
            <li><a href="<%=URL("P_UserLike","")%>"><span>My  like</span></a></li>
            <li><a href="<%=URL("P_UserOftenBuy","")%>"><span>Often Buy</span></a></li>
            <li><a href="<%=URL("P_UserComment","")%>"><span>Reviews<em>(<%=Count_Comment(0) %>)</em></span></a></li>
            <li><a href="<%=URL("P_UserAsk","")%>"><span>Comment<em>(<%=Count_ProductAsk(0) %>)</em></span></a></li>
        </ul>
    </div>
</div>
<div class="mbox clearfix">
    <div class="mt">
        <h2>Messages</h2>
    </div>
    <div class="mc usermenu clearfix">
        <ul>
            <li><a href="<%=URL("P_UserMessage","0")%>"><span>Inbox<em>(<%=Count_Message(0) %>)</em></span></a></li>
            <li><a href="<%=URL("P_UserMessage","1")%>"><span>Outbox</span></a></li>
            <li><a href="<%=URL("P_UserMessageWrite","")%>"><span>Send Message</span></a></li>
        </ul>
    </div>
</div>
<%if (Shop.LebiAPI.Service.Instanse.Check("plugin_agent")){ %>
<div class="mbox clearfix">
    <div class="mt">
        <h2>Promotion Commission</h2>
    </div>
    <div class="mc usermenu clearfix">
        <ul>
            <li><a href="<%=URL("P_UserAgent","")%>"><span>Basic Information<em></em></span></a></li>
            <li><a href="<%=URL("P_UserAgentMoney","")%>"><span>Commission Query</span></a></li>
        </ul>
    </div>
</div>
<%} %>

    </div>
    <div class="bodymain clearfix">
        
    

<div class="nbbox clearfix">
<div class="userbox">
    <div class="mt">
        <h2>Profile</h2>
    </div>
    <div class="mc clearfix">
    <div class="dl-table clearfix">
    <dl>
        <dt>Username：</dt>
        <dd><%=CurrentUser.UserName %>&nbsp;<em>This cannot be modified</em></dd>
    </dl>
    <dl>
        <dt>Full Name：</dt>
        <dd><input type="text" name="RealName" id="RealName" size="30" value="<%=CurrentUser.RealName %>" class="input" shop="true" /></dd>
    </dl>
    <dl>
        <dt>Nickname：</dt>
        <dd><input type="text" name="NickName" id="NickName" size="30" value="<%=CurrentUser.NickName %>" class="input" shop="true" /></dd>
    </dl>
    <dl>
        <dt>Birthday：</dt>
        <dd><input type="text" name="Birthday" size="30" value="<%=FormatDate(CurrentUser.Birthday) %>" id="Birthday" class="input" shop="true" /></dd>
    </dl>
    <dl>
        <dt>Gender：</dt>
        <dd><lable><input type="radio" name="Sex" value="男" class="input" shop="true" <%=CurrentUser.Sex=="男"?"checked":"" %>/><%=Tag("男") %></lable>
        <lable><input type="radio" name="Sex" value="女" class="input" shop="true" <%=CurrentUser.Sex=="女"?"checked":"" %>/><%=Tag("女") %></lable></dd>
    </dl>
    <dl>
        <dt>Mobile Number：</dt>
        <dd><input type="text" name="MobilePhone" id="MobilePhone" size="30" value="<%=CurrentUser.MobilePhone %>" class="input" shop="true" />
            <%if(Checkmobilephone){ %>
            &nbsp;Security Code：
            <input type="text" shop="true" min="notnull" maxlength="6" name="MobilePhone_checkcode" id="MobilePhone_checkcode" style="width: 60px;" class="input" />
            <input id="btn_phone" type="button" value="Verification code" style="width: 80px; height:25px" onclick="getcheckcode('phone');" />
            <span id="msg_phone"></span>
            <%} %>
        </dd>
    </dl>
    <dl>
        <dt>Phone：</dt>
        <dd><input type="text" name="Phone" size="30" id="Phone" value="<%=CurrentUser.Phone %>" class="input" shop="true" /></dd>
    </dl>
    <dl>
        <dt>Fax：</dt>
        <dd><input type="text" name="fax" id="fax" size="30" value="<%=CurrentUser.Fax %>" class="input" shop="true" /></dd>
    </dl>
    <dl>
        <dt>E-mail：</dt>
        <dd><input type="text" name="Email" id="Email" size="30" value="<%=CurrentUser.Email %>" class="input" shop="true" />
            <%if(Checkemail){ %>
            &nbsp;Security Code：
            <input type="text" shop="true" min="notnull" maxlength="6" name="Email_checkcode" id="Email_checkcode" style="width: 60px;" class="input" />
            <input id="btn_email" type="button" value="Verification code" style="height:25px" onclick="getcheckcode('email');" />
            <span id="msg_email"></span>
            <%} %>
        </dd>
    </dl>
    <dl>
        <dt>QQ：</dt>
        <dd><input type="text" name="QQ" id="QQ" size="30" value="<%=CurrentUser.QQ %>" class="input" shop="true" /></dd>
    </dl>
    <dl>
        <dt>Postal Code：</dt>
        <dd><input type="text" name="Postalcode" id="Postalcode" size="30" value="<%=CurrentUser.Postalcode %>" class="input" shop="true" /></dd>
    </dl>
    <dl>
        <dt>Address：</dt>
        <dd><input type="text" name="Address" id="Address" size="30" value="<%=CurrentUser.Address %>" class="input" shop="true" /></dd>
    </dl>
    <dl>
        <dt>Area：</dt>
        <dd><div id="Area_id_div"></div></dd>
    </dl>
    <dl class="dl-btn">
        <dt></dt>
        <dd><a href="javascript:void(0)" onclick="update();" class="btn btn-11"><s></s>Submit</a></dd>
    </dl>
    </div>
    </div>
</div>
</div>
<script type="text/javascript">
    $(document).ready(function ($) { 
        $("#Birthday").datepicker({dateFormat:"yy-mm-dd"});
    });
    GetAreaList(<%=SYS.TopAreaid %>, <%=CurrentUser.Area_id %>); //加载地区下拉框
    function update() {
        var postData = GetFormJsonData("shop");
        var Area_id = $("#Area_id").val();
        var url = path+"/ajax/Ajax_userin.aspx?__Action=User_Info&Area_id="+Area_id;
        RequestAjax(url, postData, function () { MsgBox(1, "Operation Successful", "") });
    }
    var djs_phone = 60;
    var djs_email = 60;
    function getcheckcode(t) {
        var email = '';
        var postData = '';
        var url = '';
        if (t == 'phone') {
            phone = $("#MobilePhone").val();
            postData = { "phone": phone };
            url = path + "/ajax/ajax.aspx?__Action=GetPhoneCheckCode&m=<%=mcode%>";
        } else {
            email = $("#Email").val();
            postData = { "email": email };
            url = path + "/ajax/ajax.aspx?__Action=GetEmailCheckCode&m=<%=mcode%>";
            if (!IsEmail(email)) {
                $("#msg_" + t).html("Please fill in the mailbox");
                return false;
            }
        }
        $.ajax({
            type: "POST",
            url: url,
            data: postData,
            dataType: 'json',
            beforeSend: function () {
                $("#btn_" + t).hide();
                $("#msg_" + t).html("Sending ...");
            },
            success: function (res) {
                if (res.msg == "OK") {
                    if (t == 'phone') {
                        djs_phone = 60;
                        daojishi_phone();
                        setInterval(daojishi_phone, 1000);
                    } else {
                        djs_email = 60;
                        daojishi_email();
                        setInterval(daojishi_email, 1000);
                    }
                    return false;
                }
                else {
                    $("#btn_" + t).show();
                    $("#msg_" + t).html(res.msg);
                    return false;
                }
            }
        });
    }
    function daojishi_email() {
        djs_email = djs_email - 1;
        if (djs_email > 0)
            $("#msg_email").html(djs_email + "Resend seconds");
        else {
            $("#msg_email").html("");
            $("#btn_email").show();
        }
    }
    function daojishi_phone() {
        djs_phone = djs_phone - 1;
        if (djs_phone > 0)
            $("#msg_phone").html(djs_phone + "Resend seconds");
        else {
            $("#msg_phone").html("");
            $("#btn_phone").show();
        }
    }
</script>


    </div>
</div>

<div class="footer">
    <%=Lang(SYS.FootHtml) %>
    <div class="copyright f11 footer_logos">
        <div class="footer_logos-list">
            <%Table="Lebi_FriendLink";Where="IsShow=1 and ','+Language_ids+',' like '%," + CurrentLanguage.id + ",%'";Order="Sort desc,id desc";PageSize=7;pageindex=1;RecordCount=B_Lebi_FriendLink.Counts(Where);int knnO_index=1;
List<Lebi_FriendLink> knnOs = B_Lebi_FriendLink.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_FriendLink knnO in knnOs){%>
            
                <% if (knnO.Logo != "" && knnO.IsPic == 1){ %><a href="<%=knnO.Url%>" target="_blank"><img src="<%=Image(knnO.Logo) %>" alt="<%=knnO.Name%>" /></a><%}else{%><a href="<%=knnO.Url%>" target="_blank"><%=knnO.Name%></a><%} %>     
           
            <%knnO_index++;}%>
         </div>
    </div>
</div>
<div class="copyright">
    

<%if (servicepannel.Status == "1"){%>
<%if (servicepannel.Style == "1"){%>
<script type="text/javascript" src="/Theme/system/js/ServicePanel.js"></script>
<div id="divStayTopLeft" onmouseout="Showservicepannel(event);" style="z-index:9998;width: 170px; position:absolute; right:0">
<layer id="divStayTopLeft">
<div id="divOnline" style="display:none;">
<div class="servicepannel">
<div class="menutop"><img src="/Theme/system/images/<%=CurrentLanguage.Code %>/ServicePanel/<%=servicepannel.Theme%>_1.gif" alt="" /></div>
<div class="menucenter"><div style="background:url(/Theme/system/images/<%=CurrentLanguage.Code %>/ServicePanel/<%=servicepannel.Theme%>_2.gif) repeat-y">
<%Table="Lebi_ServicePanel_Group";Where="Supplier_id = 0 and ','+Language_ids+',' like '%,"+ CurrentLanguage.id + ",%'";Order="Sort desc";PageSize=20;pageindex=Rint("page");RecordCount=B_Lebi_ServicePanel_Group.Counts(Where);int group_index=1;
List<Lebi_ServicePanel_Group> groups = B_Lebi_ServicePanel_Group.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_ServicePanel_Group group in groups){%>
<ul class="group clearfix">
<h2><%=group.Name%></h2>
<ul class="group-user clearfix">
<%Table="Lebi_ServicePanel";Where="Supplier_id = 0 and ServicePanel_Group_id = "+group.id+" and ','+Language_ids+',' like '%,"+ CurrentLanguage.id + ",%'";Order="Sort desc,id desc";PageSize=20;pageindex=Rint("page");RecordCount=B_Lebi_ServicePanel.Counts(Where);int user_index=1;
List<Lebi_ServicePanel> users = B_Lebi_ServicePanel.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_ServicePanel user in users){%>
<%
    string url = GetServicePanelType(user.ServicePanel_Type_id).Url;
    url = url.Replace("{@uid}",user.Account);
    url = url.Replace("{@uname}",user.Name);
%>
<li><a target="blank" href="<%=url%>"><img src="<%if (GetServicePanelType(user.ServicePanel_Type_id).IsOnline == 1){
    Response.Write(GetServicePanelType(user.ServicePanel_Type_id).Code.Replace("{@uid}",user.Account));
}else{
    Response.Write(Image(GetServicePanelType(user.ServicePanel_Type_id).Face));
}%>" border="0" align="absmiddle" />&nbsp;<%=user.Name%></a></li>
<%user_index++;}%>
</ul>
</li></ul>
<%group_index++;}%>
</div></div>
<div class="menufoot" style="background:url(/Theme/system/images/<%=CurrentLanguage.Code %>/ServicePanel/<%=servicepannel.Theme%>_3.gif) top no-repeat"><img src="/Theme/system/images/<%=CurrentLanguage.Code %>/ServicePanel/<%=servicepannel.Theme%>_3.gif" /></div>
</div>
</div></layer>
<div id="divMenu" onmouseover="servicepannelOver();"><img src="/Theme/system/images/<%=CurrentLanguage.Code %>/ServicePanel/menu_<%=servicepannel.Theme%>.gif" style="right:0;border:none;cursor:pointer;width:26px;height:136px;position: absolute;" /></div>
</div>
<%} else{%>
<div class="servicepannel-fix clearfix">
<ul class="group">
<%Table="Lebi_ServicePanel_Group";Where="Supplier_id = 0 and ','+Language_ids+',' like '%,"+ CurrentLanguage.id + ",%'";Order="Sort desc";PageSize=20;pageindex=Rint("page");RecordCount=B_Lebi_ServicePanel_Group.Counts(Where);int group_index=1;
List<Lebi_ServicePanel_Group> groups = B_Lebi_ServicePanel_Group.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_ServicePanel_Group group in groups){%>
<li>
<h2><%=group.Name%></h2>
<ul class="group-user">
<%Table="Lebi_ServicePanel";Where="Supplier_id = 0 and ServicePanel_Group_id = "+group.id+" and ','+Language_ids+',' like '%,"+ CurrentLanguage.id + ",%'";Order="Sort desc,id desc";PageSize=20;pageindex=Rint("page");RecordCount=B_Lebi_ServicePanel.Counts(Where);int user_index=1;
List<Lebi_ServicePanel> users = B_Lebi_ServicePanel.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_ServicePanel user in users){%>
<%
    string url = GetServicePanelType(user.ServicePanel_Type_id).Url;
    url = url.Replace("{@uid}",user.Account);
    url = url.Replace("{@uname}",user.Name);
%>
<li><a target="blank" href="<%=url%>"><img src="<%if (GetServicePanelType(user.ServicePanel_Type_id).IsOnline == 1){
    Response.Write(GetServicePanelType(user.ServicePanel_Type_id).Code.Replace("{@uid}",user.Account));
}else{
    Response.Write(Image(GetServicePanelType(user.ServicePanel_Type_id).Face));
}%>" border="0" align="absmiddle" />&nbsp;<%=user.Name%></a></li>
<%user_index++;}%>
</ul>
</li>
<%group_index++;}%>
</ul></div>
<%}}%>

    <%=Lang(SYS.Copyright) %>
    <%=GetCNZZ() %>
</div>




<link rel="stylesheet" type="text/css" href="/Theme/system/js/sidebar/base.css" />
<script type="text/javascript" src="/Theme/system/js/sidebar/sidebar.js"></script>
<div class="mui-mbar-tabs">
	<div class="quick_link_mian">
		<div class="quick_links_panel">
			<div id="quick_links" class="quick_links">
				<li>
					<a href="javascript:void(0);" class="ico_account"><i class="i_ico_account"></i></a>
					<div class="ibar_login_box status_login">
						<div class="avatar_box">
							<p class="avatar_imgbox">
                                <%if(CurrentUser.Face.Trim()!=""){ %>
                                <img src="<%=CurrentUser.Face %>" />
                                <%}else{ %>
                                <img src="/Theme/system/js/sidebar/no-img_mid_.jpg" />
                                <%} %>
                            </p>
							<ul class="user_info">
								<li><%=Tag("用户名") %>：<%=Shop.Bussiness.EX_User.LoginStatus()?CurrentUser.UserName:Tag("未登录") %></li>
								<li><%=Tag("级别") %>：<%=Lang(CurrentUserLevel.Name) %></li>
							</ul>
						</div>
						<div class="login_btnbox">
                            <%if(Shop.Bussiness.EX_User.LoginStatus()){ %>
							<a href="<%=URL("P_UserOrders","") %>" class="login_order"><%=Tag("我的订单") %></a>
							<a href="<%=URL("P_UserLike","")%>" class="login_favorite"><%=Tag("我的收藏") %></a>
                            <%}else{ %>
                            <a href="<%=URL("P_Login","") %>" class="login_order"><%=Tag("登录") %></a>
							<a href="<%=URL("P_Register","")%>" class="login_favorite"><%=Tag("注册") %></a>
                            <%} %>
						</div>
						<i class="icon_arrow_white"></i>
					</div>
				</li>
				<li id="shopCart">
					<a href="<%=URL("P_Basket", "") %>" class="ico_basket" ><i class="i_ico_basket"></i><div class="span"><%=Tag("购物车") %></div><span class="cart_num"><%=Basket_Product_Count() %></span></a>
				</li>
				<li>
					<a class="ico_history"><i class="i_ico_history"></i></a>
					<div class="mp_tooltip"><%=Tag("我的足迹") %><i class="icon_arrow_right_black"></i></div>
				</li>
				<li>
					<a href="<%=URL("P_UserLike", "") %>" class="ico_like"><i class="i_ico_like"></i></a>
					<div class="mp_tooltip"><%=Tag("我的收藏") %><i class="icon_arrow_right_black"></i></div>
				</li>
			</div>
			<div class="quick_toggle">
				<li>
					<a href="<%=URL("P_Help","") %>" class="ico_service"><i class="i_ico_service"></i></a>
					<div class="mp_service" style="display:none;">
                        <div class="servicepannel">
                        <%Table="Lebi_ServicePanel_Group";Where="Supplier_id = 0 and ','+Language_ids+',' like '%,"+ CurrentLanguage.id + ",%'";Order="Sort desc";PageSize=20;pageindex=Rint("page");RecordCount=B_Lebi_ServicePanel_Group.Counts(Where);int siderbargroup_index=1;
List<Lebi_ServicePanel_Group> siderbargroups = B_Lebi_ServicePanel_Group.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_ServicePanel_Group siderbargroup in siderbargroups){%>
                            <ul class="group clearfix"><li>
                            <h2><%=siderbargroup.Name%></h2>
                            <ul class="group-user clearfix">
                            <%Table="Lebi_ServicePanel";Where="Supplier_id = 0 and ServicePanel_Group_id = "+siderbargroup.id+" and ','+Language_ids+',' like '%,"+ CurrentLanguage.id + ",%'";Order="Sort desc,id desc";PageSize=20;pageindex=Rint("page");RecordCount=B_Lebi_ServicePanel.Counts(Where);int buser_index=1;
List<Lebi_ServicePanel> busers = B_Lebi_ServicePanel.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_ServicePanel buser in busers){%>
                            <%
                                string url = GetServicePanelType(buser.ServicePanel_Type_id).Url;
                                url = url.Replace("{@uid}",buser.Account);
                                url = url.Replace("{@uname}",buser.Name);
                            %>
                            <li><a target="blank" href="<%=url%>"><img src="<%if (GetServicePanelType(buser.ServicePanel_Type_id).IsOnline == 1){
                                Response.Write(GetServicePanelType(buser.ServicePanel_Type_id).Code.Replace("{@uid}",buser.Account));
                            }else{
                                Response.Write(Image(GetServicePanelType(buser.ServicePanel_Type_id).Face));
                            }%>" border="0" align="absmiddle" />&nbsp;<%=buser.Name%></a></li>
                            <%buser_index++;}%>
                            </ul>
                            </li></ul>
                            <%siderbargroup_index++;}%>
                        </div>
                        <i class="icon_arrow_white"></i>

                    </div>
				</li>
				<li id="mp_qrcode">
					<a href="#none" class="ico_qrcode"><i class="i_ico_qrcode"></i></a>
					<div class="mp_qrcode" style="display:none;"><img src="<%=SYS.platform_weixin_image_qrcode%>" width="150" height="150" /><i class="icon_arrow_white"></i></div>
				</li>
				<li><a href="#top" class="return_top"><i class="top"></i></a></li>
			</div>
		</div>
		<div id="quick_links_pop" class="quick_links_pop hide"></div>
	</div>
</div>

<script type="text/javascript" src="/Theme/system/js/sidebar/parabola.js"></script>
<script type="text/javascript">
    $(".quick_links_panel li").mouseenter(function () {
        $(this).children(".mp_tooltip").animate({ left: -92, queue: true });
        $(this).children(".mp_tooltip").css("visibility", "visible");
        $(this).children(".ibar_login_box").css("display", "block");
    });
    $(".quick_links_panel li").mouseleave(function () {
        $(this).children(".mp_tooltip").css("visibility", "hidden");
        $(this).children(".mp_tooltip").animate({ left: -121, queue: true });
        $(this).children(".ibar_login_box").css("display", "none");
    });
    $(".quick_toggle li:first").mouseover(function () {
        $(".mp_service").show();
    });
    $(".quick_toggle li:first").mouseleave(function () {
        $(".mp_service").hide();
    });
    $(".quick_toggle li#mp_qrcode").mouseover(function () {
        $(".mp_qrcode").show();
    });
    $(".quick_toggle li#mp_qrcode").mouseleave(function () {
        $(".mp_qrcode").hide();
    });
</script>

</body>
</html><div style="width:100%;text-align:center;font-size:12px;color:#999">Powered by <a style="font-size:12px;color:#00497f" href="http://www.lebi.cn/support/license/?url=" target="_blank" title="LebiShop多语言网店系统">LebiShop</a> V<%=SYS.Version%>.<%=SYS.Version_Son%></div>