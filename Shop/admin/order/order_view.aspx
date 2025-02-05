﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Order_View" validateRequest="false"%>
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
    
    
    <link href="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/horizontal-timeline/css/horizontal-timeline.css" rel="stylesheet">
    <style media=print>
        .print-btn {
            display: none;
        }
    </style>

    <script>
        var AdminPath = "<%=site.AdminPath %>";var WebPath ="<%=site.WebPath %>";var AdminImagePath = "<%=site.AdminImagePath %>";var requestPage = "<%=LB.Tools.RequestTool.GetRequestUrl().ToLower() %>";var refPage = "<%=LB.Tools.RequestTool.GetUrlReferrer().ToLower() %>";
    </script>
</head>
<body class="fix-sidebar fix-header card-no-border">
	
    <%
    Lebi.ERP.PLebi_User user =new Lebi.ERP.PLebi_User(model.User_id);
    //Lebi.ERP.PLebi_Order porder =new Lebi.ERP.PLebi_Order(model.id);
    %>
    <div id="main-wrapper">
        <div class="container-fluid">
            <div class="page-titles titles-flex print-btn">
                <div class="row">
                    <div class="col-md-9 align-self-center">
                        <%if (model.Type_id_OrderType==212){%>
                        <button class="btn btn-default" style="cursor:none"><i class="ti-info-alt"></i> <%=Shop.Bussiness.EX_Type.TypeName(model.Type_id_OrderType)%></button>
                        <%if (model.IsVerified == 0){ %>
                        <button class="btn btn-success" onclick="Order_type(1,'<%=model.id %>','IsInvalid');"><i class="ti-check"></i> <%=Tag("有效订单")%></button>
                        <button class="btn btn-success" onclick="Order_type(1,'<%=model.id %>','IsVerified');"><i class="ti-check"></i> <%=Tag("审核订单")%></button>
                        <%} else { %>
                        <button class="btn btn-danger" onclick="Order_type(0,'<%=model.id %>','IsVerified');"><i class="ti-na"></i> <%=Tag("取消审核")%></button>
                        <%}%>
                        <%if (model.IsReceived_All == 1 && model.IsCreateNewOrder == 0 && model.IsPaid == 0){%>
                        <button class="btn btn-danger" onclick="torder_cash(1);"><i class="ti-back-left"></i> <%=Tag("退款到提现") %></button>
                        <button class="btn btn-danger" onclick="torder_cash(2);"><i class="ti-back-left"></i> <%=Tag("退款到账户") %></button>
                        <button class="btn btn-info" onclick="torder_cash(3);"><i class="ti-plus"></i> <%=Tag("生成新订单")%></button>
                        <%} %>
                        <%} else {%>
                        <button class="btn btn-default" style="cursor:none"><i class="ti-info-alt"></i> <%=Tag("已取消")%></button>
                        <%if (model.Type_id_OrderType == 212){ %>
                        <button class="btn btn-default" style="cursor:none"><i class="ti-info-alt"></i> <%=Shop.Bussiness.EX_Type.TypeName(model.Type_id_OrderType)%></button>
                        <%} %>
                        <%if (model.IsInvalid == 1){ %>
                        <button class="btn btn-danger" onclick="Order_type(0,'<%=model.id %>','IsInvalid');"><i class="ti-na"></i> <%=Tag("无效订单")%></button>
                        <%} else {%>
                        <%if (model.IsRefund == 2){ %>
                        <button class="btn btn-success" onclick="Order_type(1,'<%=model.id %>','IsRefund');"><i class="ti-check"></i> <%=Tag("同意")%><%=Tag("取消订单")%></button>
                        <button class="btn btn-success" onclick="Order_type(3,'<%=model.id %>','IsRefund');"><i class="ti-na"></i> <%=Tag("拒绝")%><%=Tag("取消订单")%></button>
                        <%}if (model.IsVerified == 0){ %>
                        <button class="btn btn-success" onclick="Order_type(1,'<%=model.id %>','IsInvalid');"><i class="ti-check"></i> <%=Tag("有效订单")%></button>
                        <button class="btn btn-success" onclick="Order_type(1,'<%=model.id %>','IsVerified');"><i class="ti-check"></i> <%=Tag("审核订单")%></button>
                        <%} else { %>
                        <button class="btn btn-danger" onclick="Order_type(0,'<%=model.id %>','IsVerified');"><i class="ti-na"></i> <%=Tag("取消审核")%></button>
                        <%if (model.Type_id_OrderType != 212){%>
                        <%if (model.IsPaid != 1){ %>
                        <button class="btn btn-success" onclick="Order_Pay('<%=model.id %>');"><i class="ti-check"></i> <%=Tag("已支付")%></button>
                        <%} else {%>
                        <button class="btn btn-danger" onclick="Order_type(0,'<%=model.id %>','IsPaid');"><i class="ti-na"></i> <%=Tag("未支付")%></button>
                        <%} %>
                        <%if (model.IsShipped_All != 1){ %>
                        <button class="btn btn-success" onclick="Order_shipping('<%=model.id %>');"><i class="ti-check"></i> <%=Tag("发货")%></button>
                        <%} %>
                        <%} %>
                        <%if (model.IsShipped == 1 && model.IsCompleted != 1){ %>
                        <button class="btn btn-success" onclick="Order_type(1,'<%=model.id %>','IsCompleted');"><i class="ti-check"></i> <%=Tag("已完成")%></button>
                        <%}%>
                        <%if (model.IsCompleted == 1){%>
                        <button class="btn btn-danger" onclick="Order_type(0,'<%=model.id %>','IsCompleted');"><i class="ti-na"></i> <%=Tag("未完成")%></button>
                        <%}%>
                        <%} %>
                        <%} %>
                        <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_orderquickpay")){%>
                        <button class="btn btn-default" onclick="OrderQucikPay('<%=model.id %>');"><i class="ti-link"></i> <%=Tag("付款链接")%></button>
                        <%} %>
                        <%} %>
                    </div>
                    <div class="closebtn col-md-3 align-self-center">
                        <div class="d-flex justify-content-end">
                            <button class="btn btn-info m-r-5" onclick="window.print();"><i class="ti-printer"></i> <%=Tag("打印")%></button>
                            <button class="btn btn-default" onclick="window.close();"><i class="ti-close"></i> <%=Tag("关闭")%></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row with-titles-flex">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <section class="cd-horizontal-timeline">
                                <div class="timeline">
                                    <div class="events-wrapper">
                                        <div class="events">
                                            <ol>
                                                <li><a href="#0" data-date="01/01/2019" class="selected"><%=Tag("提交订单")%><em><%=FormatTime(model.Time_Add) %></em></a></li>
                                                <%if (model.IsInvalid == 1){ %>
                                                <%if (model.IsRefund == 1){ %>
                                                <li><a href="#0" data-date="01/02/2019" class="selected"><%=Tag("已取消")%><em><%=FormatTime(model.Time_Refund) %></em></a></li>
                                                <%}else{ %>
                                                <li><a href="#0" data-date="01/02/2019" class="selected"><%=Tag("无效订单")%><em><%=FormatTime(model.Time_Completed) %></em></a></li>
                                                <%} %>
                                                <%}else if (model.IsVerified == 0){ %>
                                                <li><a href="#0" data-date="01/02/2019"><%=Tag("审核订单")%></a></li>
                                                <%}else if (model.IsRefund == 2){ %>
                                                <li><a href="#0" data-date="01/02/2019" class="selected"><%=Tag("申请取消")%><em><%=FormatTime(model.Time_Refund) %></em></a></li>
                                                <li><a href="#0" data-date="01/03/2019"><%=Tag("审核订单")%></a></li>
                                                <%}else{ %>
                                                <li><a href="#0" data-date="01/02/2019" class="selected"><%=Tag("审核订单")%><em><%=FormatTime(model.Time_Verified) %></em></a></li>
                                                <%if (model.Type_id_OrderType == 212){ %>
                                                <li><a href="#0" data-date="01/03/2019" class="<%=model.IsShipped==1?" selected":"" %>"><%=Tag("发货")%><%=model.IsShipped==1?"<em>"+ FormatTime(model.Time_Shipped) +"</em>":""%></a></li>
                                                <li><a href="#0" data-date="01/04/2019" class="<%=model.IsReceived==1?" selected":"" %>"><%=Tag("收货")%><%=model.IsReceived==1?"<em>"+ FormatTime(model.Time_Received) +"</em>":""%></a></li>
                                                <%if (model.IsCreateNewOrder != 1){ %>
                                                <li><a href="#0" data-date="01/05/2019" class="<%=model.IsPaid==1?" selected":"" %>"><%=Tag("退款")%><%=model.IsPaid==1?"<em>"+ FormatTime(model.Time_Paid) +"</em>":""%></a></li>
                                                <%}else{ %>
                                                <li><a href="#0" data-date="01/05/2019" class="<%=model.IsCreateNewOrder==1?" selected":"" %>"><%=Tag("生成新订单")%><%=model.IsCreateNewOrder==1?"<em>"+ FormatTime(model.Time_CreateNewOrder) +"</em>":""%></a></li>
                                                <%} %>
                                                <li><a href="#0" data-date="01/06/2019" class="<%=model.IsCompleted==1?" selected":"" %>"><%=Tag("完成")%><%=model.IsCompleted==1?"<em>"+ FormatTime(model.Time_Completed) +"</em>":""%></a></li>
                                                <%}else{ %>
                                                <%if (model.IsPaid != 1){ %>
                                                <li><a href="#0" data-date="01/03/2019"><%=Tag("已支付")%></a></li>
                                                <%}else{ %>
                                                <li><a href="#0" data-date="01/03/2019" class="selected"><%=Tag("已支付")%><em><%=FormatTime(model.Time_Paid) %></em></a></li>
                                                <%} %>
                                                <%if (model.IsShipped != 1){ %>
                                                <li><a href="#0" data-date="01/04/2019"><%=Tag("已发货")%></a></li>
                                                <%}else{ %>
                                                <li><a href="#0" data-date="01/04/2019" class="selected"><%if (model.IsShipped_All != 1){ %><%=Tag("部分发货")%><%}else{ %><%=Tag("已发货")%><%} %><em><%=FormatTime(model.Time_Shipped) %></em></a></li>
                                                <%} %>
                                                <%if (model.IsReceived != 1){ %>
                                                <li><a href="#0" data-date="01/05/2019"><%=Tag("已收货")%></a></li>
                                                <%}else{ %>
                                                <li><a href="#0" data-date="01/05/2019" class="selected"><%=Tag("已收货")%><em><%=FormatTime(model.Time_Received) %></em></a></li>
                                                <%} %>
                                                <%if (model.IsCompleted != 1){ %>
                                                <li><a href="#0" data-date="01/06/2019"><%=Tag("已完成")%></a></li>
                                                <%}else{ %>
                                                <li><a href="#0" data-date="01/06/2019" class="selected"><%=Tag("已完成")%><em><%=FormatTime(model.Time_Completed) %></em></a></li>
                                                <%} %>
                                                <%} %>
                                                <%} %>
                                            </ol>
                                            <span class="filling-line" aria-hidden="true"></span>
                                        </div>
                                    </div>
                                    
                                    <ul class="cd-timeline-navigation">
                                        <li><a href="#0" class="prev inactive">Prev</a></li>
                                        <li><a href="#0" class="next">Next</a></li>
                                    </ul>
                                    
                                </div>
                                
                            </section>
                        </div>
                    </div>
                    <div class="card">
                        <div class="col-md-12">
                            <ul class="nav nav-tabs customtab m-t-15" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#info" role="tab"><%=Tag("基本信息")%></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#product" role="tab"><%=Tag("商品信息")%></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#ship" role="tab"><%=Tag("配送记录")%><strong>(<%if (TransportCount>0){ %><font><%=TransportCount %></font><%}else{%>0<%} %>)</strong></a>
                                </li>
                                <%if (DeliveryCount > 0){ %>
                                <li class="nav-item">
                                    <a class="nav-link" href="#pickup" role="tab"><%=Tag("配送点")%></a>
                                </li>
                                <%}%>
                                <li class="nav-item">
                                    <a class="nav-link" href="#remark" role="tab"><%=Tag("订单备注")%></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#comment" role="tab"><%=Tag("订单留言")%><strong>(<%if (CommentCount>0){ %><font><%=CommentCount %></font><%}else{%>0<%} %>)</strong></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#log" role="tab"><%=Tag("订单日志")%><strong>(<%if (LogCount>0){ %><font><%=LogCount %></font><%}else{%>0<%} %>)</strong></a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-12">
                            <h4 class="nav-tips m-t-10 m-b-10"><%=Tag("基本信息")%><a name="info"></a></h4>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th colspan="2">
                                                        <%=Tag("基本信息")%>
                                                        <%if (model.IsVerified == 0){ %>
                                                        <a href="javascript:EditBaseInfo(<%=model.id %>);"><%=Tag("编辑")%></a>
                                                        <%} %>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%if (oldmodel.id > 0){%>
                                                <tr class="no-wrap">
                                                    <td>
                                                        <%=Tag("原始订单")%>：
                                                    </td>
                                                    <td>
                                                        <a href="order_view.aspx?id=<%=oldmodel.id %>" target="_blank"><%=oldmodel.Code%></a>
                                                    </td>
                                                </tr>
                                                <%}%>
                                                <tr class="no-wrap">
                                                    <td>
                                                        <%=Tag("订单编号")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.Code %>
                                                    </td>
                                                </tr>
                                                <%if (shop.id > 0){%>
                                                <tr>
                                                    <td>
                                                        <%=Tag("商家")%>：
                                                    </td>
                                                    <td>
                                                        <%=shop.Company%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <tr>
                                                    <td>
                                                        <%=Tag("订购时间")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatTime(model.Time_Add) %>
                                                    </td>
                                                </tr>
                                                <tr class="no-wrap">
                                                    <td>
                                                        <%=Tag("状态")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.Order.OrderStatus(model, CurrentLanguage.Code) %>
                                                        <%//=model.IsShipped_All==0?"["+Tag("部分发货")+"]":"" %>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("商品重量")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.Weight %> <%=Tag("KG")%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("商品体积")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.Volume/1000000 %> m&sup3;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("配送方式")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.Transport_Name %>[<%=model.Transport_Mark %>]
                                                        <%if(model.PickUp_id>0){ %>
                                                        <br />
                                                        <%=Tag("自提点") %>：<%=model.PickUp_Name %><br />
                                                        <%=Tag("自提时间")%>：<%=model.PickUp_Date.ToString("yyyy-MM-dd") %>

                                                        <%} %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("支付方式")%>：
                                                    </td>
                                                    <td>
                                                        <%if (model.OnlinePay_id > 0){%>
                                                        <%=Shop.Bussiness.Language.Content(model.OnlinePay,CurrentLanguage)%>
                                                        <%}else{%>
                                                        <%=Shop.Bussiness.Language.Content(model.Pay,CurrentLanguage)%>
                                                        <%}%>
                                                    </td>
                                                </tr>
                                                <%if(SYS.BillFlag=="1"){%>
                                                <tr>
                                                    <td>
                                                        <%=Tag("发票状态")%>：
                                                    </td>
                                                    <td>
                                                        <%=billstatus%>
                                                        <a href="javascript:EditBill('<%=model.id %>');"><%=Tag("编辑")%></a>
                                                    </td>
                                                </tr>
                                                <%}%>
                                                <%if(Promotion!=""){%>
                                                <tr>
                                                    <td>
                                                        <%=Tag("优惠方式")%>：
                                                    </td>
                                                    <td>
                                                        <%=Promotion%>
                                                    </td>
                                                </tr>
                                                <%}%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th colspan="2">
                                                        <%=Tag("金额")%>
                                                        <%if (model.IsPaid == 0){ %>
                                                        <a href="javascript:EditOrderMoney('<%=model.id %>');"><%=Tag("编辑")%></a>
                                                        <%} %>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr class="no-wrap">
                                                    <td>
                                                        <%=Tag("商品总额")%>：
                                                    </td>
                                                    <td align="left">
                                                        <%=FormatMoney(model.Money_Product)%>
                                                        <%=FormatMoney(model.Money_Product, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%if (model.Money_Cut>0){ %>
                                                <tr>
                                                    <td>
                                                        <%=Tag("优惠金额")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_Cut)%>
                                                        <%=FormatMoney(model.Money_Cut, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_Give>0){ %>
                                                <tr>
                                                    <td>
                                                        <%if (model.Type_id_OrderType==212){%>
                                                        <%=Tag("退款金额")%>：
                                                        <%}else{%>
                                                        <%=Tag("返还金额")%>：
                                                        <%}%>
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_Give)%>
                                                        <%=FormatMoney(model.Money_Give, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Type_id_OrderType!=212){%>
                                                <tr>
                                                    <td>
                                                        <%=Tag("配送费用")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_Transport)%>
                                                        <%=FormatMoney(model.Money_Transport, model.Currency_Code)%>
                                                        <%if (model.IsPaid == 0){ %>
                                                        <a href="javascript:EditOrderMoney_Transport('<%=model.id %>');"><%=Tag("编辑")%></a>
                                                        <%} %>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_Bill>0){ %>
                                                <tr>
                                                    <td>
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
                                                    <td>
                                                        <%=Tag("税金")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_Tax)%>
                                                        <%=FormatMoney(model.Money_Tax, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_fromorder > 0){ %>
                                                <tr>
                                                    <td>
                                                        <%=Tag("其它订单")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_fromorder)%>
                                                        <%=FormatMoney(model.Money_fromorder, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_Property>0){ %>
                                                <tr>
                                                    <td>
                                                        <%=Tag("其它费用")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_Property)%>
                                                        <%=FormatMoney(model.Money_Property, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <tr>
                                                    <td>
                                                        <%=Tag("订单总额")%>：
                                                    </td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_Order)%>
                                                        <%=FormatMoney(model.Money_Order,model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%if (model.Money_UserCut > 0){ %>
                                                <tr>
                                                    <td><%=Tag("余额支付")%>：</td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_UserCut)%>
                                                        <%=FormatMoney(model.Money_UserCut, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_UseCard311 > 0)
                                                { %>
                                                <tr>
                                                    <td><%=Tag("购物卡支付")%>：</td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_UseCard311)%>
                                                        <%=FormatMoney(model.Money_UseCard311, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_UseCard312 > 0)
                                                { %>
                                                <tr>
                                                    <td><%=Tag("代金券支付")%>：</td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_UseCard312)%>
                                                        <%=FormatMoney(model.Money_UseCard312, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_fromorder > 0){ %>
                                                <tr>
                                                    <td><%=Tag("转移金额")%>：</td>
                                                    <td>
                                                        <%=FormatMoney(model.Money_fromorder)%>
                                                        <%=FormatMoney(model.Money_fromorder, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (model.Money_Pay>0){ %>
                                                <tr>
                                                    <td>
                                                        <%=Tag("应付金额")%>：
                                                    </td>
                                                    <td>
                                                        <strong>
                                                            <%=FormatMoney(model.Money_Pay)%>
                                                            <%=FormatMoney(model.Money_Pay, model.Currency_Code)%>
                                                        </strong>

                                                    </td>
                                                </tr>
                                                <%} %>
                                                <tr>
                                                    <td>
                                                        <%=Tag("可得积分")%>：
                                                    </td>
                                                    <td>
                                                        <%=str + model.Point%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("消费积分")%>：
                                                    </td>
                                                    <td>
                                                        <%=str + model.Point_Buy%>
                                                    </td>
                                                </tr>
                                                <%if (model.Refund_VAT > 0){ %>
                                                <tr>
                                                    <td>
                                                        <%=Tag("退税信息")%>：
                                                    </td>
                                                    <td>
                                                        <%=Tag("所含税额")%>：<%=FormatMoney(model.Refund_VAT)%>
                                                        <%=FormatMoney(model.Refund_VAT, model.Currency_Code)%><br />
                                                        <%=Tag("退税手续费")%>：<%=FormatMoney(model.Refund_Fee)%>
                                                        <%=FormatMoney(model.Refund_Fee, model.Currency_Code)%><br />
                                                        <%=Tag("退税总额")%>：<%=FormatMoney(model.Refund_VAT - model.Refund_Fee)%>
                                                        <%=FormatMoney(model.Refund_VAT - model.Refund_Fee, model.Currency_Code)%>
                                                    </td>
                                                </tr>
                                                <%} %>
                                                <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_erp")) {%>
                                                <%if(model.IsPaid==0){%>
                                                <tr>
                                                    <td>
                                                        <%=Tag("余额")%>：
                                                    </td>
                                                    <td>
                                                        <%=user.Money-user.Money_fanxian%>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                                        <%if(user.id>0){%>
                                                        <a href="javascript:money_add('<%=user.UserName%>',<%=user.id%>)"><%=Tag("充值")%></a>
                                                        <%}%>
                                                    </td>
                                                </tr>
                                                <%if(user.Money_fanxian>0){%>
                                                <tr>
                                                    <td>
                                                        <%=Tag("返利支付")%>：
                                                    </td>
                                                    <td>
                                                        <input type="text" id="Money_fanxianpay" name="Money_fanxianpay" value="0" class="form-control form-control-sm" onchange="changefanxianpay();" shoporder="true" style="width:70px;" onkeyup="value=value.replace(/[^\d\.-]/g,'')" />
                                                        <%=Tag("返利余额")%>：<%=user.Money_fanxian%>
                                                    </td>
                                                </tr>
                                                <%}%>
                                                <tr>
                                                    <td></td>
                                                    <td>
                                                        
                                                        <button type="button" class="btn btn-success" onclick="pay('p');"><i class="ti-check"></i> 使用余额支付￥<%=model.Money_Pay%></button>
                                                    </td>
                                                </tr>
                                                <%}} %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th colspan="2">
                                                        <%=Tag("收货人信息")%>
                                                        <%if (model.IsShipped == 0){ %>
                                                        <a href="javascript:EditBillingAddress('<%=model.id %>');"><%=Tag("编辑")%></a>
                                                        <%} %>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr class="no-wrap">
                                                    <td>
                                                        <%=Tag("姓名")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.T_Name %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("电话")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.T_Phone %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("手机")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.T_MobilePhone %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("地区")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.EX_Area.GetAreaName(model.T_Area_id)%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("地址")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.T_Address %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("邮编")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.T_Postalcode %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("Email")%>：
                                                    </td>
                                                    <td>
                                                        <%=model.T_Email %>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th colspan="2">
                                                        <%=Tag("会员信息")%>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr class="no-wrap">
                                                    <td>
                                                        <%=Tag("会员")%>：
                                                    </td>
                                                    <td>
                                                        <a href="../user/default.aspx?key=<%=model.User_UserName%>"><%=model.User_UserName%></a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("姓名")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.EX_User.GetUser(model.User_id).RealName %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("电话")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.EX_User.GetUser(model.User_id).Phone %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("手机")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.EX_User.GetUser(model.User_id).MobilePhone %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("地区")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.EX_Area.GetAreaName(Shop.Bussiness.EX_User.GetUser(model.User_id).Area_id)%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("地址")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.EX_User.GetUser(model.User_id).Address %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("邮编")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.EX_User.GetUser(model.User_id).Postalcode %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Tag("Email")%>：
                                                    </td>
                                                    <td>
                                                        <%=Shop.Bussiness.EX_User.GetUser(model.User_id).Email %>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a name="product"></a>
                        <div class="col-md-12">
                            <h4 class="nav-tips m-t-10 m-b-10"><%=Tag("商品信息")%></h4>
                            <%if (model.IsVerified == 0){ %>
                            <div class="row">
                                <div class="col-md-9 m-b-10">
                                    <button class="btn btn-success btn-xs btn-sm" onclick="Pro_Save('<%=model.id %>');"><i class="ti-check"></i> <%=Tag("保存")%></button>
                                    <button class="btn btn-danger btn-xs btn-sm" onclick="Pro_Del('<%=model.id %>');"><i class="ti-trash"></i> <%=Tag("删除")%></button>
                                </div>
                                <div class="col-md-3 m-b-10">
                                    <div class="input-group">
                                        <input type="text" id="pnumber" name="pnumber" placeholder="<%=Tag(" 商品编号")%>" class="form-control form-control-sm">
                                        <div class="input-group-append">
                                            <button type="button" class="btn btn-success btn-xs btn-sm" onclick="selectproduct(0);"><i class="ti-check"></i> <%=Tag("添加")%></button>
                                            <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_erp")) {%>
                                            <button type="button" class="btn btn-info btn-xs btn-sm" onclick="searchprodutwindow();"><i class="ti-search"></i> <%=Tag("查询商品")%></button>
                                            <%} %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%} %>
                            <div class="table-responsive">
                                <table class="table table-hover no-wrap">
                                    <thead>
                                        <tr class="no-wrap">
                                            <%if (model.IsVerified==0)
                                            { %>
                                            <th style="width: 30px" class="selectAll">
                                                <a href="javascript:void(0);" onclick="$('input[name=\'proid\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a>
                                            </th>
                                            <%} %>
                                            <th>
                                                <%=Tag("商品编号")%>
                                            </th>
                                            <th>
                                                <%=Tag("商品货号")%>
                                            </th>
                                            <th>
                                                <%=Tag("商品名称")%>
                                            </th>
                                            <th>
                                                <%=Tag("规格")%>
                                            </th>
                                            <th>
                                                <%=Tag("单位")%>
                                            </th>
                                            <th>
                                                <%if (model.Type_id_OrderType == 212) { Response.Write(Tag("数量")); } else { Response.Write(Tag("订购数量")); }%>
                                            </th>
                                            <th>
                                                <%=Tag("已发数量")%>
                                            </th>
                                            <th>
                                                <%=Tag("已收数量")%>
                                            </th>
                                            <th>
                                                <%=Tag("单价")%>
                                            </th>
                                            <th>
                                                <%=Tag("小计")%>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%foreach (DB.LebiShop.Lebi_Order_Product pro in pros){ %>
                                        <tr>
                                            <%if (model.IsVerified==0){ %>
                                            <td>
                                                <label class="custom-control custom-checkbox">
                                                    <input type="checkbox" id="proid<%=model.id %>" name="proid" value="<%=pro.id %>" class="custom-control-input" del="true">
                                                    <span class="custom-control-label"></span>
                                                </label>
                                                <input type="hidden" name="Uproid" value="<%=pro.id %>" pro="true" />
                                            </td>
                                            <%} %>
                                            <td>
                                                <%=pro.Product_Number %>
                                                <%if (model.IsVerified == 0 && pro.Count_Shipped == 0){ %>
                                                <a href="javascript:void(0);" onclick="selectproduct(<%=pro.id %>)"><%=Tag("编辑")%></a>
                                                <%} %>
                                            </td>
                                            <td><%=Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).Code%></td>
                                            <td>
                                                <img src="<%=Image(pro.ImageOriginal,50,50) %>" style="height:30px;padding:3px 0" />
                                                [<%=Shop.Bussiness.EX_Type.TypeName(pro.Type_id_OrderProductType,CurrentLanguage.Code) %>]
                                                <%=Lang(pro.Product_Name) %>&nbsp;
                                                <a target="_blank" href="<%=Shop.Bussiness.ThemeUrl.GetURL(" P_Product",pro.Product_id.ToString(),"",CurrentLanguage.Code)%>"><i class="ti-new-window"></i></a>
                                            </td>
                                            <td>
                                                <%if (pro.ProPerty134!=""){ %><%=pro.ProPerty134%><br /><%} %><%=Shop.Bussiness.EX_Product.ProPertyNameStr(Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).ProPerty131, CurrentLanguage)%>
                                            </td>
                                            <td><%=Lang(Shop.Bussiness.EX_Product.ProductUnit(pro.Units_id))%></td>
                                            <td>
                                                <%if (model.IsVerified==1){ %>
                                                <%=str + pro.Count%>
                                                <%}else{ %>
                                                <input type="text" id="Count<%=pro.id %>" name="Count<%=pro.id %>" value="<%=pro.Count %>" class="form-control form-control-sm" style="max-width:70px;" pro="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                                                <%} %>
                                            </td>
                                            <td>
                                                <%=pro.Count_Shipped %>
                                            </td>
                                            <td>
                                                <%=pro.Count_Received %>
                                            </td>
                                            <td>
                                                <%if (model.IsVerified==1){ %>
                                                <%=pro.Price %>
                                                <%}else{ %>
                                                <input type="text" id="Price<%=pro.id %>" name="Price<%=pro.id %>" value="<%=FormatMoney(pro.Price," Number") %>" class="form-control form-control-sm" style="max-width:70px;" pro="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                                <%} %>
                                            </td>
                                            <td>
                                                <%=str + FormatMoney(pro.Money)%>
                                            </td>
                                        </tr>
                                        <%} %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <a name="ship"></a>
                        <div class="col-md-12">
                            <h4 class="nav-tips m-t-10 m-b-10"><%=Tag("配送记录")%></h4>
                            <div class="row">
                                <div class="table-responsive">
                                    <table class="table table-hover no-wrap">
                                        <thead>
                                            <tr class="no-wrap">
                                                <th>
                                                    <%=Tag("时间")%>
                                                </th>
                                                <th>
                                                    <%=Tag("类型")%>
                                                </th>
                                                <th>
                                                    <%=Tag("配送方式")%>
                                                </th>
                                                <th>
                                                    <%=Tag("发货单号")%>
                                                </th>
                                                <th>
                                                    <%=Tag("实际运费")%>
                                                </th>
                                                <th>
                                                    <%=Tag("状态")%>
                                                </th>
                                                <th>
                                                    <%=Tag("收/发件人")%>
                                                </th>
                                                <th>
                                                    <%=Tag("操作")%>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%foreach (DB.LebiShop.Lebi_Transport_Order torder in torders){ %>
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
                                                    <%=FormatMoney(torder.Money) %>
                                                </td>

                                                <td>
                                                    <%=Shop.Bussiness.EX_Type.TypeName(torder.Type_id_TransportOrderStatus) %>
                                                </td>

                                                <td>
                                                    <%=torder.T_Name %>
                                                </td>
                                                <td>
                                                    <a href="javascript:Order_shipping_log(<%=torder.id %>);"><%=Tag("跟踪")%></a>
                                                    <%if (model.Type_id_OrderType == 212){ %>
                                                    <a href="javascript:Order_shipping_shouhuo(<%=torder.id %>);"><%=Tag("收货")%></a>
                                                    <%}else{%>
                                                    <a href="javascript:Order_shipping_view(<%=torder.id %>);"><%=Tag("查看")%></a>
                                                    <a href="Express_Print.aspx?Tid=<%=torder.Transport_id %>&id=<%=model.id %>" target="_blank"><%=Tag("打印快递单")%><%if (model.IsPrintExpress == 1){ %>(<font class=red><%=Tag("已打印")%></font>)<%} %></a>
                                                    <%}%>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                    </table>
                                </div>
                                
                            </div>
                        </div>
                        <%if (DeliveryCount > 0){ %>
                        <a name="pickup"></a>
                        <div class="col-md-12">
                            <h4 class="nav-tips m-t-10 m-b-10"><%=Tag("配送点")%></h4>
                            <div class="row">
                                <div class="col-12">
                                    <form action="javascript:SaveOrder('<%=model.id %>');" novalidate>
                                        <div class="form-group">
                                            <select name="Supplier_Delivery_id" class="form-control form-control-sm" shop="true">
                                                <option value="0"><%=Tag("请选择")%></option>
                                                <%foreach (DB.LebiShop.Lebi_Supplier_Delivery delivery in deliveries){ %>
                                                <option value="<%=delivery.id %>" <%=delivery.id == model.Supplier_Delivery_id?"selected":"" %>><%=delivery.Name %></option>
                                                <%} %>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-success btn-xs btn-sm"><i class="ti-check"></i> <%=Tag("保存")%></button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        <a name="remark"></a>
                        <div class="col-md-12">
                            <h4 class="nav-tips m-t-10 m-b-10"><%=Tag("订单备注")%></h4>
                            <div class="row">
                                <div class="col-12">
                                    <form action="javascript:SaveOrder('<%=model.id %>');" novalidate>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <label class="custom-control custom-radio m-r-20">
                                                    <input type="radio" name="mark" value="0" class="custom-control-input" shop="true" <%=model.Mark==0?"checked":"" %>>
                                                    <span class="custom-control-label"><i class="ti-flag text-dark"></i></span>
                                                </label>
                                                <label class="custom-control custom-radio m-r-20">
                                                    <input type="radio" name="mark" value="1" class="custom-control-input" shop="true" <%=model.Mark==1?"checked":"" %>>
                                                    <span class="custom-control-label"><i class="ti-flag text-danger"></i></span>
                                                </label>
                                                <label class="custom-control custom-radio m-r-20">
                                                    <input type="radio" name="mark" value="2" class="custom-control-input" shop="true" <%=model.Mark==2?"checked":"" %>>
                                                    <span class="custom-control-label"><i class="ti-flag text-primary"></i></span>
                                                </label>
                                                <label class="custom-control custom-radio m-r-20">
                                                    <input type="radio" name="mark" value="3" class="custom-control-input" shop="true" <%=model.Mark==3?"checked":"" %>>
                                                    <span class="custom-control-label"><i class="ti-flag text-success"></i></span>
                                                </label>
                                                <label class="custom-control custom-radio m-r-20">
                                                    <input type="radio" name="mark" value="4" class="custom-control-input" shop="true" <%=model.Mark==4?"checked":"" %>>
                                                    <span class="custom-control-label"><i class="ti-flag text-warning"></i></span>
                                                </label>
                                                <label class="custom-control custom-radio">
                                                    <input type="radio" name="mark" value="5" class="custom-control-input" shop="true" <%=model.Mark==5?"checked":"" %>>
                                                    <span class="custom-control-label"><i class="ti-flag text-purple"></i></span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <textarea id="Remark_Admin" name="Remark_Admin" class="form-control" style="height:60px;" shop="true"><%=model.Remark_Admin%></textarea>
                                            <div class="button-group m-t-5">
                                                <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark_Admin',100);"><%=Tag("展开")%></button>
                                                <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark_Admin',-100);"><%=Tag("收缩")%></button>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-success btn-xs btn-sm"><i class="ti-check"></i> <%=Tag("保存")%></button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <a name="comment"></a>
                        <div class="col-md-12">
                            <h4 class="nav-tips m-t-10 m-b-10"><%=Tag("订单留言")%></h4>
                            <div class="row">
                                <div class="col-12">
                                    <form action="javascript:SaveComment('<%=model.id %>');" novalidate>
                                        <div class="form-group">
                                            <textarea id="Comment" name="Comment" class="form-control" style="height:60px;" Comment="true"></textarea>
                                            <div class="button-group m-t-5">
                                                <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Comment',100);"><%=Tag("展开")%></button>
                                                <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Comment',-100);"><%=Tag("收缩")%></button>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-success btn-xs btn-sm"><i class="ti-check"></i> <%=Tag("保存")%></button>
                                    </form>
                                </div>
                            </div>
                            <%if (comms.Count > 0){%>
                            <div class="row m-t-20">
                                <div class="col-md-12 m-b-10">
                                    <button class="btn btn-danger btn-xs btn-sm" onclick="Comment_Del('<%=model.id %>');"><i class="ti-trash"></i> <%=Tag("删除")%></button>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover no-wrap">
                                    <thead>
                                        <tr class="no-wrap">
                                            <th style="width:30px;" class="selectAll">
                                                <a href="javascript:void(0);" onclick="$('input[name=\'commid\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a>
                                            </th>
                                            <th>
                                                <%=Tag("时间")%>
                                            </th>
                                            <th>
                                                <%=Tag("内容")%>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%foreach (DB.LebiShop.Lebi_Comment comm in comms){ %>
                                        <tr>
                                            <td>
                                                <label class="custom-control custom-checkbox">
                                                    <input type="checkbox" id="commid<%=model.id %>" name="commid" value="<%=comm.id %>" class="custom-control-input" del="true">
                                                    <span class="custom-control-label"></span>
                                                </label>
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
                                    </tbody>
                                </table>
                            </div>
                            <%}%>
                        </div>
                        <a name="log"></a>
                        <div class="col-md-12">
                            <h4 class="nav-tips m-t-10 m-b-10"><%=Tag("订单日志")%></h4>
                            <div class="table-responsive">
                                <table class="table table-hover no-wrap">
                                    <thead>
                                        <tr class="no-wrap">
                                            <th>
                                                <%=Tag("时间")%>
                                            </th>
                                            <th>
                                                <%=Tag("操作人")%>
                                            </th>
                                            <th>
                                                <%=Tag("行为")%>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%foreach (DB.LebiShop.Lebi_Log log in Logs){%>
                                        <tr>
                                            <td><%=FormatTime(log.Time_Add) %></td>
                                            <td>
                                                <%
                                                if(log.Admin_id>0)
                                                Response.Write("["+Tag("管理员")+"]"+log.AdminName);
                                                if(log.User_id>0)
                                                Response.Write("["+Tag("会员")+"]"+log.UserName);
                                                if(log.Supplier_id>0)
                                                Response.Write("["+Tag("供应商")+"]"+log.Supplier_SubName);
                                                %>
                                            </td>
                                            <td><%=log.Content +" "+ log.Description%></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<div class="modal fade" id="Modal-Confirm" tabindex="-1" role="dialog" aria-labelledby="Confirm">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><%=Tag("警告")%></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <p><i class="ti-alert"></i> <span id="Confirm-Content"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("取消")%></button>
                <button type="button" class="btn btn-success btn-ok"><i class="ti-check"></i> <%=Tag("确定")%></button>
            </div>
        </div>
    </div>
</div>

    
<div class="modal fade" tabindex="-1" role="dialog" id="EditModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <p><i class="ti-alert"></i> <%=Tag("加载中")%></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            </div>
        </div>
    </div>
</div>

    
<div class="modal fade" tabindex="-1" role="dialog" id="EditsubModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <p><i class="ti-alert"></i> <%=Tag("加载中")%></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
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
    
    <script src="<%=site.AdminJsPath %>/validation.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/moment/moment.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/horizontal-timeline/js/horizontal-timeline.js"></script>

    <script>
        function SaveOrder(id) {
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_Edit&id=" + id;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function SaveComment(id) {
            var postData = GetFormJsonData("comment");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Comment_Edit&id=" + id;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        //确认订单
        function Order_type(t, id, model) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认操作吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "Order_type_obj('" + t + "', '" + id + "', '" + model + "');");
        }
        function Order_type_obj(t, id, model) {
            $("#Modal-Confirm").modal("hide");
            var postData = { "t": t };
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_type&id=" + id + "&model=" + model;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function Order_Pay(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "order_pay_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function EditBillingAddress(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "billingaddress_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function EditOrderMoney(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "order_money_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function EditOrderMoney_Transport(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "order_money_transport_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Order_shipping(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "shipping_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Order_shipping_view(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "shipping_view_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Order_shipping_log(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "shipping_log_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Pro_Del(id) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "Pro_DelObj(" + id + ");");
        }
        function Pro_DelObj(id) {
            $("#Modal-Confirm").modal("hide");
            var postData = GetFormJsonData("del");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=OrderPro_Del&id=" + id;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function Comment_Del(id) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "Comment_DelObj(" + id + ");");
        }
        function Comment_DelObj(id) {
            $("#Modal-Confirm").modal("hide");
            var postData = GetFormJsonData("del");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Comment_Del&id=" + id;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function Pro_Save(id) {
            var postData = GetFormJsonData("pro");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=OrderPro_Edit&id=" + id;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function selectproduct(id) {
            var pnumber = $("#pnumber").val();
            $("#EditModal").modal("show");
            $.ajax({
                url: "selectproduct_window.aspx",
                type: "GET",
                cache: false,
                data: { orderid: '<%=model.id %>', id: id, pnumber: pnumber },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function EditBaseInfo(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "order_baseinfo_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function EditBill(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "<%=site.AdminPath %>/order/bill_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { orderid: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function torder_cash(t) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认操作吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "torder_cash_obj(" + t + ");");
        }
        function torder_cash_obj(t) {
            $("#Modal-Confirm").modal("hide");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=TOrder_Cash&id=<%=model.id %>&type=" + t;
            RequestAjax(url, '', function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function Order_shipping_shouhuo(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "shipping_shouhuo_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
    </script>
    <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_orderquickpay")) {%>
    <script>
        function OrderQucikPay(id) {
            var title_ = "<%=Tag("付款链接")%>";
            $("#EditModal").modal("show");
            $.ajax({
                url: "<%=site.AdminPath %>/order/order_quickpay_window.aspx",
                type: "GET",
                cache: false,
                data: { orderid: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
    </script>
    <%}%>
    <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_erp")) {%>
    <script>
        var selectproductmuti = undefined;
        function searchprodutwindow() {
            var title_ = "<%=Tag("选择商品")%>";
            $("#EditsubModal .modal-dialog").attr("class", "modal-dialog modal-lg");
            $("#EditsubModal .modal-dialog").attr("style", "max-width:1500px;");
            $("#EditsubModal").modal("show");
            $.ajax({
                url: "selectproductadd_window.aspx",
                type: "GET",
                cache: false,
                data: { title: title_ },
            }).done(function (result) {
                $("#EditsubModal .modal-content").html(result);
            });
        }
        function search_product(Product_id, number) {
            $('#pnumber').val(number);
            $('#pwindow').dialog('close');
        }
        function money_add(User_Name, id) {
            var title_ = "<%=Tag("充值")%>";
            $("#EditModal").modal("show");
            $.ajax({
                url: "usermoney_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { User_Name: User_Name, t: 191, title: title_ },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function changefanxianpay() {
            var s = $('#Money_fanxianpay').val();
            var p =<%=model.Money_Pay%> -s;
            if (p < 0) {
                MsgBox(2, "输入错误！", "")
                $('#Money_fanxianpay').val('0');
                $('#btn_pay').val('使用余额支付￥<%=model.Money_Pay%>');
            } else {
                $('#btn_pay').val('使用余额支付￥' + p);
            }
        }
        function pay(t) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认付款吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "pay_obj('" + t + "');");
        }
        function pay_obj(t) {
            $("#Modal-Confirm").modal("hide");
            var postData = GetFormJsonData("shoporder");
            //var T_Area_id=$('#Area_id').val();
            var T_Area_id = 0;
            var url = "<%=site.AdminPath %>/ajax/ajax_ex.aspx?__Action=checkout_order_pay&id=<%=model.id%>&T_Area_id=" + T_Area_id + "&t=" + t;
            $.ajax({
                type: 'POST',
                url: url,
                data: postData,
                dataType: 'json',
                success: function (res) {
                    if (res.msg == "OK") {
                        MsgBox(1, "<%=Tag("操作成功")%>", "?");
                    } else {
                        MsgBox(2, res.msg, "");
                    }
                }
            });

        }
    </script>
    <%}%>

</body>
</html>