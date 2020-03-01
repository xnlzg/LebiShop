<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.P_Product" validateRequest="false"%>


<%@ Import Namespace="Shop.Bussiness" %>
<%@ Import Namespace="Shop.Model" %>
<%@ Import Namespace="DB.LebiShop" %>
<%@ Import Namespace="System.Collections.Generic" %>
<% LoadPage("wangdayu523@163.com_37",1,"tcn","P_Product"); %>

<!DOCTYPE html PUBliC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<title><%=ThemePageMeta("P_Product","title")%></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
<meta name="keywords" content="<%=ThemePageMeta("P_Product","keywords")%>" />
<meta name="description" content="<%=ThemePageMeta("P_Product","description")%>" />
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
    var langpath = "/tw/";
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
 

    <meta property="og:title" content="<%=Lang(product.Name) %>">
    <meta property="og:type" content="product">
    <meta property="og:url" content="<%=LB.Tools.RequestTool.GetRequestUrl() %>">
    <meta property="og:image" content="<%=Image(product.ImageOriginal)%>">
    <meta property="og:site_name" content="<%=Lang(SYS.Name) %>">
    <meta property="og:description" content="<%=ThemePageMeta("P_Product","description")%>">
    <meta property="og:image:type" content="image/jpeg">
    <meta property="og:image:width" content="600">
    <meta property="og:image:height" content="600">
    <meta property="twitter:card" content="summary_large_image">
    <meta property="twitter:image:width" content="600">
    <meta property="twitter:image:height" content="600">
    <meta property="twitter:site" content="<%=Lang(SYS.Name) %>">
    <meta property="twitter:creator" content="<%=Lang(SYS.Name) %>">
    <meta property="twitter:image" content="<%=Image(product.ImageOriginal)%>">

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
        <li class="language_li"><a class="noclick"><span>網站語言：</span><s><%if (CurrentLanguage.ImageUrl!=""){%><img src="<%=Image(CurrentLanguage.ImageUrl) %>" /><%}%><%=CurrentLanguage.Name %></s></a><dl
            class="language_li_content">
            <%List<DB.LebiShop.Lebi_Language> jlUUs=Languages();RecordCount=jlUUs.Count;int jlUU_index=1;
foreach (DB.LebiShop.Lebi_Language jlUU in jlUUs){%>
            <dd <%if (jlUU_index==RecordCount){%>class="last" <%} %>>
                <a href="javascript:SetLanguage(<%=jlUU.id%>,'<%=jlUU.Code%>','<%=jlUU.Path%>');"><%if (jlUU.ImageUrl!=""){%><img src="<%=Image(jlUU.ImageUrl) %>" /><%}%><%=jlUU.Name%></a></dd>
            <%jlUU_index++;}%>
        </dl>
        </li>
    </ul>
</div>
</li>
                <li>

<%if(SYS.IsMutiCurrencyShow=="0"){ %>
<div class="currency">
    <ul class="dropcurrency">
        <li class="currency_li"><a class="noclick"><span>幣種：</span><s><%=CurrentCurrency.Code %></s></a><dl
            class="currency_li_content">
            <%Table="Lebi_Currency";Where="";Order="Sort desc";PageSize=20;pageindex=Rint("page");RecordCount=B_Lebi_Currency.Counts(Where);int rrjs_index=1;
List<Lebi_Currency> rrjss = B_Lebi_Currency.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_Currency rrjs in rrjss){%>
            <dd <%if (rrjs_index==RecordCount){%>class="last" <%} %>>
                <a href="javascript:SetCurrency(<%=rrjs.id%>,'<%=rrjs.Code%>',<%=rrjs.ExchangeRate%>,'<%=rrjs.Msige%>','<%=rrjs.DecimalLength%>');"><%=rrjs.Code%></a></dd>
            <%rrjs_index++;}%>
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
           

<a href="/tw/"><img src="<%=Image(Lang(SYS.Logoimg)) %>" alt="<%=Lang(SYS.Name)%>" title="<%=Lang(SYS.Name)%>" /></a>
</h1>
        <div class="search">
            

