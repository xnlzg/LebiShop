<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.statis.sales_list" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("销售报表")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
<style media=print>.print-btn{display:none;}</style>

    <script>
        var AdminPath = "<%=site.AdminPath %>";var WebPath ="<%=site.WebPath %>";var AdminImagePath = "<%=site.AdminImagePath %>";var requestPage = "<%=LB.Tools.RequestTool.GetRequestUrl().ToLower() %>";var refPage = "<%=LB.Tools.RequestTool.GetUrlReferrer().ToLower() %>";
    </script>
</head>
<body class="fix-sidebar fix-header card-no-border">
	
    <div id="main-wrapper">
        <div class="container-fluid">
            <div class="row page-titles print-btn">
                <div class="col-md-12 col-12 align-self-center">
                    <button class="btn btn-info" onclick="window.print();"><i class="ti-printer"></i> <%=Tag("打印")%></button>
                    <button class="btn btn-default" onclick="window.close();"><i class="ti-close"></i> <%=Tag("关闭")%></button>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="box-title"><%=dateFrom%> - <%=dateTo%></h3>
                            <div class="table-responsive">
                                <table class="table table-hover no-wrap m-t-20">
                                    <thead>
                                        <tr>
                                            <th><%=Tag("序号")%></th>
                                            <th><%=Tag("商品编号")%></th>
                                            <th><%=Tag("商品货号")%></th>
                                            <th><%=Tag("商品名称")%></th>
                                            <th><%=Tag("规格")%></th>
                                            <th><%=Tag("数量")%></th>
                                            <th><%=Tag("单价")%></th>
                                            <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
                                            <th><%=Tag("成本")%></th>
                                            <th><%=Tag("利润")%></th>
                                            <%} %>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%int i = 0; int totalqty = 0; decimal totalprice = 0; decimal totalprice_cost = 0; decimal totalprofit = 0; foreach (DB.LebiShop.Lebi_Order_Product pro in pros){
                                        if (pro.Price_Cost == 0){
                                        pro.Price_Cost = Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).Price_Cost;
                                        DB.LebiShop.B_Lebi_Order_Product.Update(pro);
                                        }
                                        %>
                                        <tr>
                                            <td class="list" title="<%=pro.Time_Add%>"><%=i + 1%></td>
                                            <td class="list"><%=pro.Product_Number%>&nbsp;</td>
                                            <td class="list"><%=Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).Code%>&nbsp;</td>
                                            <td class="list"><%=Shop.Bussiness.Language.Content(pro.Product_Name, CurrentLanguage)%></td>
                                            <td class="list"><%=Shop.Bussiness.EX_Product.ProPertyNameStr(Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).ProPerty131, CurrentLanguage)%>&nbsp;</td>
                                            <td class="list"><%=pro.Count%></td>
                                            <td class="list"><%=FormatMoney(pro.Price)%></td>
                                            <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
                                            <td class="list"><%=FormatMoney(pro.Price_Cost)%></td>
                                            <td class="list"><%=FormatMoney((pro.Price - pro.Price_Cost) * pro.Count)%></td>
                                            <%} %>
                                        </tr>
                                        <%i += 1; totalqty += pro.Count; totalprice += pro.Price * pro.Count; totalprice_cost += pro.Price_Cost * pro.Count; totalprofit += (pro.Price - pro.Price_Cost) * pro.Count;
                                        } %>
                                        <tr>
                                            <td colspan="5"><strong><%=Tag("合计")%></strong></td>
                                            <td><strong><%=totalqty%></strong></td>
                                            <td><strong><%=FormatMoney(totalprice)%></strong></td>
                                            <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
                                            <td><strong><%=FormatMoney(totalprice_cost)%></strong></td>
                                            <td><strong><%=FormatMoney(totalprofit)%></strong></td>
                                            <%} %>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
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