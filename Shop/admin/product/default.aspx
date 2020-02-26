<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.default_" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("商品列表")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link href="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/multiselect/css/jquery.multiselect2side.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/lightbox/css/lightbox.min.css" rel="stylesheet" />

    <script>
        var AdminPath = "<%=site.AdminPath %>";var WebPath ="<%=site.WebPath %>";var AdminImagePath = "<%=site.AdminImagePath %>";var requestPage = "<%=LB.Tools.RequestTool.GetRequestUrl().ToLower() %>";var refPage = "<%=LB.Tools.RequestTool.GetUrlReferrer().ToLower() %>";
    </script>
</head>
<body class="fix-sidebar fix-header card-no-border">
    <div id="main-wrapper">
        <header class="topbar">
            <nav class="navbar top-navbar navbar-expand-md navbar-light">
                <div class="navbar-header">
                    <a class="navbar-brand" href="<%=site.AdminPath %>/ajax/ajax_admin.aspx?__Action=MenuJump&pid=0">
                        <b>
                            <img src="<%=Shop.Bussiness.ShopCache.GetBaseConfig().system_layout_logo %>" class="light-logo" />
                        </b>
                     </a>
                </div>
                <div class="navbar-collapse">
                    <ul class="navbar-nav mr-auto mt-md-0">
                        <li class="nav-item"> <a class="nav-link nav-toggler hidden-md-up text-muted waves-effect waves-dark" href="javascript:void(0)"><i class="ti-menu"></i></a> </li>
                        <li class="nav-item"> <a class="nav-link sidebartoggler hidden-sm-down text-muted waves-effect waves-dark" href="javascript:void(0)"><i class="ti-menu"></i></a> </li>
                    </ul>
                    <ul class="navbar-nav my-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="<%=CurrentAdmin.Avatar%>" alt="<%=CurrentAdmin.UserName%>" class="profile-pic" /></a>
                            <div class="dropdown-menu dropdown-menu-right scale-up">
                                <ul class="dropdown-user">
                                    <li>
                                        <div class="dw-user-box">
                                            <div class="u-img"><img src="<%=CurrentAdmin.Avatar%>" alt="<%=CurrentAdmin.UserName%>" /></div>
                                            <div class="u-text">
                                                <h4><%=CurrentAdmin.UserName%></h4>
                                                <p class="text-muted"><%=Lang(CurrentAdminGroup.Name)%></p></div>
                                        </div>
                                    </li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="javascript:AdminPWD(0);"><i class="ti-key"></i> <%=Tag("改密")%></a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="<%=site.AdminPath %>/admin/log.aspx?id=<%=CurrentAdmin.id%>"><i class="ti-location-pin"></i> <%=Tag("操作日志")%></a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="javascript:void(0);" onclick="quit()"><i class="ti-power-off"></i> <%=Tag("注销")%></a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><i class="ti-world"></i> <%=CurrentAdminLanguage.Name%></a>
                            <div class="dropdown-menu dropdown-menu-right scale-up"> 
                            <%foreach (DB.LebiShop.Lebi_Language_Code langc in langs)
                              {
                            %>
                            <a class="dropdown-item" href="javascript:SetLanguage('<%=langc.Code %>','<%=langc.Name %>');"><%=langc.Name %></a>
                            <%} %>
							</div>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <aside class="left-sidebar">
            
            <div class="scroll-sidebar">
                
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
						<%if (desk == 1){ %>
							<li>
								<a class="has-arrow waves-effect waves-dark" href="#" aria-expanded="false"><i class="ti-anchor"></i><span class="hide-menu"><%=Tag("快捷菜单")%> </span></a>
								<ul aria-expanded="false" class="collapse">
									<%foreach (DB.LebiShop.Lebi_Menu menu in GetIndexMenus()){ %><li><a href="<%=MenuUrl(menu.URL,1) %>"><%=Tag(menu.Name)%></a></li><%}%>
								</ul>
							</li>
							<%foreach (DB.LebiShop.Lebi_Menu menu in TopMenus){ %>
							<li> <a class="waves-effect waves-dark" href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=<%=menu.id %>"><i class="<%=menu.Image!=""?menu.Image:"ti-folder"%>"></i><span class="hide-menu"><%=Tag(menu.Name)%></span></a>
							</li>							<%} %>                        <%} else { %>
							<li>
								<a class="has-arrow waves-effect waves-dark" href="#" aria-expanded="false"><i class="ti-more"></i><span class="hide-menu"><%=Tag("顶级分类")%> </span></a>
								<ul aria-expanded="false" class="collapse">
									<%foreach (DB.LebiShop.Lebi_Menu menu in TopMenus){ %><li><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=<%=menu.id %>"><%=Tag(menu.Name)%></a></li><%}%>
								</ul>
							</li>
							<%foreach (DB.LebiShop.Lebi_Menu menu in GetMenus(CurrentTopMenu.id)){ %>
							<li> <a class="has-arrow waves-effect waves-dark" href="#" aria-expanded="false"><i class="<%=menu.Image!=""?menu.Image:"ti-folder"%>"></i><span class="hide-menu"><%=Tag(menu.Name)%></span></a>
								<ul aria-expanded="true" class="collapse">
								<%foreach (DB.LebiShop.Lebi_Menu pmenu in GetMenus(menu.id)){ %>
								<li> <a href="<%=MenuUrl(pmenu.URL,0) %>"><%=Tag(pmenu.Name)%></a>
								</li>
								<%} %>
								</ul>
							</li>							<%} %>
						<%} %>
                        <li class="nav-devider"></li>
                        <li><a href="javascript:void(0);" onclick="updateadmin();"><i class="ti-reload"></i><span class="hide-menu"><%=Tag("系统刷新")%></span></a></li>
                        <li><a href="javascript:void(0);" onclick="UpdateCache(0);"><i class="ti-server"></i><span class="hide-menu"><%=Tag("更新缓存")%></span></a></li>
                        <li><a href="javascript:void(0);" onclick="UpdateCache(1);"><i class="ti-cloud-down"></i><span class="hide-menu"><%=Tag("数据同步")%></span></a></li>
                    </ul>
                </nav>
            </div>
            <div class="sidebar-footer">
                <a href="<%=site.WebPath %>/" target="_blank" class="link" title="<%=Tag("网站前台") %>"><i class="ti-home"></i></a>
                <a href="javascript:void(0);" onclick="Copyright();" class="link" title="<%=Tag("关于")%>"><i class="ti-info-alt"></i></a>
                <a href="javascript:void(0);" onclick="quit()" class="link" data-toggle="tooltip" title="<%=Tag("注销")%>"><i class="ti-power-off"></i></a>
            </div>
        </aside>
        <div class="page-wrapper">
            <div class="container-fluid">
                <div class="row page-titles">
                    <div class="col-12 align-self-center">
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("商品列表")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/product/"><%=Tag("商品列表")%></a></li>
        <li class="breadcrumb-item active"><%=sp.Description%></li>
    </ol>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-9 m-b-10">
                        <%if (PageReturnMsg == ""){%>
                        <a class="btn btn-info" href="Product_Edit.aspx?Type_id_ProductType=<%=Type_id_ProductType %>" target="_blank"><i class="ti-plus"></i> <%=Tag("添加")%></a>
                        <button class="btn btn-danger" onclick="DeleteConfirm()"><i class="ti-trash"></i> <%=Tag("删除")%></button>
                        <button class="btn btn-default" onclick="Product_Status_Edit_muti(1);"><i class="ti-arrow-up"></i> <%=Tag("上架")%></button>
                        <button class="btn btn-default" onclick="Product_Status_Edit_muti(0);"><i class="ti-arrow-down"></i> <%=Tag("下架")%></button>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <%=Tag("更多")%>
                            </button>
                            <div class="dropdown-menu">
                                <a href="javascript:void(0);" onclick="Product_MoveCategory();" class="dropdown-item"><%=Tag("类别")%></a>
                                <a href="javascript:void(0);" onclick="Product_MoveBrand();" class="dropdown-item"><%=Tag("品牌")%></a>
                                <a href="javascript:void(0);" onclick="Product_MoveTag();" class="dropdown-item"><%=Tag("标签")%></a>
                                
                                <%if (site.SiteCount > 1){ %><div class="dropdown-divider"></div><a href="javascript:void(0);" onclick="Product_Site();" class="dropdown-item"><%=Tag("站点")%></a><%} %>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <div class="col-md-3 m-b-10">
                        <div class="input-group">
                            <input type="text" id="key" name="key" value="<%=key %>" class="form-control" onkeydown="if(event.keyCode==13){search_();}">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-primary" onclick="search_();"><i class="ti-search"></i></button>
                                <button class="btn btn-default" onclick="SearchWindow();"><i class="ti-filter"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive sorttable">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr>
                                <th class="selectAll" style="width: 40px">
                                    <a href="javascript:void(0);" onclick="$('input[name=\'productid\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a>
                                </th>
                                <th>
                                    <%=Tag("图片")%>
                                </th>
                                <th>
                                    <%=Tag("编号")%>
                                </th>
                                <th>
                                    <%=Tag("商品名称")%>
                                </th>
                                <th>
                                    <%=Tag("子商品")%>
                                </th>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy," PriceDesc")%>
                                    ');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy," PriceDesc","icon")%>"><%if (Type_id_ProductType == 321){ %><%=Tag("抢购价")%><%}else if (Type_id_ProductType == 322){ %><%=Tag("团购价")%><%}else if (Type_id_ProductType == 323){ %><%=Tag("换购积分")%><%}else{ %><%=Tag("销售价")%><%} %></div>
                                </th>
                                <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy," Price_CostDesc")%>
                                    ');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy," Price_CostDesc","icon")%>"><%=Tag("成本价")%></div>
                                </th>
                                <%} %>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy," CountDesc")%>
                                    ');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy," CountDesc","icon")%>"><%=Tag("库存")%></div>
                                </th>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy," FreezeDesc")%>
                                    ');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy," FreezeDesc","icon")%>"><%=Tag("冻结库存")%></div>
                                </th>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy," SalesDesc")%>
                                    ');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy," SalesDesc","icon")%>"><%=Tag("销量")%></div>
                                </th>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy," ViewsDesc")%>
                                    ');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy," ViewsDesc","icon")%>"><%=Tag("浏览量")%></div>
                                </th>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy," StatusDesc")%>
                                    ');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy," StatusDesc","icon")%>"><%=Tag("状态")%></div>
                                </th>
                                <%if (Type_id_ProductType == 321){ %>
                                <th>
                                    <%=Tag("截止日期")%>
                                </th>
                                <%} %>
                                <th style="width:15%">
                                    <%=Tag("操作")%>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            decimal Total_Price = 0;
                            decimal Total_Price_Cost = 0;
                            int Total_Count_Stock = 0;
                            int Total_Count_Freeze = 0;
                            int Total_Count_Sales = 0;
                            int Total_Count_Views = 0;
                            foreach (DB.LebiShop.Lebi_Product model in models)
                            {
                            int Count_Stock = Shop.Bussiness.EX_Product.ProductStockForAdmin(model);
                            Count_Stock += model.Count_Freeze;
                            string Price = "";
                            if (model.Type_id_ProductType == 321 || model.Type_id_ProductType == 322){
                            Price = FormatMoney(model.Price_Sale).ToString();
                            Total_Price += model.Price_Sale*Count_Stock;
                            }else if (model.Type_id_ProductType == 323){
                            Price = model.Price_Sale.ToString();
                            }else{
                            Price = FormatMoney(model.Price).ToString();
                            Total_Price += model.Price*Count_Stock;
                            }
                            Total_Price_Cost += model.Price_Cost*Count_Stock;
                            Total_Count_Stock += Count_Stock;
                            Total_Count_Freeze += model.Count_Freeze;
                            Total_Count_Sales += model.Count_Sales;
                            Total_Count_Views += model.Count_Views;
                            %>
                            <tr>
                                <td>
                                    <label class="custom-control custom-checkbox">
                                        <input type="checkbox" id="checkbox<%=model.id %>" name="productid" value="<%=model.id %>" class="custom-control-input" ShopKeyID="true">
                                        <span class="custom-control-label"></span>
                                    </label>
                                </td>
                                <td>
                                    <a href="<%=Image(model.ImageOriginal," big") %>" data-lightbox="image<%=model.id %>"><img style="height: 30px;width: 30px;vertical-align:middle" src="<%=Image(model.ImageOriginal,50,50) %>" /></a>
                                </td>
                                <td>
                                    <%=model.Number%>
                                </td>
                                <td>
                                    <%if (model.IsCombo==1){%><span class="tag green"><span><%=Tag("组合商品")%></span></span><%} %>
                                    <a href="product_edit.aspx?id=<%=model.id%>" target="_blank"><%=Lang(model.Name)%></a>&nbsp;
                                    <%if (model.Supplier_id > 0){ %><a href="?Supplier_id=<%=model.Supplier_id %>" title="<%=Tag(" 商家")%>：<%=Shop.Bussiness.EX_Supplier.GetSupplier(model.Supplier_id).Company%>"><i class="ti-user"></i></a>&nbsp;<%} %>
                                    <a target="_blank" href="<%=Shop.Bussiness.ThemeUrl.GetURL(" P_Product",model.id.ToString(),"",CurrentLanguage.Code)%>"><i class="ti-new-window"></i></a>
                                </td>
                                <td>
                                    <a href="subproduct_edit.aspx?id=<%=model.id %>"><%=CountSon(model.id)%></a>
                                </td>
                                <td>
                                    <%=Price%>
                                </td>
                                <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
                                <td>
                                    <%=FormatMoney(model.Price_Cost)%>
                                </td>
                                <%} %>
                                <td>
                                    <%//=model.Count_Stock%>
                                    <%=Count_Stock%>
                                </td>
                                <td>
                                    <a href="javascript:void(0)" onclick="Product_Freeze('<%=model.id %>');"><%=model.Count_Freeze%></a>
                                </td>
                                <td>
                                    <a href="javascript:void(0)" onclick="Product_Sales('<%=model.Number %>');"><%=model.Count_Sales %></a>
                                </td>
                                <td>
                                    <%=model.Count_Views%>
                                </td>
                                <td href="javascript:void(0);" onclick="Product_Status(<%=model.id %>);">
                                    <span id="ProductStatus<%=model.id %>">
                                        <%=Shop.Bussiness.EX_Type.TypeName(model.Type_id_ProductStatus,CurrentLanguage.Code) %>
                                    </span><input type="hidden" id="Type_id_ProductStatus<%=model.id %>" value="<%=model.Type_id_ProductStatus %>" />
                                </td>
                                <%if (Type_id_ProductType == 321){ %>
                                <td>
                                    <%if (model.Time_Expired < DateTime.Now)
                                    { %><span class="red"><%=Tag("已结束")%></span><%}
                                    else
                                    { %><%=model.Time_Expired%><%} %>
                                </td>
                                <%} %>
                                <td>
                                    <a href="product_edit.aspx?id=<%=model.id%>" target="_blank"><%=Tag("编辑")%></a> | <a href="product_edit.aspx?id=<%=model.id%>&t=copy" target="_blank"><%=Tag("复制")%></a> |
                                    <a href="product_price.aspx?id=<%=model.id%>" target="_blank"><%=Tag("会员价格")%></a>
                                    <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_productlimit")){%> | <a href="javascript:void(0)" onclick="ProductLimit(<%=model.id %>,'<%=Lang(model.Name)%>');"><%=Tag("商品权限")%></a><%} %>
                                </td>
                            </tr>
                            <%} %>
                            <tr>
                                <td colspan="5" style="text-align:right;font-weight:bold"><%=Tag("合计")%></td>
                                <td style="font-weight:bold"><%=FormatMoney(Total_Price)%></td>
                                <td style="font-weight:bold"><%=FormatMoney(Total_Price_Cost)%></td>
                                <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
                                <td style="font-weight:bold"><%=Total_Count_Stock%></td>
                                <%} %>
                                <td style="font-weight:bold"><%=Total_Count_Freeze%></td>
                                <td style="font-weight:bold"><%=Total_Count_Sales%></td>
                                <td style="font-weight:bold"><%=Total_Count_Views%></td>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div class="col-12">
                        <nav aria-label="Page navigation">
                            <%=PageString%>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

						<%}else{%>
						<%=PageReturnMsg%>
						<%}%>
                </div>
            </div>
            <footer class="footer" id="lebicopy">
                <asp:Label ID="LBLicense" runat="server"></asp:Label>
            </footer>
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

    <script src="<%=site.AdminAssetsPath %>/plugins/jquery/jquery.min.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/popper/popper.min.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=site.AdminJsPath %>/jquery.slimscroll.js"></script>
    <script src="<%=site.AdminJsPath %>/sidebarmenu.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/sticky-kit-master/dist/sticky-kit.min.js"></script>
	<script src="<%=site.AdminJsPath %>/validation.js"></script>
    <script src="<%=site.AdminJsPath %>/custom.min.js"></script>
    <script src="<%=site.AdminJsPath %>/Cookies.js"></script>
    <script src="<%=site.AdminJsPath %>/main.js"></script>
    <script src="<%=site.AdminJsPath %>/messagebox.js"></script>
	<script>
		$(function(){
			$(".modal-dialog").draggable();
		})
		function Copyright() {
			$("#EditModal").modal("show");
			$.ajax({
				url: "<%=site.AdminPath %>/Config/Copyright_window.aspx",
				type: "GET",
				cache: false,
				data: {},
			}).done(function(result){
				$("#EditModal .modal-content").html(result);
			});
		}
		function AdminPWD(id) {
			$("#EditModal").modal("show");
			$.ajax({
				url: "<%=site.AdminPath %>/admin/admin_pwd_edit_window.aspx",
				type: "GET",
				cache: false,
				data: {id: id},
			}).done(function(result){
				$("#EditModal .modal-content").html(result);
			});
		}
		function quit() {
			$("#Modal-Confirm").modal("show");
			$("#Confirm-Content").html("<%=Tag("您确定要退出吗？")%>");
			$("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "quit_obj();");
		}
		function quit_obj() {
			$("#Modal-Confirm").modal("hide");
			location.href='<%=site.AdminPath %>/Logout.aspx';
		}
		function UpdateCache(type) {
			var postData = ""; 
			if (type == 0){
				postData = {'datatype':'languagetag,producttype,config,themepage'};
			}else{
				postData = {'datatype':'dbbody,lebitype,lebimenu,lebipage'};
			}
			var url = "<%=site.AdminPath %>/ajax/ajax_db.aspx?__Action=CacheReset";
			RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
		}
		function updateadmin(){
			var url="<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=UpdateAdmin";
			RequestAjax(url,"",function(res){RequestAjax("<%=site.AdminPath %>/ajax/ajax_db.aspx?__Action=CacheReset","{'datatype':'dbbody'}",function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});});
		}
	</script>
	
    <script src="<%=site.AdminAssetsPath %>/plugins/moment/moment.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/multiselect/js/jquery.multiselect2side.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/lightbox/lightbox.min.js"></script>
    <script type="text/javascript">
        function search_(scurl) {
            var key = $("#key").val();
            window.location = "?key=" + escape(key) + "&OrderBy=<%=OrderBy%>&" + scurl;
        }
        function OrderBy(url) {
            url += '&key=' + escape('<%=key%>') + '&<%=sp.URL%>';
            MsgBox(4, "<%=Tag("正在排序，请稍后")%> ……", url);
        }
        function Product_Status(id) {
            var Type_id_ProductStatus = $("#Type_id_ProductStatus" + id).val();
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Status&id=" + id + "&Status=" + Type_id_ProductStatus;
            RequestAjax(url, "", function () { if (Type_id_ProductStatus == 101) { $("#ProductStatus" + id).html("<%=Tag("下架")%>"); $("#Type_id_ProductStatus" + id).val(100); } else if (Type_id_ProductStatus == 100) { $("#ProductStatus" + id).html("<%=Tag("上架")%>"); $("#Type_id_ProductStatus" + id).val(101); }; MsgBox(1, "<%=Tag("操作成功")%>", "") });
        }
        function DeleteConfirm() {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "Product_Del();");
        }
        function Product_Del() {
            $("#Modal-Confirm").modal("hide");
            var postData = GetFormJsonData("ShopKeyID");
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Del&father=1";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function Product_Status_Edit_muti(status) {
            var postData = GetFormJsonData("ShopKeyID");
            var action = $("#action").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Status_Edit_muti&father=1&status=" + status;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function Product_Sales(number) {
            $("#EditModal .modal-dialog").attr("class", "modal-dialog modal-lg");
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_sales_window.aspx",
                type: "GET",
                cache: false,
                data: { number: number },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Product_MoveCategory() {
            var ids = GetChkCheckedValues("productid");
            if (ids == "") {
                MsgBox(2, "<%=Tag("请选择要修改的商品")%>", "");
                return;
            }
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_category_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { ids: ids },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Product_MoveBrand() {
            var ids = GetChkCheckedValues("productid");
            if (ids == "") {
                MsgBox(2, "<%=Tag("请选择要修改的商品")%>", "");
                return;
            }
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_brand_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { ids: ids },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Product_MoveTag() {
            var ids = GetChkCheckedValues("productid");
            if (ids == "") {
                MsgBox(2, "<%=Tag("请选择要修改的商品")%>", "");
                return;
            }
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_tag_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { ids: ids },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Product_Freeze(id) {
            $("#EditModal .modal-dialog").attr("class", "modal-dialog modal-lg");
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_freeze_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function SearchWindow() {
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_search_window.aspx?callback=search_&<%=sp.URL %>",
                type: "GET",
                cache: false,
                data: {},
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Product_Site() {
            var ids = GetChkCheckedValues("productid");
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_site_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { ids: ids },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        //function Product_Property() {
        //    var ids = GetChkCheckedValues("productid");
        //    if (ids == ""){
        //        MsgBox(2, "<%=Tag("请选择要修改的商品")%>", "");
        //        return;
        //    }
        //    $("#EditModal .modal-dialog").attr("class", "modal-dialog modal-lg");
        //    $("#EditModal").modal("show");
        //    $.ajax({
        //        url: "product_property_edit_window.aspx",
        //        type: "GET",
        //        cache: false,
        //        data: { ids: ids },
        //    }).done(function (result) {
        //        $("#EditModal .modal-content").html(result);
        //    });
        //}
        //function Product_Property132() {
        //    var ids = GetChkCheckedValues("productid");
        //    if (ids == ""){
        //        MsgBox(2, "<%=Tag("请选择要修改的商品")%>", "");
        //        return;
        //    }
        //    var title_ = "<%=Tag("商品属性")%>";
        //    $("#EditModal .modal-dialog").attr("class", "modal-dialog modal-lg");
        //    $("#EditModal").modal("show");
        //    $.ajax({
        //        url: "product_property132_edit_window.aspx",
        //        type: "GET",
        //        cache: false,
        //        data: { ids: ids, title: title_ },
        //    }).done(function (result) {
        //        $("#EditModal .modal-content").html(result);
        //    });
        //}
        function ProductLimit(id, name) {
            window.open("<%=site.AdminPath %>/product/productlimit_user.aspx?proid=" + id);
            return;
            var title_ = "<%=Tag("商品权限")%>-" + name;
            var url_ = "<%=site.AdminPath %>/user/productlimit_window.aspx?productid=" + id;
            var width_ = 900;
            var height_ = 750;
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_, 'selectproduct');
        }
    </script>

</body>
</html>