<script type="text/javascript">
    $(function () {
        blurInput('#keyword', '<%if (Rstring("Keyword")!=""){ %><%=Rstring("Keyword")%><%}else{%><%Table="Lebi_Searchkey";Where="Type=1";Order="Sort desc,id desc";PageSize=1;pageindex=1;RecordCount=B_Lebi_Searchkey.Counts(Where);int pmaj_index=1;
List<Lebi_Searchkey> pmajs = B_Lebi_Searchkey.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_Searchkey pmaj in pmajs){%><%=Lang(pmaj.Name)%><%pmaj_index++;}%><%} %>');
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
    <dt><span id="searchtype" typename="product">商品</span><em class="ico-jtb"></em></dt>
    <dd>
        <a typename="product" href="javascript:void(0)">商品</a>
        <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
        <a typename="shop" href="javascript:void(0)">店鋪</a>
        <%}%>
    </dd>
</dl>
</div>
<input id="keyword" value="" type="text" name="keyword" onfocus="if (this.value != '') {this.value = '';}" />
<input type="button" value="搜索" class="button" />
</div>

            

<div class="searchkeyword">
<%Table="Lebi_Searchkey";Where="";Order="Sort desc,id desc";PageSize=5;pageindex=1;RecordCount=B_Lebi_Searchkey.Counts(Where);int bCnS_index=1;
List<Lebi_Searchkey> bCnSs = B_Lebi_Searchkey.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_Searchkey bCnS in bCnSs){%>
<%if (bCnS.Type==1){ %><a href="<%=URL("P_Search",""+Lang(bCnS.Name)+"") %>"><%}else{ %><a href="<%=bCnS.URL%>" target="_blank"><%} %><span><%=Lang(bCnS.Name)%></span></a>
<%bCnS_index++;}%>
</div>

        </div>
        <div class="toplink"> 
            <a href="<%=URL("P_UserCenter","") %>">
                <img src="/theme/newdefault/images/topIco1.png">我的賬號</a>
            <a href="<%=URL("P_Basket","") %>">
                <img src="/theme/newdefault/images/topIco2.png">購物車</a>
        </div>
    </div>
</div>
  <div class="mainNav">
    <div class="mainNav-con">
      <div class="allnav">
        <h2 class="title">
          <a href="<%=URL("P_AllProductCategories", "")%>">全部商品分類</a><i class="title-icon"></i>
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
        

<%Table="Lebi_Page";Where="Node_id="+Node("HeadMenu").id+" and ','+Language_ids+',' like '%," + CurrentLanguage.id + ",%'";Order="Sort desc";PageSize=10;pageindex=1;RecordCount=B_Lebi_Page.Counts(Where);int Vyiz_index=1;
List<Lebi_Page> Vyizs = B_Lebi_Page.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_Page Vyiz in Vyizs){%>
<a class="menu" href="<%=URL("","",Vyiz.url)%>" target="<%=Vyiz.target%>"><span style="color:<%=Vyiz.NameColor%>"><%=Vyiz.Name%></span></a> 
<%Vyiz_index++;}%>

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
<div class="viewhistory">
    <div class="mt">
        <h2>瀏覽歷史</h2>
    </div>
    <div class="mc clearfix" id="viewhistory">
    </div>
</div>
</div>
<script type="text/javascript">LoadPage(path + '/inc/viewhistory.aspx', 'viewhistory');</script>



<div class="mbox clearfix">
<div class="newstop">
<div class="mt">
    <h2>商城動態</h2>
</div>
<div class="mc clearfix">
    <ul class="text">
        <%Table="Lebi_Page";Where="Node_id="+Node("News").id+" and ','+Language_ids+',' like '%," + CurrentLanguage.id + ",%'";Order="Time_Add desc,id desc";PageSize=5;pageindex=1;RecordCount=B_Lebi_Page.Counts(Where);int vuyJ_index=1;
List<Lebi_Page> vuyJs = B_Lebi_Page.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_Page vuyJ in vuyJs){%>
        <li><a href="<%if (vuyJ.url == ""){Response.Write(URL("P_NewsDetails",vuyJ.id));}else{Response.Write(vuyJ.url);} %>" title="<%=vuyJ.Name%>"><em><%=vuyJ.Time_Add.ToString("MM-dd") %></em><span style="color:<%=vuyJ.NameColor%>"><%=vuyJ.Name%></span></a></li>
        <%vuyJ_index++;}%>
    </ul>
