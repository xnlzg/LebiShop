﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.torder_view" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("订单详情")%>-<%=Shop.Bussiness.EX_Type.TypeName(model.Type_id_OrderType)%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link rel="stylesheet" type="text/css" href="<%=site.AdminCssPath %>/order.css" />
    <style>body{background:#fff;margin:0;padding:0;font-size:12px;text-align:left}input{font-size:12px}.tools .close,.tools .print{float:right;}.tools .name{float:left;margin-right:10px}</style>
    <style media=print>.print-btn{display:none;}</style>

    <script>
        var AdminPath = "<%=site.AdminPath %>";var WebPath ="<%=site.WebPath %>";var AdminImagePath = "<%=site.AdminImagePath %>";var requestPage = "<%=LB.Tools.RequestTool.GetRequestUrl().ToLower() %>";var refPage = "<%=LB.Tools.RequestTool.GetUrlReferrer().ToLower() %>";
    </script>
</head>
<body class="fix-sidebar fix-header card-no-border">
	
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            var ul = $("div.mod-tab ul");
            var li = $("div.mod-tab ul li");
            var divShow = $("div.main");
            $(li).each(function (i) {
                var _this = this;
                $(_this).click(function () {
                    ul.find("li").removeClass("selected");
                    $(_this).addClass("selected");
                    divShow.find("div.cont").hide();
                    var divindex = divShow.find("div.cont")[i];
                    $(divindex).show();
                    SetCookie("OrderDetails-<%=model.id %>", i, 1);
                });
            });
            var i = GetCookie("OrderDetails-<%=model.id %>");
            if (i == "" || i == null)
                i = 0;
            if (i!=""){
                $(li).each(function () {
                    ul.find("li").removeClass("selected");
                    divShow.find("div.cont").hide();
                    var divindex = divShow.find("div.cont")[i];
                    $(li[i]).addClass("selected");
                    $(divindex).show()
                });
            }
        });
        function SaveOrder(id) {
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_Edit&id=" + id;
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function SaveComment(id) {
            var postData = GetFormJsonData("comment");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Comment_Edit&id=" + id;
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        //确认订单
        function Order_type(t, id, model) {
            if (!confirm("<%=Tag("确认操作吗？")%>"))
                return false;
            var postData = { "t": t };
        var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_type&id=" + id + "&model=" + model;
        RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function EditBillingAddress(id) {
            var title_ = "<%=Tag("编辑收货人")%>";
            var url_ = "billingaddress_edit_window.aspx?id=" + id;
            var width_ = 600;
            var height_ = "auto";
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_);
        }
        function EditOrderMoney(id) {
            var title_ = "<%=Tag("修改金额")%>";
            var url_ = "torder_money_edit_window.aspx?id=" + id;
            var width_ = 400;
            var height_ = "auto";
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_);
        }
        function Order_shipping_shouhuo(id) {
            var title_ = "<%=Tag("收货")%>";
            var url_ = "shipping_shouhuo_window.aspx?id=" + id;
            var width_ = 600;
            var height_ = "auto";
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_);
        }
        function Order_shipping_view(id) {
            var title_ = "<%=Tag("运输单据")%>";
            var url_ = "shipping_view_window.aspx?id=" + id;
            var width_ = 600;
            var height_ = "auto";
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_, 'shippingview');
        }
        function Order_shipping_log(id) {
            var title_ = "<%=Tag("物流跟踪")%>";
            var url_ = "shipping_log_window.aspx?id=" + id;
            var width_ = 700;
            var height_ = 'auto';
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_, 'shippingview');
        }
        function Pro_Del(id) {
            if (!confirm("<%=Tag("确认要删除吗？")%>"))
                return false;
            var postData = GetFormJsonData("del");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=OrderPro_Del&id=" + id;
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function torder_cash(t,msg) {
            if (!confirm(msg+'？'))
                return false;
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=TOrder_Cash&id=<%=model.id %>&type="+t;
            RequestAjax(url,'',function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function Comment_Del(id) {
            if (!confirm("<%=Tag("确认要删除吗？")%>"))
                return false;
            var postData = GetFormJsonData("del");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Comment_Del&id=" + id;
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function Pro_Save(id) {
            var postData = GetFormJsonData("pro");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=OrderPro_Edit&id=" + id;
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>
    <div class="print-btn">
        <div class="tools">
            <ul>
   
                <li class="tip"><a href="#"><b></b><span><%=Shop.Bussiness.EX_Type.TypeName(model.Type_id_OrderType)%></span></a></li>
                <%if (model.IsInvalid == 1)
                  { %>
                <li class="submit"><a href="#" class="a-btn" onclick="Order_type(0,<%=model.id %>,'IsInvalid');"><b></b><span><%=Tag("有效订单")%></span></a></li>
                <%}
                  else
                  {
                      if (model.IsVerified == 0)
                      { %>
                <li class="cancel"><a href="#" class="a-btn" onclick="Order_type(1,<%=model.id %>,'IsInvalid');"><b></b><span><%=Tag("无效订单")%></span></a></li>
                <li class="submit"><a href="#" class="a-btn" onclick="Order_type(1,<%=model.id %>,'IsVerified');"><b></b><span><%=Tag("审核订单")%></span></a></li>
                <%}
                    }
                %>
                <li class="close"><a href="javascript:void(0);" onclick="window.close();"><b></b><span><%=Tag("关闭")%></span></a></li>
                <li class="print"><a href="javascript:void(0);" onclick="window.print();"><b></b><span><%=Tag("打印")%></span></a></li>
            </ul>
        </div>
    </div>
    <div class="main" id="infotab">
        <div class="mod-tab">
            <div class="tablist">
                <ul>
                    <li class="selected"><a><span><%=Tag("基本信息")%></span></a></li>
                    <li><a><span><%=Tag("商品信息")%></span></a></li>
                    <li><a><span><%=Tag("配送记录")%></span></a></li>
                    <li><a><span><%=Tag("订单备注")%></span></a></li>
                    <li><a><span><%=Tag("订单留言")%></span></a></li>
                    <li><a><span><%=Tag("订单日志")%></span></a></li>
                </ul>
            </div>
        </div>
        
        <div style="display: block" class="cont">
            <%if (model.IsInvalid == 1)
                { %>
            <div id="process" class="section2">
		        <div class="node fore ready"><ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("提交订单")%></li><li class="tx3"><%=FormatTime(model.Time_Add) %></li></ul></div>
            	<div class="proce ready"><ul><li class="tx1">&nbsp;</li></ul></div>
                <div class="node ready"><ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("无效订单")%></li><li class="tx3"><%=FormatTime(model.Time_Completed)%></li></ul></div>
            </div>
            <%}
              else if (model.IsVerified == 0)
                { %>
            <div id="process" class="section2">
		        <div class="node fore ready"><ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("提交订单")%></li><li class="tx3"><%=FormatTime(model.Time_Add) %></li></ul></div>
            	<div class="proce wait"><ul><li class="tx1">&nbsp;</li></ul></div>
                <div class="node wait"><ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("审核订单")%></li><li class="tx3"></li></ul></div>
            </div>
            <%}else{ %>
            
         
            <div id="process" class="section5">
		        <div class="node fore ready"><ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("提交订单")%></li><li class="tx3"><%=FormatTime(model.Time_Add) %></li></ul></div>
            	<div class="proce ready"><ul><li class="tx1">&nbsp;</li></ul></div>
                <div class="node ready"><ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("审核订单")%></li><li class="tx3"><%=FormatTime(model.Time_Verified)%></li></ul></div>
                
                
            	<div class="proce <%=model.IsShipped==1?"ready":"wait" %>"><ul><li class="tx1">&nbsp;</li></ul></div>
            	<div class="node <%=model.IsShipped==1?"ready":"wait" %>">
                    <ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("发货")%></li>
                        <li class="tx3"><%=model.IsShipped==1?FormatTime(model.Time_Shipped):""%></li>
                    </ul>
                </div>
                <div class="proce <%=model.IsReceived==1?"ready":"wait" %>"><ul><li class="tx1">&nbsp;</li></ul></div>
            	<div class="node <%=model.IsReceived==1?"ready":"wait" %>">
                    <ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("收货")%></li>
                        <li class="tx3"><%=model.IsReceived == 1 ? FormatTime(model.Time_Received) : ""%></li>
                    </ul>
                </div>
                <%if (model.IsCreateNewOrder != 1)
                  { %>
                <div class="proce <%=model.IsPaid==1?"ready":"wait" %>"><ul><li class="tx1">&nbsp;</li></ul></div>
            	<div class="node <%=model.IsPaid==1?"ready":"wait" %>">
                    <ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("退款")%></li>
                        <li class="tx3"><%=model.IsPaid == 1 ? FormatTime(model.Time_Paid) : ""%></li>
                    </ul>
                </div>
                <%}else{ %>
                <div class="proce <%=model.IsCreateNewOrder==1?"ready":"wait" %>"><ul><li class="tx1">&nbsp;</li></ul></div>
            	<div class="node <%=model.IsCreateNewOrder==1?"ready":"wait" %>">
                    <ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("生成新订单")%></li>
                        <li class="tx3"><%=model.IsCreateNewOrder == 1 ? FormatTime(model.Time_CreateNewOrder) : ""%></li>
                    </ul>
                </div>
                <%} %>
                <div class="proce <%=model.IsCompleted==1?"ready":"wait" %>"><ul><li class="tx1">&nbsp;</li></ul></div>
            	<div class="node <%=model.IsCompleted==1?"ready":"wait" %>">
                    <ul><li class="tx1">&nbsp;</li><li class="tx2"><%=Tag("完成")%></li>
                        <li class="tx3"><%=model.IsCompleted == 1 ? FormatTime(model.Time_Completed) : ""%></li>
                    </ul>
                </div>

            </div>
            <%} %>
            <div class="mod-title">
                <div><%=Tag("基本信息")%></div>
            </div>
            <div class="mod-table-main">
                <div class="con style05">
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tbody>
                            <tr>
                                <th width="33%" height="30px">
                                    <%=Tag("基本信息")%>
                                </th>
                                <th width="33%" class="x-tab">
                                    <%=Tag("金额")%>
                                    <%if (model.IsPaid == 0)
                                      { %>
                                    <a href="javascript:EditOrderMoney(<%=model.id %>);"><%=Tag("编辑")%></a>
                                    <%} %>
                                </th>
                                <th class="x-tab">
                                    <%=Tag("退货人信息")%> 
                                    <%if (model.IsShipped == 0)
                                      { %>
                                     <a href="javascript:EditBillingAddress(<%=model.id %>);"><%=Tag("编辑")%></a>
                                    <%} %>
                                </th>
                            </tr>
                            <tr>
                                <td valign="top" align="right" height="30px">
                                    <div class="hr10">
                                    </div>
                                    <div class="mod-table-main">
                                        <div class="con style02">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="100" align="right">
                                                        <%=Tag("状态")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.Order.OrderStatus(model, CurrentLanguage.Code) %>
                                                        <%//=model.IsShipped_All==0?"["+Tag("部分发货")+"]":"" %>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="70" align="right">
                                                        <%=Tag("原始订单")%>：
                                                    </td>
                                                    <td>
                                                        <a href="order_view.aspx?id=<%=oldmodel.id %>"><%=oldmodel.Code%></a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="70" align="right">
                                                        <%=Tag("订单编号")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.Code %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("订购时间")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatTime(model.Time_Add) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("商品重量")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.Weight %> <%=Tag("KG")%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("商品体积")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.Volume/1000000 %> m&sup3;
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="hr10">
                                    </div>
                                </td>
                                <td valign="top" align="right" height="30px">
                                    <div class="hr10"></div>
                                    <div class="mod-table-main">
                                        <div class="con style02">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("商品总额")%>：
                                                    </td>
                                                    <td align="left">
                                                        <%=FormatMoney(model.Money_Product)%>
                                                        <%=FormatMoney(model.Money_Product, model.Currency_Code)%>
                                                        
                                                    </td>
                                                </tr>
                                                <%if (model.Money_Give>0){ %>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("退款金额")%>：
                                                    </td>
                                                    <td>
                                                        <strong><%=FormatMoney(model.Money_Give)%>
                                                        <%=FormatMoney(model.Money_Give, model.Currency_Code)%></strong>
                                                        
                                                    </td>
                                                </tr>
                                                <%} %>
                                                
                                                 <%if (model.Money_Transport > 0)
                                                   { %>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("配送费用")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_Transport)%>
                                                        <%=FormatMoney(model.Money_Transport, model.Currency_Code)%>
                                                        
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_Bill>0){ %>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("发票税金")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_Bill)%>
                                                        <%=FormatMoney(model.Money_Bill, model.Currency_Code)%>
                                                        
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_Tax>0){ %>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("税金")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_Tax)%>
                                                        <%=FormatMoney(model.Money_Tax, model.Currency_Code)%>
                                                        
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_fromorder > 0)
                                                   { %>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("其它订单")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_fromorder)%>
                                                        <%=FormatMoney(model.Money_fromorder, model.Currency_Code)%>
                                                        
                                                    </td>
                                                </tr>
                                                <%} %>                                             
                                                <%if (model.Money_UseCard311 > 0)
                                                  { %>                                                
                                                <tr>
                                                    <td width="100" align="right"><%=Tag("购物卡支付")%>：</td>
                                                    <td>
                                                    <%=FormatMoney(model.Money_UseCard311)%>
                                                    <%=FormatMoney(model.Money_UseCard311, model.Currency_Code)%></td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_UseCard312 > 0)
                                                  { %>                                                
                                                <tr>
                                                    <td width="100" align="right"><%=Tag("代金券支付")%>：</td>
                                                    <td>
                                                    <%=FormatMoney(model.Money_UseCard312)%>
                                                    <%=FormatMoney(model.Money_UseCard312, model.Currency_Code)%></td>
                                                </tr>
                                                <%} %>
                                                
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("扣除积分")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.Point%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <%if (model.IsReceived_All == 1 && model.IsCreateNewOrder == 0 && model.IsPaid == 0)
                                                          {
                                                         %>  
                                                        <input type="button" value="<%=Tag("退款到提现") %>" onclick="torder_cash(1,'<%=Tag("退款到提现") %>');" />
                                                        <input type="button" value="<%=Tag("退款到账户") %>" onclick="torder_cash(2,'<%=Tag("退款到账户") %>');" />
                                                        
                                                        <input type="button" value="<%=Tag("生成新订单") %>" onclick="torder_cash(3,'<%=Tag("生成新订单") %>');" />
                                                        <%
                                                          } %>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="hr10">
                                    </div>
                                </td>
                                <td valign="top" height="30px">
                                    <div class="hr10">
                                    </div>
                                    <div class="mod-table-main">
                                        <div class="con style02">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="70" align="right">
                                                        <%=Tag("会员")%>：
                                                    </td>
                                                    <td>
                                                        <span id="Span2"><a href="../user/default.aspx?key=<%=model.User_UserName%>"><%=model.User_UserName%></a></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("姓名")%>：
                                                    </td>
                                                    <td>
                                                        <span id="lblReceivingName"><%=model.T_Name %></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("电话")%>：
                                                    </td>
                                                    <td>
                                                        <span id="lblReceivingTelePhone"><%=model.T_Phone %></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("手机")%>：
                                                    </td>
                                                    <td>
                                                        <span id="lblReceivingPhone"><%=model.T_MobilePhone %></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("地区")%>：
                                                    </td>
                                                    <td>
                                                        <span id="lblReceivingArea"><%=Shop.Bussiness.EX_Area.GetAreaName(model.T_Area_id)%></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("地址")%>：
                                                    </td>
                                                    <td>
                                                        <span id="lblReceivingAddress"><%=model.T_Address %></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <%=Tag("邮编")%>：
                                                    </td>
                                                    <td>
                                                        <span id="lblReceivingPostCode"><%=model.T_Postalcode %></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Email：
                                                    </td>
                                                    <td>
                                                        <span id="Span1"><%=model.T_Email %></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="hr10">
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            
            <div class="mod-title">
              <div><%=Tag("商品信息")%></div>
            </div>
            <div class="mod-table-main">
                <div class="con style05">
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tr>
                            <th style="width:100px;">
                                <%=Tag("商品编号")%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("商品货号")%>
                            </th>
                            <th>
                                <%=Tag("商品名称")%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("规格")%>
                            </th>
                            <th style="width:100px;">
                                <%if (model.Type_id_OrderType == 212) { Response.Write(Tag("数量")); } else { Response.Write(Tag("订购数量")); }%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("已发数量")%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("已收数量")%>
                            </th>
                            <th style="width:70px;">
                                <%=Tag("单价")%>
                            </th>
                            <th style="width:70px;">
                                <%=Tag("代金券金额")%>
                            </th>
                            <th style="width:70px;">
                                <%=Tag("返现金额")%>
                            </th>
                            <th style="width:70px;">
                                <%=Tag("产生积分")%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("小计")%>
                            </th>
                        </tr>
                      <%foreach (DB.LebiShop.Lebi_Order_Product pro in pros)
                        { %>
                        <tr>
                            <td>
                                <%=pro.Product_Number %>
                            </td>
                            <td><%=Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).Code%>&nbsp;</td>
                            <td>
                                <img src="<%=Image(pro.ImageOriginal,50,50) %>" style="height:30px;padding:3px 0" />
                                <%=Shop.Bussiness.Language.Content(pro.Product_Name,CurrentLanguage) %>&nbsp;<a target="_blank" href="<%=Shop.Bussiness.ThemeUrl.GetURL("P_Product",pro.Product_id.ToString(),"",CurrentLanguage)%>"><i class="ti-new-window"></i></a>
                            </td>
                            <td>
                                <%=Shop.Bussiness.EX_Product.ProPertyNameStr(Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).ProPerty131, CurrentLanguage)%>
                            </td>
                            <td>
                                <%=str + pro.Count%>
                            </td>
                            <td>
                                <%=pro.Count_Shipped %>
                            </td>
                             <td>
                                <%=pro.Count_Received %>
                            </td>
                            <td>
                                <%=FormatMoney(pro.Price) %>
                            </td>
                            <td>
                                <%=FormatMoney(pro.Money_Card312_one*pro.Count)%>
                            </td>
                            <td>
                                <%=FormatMoney(pro.Money_Give_one * pro.Count)%>
                            </td>
                            <td>
                                <%=pro.Point_Give_one*pro.Count%>
                            </td>
                            <td>
                                <%=str + FormatMoney(pro.Money)%>
                            </td>
                        </tr>

                    <%} %>
                    </table>
                </div>
            </div>
            
            <div class="hr40">
            </div>
            

            
        </div>
        
        
        <div style="display: none" class="cont">
            <div class="mod-title">
                <div><%=Tag("商品信息")%></div>
            </div>
            <div class="mod-table-main">
                <div class="con style05">
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tr>
                            <%if (model.IsVerified==0)
                                { %>
                           <th style="width: 30px" class="selectAll">
                                <a href="javascript:void(0);" onclick="$('input[name=\'proid\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a>
                            </th>
                            <%} %>
                            <th style="width:100px;">
                                <%=Tag("商品编号")%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("商品货号")%>
                            </th>
                            <th>
                                <%=Tag("商品名称")%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("规格")%>
                            </th>
                            <th style="width:100px;">
                                <%if (model.Type_id_OrderType == 212) { Response.Write(Tag("数量")); } else { Response.Write(Tag("订购数量")); }%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("已发数量")%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("已收数量")%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("单价")%>
                            </th>
                            <th style="width:100px;">
                                <%=Tag("小计")%>
                            </th>
                        </tr>
                      <%foreach (DB.LebiShop.Lebi_Order_Product pro in pros)
                        { %>
                        <tr>
                            <%if (model.IsVerified==0)
                                { %>
                            <td style="text-align:center"><input type="checkbox" name="proid" value="<%=pro.id %>" del="true" /><input type="hidden" name="Uproid" value="<%=pro.id %>" pro="true" /></td>
                            <%} %>
                            <td><%=pro.Product_Number %></td>
                            <td><%=Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).Code%>&nbsp;</td>
                            <td>
                                <img src="<%=Image(pro.ImageOriginal,50,50) %>" style="height:30px;padding:3px 0" />
                                <%=Shop.Bussiness.Language.Content(pro.Product_Name,CurrentLanguage) %>&nbsp;<a target="_blank" href="<%=Shop.Bussiness.ThemeUrl.GetURL("P_Product",pro.Product_id.ToString(),"",CurrentLanguage)%>"><i class="ti-new-window"></i></a>
                            </td>
                            <td>
                                <%=Shop.Bussiness.EX_Product.ProPertyNameStr(Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).ProPerty131, CurrentLanguage)%>
                            </td>
                            <td>
                                <%if (model.IsVerified==1)
                                  { %>
                                <%=str + pro.Count%>
                                <%}
                                  else
                                  { %>
                                <input type="text" class="input" pro="true" name="Count<%=pro.id %>"  id="Count<%=pro.id %>" value="<%=pro.Count %>" onkeyup="value=value.replace(/[^\d]/g,'')" style="width: 70px;" />
                                <%} %>
                            </td>
                            <td>
                                <%=pro.Count_Shipped %>
                            </td>
                            <td>
                                <%=pro.Count_Received %>
                            </td>
                            <td>
                                <%if (model.IsVerified==1)
                                  { %>
                                <%=pro.Price %>
                                <%}
                                  else
                                  { %>
                                <input type="text" class="input" pro="true" name="Price<%=pro.id %>" id="Price<%=pro.id %>" value="<%=pro.Price %>" onkeyup="value=value.replace(/[^\d\.]/g,'')" style="width: 70px;" />
                                <%} %>
                            </td>
                            <td>
                                <%=str + FormatMoney(pro.Money)%>
                            </td>
                        </tr>

                    <%} %>
                    </table>
                </div>
                <%if (model.IsVerified == 0)
                  { %>
                <div style="text-align:left;margin-top:10px;">
                    <div class="tools tools-m clear">
                        <ul>
                            <li class="submit"><a href="javascript:void(0);" onclick="Pro_Save(<%=model.id %>);"><b></b><span><%=Tag("保存")%></span></a></li>
                            <li class="del"><a href="javascript:void(0);" onclick="Pro_Del(<%=model.id %>);"><b></b><span><%=Tag("删除")%></span></a></li>
                        </ul>
                    </div>
                </div>
                <%} %>
            </div>
        </div>
        
        
        <div style="display: none" class="cont">
            
            <div class="mod-title">
                <div><%=Tag("配送记录")%></div>
            </div>
            <div class="mod-table-main">
                <div class="con style05">
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tr>
                            <th style="width: 150px;">
                                <%=Tag("时间")%>
                            </th>
                            <th style="width: 100px;">
                                <%=Tag("类型")%>
                            </th>
                            <th style="width: 150px;">
                                <%=Tag("配送方式")%>
                            </th>
                            <th style="width: 150px;">
                                <%=Tag("发货单号")%>
                            </th>
                            <th style="width: 100px;">
                                <%=Tag("实际运费")%>
                            </th>
                            <th style="width: 150px;">
                                <%=Tag("状态")%>
                            </th>
                            <th style="width: 150px;">
                                <%=Tag("收/发件人")%>
                            </th>
                            <th>
                                <%=Tag("操作")%>
                            </th>
                            
                        </tr>
                        <%foreach (DB.LebiShop.Lebi_Transport_Order torder in torders)
                          { %>
                        <tr>
                            <td>
                                <%=FormatTime(torder.Time_Add) %>
                            </td>
                            <td>
                                <%=Shop.Bussiness.EX_Type.TypeName(model.Type_id_OrderType) %>
                            </td>
                            <td>
                                <%=torder.Transport_Name %>
                            </td>
                            <td>
                                <%=torder.Code %>
                            </td>
                            <td>
                                <%=DefaultCurrency.Msige %><%=torder.Money %>
                            </td>
                            
                            <td>
                                <%=Shop.Bussiness.EX_Type.TypeName(torder.Type_id_TransportOrderStatus) %>
                            </td>
                            
                            <td>
                                <%=torder.T_Name %>
                            </td>
                            <td>
                                
                                <a href="javascript:Order_shipping_log(<%=torder.id %>);"><%=Tag("跟踪")%></a> 
                                | <a href="javascript:Order_shipping_shouhuo(<%=torder.id %>);"><%=Tag("收货")%></a>
                            </td>
                        </tr>
                        <%} %>
                    </table>
                </div>
            </div>
            
            <div class="hr40">
            </div>

        </div>
        
        
        <div style="display: none" class="cont">
            <div class="mod-title">
                <div><%=Tag("订单备注")%></div>
            </div>
            <div style="text-align:left;margin-top:10px;">
                <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                <th height="30">
                <input type="radio" name="mark" shop="true" value="0" <%if (model.Mark == 0){Response.Write("checked");} %> /> <img src="<%=AdminImage("mark/0.png")%>" height="12" />&nbsp;
                <input type="radio" name="mark" shop="true" value="1" <%if (model.Mark == 1){Response.Write("checked");} %> /> <img src="<%=AdminImage("mark/1.png")%>" height="12" />&nbsp;
	            <input type="radio" name="mark" shop="true" value="2" <%if (model.Mark == 2){Response.Write("checked");} %> /> <img src="<%=AdminImage("mark/2.png")%>" height="12" />&nbsp;
	            <input type="radio" name="mark" shop="true" value="3" <%if (model.Mark == 3){Response.Write("checked");} %> /> <img src="<%=AdminImage("mark/3.png")%>" height="12" />&nbsp;
	            <input type="radio" name="mark" shop="true" value="4" <%if (model.Mark == 4){Response.Write("checked");} %> /> <img src="<%=AdminImage("mark/4.png")%>" height="12" />&nbsp;
	            <input type="radio" name="mark" shop="true" value="5" <%if (model.Mark == 5){Response.Write("checked");} %> /> <img src="<%=AdminImage("mark/5.png")%>" height="12" />
                </th>
                </tr>
                <tr>
                <th colspan="2">
               <textarea name="Remark_Admin" id="Remark_Admin" shop="true" class="textarea" style="width:600px;height:60px"><%=model.Remark_Admin %></textarea>
                <div class="tools clear">
                    <ul>
                        <li class="plus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Remark_Admin',100);"><b></b><span><%=Tag("展开")%></span></a></li>
                        <li class="minus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Remark_Admin',-100)"><b></b><span><%=Tag("收缩")%></span></a></li>
                    </ul>
                </div>
                </th>
                </tr>
                </table>
            </div>
            <div style="text-align:left;margin-top:10px;">
                <div class="tools tools-m">
                    <ul>
                        <li class="submit"><a href="javascript:void(0);" onclick="SaveOrder(<%=model.id %>);"><b></b><span><%=Tag("保存")%></span></a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div style="display: none" class="cont">
            <div class="mod-title">
                <div><%=Tag("订单留言")%></div>
            </div>
            <div style="text-align:left;margin-top:10px;">
               <textarea name="Comment" id="Comment" Comment="true" class="textarea" style="width:600px;height:60px"></textarea>
                <div class="tools clear">
                    <ul>
                        <li class="plus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Comment',100);"><b></b><span><%=Tag("展开")%></span></a></li>
                        <li class="minus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Comment',-100)"><b></b><span><%=Tag("收缩")%></span></a></li>
                    </ul>
                </div>
            </div>
            <div style="text-align:left;margin-top:10px;">
                <div class="tools tools-m clear">
                    <ul>
                        <li class="submit"><a href="javascript:void(0);" onclick="SaveComment(<%=model.id %>);"><b></b><span><%=Tag("保存")%></span></a></li>
                    </ul>
                </div>
            </div>
            <div class="mod-title">
                <div><%=Tag("订单留言")%></div>
            </div>
            <div class="mod-table-main">
                <div class="con style05">
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        
                        <tr>
                            <th style="width:30px;" class="selectAll">
                <a href="javascript:void(0);" onclick="$('input[name=\'commid\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a></th>
                            <th style="width:150px;">
                                <%=Tag("时间")%>
                            </th>
                            <th>
                                <%=Tag("内容")%>
                            </th>
                        </tr>
                      <%foreach (DB.LebiShop.Lebi_Comment comm in comms)
                        { %>
                        <tr>
                            <td style="text-align:center">
                                <input type="checkbox" name="commid" value="<%=comm.id %>" del="true" />
                            </td>
                            <td>
                                <%=FormatTime(comm.Time_Add) %>
                            </td>
                            
                            <td>
                                <%
                                    if (comm.Admin_id > 0)
                                        Response.Write("[" + Tag("管理员") + "]" + comm.Admin_UserName);
                                    if (comm.User_id > 0)
                                        Response.Write("[" + Tag("会员") + "]" + comm.User_UserName);
                                    if (comm.Supplier_id > 0)
                                        Response.Write("[" + Tag("供应商") + "]" + comm.Supplier_SubName);
                                %> ：
                                <%=comm.Content%>
                            </td>
                        </tr>

                    <%} %>
                    </table>
                </div>
                <div style="text-align:left;margin-top:10px;">
                    <div class="tools tools-m clear">
                        <ul>
                            <li class="del"><a href="javascript:void(0);" onclick="Comment_Del(<%=model.id %>);"><b></b><span><%=Tag("删除")%></span></a></li>
                        </ul>
                    </div>
                </div>
                
            </div>
        </div>
        
        
        <div style="display: none" class="cont">
            <div class="mod-title">
                <div><%=Tag("订单日志")%></div>
            </div>
            <div class="mod-table-main">
                <div class="con style05">
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tr>
                            <th width="150px;">
                                <%=Tag("时间")%>
                            </th>
                            <th width="180px;">
                                <%=Tag("操作人")%>
                            </th>
                            <th >
                                <%=Tag("行为")%>
                            </th>
                        </tr>
                        <% 
                            foreach (DB.LebiShop.Lebi_Log log in Logs)
                            {    
                            
                        %>
                        <tr>
                            <td><%=FormatTime(log.Time_Add) %></td>
                            <td><%
                                if(log.Admin_id>0)
                                    Response.Write("["+Tag("管理员")+"]"+log.AdminName);
                                if(log.User_id>0)
                                    Response.Write("["+Tag("会员")+"]"+log.UserName);
                                if (log.Supplier_id > 0)
                                    Response.Write("["+Tag("供应商")+"]"+log.Supplier_SubName);
                                %></td>
                            <td><%=log.Content +" "+ log.Description%></td>
                        </tr>
                        <% } %>
                    </table>
                </div>
            </div>
        </div>
        
    </div>

    <script src="<%=site.AdminAssetsPath %>/plugins/jquery/jquery.min.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/popper/popper.min.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=site.AdminJsPath %>/jquery.slimscroll.js"></script>
    <script src="<%=site.AdminJsPath %>/sidebarmenu.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/sticky-kit-master/dist/sticky-kit.min.js"></script>
    <script src="<%=site.AdminJsPath %>/custom.min.js"></script>
    <script src="<%=site.AdminJsPath %>/Cookies.js"></script>
    <script src="<%=site.AdminJsPath %>/main.js"></script>
    <script src="<%=site.AdminJsPath %>/messagebox.js"></script>
	<script>
		$(document).on("modal fade show", ".modal", function(){
			$(this).draggable({
				handle: ".modal-header"   // 只能点击头部拖动
				cursor: 'move',
			});
			$(this).css("overflow", "hidden");
		});
	</script>
    
</body>
</html>