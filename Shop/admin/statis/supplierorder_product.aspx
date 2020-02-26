<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.statis.supplierorder_product" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("订单报表")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
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
                        
    <div class="tools">
    <ul>
    <li class="name"><span id="navIgation"><%=Tag("当前位置")%>：<a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a>
     > <a href="<%=site.AdminPath %>/statis/supplierorder.aspx"><%=Tag("订单报表")%></a>
     > <%=Tag("按供应商")%>
     </span></li>
    </ul>
    </div>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <div class="proBox clear">
    <ul class="btns clear">
        <li class="submit" onclick="submit();"><%=Tag("提交")%></li>
        <li class="add" onclick="exportorder();"><%=Tag("导出")%></li>
    </ul>
    <div class="iTabHead">
        <table class="table">
        <tr>
            <th>
                <%=Tag("关键词")%>：
            </th>
            <td>
                <input type="text" id="key" name="key" class="input-query" value="<%=key %>" />
            </td>
        </tr>
         <tr>
            <th>
                <%=Tag("单号")%>：
            </th>
            <td>
                <input type="text" id="orderkey" name="orderkey" class="input-query" value="<%=orderkey %>" />
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("订购日期")%>：
            </th>
            <td>
                <input type="text" name="dateFrom" id="dateFrom" size="12" class="input-calendar" value="<%=dateFrom%>" readonly /> - <input type="text" name="dateTo" id="dateTo" size="12" class="input-calendar" value="<%=dateTo%>" readonly />
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("支付状态")%>：
            </th>
            <td>
                <select name="IsPay" id="IsPay">
                    <option value="-1">┌<%=Tag("全部")%></option>
                    <option value="0" <%=IsPay == 0?"selected":"" %>><%=Tag("未支付")%></option>
                    <option value="1" <%=IsPay == 1?"selected":"" %>><%=Tag("已支付")%></option>
                </select>
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("支付方式")%>：
            </th>
            <td>
                <select name="Pay_id" id="Pay_id">
                    <option value="0">┌<%=Tag("全部")%></option>
                    <%foreach (DB.LebiShop.Lebi_Pay pay in pays){%>
                    <option value="<%=pay.id %>" <%=Pay_id == pay.id?"selected":"" %>><%=Shop.Bussiness.Language.Content(pay.Name, CurrentLanguage.Code)%></option>
                    <%} %>
                </select>
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("配送方式")%>：
            </th>
            <td>
                <select name="Transport_id" id="Transport_id">
                    <option value="0">┌<%=Tag("全部")%></option>
                    <%foreach (DB.LebiShop.Lebi_Transport transport in transports)
                      {%>
                    <option value="<%=transport.id %>" <%=Transport_id == transport.id?"selected":"" %>><%=transport.Name%></option>
                    <%} %>
                </select>
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("供应商")%>：
            </th>
            <td>
                <select name="supplier_id" id="supplier_id">
                    <option value="">┌<%=Tag("全部")%></option>
                    <option value="0">┌<%=Tag("商城")%></option>
                    <%foreach (DB.LebiShop.Lebi_Supplier sup in suppliers){%>
                    <option value="<%=sup.id %>" <%=supplier_id == sup.id.ToString()?"selected":"" %>><%=sup.SubName%></option>
                    <%} %>
                </select>
            </td>
        </tr>
    </table>
    </div>
    </div>
        <table class="datalist">
            <tr class="title">
                <th><%=Tag("序号")%></th>
                <th><%=Tag("供应商")%></th>
                <th><%=Tag("配送点")%></th>
                <th><%=Tag("单号")%></th>
                <th><%=Tag("订购日期")%></th>
                <th><%=Tag("支付状态")%></th>
                <th><%=Tag("支付方式")%></th>
                <th><%=Tag("配送方式")%></th>
                <th><%=Tag("商品名称")%></th>
                <th><%=Tag("条形码")%></th>
                <th><%=Tag("商品条码")%></th>
                <th><%=Tag("单位")%></th>
                <th><%=Tag("数量")%></th>
                <th><%=Tag("金额")%></th>
            </tr>
            <%
            int i=0;
            foreach(DB.LebiShop.Lebi_Order_Product pro in pros){
            DB.LebiShop.Lebi_Order order =Shop.Bussiness.Order.GetOrder(pro.Order_id);
            i++; %>
            <tr class="list">
                <td><%=i%></td>
                <td><%=GetSupplier(order.Supplier_id).SubName%></td>
                <td><%=GetDelivery(order.Supplier_Delivery_id).Name%></td>
                <td><%=order.Code%></td>
                <td><%=order.Time_Add%></td>
                <td><%=order.IsPaid==1?Tag("已支付"):Tag("未支付")%></td>
                <td><%=Lang(order.Pay)%>
                    <%=Lang(order.OnlinePay)%>
                </td>
                <td><%=order.Transport_Name%></td>
                <td>
                <%=Lang(pro.Product_Name) %> 
                </td>
                <td>
                <%=pro.Product_Number %>
                </td>
                <td>
                <%=Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).Code %>
                </td>
                <td>
                <%=Lang(Shop.Bussiness.EX_Product.ProductUnit(Shop.Bussiness.EX_Product.GetProduct(pro.Product_id).Units_id))%>
                </td>
                <td>
                <%=pro.Count %>
                </td>
                <td><%=FormatMoney(pro.Price * pro.Count)%></td>
            </tr>
            <%} %>
        </table> 

    <script type="text/javascript">
        function submit() {
            var key = $("#key").val();
            var orderkey = $("#orderkey").val();
            var dateFrom = $("#dateFrom").val();
            var dateTo = $("#dateTo").val();
            var IsPay = $("#IsPay").val();
            var Pay_id = $("#Pay_id").val();
            var Transport_id = $("#Transport_id").val();
            var supplier_id = $("#supplier_id").val();
            if (dateFrom == "" || dateTo == "") {
                MsgBox(1, "<%=Tag("请选择订购日期")%>", "")
            }
            window.location = "?key=" + escape(key) + "&orderkey=" + escape(orderkey) + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&IsPay=" + IsPay + "&Pay_id=" + Pay_id + "&Transport_id=" + Transport_id + "&supplier_id=" + supplier_id;
        }
        function exportorder()
        {
            window.location="../ajax/export.aspx?__Action=SupplierOrder_product_Export&where=<%=where %>";
        }
    </script>

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
	
</body>
</html>