</div>
</div>
</div>


    </div>
    <div class="bodymain clearfix">
        
<div class="nbbox">
<div class="productdetail">
<div class="image left">


<script type="text/javascript" src="/Theme/system/js/jquery.jqzoom.js"></script>
<link rel="stylesheet" type="text/css" href="/Theme/system/js/lightbox/lightbox.min.css" />
<script type="text/JavaScript">
    $(document).ready(function () {
        var liw = 0;var pw = $(".listimage .piclist").width();
        $(".list-h li").each(function () {liw += $(this).width() + 6;})
        $(".list-h").width(liw + "px");
        $("#PicList img").bind("mouseover", function () {var src = $(this).attr("imghead");var jqimg = $(this).attr("imghead");$("#jqzoom img").attr("src", src);$("#jqzoom img").attr("jqimg", jqimg);$(this).attr("class", "current");}).bind("mouseout", function () {$(this).attr("class", "");});
        $(".jqzoom").jqueryzoom({xzoom: 300,yzoom: 300,offset: 10,position: "right",preload: 1,lens: 1});
        $(".pic_next").click(function () {if ($(".list-h").is(":animated")) {$(".list-h").stop(true, true);}ml = parseInt($(".list-h").css("left"));r = liw - (pw - ml);if (r < pw) {s = r;} else {s = pw;}$(".list-h").animate({ left: ml - s + "px" }, "slow");})
        $(".pic_prev").click(function () {if ($(".list-h").is(":animated")) {$(".list-h").stop(true, true);}ml = parseInt($(".list-h").css("left"));if (ml > -pw) {s = ml;} else {s = -pw;}$(".list-h").animate({ left: ml - s + "px" }, "slow");})
    })
</script>
<div class="bigimage jqzoom clearfix" id="jqzoom">
    <img jqimg="<%=Image(product.ImageOriginal) %>" src="<%=Image(product.ImageOriginal) %>" name="prodView" id="Img1" />
</div>
<div class="clear"></div>
<div class="listimage">
	<div class="pic_prev"></div>
    <div id="PicList" class="piclist">
        <div class="piclistbox">
        <ul class="list-h">
            <li><a href="<%=Image(product.ImageOriginal)%>" data-lightbox="image"><img src="<%=Image(product.ImageOriginal,"small") %>" imghead="<%=Image(product.ImageOriginal,"big") %>"/></a></li>
            <% 
            foreach(LBimage image in images){
            %>
            <li><a href="<%=Image(image.original) %>" data-lightbox="image"><img src="<%=Image(image.original,"small") %>" imghead="<%=Image(image.original,"big") %>"></a></li>
            <%} %>
        </ul>
        </div>
    </div>
	<div class="pic_next"></div>
</div>
<script type="text/javascript" src="/Theme/system/js/lightbox/lightbox.min.js"></script>

<div class="jiathis-share">

<div class="jiathis_style">
	<a class="jiathis_button_email"></a>
	<a class="jiathis_button_fb"></a>
	<a class="jiathis_button_twitter"></a>
	<a class="jiathis_button_googleplus"></a>
	<a class="jiathis_button_stumbleupon"></a>
	<a class="jiathis_button_gmail"></a>
	<a class="jiathis_button_linkedin"></a>
	<a class="jiathis_button_pinterest"></a>
	<a class="jiathis_button_tumblr"></a>
	<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
</div>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>

</div>
</div>
<div class="con left">
                        


<script type="text/JavaScript">
    $(document).ready(function () {
        $(".time_expired").each(function () {
            var endDate = $(this).attr("endDate");
            var productId = $(this).attr("Product");
            var _countdown = new CountDown();
            _countdown.init({
                id: 'time_expired_' + productId,
                time_Dom: $("#time_expired_" + productId),
                day_Dom: $("#dayEnd_" + productId),
                hour_Dom: $("#hourEnd_" + productId),
                min_Dom: $("#minEnd_" + productId),
                sec_Dom: $("#secEnd_" + productId),
                endTime: endDate
            });
        });
    });
</script>
<%
decimal price_market=ProductPrice_Market(product);
decimal price=ProductPrice(product);
int levelcount=ProductLevelCount(product);
%>
<div class="productname">
    <span>
        <%=Lang(product.Name) %>
    </span>
