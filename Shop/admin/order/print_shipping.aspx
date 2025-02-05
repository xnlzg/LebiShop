﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Print_Shipping" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("发货单")%>-<%=Tag("单据打印")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
<style>body{background:#fff;margin:0;padding:0;font-size:12px;text-align:left}input{font-size:12px}.order-print table{width:100%; margin-bottom:10px}
.order-print h2{margin:0 0 10px 0; padding:10px 0; border-bottom:1px dotted #000; font-weight:bold; font-size:15px; text-align:Center}
.order-print .headmenu{padding-left:5px; height:27px;color:#666;font-size:13px;font-weight:bold}
.order-print th{padding-left:5px; line-height:25px; font-weight:normal; text-align:left; border-bottom:1px dotted #000}
.order-print td{padding-left:5px; line-height:25px; text-align:left; background:#fff}
.order-print TR.list {background-color:expression((this.rowIndex%2==0)?"#FFFFFF":"#FFFFFF")}
.order-print TD.list {padding-left:3px;border-bottom:1px dotted #000; line-height:25px}
.order-print TD.list .pro-pic {width: 45px; height: 45px}
.order-print TD.list .pro-pic IMG {width: expression(this.width > 45 ? 45 : true); height: expression(this.height > 45 ? 45 : true); max-width: 45px; max-height: 45px; vertical-align: middle; text-align: center}</style>
<style media=print>.print-btn{display:none;}</style>

    <script>
        var AdminPath = "<%=site.AdminPath %>";var WebPath ="<%=site.WebPath %>";var AdminImagePath = "<%=site.AdminImagePath %>";var requestPage = "<%=LB.Tools.RequestTool.GetRequestUrl().ToLower() %>";var refPage = "<%=LB.Tools.RequestTool.GetUrlReferrer().ToLower() %>";
    </script>
</head>
<body class="fix-sidebar fix-header card-no-border">
	
<div class="print-btn">
    <div class="tools">
        <ul>
            <li class="print"><a href="javascript:void(0);" onclick="window.print();"><b></b><span><%=Tag("打印")%></span></a></li>
            <li class="close"><a href="javascript:void(0);" onclick="window.close();"><b></b><span><%=Tag("关闭")%></span></a></li>
        </ul>
    </div>
</div>
<div class="order-print">
<h2><%=Shop.Bussiness.Language.Content(config.Name,CurrentLanguage.Code)%> <%=Tag("发货单")%></h2>
<table cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="width:33%"><%=Tag("订单编号")%>：<%=model.Code%></td>
<td style="width:33%"><%=Tag("姓名")%>：<%=model.T_Name %></td>
<td style="width:33%"><%=Tag("会员账号")%>：<%=model.User_UserName%></td>
</tr>
<tr>
<td><%=Tag("打印时间")%>：<%=FormatTime(DateTime.Now)%></td>
<td><%=Tag("电话")%>：<%=model.T_Phone%></td>
<td><%=Tag("手机")%>：<%=model.T_MobilePhone%></td>
</tr>
<tr>
<td colspan="3" valign="top"><%=Tag("地址")%>：<%=model.T_Address%></td>
</tr>
<tr>
<td colspan="3" valign="top"><%=Tag("订单留言")%>：<%int i =0;foreach (DB.LebiShop.Lebi_Comment comm in comms){ %><%=comm.Content%><%if (i>0){Response.Write("<br/>");}i++;} %>
</td>
</tr>
</table>
<table cellspacing="0" cellpadding="0" align="center">
<tr>
<th style="width:5%"><%=Tag("序号")%></th>
<th style="width:10%"><%=Tag("商品编号")%></th>
<th style="width:10%"><%=Tag("商品货号")%></th>
<th><%=Tag("商品名称")%></th>
<th style="width:10%"><%=Tag("规格")%></th>
<th style="width:10%"><%=Tag("数量")%></th>
<th style="width:10%"><%=Tag("单价")%></th>
<th style="width:10%"><%=Tag("小计")%></th>
</tr>
<%i = 0; int totalqty = 0; foreach (DB.LebiShop.Lebi_Order_Product pro in pros)
  { %>
<tr class="list">
<td class="list"><%=i + 1%></td>
<td class="list"><%=pro.Product_Number%>&nbsp;</td>
<td class="list"><%=Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).Code%>&nbsp;</td>
<td class="list"><%=Shop.Bussiness.Language.Content(pro.Product_Name, CurrentLanguage)%></td>
<td class="list"><%=Shop.Bussiness.EX_Product.ProPertyNameStr(Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).ProPerty131, CurrentLanguage)%>&nbsp;</td>
<td class="list"><%=FormatMoney(pro.Count)%></td>
<td class="list"><%=FormatMoney(pro.Price)%></td>
<td class="list"><%=FormatMoney(pro.Money)%></td>
</tr>
<%i += 1; totalqty += pro.Count;
  } %>
</table>
<table cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="width:20%"><%=Tag("商品总数")%>：<%=totalqty%></td>
<td style="width:20%"><%=Tag("商品总额")%>：<%=FormatMoney(model.Money_Product)%></td>
<td style="width:20%"><%=Tag("配送费用")%>：<%=FormatMoney(model.Money_Transport)%></td>
<td style="width:20%"><%=Tag("税金")%>：<%=FormatMoney(model.Money_Bill)%></td>
<td style="width:20%"><%=Tag("订单总额")%>：<%=FormatMoney(model.Money_Order)%></td>
</tr>
</table>
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