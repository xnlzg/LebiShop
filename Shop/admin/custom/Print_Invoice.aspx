﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Shop.Bussiness.PageBase.AdminCustomPageBase.cs" Inherits="Shop.Bussiness.AdminCustomPageBase" %>
<%@ Import Namespace="Shop.Bussiness" %>
<%@ Import Namespace="Shop.Model" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%
int id = Rint("id");
Lebi_Order model = B_Lebi_Order.GetModel(id);
if (model == null)
{
    model = new Lebi_Order();
}
List<Lebi_Order_Product> pros = B_Lebi_Order_Product.GetList("Order_id=" + model.id + "", "");
List<Lebi_Comment> comms = B_Lebi_Comment.GetList("TableName='Order' and Keyid=" + model.id + " and User_id = "+ model.User_id +" and Admin_id = 0", "id desc");
Lebi_Bill bill = B_Lebi_Bill.GetModel("Order_id = "+ id);
if (bill == null)
{
    bill = new Lebi_Bill();
}
%>
<html>
<head>
<title>发票-<%=Tag("单据打印")%>-<%=site.title%></title>
<META name="author" content="LebiShop">
<link rel="stylesheet" type="text/css" href="<%=site.AdminCssPath %>/css.css">
<script type="text/javascript" src="<%=site.AdminJsPath %>/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=site.AdminJsPath %>/messagebox.js"></script>
<script type="text/javascript" src="<%=site.AdminJsPath %>/jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=site.AdminJsPath %>/jqueryuicss/redmond/jquery-ui.css" />
<style>
body{background:#fff;margin:0;padding:0;font-size:12px;text-align:left}h1,h2,h3{text-align:center;font-weight:bold;}h1{font-size:22px},h2{font-size:18px}h3{font-size:14px}input{font-size:12px}.order-print{width:754px;margin:0 auto}.order-print table{width:100%; margin-bottom:10px;border-collapse:collapse;}.order-print table td{border-bottom:1px solid #000}.order-print table th{text-align:left}
.order-print h2{margin:0; padding:5px 0; font-weight:bold; font-size:14px; text-align:left}
.order-print .headmenu{padding-left:5px; height:27px;color:#666;font-size:13px;font-weight:bold}
.order-print .list{border-top:1px solid #000}
.order-print .list th{padding-left:5px; line-height:25px; font-weight:normal; text-align:left; border-bottom:1px solid #000}
.order-print .list td{padding-left:5px; line-height:25px; text-align:left; background:#fff; border-bottom:1px solid #fff}
.order-print .list TR.list {background-color:expression((this.rowIndex%2==0)?"#FFFFFF":"#FFFFFF")}
.order-print .list TH.list .pro-pic {width: 45px; height: 45px}
.order-print .list TH.list .pro-pic IMG {width: expression(this.width > 45 ? 45 : true); height: expression(this.height > 45 ? 45 : true); max-width: 45px; max-height: 45px; vertical-align: middle; text-align: center}</style>
<style media=print>.print-btn{display:none;}</style>
</head>
<body>
<div class="print-btn">
    <div class="tools">
        <ul>
            <li class="print"><a href="javascript:void(0);" onclick="window.print();"><b></b><span><%=Tag("打印")%></span></a></li>
            <li class="close"><a href="javascript:void(0);" onclick="window.close();"><b></b><span><%=Tag("关闭")%></span></a></li>
        </ul>
    </div>
</div>
<div class="order-print">
<h1>中领国际实业有限公司</h1>
<h1>SINOLINK International Industrial Co.,Limited</h1>
<h3>ADD: Room H,15/F,Siu King Building.6 On Wah Street,Ngau Tau Kok.Kowloon,HongKong.</h3>
<h1>发票</h1>
<h1>INVOICE</h1>
<table cellspacing="0" cellpadding="0" align="center">
<tr>
<th style="width:18%">Order Number：</th><td style="width:32%"><%=model.Code%></td>
<th style="width:18%">INVOICE No.：</th><td style="width:32%"><%=bill.BillNo%></td>
</tr>
<tr>
<th>Shipping way：</th><td><%=Shop.Bussiness.Language.Content(model.Pay,CurrentLanguage)%></td>
<th>Payment Term：</th><td>T/T</td>
</tr>
<tr>
<th>Loading port：</th><td>SHEKOU,CHINA</td>
<th>Date：</th><td><%=model.Time_Add %></td>
</tr>
</table>
<h2>Buyer information</h2>
<table cellspacing="0" cellpadding="0" align="center">
<tr>
<th style="width:18%">Buyer name：</th><td style="width:32%"><%=model.T_Name %></td>
<th style="width:18%">Mobile.：</th><td style="width:32%"><%=model.T_MobilePhone%></td>
</tr>
<tr>
<th>Buyer address：</th><td><%=model.T_Address%> <%=Shop.Bussiness.EX_Area.GetAreaName(model.T_Area_id)%></td>
<th>Discharge port：</th><td><%=Shop.Bussiness.EX_Area.GetAreaName(model.T_Area_id,0)%></td>
</tr>
<tr>
<th>City：</th><td><%=Shop.Bussiness.EX_Area.GetAreaName(model.T_Area_id,0)%></td>
<th>Country：</th><td><%=Shop.Bussiness.EX_Area.GetAreaName(Shop.Bussiness.EX_Area.Parentids_Get(model.T_Area_id,0),0)%></td>
</tr>
<tr>
<th>Zip / postal code：</th><td><%=model.T_Postalcode %></td>
<th>E-mail Address：</th><td><%=model.T_Email %></td>
</tr>
<tr>
<th>Telephone number：</th><td colspan="3"><%=model.T_Phone %></td>
</tr>
</table>
<table cellspacing="0" cellpadding="0" border="1" align="center" class="list">
<tr>
<th style="width:10%;line-height:130%">Item No.</th>
<th colspan="2">Pic & Goods Description</th>
<th style="width:8%;line-height:130%">Unit</th>
<th style="width:8%;line-height:130%">QTY</th>
<th style="width:10%;line-height:130%">Unit Price</th>
<th style="width:10%;line-height:130%">Amount</th>
</tr>
<%int totalqty = 0;decimal totalmoney = 0; foreach (Shop.Model.Lebi_Order_Product pro in pros)
  { %>
<tr class="list">
<th class="list"><%=pro.Product_Number %></th>
<th class="list" width="50"><img src="<%=WebPath + pro.ImageSmall %>" style="height:40px;padding:3px 0" /></th>
<th class="list"><%=Shop.Bussiness.Language.Content(pro.Product_Name, CurrentLanguage)%></th>
<th class="list"><%=Lang(Shop.Bussiness.EX_Product.ProductUnit(pro.Units_id))%></th>
<th class="list"><%=pro.Count%></th>
<th class="list"><%=FormatMoney(pro.Price) %></th>
<th class="list"><%=FormatMoney(pro.Money)%></th>
</tr>
<%totalqty += pro.Count;totalmoney += pro.Money;;
  } %>
<tr>
<th class="list">&nbsp;</th>
<th class="list">&nbsp;</th>
<th class="list">&nbsp;</th>
<th class="list">&nbsp;</th>
<th class="list" colspan="2" style="text-align:right">TOTAL:</th>
<th class="list"><%=FormatMoney(totalmoney)%></th>
</tr>
<tr>
<th class="list" colspan="7">
BANK INFO:<br />
Beneficiary: SINOLINK International Industrial Co., Limited<br />
Address: Room H, 15/F, Siu King Building, 6 On Wah Street, Ngau Tau Kok, Kowloon, Hongkong.<br />
Account number: 817-276256-838<br />
Bank name: HSBC Hong Kong<br />
Bank Addr.: 1 Queen's Road Central, Hong Kong<br />
SWIFT code: HSBCHKHHHKH
</th>
</tr>
</table>
</div>
</body>
</html>