</div>
<div class="productinfo clearfix">
    <dl>
        <dt>
            <%=Tag("商品编号")%>：
        </dt>
        <dd>
            <%=product.Number %>
        </dd>
    </dl>
    <%if (product.Type_id_ProductType == 320)
    { %>
    <%if (price_market > 0){ %>
    <dl>
        <dt>
            <%=Tag("市场价")%>：
        </dt>
        <dd>
            <span class="marketprice">
                <%=FormatMoney(price_market) %>
            </span>
        </dd>
    </dl>
    <%} %>
    <dl>
        <dt>
            <%=Lang(CurrentUserLevel.PriceName) %>：
        </dt>
        <dd>
            <span class="buyprice productprice">
                <%=FormatMoney(price) %>
            </span><%if (price_market > 0){ %><span class="buyprice">&nbsp;&nbsp;<em><%=Tag("节省")%>：<%=FormatMoney(price_market-price) %></em></span><%} %>
        </dd>
    </dl>
    <%} %>

    <%if (product.Type_id_ProductType == 324)
    { %>
    <%if (product.Price_Market > 0){ %>
    <dl>
        <dt>
            <%=Tag("市场价")%>：
        </dt>
        <dd>
            <span class="marketprice">
                <%=FormatMoney(product.Price_Market) %>
            </span>
        </dd>
    </dl>
    <%} %>
    <dl>
        <dt>
            <%=Lang(CurrentUserLevel.PriceName) %>：
        </dt>
        <dd>
            <span class="buyprice productprice">
                <%=FormatMoney(price) %>
            </span><%if (product.Price_Market > 0){ %><span class="buyprice">&nbsp;&nbsp;<em><%=Tag("节省")%>：<%=FormatMoney(product.Price_Market-price) %></em></span><%} %>
        </dd>
    </dl>
    <dl>
        <dt>
            <%=Tag("定金") %>：
        </dt>
        <dd>
            <span class="buyprice productprice">
                <%=FormatMoney(product.Price_reserve) %>
            </span>
            <span class="buyprice">&nbsp;&nbsp;<em><%=Tag("到货周期")%>：<%=product.Reserve_days%><%=Tag("天")%></em></span>

        </dd>
    </dl>
    <%} %>

    <%if (product.Type_id_ProductType == 321 || product.Type_id_ProductType == 322)
    { %>
    <%if (product.Price_Market > 0){ %>
    <dl>
        <dt>
            <%=Tag("市场价")%>：
        </dt>
        <dd>
            <span class="marketprice">
                <%=FormatMoney(product.Price_Market) %>
            </span>
        </dd>
    </dl>
    <%} %>
    <dl>
        <dt>
            <%if (product.Type_id_ProductType == 321)
            { %><%=Tag("抢购价")%><%}
            else if (product.Type_id_ProductType == 322)
            { %><%=Tag("团购价")%><%} %>：
        </dt>
        <dd>
            <span class="buyprice productprice">
                <%=FormatMoney(product.Price_Sale)%><%if (product.Price_Market > 0){ %>&nbsp;&nbsp;<em><%=Discount(product.Price_Market, product.Price_Sale)%>% <%=Tag("折")%></em><%} %>
            </span>
        </dd>
    </dl>
    <%if (product.Type_id_ProductType == 322)
    {%>
    <dl>
        <dt>
            <%=Tag("已参团")%>：
        </dt>
        <dd>
            <%=product.Count_Sales_Show%>
        </dd>
    </dl>
    <%} %>
    <%if (product.Count_Limit > 0)
    { %>
    <dl>
        <dt>
            <%=Tag("每人限购")%>：
        </dt>
        <dd>
            <%=product.Count_Limit%>
            <span class="unit">
                <%=Shop.Bussiness.EX_Product.ProductUnit(product,CurrentLanguage)%>
            </span>
        </dd>
    </dl>
    <%} %>
    <%if (System.DateTime.Now < product.Time_Start)
    { %>
    <dl>
        <dt>
            <%=Tag("开始")%>：
        </dt>
        <dd>
            <%=product.Time_Start%>
        </dd>
    </dl>
    <%} %>
    <dl>
        <dt>
            <%if (System.DateTime.Now < product.Time_Start)
            { %><%=Tag("倒计时")%><%}
            else
            { %><%=Tag("剩余")%><%} %>：
        </dt>
        <dd>
            <div class="time_expired" enddate="<%if (System.DateTime.Now < product.Time_Start){ %><%=DateFormat(product.Time_Start)%><%}else{ %><%=DateFormat(product.Time_Expired)%><%} %>"
                 product="<%=product.id %>" id="time_expired_<%=product.id %>">
                <span>
                    <span id="dayEnd_<%=product.id %>">0</span><em><%=Tag("天")%></em><span id="hourEnd_<%=product.id %>">0</span><em><%=Tag("小时")%></em><span id="minEnd_<%=product.id %>">0</span><em><%=Tag("分钟")%></em><span id="secEnd_<%=product.id %>">0</span><em><%=Tag("秒")%></em>
                </span>
            </div>
        </dd>
    </dl>
    <%}%>
    <%if (product.Type_id_ProductType == 323)
    {%>
    <%if (price > 0){ %>
    <dl>
        <dt>
            <%=Tag("销售价")%>：
        </dt>
        <dd>
            <span class="marketprice productprice">
                <%=FormatMoney(price) %>
            </span>
        </dd>
    </dl>
    <%} %>
    <dl>
        <dt>
            <%=Tag("兑换积分")%>：
        </dt>
        <dd>
            <span class="buyprice">
                <%=product.Price_Sale%>
            </span>
        </dd>
    </dl>
    <%} %>
    <%string stepp=StepPriceShow(product);if(stepp!=""){%>
    <dl>
        <dt>
            <%=Tag("阶梯价格") %>：
        </dt>
        <dd>
            <%=stepp%>
        </dd>
    </dl>
    <%}%>
    <%if (product.Brand_id > 0)
    { %>
    <dl>
        <dt>
            <%=Tag("商品品牌")%>：
        </dt>
        <dd>
            <a href="<%=URL(" P_Brand",product.Brand_id) %>
                " target="_blank">
                <%=Shop.Bussiness.EX_Product.ProductBrand(product,CurrentLanguage)%>
            </a>
        </dd>
    </dl>
    <%} %>
    <%foreach (Shop.Model.KeyValue kv in ProPertys)
    { %>
    <%if (kv.V != "")
    { %>
    <dl>
        <dt>
            <%=kv.K %>：
        </dt>
        <dd>
            <%=kv.V %>
        </dd>
    </dl>
    <%} %>
    <%} %>
    <%if (product.Supplier_id > 0)
    { %>
    <dl>
        <dt>
            <%=Tag("服务商家")%>：
        </dt>
        <dd>
            <a href="<%=URL(" P_ShopIndex",product.Supplier_id) %>
                " class="color">
                <%=Lang(Shop.Bussiness.EX_Supplier.GetUser(product.Supplier_id).Name)%>
            </a>
        </dd>
    </dl>
    <%} %>
</div>
<div class="choosesp clearfix">
    <%=Get_guige(product)%>
    <%
    int stock=ProductStock(product);
    if (product.Type_id_ProductStatus == 101 && (stock > 0 || SYS.IsNullStockSale=="1" || product.Type_id_ProductType==324))
    { %>
    <dl class="clearfix">
        <dt>
            <%=Tag("购买数量")%>：
        </dt>
        <dd>
            <input type="text" name="pro_num" id="pro_num" value="<%=levelcount%>" class="input" size="5" onchange="changeproducecount();checkinputtop('pro_num',<%=levelcount %>,<%=product.Count_Limit%>)" />
            <span class="unit">
                <%=Shop.Bussiness.EX_Product.ProductUnit(product,CurrentLanguage)%>
            </span>
            <%
            if(stock>0){
            %>
            <em><%=Tag("库存")%>：<%=stock %><%=Shop.Bussiness.EX_Product.ProductUnit(product,CurrentLanguage)%></em>
            <%}%>

        </dd>
    </dl>
    <%} %>
</div>
<div class="productbutton clearfix">
    <%if ((product.Type_id_ProductType == 321 || product.Type_id_ProductType == 322 || product.Type_id_ProductType == 323) && System.DateTime.Now < product.Time_Start)
    { %>
    <strong>
        <%=Tag("尚未开始")%>
    </strong>
    <%}
    else if ((product.Type_id_ProductType == 321 || product.Type_id_ProductType == 322 || product.Type_id_ProductType == 323) && System.DateTime.Now > product.Time_Expired)
    { %>
    <strong>
        <%=Tag("已结束")%>
    </strong>
    <%}
    else
    { %>
    <% if (product.Type_id_ProductStatus == 100 || product.Type_id_ProductStatus == 103)
    { %>
    <div class="nosale">
        <span>
            <%=Tag("该商品已经下架")%>
        </span>
    </div>
    <%}
    else if (stock < 1 && SYS.IsNullStockSale!="1" && product.Type_id_ProductType!=324)
    { %>
    <div class="nosale">
        <span>
            <%=Tag("该商品已经售罄")%>
        </span>
    </div>
    <%}
    else
    { %>
    <a href="javascript:void(0)" onclick="UserProduct_Edit(<%=product.id %>,142,$('#pro_num').val(),'','Property134');" class="btn btn-buy"><s></s><%=Tag("加入购物车")%></a>
    <a href="javascript:void(0)" onclick="UserProduct_Edit(<%=product.id %>,142,$('#pro_num').val(),'quickbuy','Property134');" class="btn btn-quickbuy"><s></s><%=Tag("立刻购买")%></a>
    <a href="javascript:void(0)" onclick="UserProduct_Edit(<%=product.id%>,141);" class="btn btn-fav"><s></s><%=Tag("收藏")%></a> 
    <%} %>
    <%} %>
    <%if (Shop.Bussiness.ShopCache.GetBaseConfig().MailSign.ToLower().Contains("sendfriend")){ %>
    <p><a href="<%=URL(" P_SendFriend",product.id) %>" class="a-email"><%=Tag("邮件分享")%></a></p>
    <%} %>
</div>
<script type="text/javascript">
    function changeproducecount() {
        var pcount = $("#pro_num").val();
        var priceurl = path + "/ajax/ajax.aspx?__Action=ProducePrice&id=<%=product.id %>&count=" + pcount;
        $.ajax({
            type: 'POST',
            url: priceurl,
            dataType: 'html',
            success: function (data) {
                $(".productprice").html(data);
            }
        });

    }
</script>

</div>
<div class="clear"></div>
</div>
<div class="nbbox">


<script type="text/javascript">
    $(document).ready(function () {
        <%if (CurrentLanguage.IsLazyLoad==1){ %>$("img.contentlazy").lazyload({ placeholder: "/Theme/system/images/lazy.gif", effect: "fadeIn" });<%} %>
        var ul = $("div.product-tab ul");
        var li = $("div.product-tab ul li");
        var divShow = $("div.product-cont");
        $(li).each(function (i) {
            var _this = this;
            $(_this).click(function () {
                ul.find("li").removeClass("selected");
                $(_this).addClass("selected");
                divShow.find("div.cont").hide();
                var divindex = divShow.find("div.cont")[i];
                $(divindex).show();
                SetCookie("Product-<%=product.id %>", i, 1);
                if (i == 2) { getcommentlist(); }
                if (i == 3) { getasklist(); }
                if (i == 4) { getrelatedlist(); }
            });
        });
        var i = GetCookie("Product-<%=product.id %>");
        if (i == "" || i == null)
            i = 0;
        if (i != "") {
            $(li).each(function () {
                ul.find("li").removeClass("selected");
                divShow.find("div.cont").hide();
                var divindex = divShow.find("div.cont")[i];
                $(li[i]).addClass("selected");
                $(divindex).show();
            });
            if (i == 2) { getcommentlist(); }
            if (i == 3) { getasklist(); }
            if (i == 4) { getrelatedlist(); }
        }
    });
    function ask() {
        var postData = GetFormJsonData("shop");
        var url = path + "/ajax/Ajax_userin.aspx?__Action=Ask_Write&id=<%=product.id %>";
        RequestAjax(url, postData, function () { MsgBox(1, "發送成功", "?"); $("#Content").val(""); getasklist(); });
    }
    function getasklist() {
        var url = path + "/inc/product_ask.aspx?id=<%=product.id %>&product_id=<%=product.Product_id %>&page=<%=LB.Tools.RequestTool.RequestInt("page", 1) %>";
        LoadPage(url, 'asklist');
    }
    function getcommentlist() {
        var url = path + "/inc/product_comment.aspx?id=<%=product.id %>&product_id=<%=product.Product_id %>&page=<%=LB.Tools.RequestTool.RequestInt("page", 1) %>";
        LoadPage(url, 'commentlist');
    }
    function getrelatedlist() {
        var url = path + "/inc/product_related.aspx?id=<%=product.id %>&tag=<%=Uri.EscapeDataString(product.Tags) %>&Count=20";
        LoadPage(url, 'relatedlist');
    }
</script>
<div class="product-tab clearfix">
    <ul class="tablist">
        <li class="selected">
            <a href="javascript:void(0);">
                <span>
                    詳細介紹
                </span>
            </a>
        </li>
        <li>
            <a href="javascript:void(0);">
                <span>
                    
                </span>
            </a>
        </li>
        <li>
            <a href="javascript:void(0);">
                <span>
                    商品評價
                </span>
            </a>
        </li>
        <li>
            <a href="javascript:void(0);">
                <span>
                    商品諮詢
                </span>
            </a>
        </li>
        <li>
            <a href="javascript:void(0);">
                <span>
                    相關商品
                </span>
            </a>
        </li>
    </ul>
</div>
<div class="product-cont">
    <div style="display: block" class="cont">
        <%if (CurrentSite.IsMobile==0){ %>
        <%=ImgSrc(Lang(product.Description),CurrentLanguage.IsLazyLoad) %>
        <%}else{ %>
        <%=ImgSrc(Lang(product.MobileDescription),CurrentLanguage.IsLazyLoad) %>
        <%if (Lang(product.MobileDescription)==""){ %><%=ImgSrc(Lang(product.Description),CurrentLanguage.IsLazyLoad) %><%} %>
        <%} %>
    </div>
    <div style="display: none" class="cont clearfix">
        <%=ImgSrc(Lang(product.Specification),CurrentLanguage.IsLazyLoad) %>
    </div>
    <div style="display: none" class="cont clearfix">
        <div id="commentlist">
        </div>
    </div>
    <div style="display: none" class="cont clearfix">
        <%if (CurrentUser.id > 0){%>
        <table class="tableform">
            <tbody>
                <tr>
                    <td>
                        <textarea id="Content" name="Content" cols="80" rows="3" class="textarea" shop="true"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="javascript:void(0)" onclick="ask();" class="btn btn-11"><s></s>發送</a>
                    </td>
                </tr>
            </tbody>
        </table>
        <%}else{%>
        <div class="mes">您還沒有登錄，請登錄後諮詢。</div>
        <%} %>
        <div id="asklist">
        </div>
    </div>
    <div style="display: none" class="cont clearfix">
        <div id="relatedlist">
        </div>
    </div>
</div>


</div>
</div>

    </div>
</div>

<div class="footer">
    <%=Lang(SYS.FootHtml) %>
    <div class="copyright f11 footer_logos">
        <div class="footer_logos-list">
            <%Table="Lebi_FriendLink";Where="IsShow=1 and ','+Language_ids+',' like '%," + CurrentLanguage.id + ",%'";Order="Sort desc,id desc";PageSize=7;pageindex=1;RecordCount=B_Lebi_FriendLink.Counts(Where);int PMcp_index=1;
List<Lebi_FriendLink> PMcps = B_Lebi_FriendLink.GetList(Where, Order,PageSize ,pageindex);foreach (Lebi_FriendLink PMcp in PMcps){%>
            
                <% if (PMcp.Logo != "" && PMcp.IsPic == 1){ %><a href="<%=PMcp.Url%>" target="_blank"><img src="<%=Image(PMcp.Logo) %>" alt="<%=PMcp.Name%>" /></a><%}else{%><a href="<%=PMcp.Url%>" target="_blank"><%=PMcp.Name%></a><%} %>     
           
            <%PMcp_index++;}%>
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


</body>
</html><div style="width:100%;text-align:center;font-size:12px;color:#999">Powered by <a style="font-size:12px;color:#00497f" href="http://www.lebi.cn/support/license/?url=" target="_blank" title="LebiShop多语言网店系统">LebiShop</a> V<%=SYS.Version%>.<%=SYS.Version_Son%></div>