<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Default" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("订单管理")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link href="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.css" rel="stylesheet">

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("订单管理")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/order/default.aspx?t=<%=t %>"><%=Shop.Bussiness.EX_Type.TypeName(t) %></a></li>
        <li class="breadcrumb-item active"><%=Tag("订单管理")%> <%=su.Description%></li>
    </ol>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <div class="col-12">
        <div class="card">
            <div class="col-md-12">
                <ul class="nav nav-tabs customtab m-t-15" role="tablist">
                    <li class="nav-item">
                        <a <%if (type==""){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl();" role="tab"><%=Tag("全部订单")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="1"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(1);" role="tab"><%=Tag("未确认")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="2"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(2);" role="tab"><%=Tag("已确认")%></a>
                    </li>
                    <%if (t == 211){%>
                    <li class="nav-item">
                        <a <%if (type=="3"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(3);" role="tab"><%=Tag("未支付")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="4"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(4);" role="tab"><%=Tag("已支付")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="5"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(5);" role="tab"><%=Tag("未发货")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="6"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(6);" role="tab"><%=Tag("已发货")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="7"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(7);" role="tab"><%=Tag("部分发货")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="8"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(8);" role="tab"><%=Tag("未收货")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="9"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(9);" role="tab"><%=Tag("已收货")%></a>
                    </li>
                    <%} %>
                    <li class="nav-item">
                        <a <%if (type=="10"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(10);" role="tab"><%=Tag("已完成")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="11"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(11);" role="tab"><%=Tag("无效订单")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="12"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(12);" role="tab"><%=Tag("申请取消")%></a>
                    </li>
                    <li class="nav-item">
                        <a <%if (type=="13"){Response.Write("class=\"nav-link active\"");}else{Response.Write("class=\"nav-link\"");} %> href="javascript:void(0)" onclick="taburl(13);" role="tab"><%=Tag("已取消")%></a>
                    </li>
                </ul>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-9 m-b-10">
                        <%if (PageReturnMsg == ""){%>
                        <%if(t==211){%>
                        <button class="btn btn-info" onclick="AddOrder()"><i class="ti-plus"></i> <%=Tag("添加订单")%></button>
                        <%}%>
                        <button class="btn btn-danger" onclick="DeleteConfirm()"><i class="ti-trash"></i> <%=Tag("删除")%></button>
                        <button class="btn btn-default" onclick="Express_Log_Add()"><i class="ti-truck"></i> <%=Tag("添加至快递单")%></button>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <%=Tag("打印")%>
                            </button>
                            <div class="dropdown-menu">
                                <%
                                List<DB.LebiShop.Lebi_AdminSkin>
                                    skins = DB.LebiShop.B_Lebi_AdminSkin.GetList("Type_id_AdminSkinType = 361", "Sort desc");
                                    foreach (DB.LebiShop.Lebi_AdminSkin skin in skins)
                                    {
                                    %>
                                    <a href="javascript:void(0);" onclick="AdminSkin('<%=skin.Code%>');" class="dropdown-item"><%=skin.Name%></a>
                                    <%} %>
                            </div>
                        </div>
                        <%
                        if (Shop.LebiAPI.Service.Instanse.Check("plugin_ordercsv")){
                        Response.Write("<button class=\"btn btn-default\" onclick=\"Export();\"><i class=\"ti-export\"></i> "+ Tag("导出") +"</button>");
                        }
                        %>
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
                <div class="table-responsive">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr>
                                <th style="width: 40px" class="selectAll">
                                    <a href="javascript:void(0);" onclick="$('input[name=\'id\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));">
                                        <%=Tag("全选")%>
                                    </a>
                                </th>
                                <th>
                                    <%=Tag("操作")%>
                                </th>
                                <th>
                                    <%=Tag("订单编号")%>
                                </th>
                                <th>
                                    <%=Tag("会员")%>
                                </th>
                                <th>
                                    <%=Tag("购买人")%>
                                </th>
                                <th>
                                    <%=Tag("金额")%>
                                </th>
                                <th>
                                    <%=Tag("运费")%>
                                </th>
                                <th>
                                    <%=Tag("订单状态")%>
                                </th>
                                <th>
                                    <%=Tag("支付方式")%>
                                </th>
                                <th>
                                    <%=Tag("配送方式")%>
                                </th>
                                <th>
                                    <%=Tag("订购日期")%>
                                </th>
                                <%if (domain3admin)
                                { %>
                                <th>
                                    <%=Tag("站点") %>
                                </th>
                                <%} %>
                            </tr>
                        </thead>
                        <tbody>
                            <%string Mark = "";foreach (DB.LebiShop.Lebi_Order model in models){
                            if (model.Mark !=0){
                            switch (model.Mark){
                            case 1:Mark="text-danger";break;
                            case 2:Mark="text-primary";break;
                            case 3:Mark="text-success";break;
                            case 4:Mark="text-warning";break;
                            case 5:Mark="text-purple";break;
                            }
                            }else{
                            Mark="text-dark";
                            }
                            %>
                            <tr ondblclick="Edit(<%=model.id %>,<%=model.Type_id_OrderType %>);">
                                <td>
                                    <label class="custom-control custom-checkbox">
                                        <input type="checkbox" id="checkbox<%=model.id %>" name="id" value="<%=model.id %>" class="custom-control-input" del="true">
                                        <span class="custom-control-label"></span>
                                    </label>
                                </td>
                                <td onmouseover="GetOrderMemo('<%=model.id %>');">
                                    <a target="_blank" href="order_view.aspx?id=<%=model.id %>"><i class="ti-new-window"></i></a>
                                    <a id="OrderMemo<%=model.id %>"><i class="ti-flag <%=Mark%>"></i></a>
                                </td>
                                <td>
                                    <a target="_blank" href="order_view.aspx?id=<%=model.id %>"><%=model.Code %></a>
                                    <%if (model.Supplier_id > 0){ %>
                                    <a href="?t=<%=t %>&Supplier_id=<%=model.Supplier_id %>">
                                        <i class="ti-user" title="<%=Tag(" 商家")%>：<%=Shop.Bussiness.EX_Supplier.GetSupplier(model.Supplier_id).Company%>"></i>
                                    </a>
                                    <%} %>
                                </td>
                                <td>
                                    <%=model.User_UserName %>
                                </td>
                                <td>
                                    <%=model.T_Name %>
                                </td>
                                <td>
                                    <%=FormatMoney(model.Money_Order) %>
                                </td>
                                <td>
                                    <%=FormatMoney(model.Money_Transport) %>
                                </td>
                                <td>
                                    <%=Shop.Bussiness.Order.OrderStatus(model, CurrentLanguage.Code, 1) %>
                                </td>
                                <td>
                                    <%=Shop.Bussiness.Language.Content(model.Pay, CurrentLanguage.Code)%>
                                </td>
                                <td>
                                    <%=model.Transport_Name%>
                                </td>
                                <td>
                                    <%=FormatTime(model.Time_Add) %>
                                </td>
                                <%if (domain3admin){ %>
                                <td><%=SiteName(model.Site_id) %></td>
                                <%} %>
                            </tr>
                            <%if (model.DT_id>0){%>
                            <tr>
                                <td colspan="14">
                                    <%=Tag("分销商")%>：
                                    <%
                                    DB.LebiShop.Lebi_DT dt = DB.LebiShop.B_Lebi_DT.GetModel(model.DT_id);
                                    if (dt !=null){
                                        Response.Write(dt.UserName);
                                    }
                                    %>
                                    &nbsp;&nbsp;<%=Tag("佣金")%>：<%=FormatMoney(model.DT_Money) %>
                                </td>
                            </tr>
                            <%} %>
                            <%} %>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div class="col-12">
                        <nav aria-label="Page navigation ">
                            <%=PageString%>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="SearchModal" tabindex="-1" role="dialog" aria-labelledby="SearchModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><%=Tag("高级搜索")%></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <div class="input-group">
                                <input type="text" name="daterange" id="daterange" class="form-control">
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <span class="ti-calendar"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="text" id="key" name="key" class="form-control" value="<%=key %>" onkeydown="if(event.keyCode==13){modal_search_();}">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
                    <button type="button" class="btn btn-success" onclick="modal_search_();"><i class="ti-search"></i> <%=Tag("搜索")%></button>
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
<script>
    $('#daterange').daterangepicker({
        startDate: '<%if (dateFrom !=""){%><%=dateFrom%><%}else{%><%=FormatDate(System.DateTime.Now)%><%}%>',
        endDate: '<%if (dateTo !=""){%><%=dateTo%><%}else{%><%=FormatDate(System.DateTime.Now)%><%}%>',
        autoUpdateInput: true,
        ranges: {
            '<%=Tag("今日")%>': [moment(), moment()],
            '<%=Tag("昨日")%>': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '<%=Tag("最近7日")%>': [moment().subtract(6, 'days'), moment()],
            '<%=Tag("最近30日")%>': [moment().subtract(29, 'days'), moment()],
            '<%=Tag("本月")%>': [moment().startOf('month'), moment().endOf('month')],
            '<%=Tag("上个月")%>': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        locale: {
            format: 'YYYY-MM-DD',
            applyLabel: '<%=Tag("确定")%>',
            cancelLabel: '<%=Tag("取消")%>',
            startLabel: '<%=Tag("开始日期")%>',
            endLabel: '<%=Tag("结束日期")%>',
            customRangeLabel: '<%=Tag("自定义")%>',
            firstDay: 1
        }
    });
</script>

    <script>
        function taburl(type) {
            if (type == undefined)
                type = "";
            window.location = "?t=<%=t%>&user_id=<%=user_id %>&Supplier_id=<%=Supplier_id %>&dateFrom=<%=dateFrom %>&dateTo=<%=dateTo %>&key=<%=HttpUtility.UrlEncode(key) %>&type=" + type;
        }
        $(document).ready(function () {
            var li = $(".datalist .menu");
            $(li).each(function (i) {
                var _this = this;
                $(_this).find(".showmenu").mouseover(function () {
                    $(".datalist .menu .submenu").hide();
                    var divindex = $(".datalist .menu").find(".submenu")[i];
                    $(divindex).show();
                    $(divindex).mouseleave(function () {
                        $(divindex).hide();
                    });
                });
            });
        });
        function search_(scurl) {
            var key = $("#key").val();
            if (scurl == undefined || scurl == '')
                scurl = '<%=su.URL %>';
            window.location = "?t=<%=t%>&type=<%=type%>&key=" + escape(key) + "&" + scurl;
        }
        function Edit(id, t) {
            if (t == 211)
                window.open("order_view.aspx?id=" + id);
            else
                window.open("torder_view.aspx?id=" + id);
        }
        function DeleteConfirm() {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "DeleteObj();");
        }
        function DeleteObj() {
            $("#Modal-Confirm").modal("hide");
            var ids = GetChkCheckedValues("id");
            var postData = { "ids": ids };
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_Del";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function GetOrderMemo(id) {
            $.ajax({
                type: "POST",
                url: AdminPath + "/ajax/ajax_order.aspx?__Action=Order_Memo&random=" + Math.random(),
                data: { "id": id },
                success: function (res) {
                    $("#OrderMemo" + id).attr("title",res);
                }
            });
        }
        function AddOrder() {
            $("#EditModal").modal("show");
            $.ajax({
                url: "<%=site.AdminPath %>/order/order_add_window.aspx",
                type: "GET",
                cache: false,
                data: {},
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Express_Log_Add() {
            var ids = GetChkCheckedValues("id");
            var postData = { "ids": ids };
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Express_Log_Add";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "Express_Log.aspx") });
        }
        function AdminSkin(code) {
            var ids = GetChkCheckedValues("id");
            if (ids == "") {
                MsgBox(2, "<%=Tag("请先选择")%>", "");
                return;
            }
            window.open("<%=site.AdminPath %>/custom/" + code + ".aspx?id=" + ids);
        }
        <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_ordercsv")) {  %>
        function Export() {
            var ids = GetChkCheckedValues("id");
            if (ids == "") {
                MsgBox(2, "<%=Tag("请先选择")%>", "");
                return;
            }
            var title_ = "<%=Tag("批量导出")%>";
            $("#EditModal").modal("show");
            $.ajax({
                url: "<%=site.AdminPath %>/plugin/Lebi.OrderCsv/export_window.aspx",
                type: "GET",
                cache: false,
                data: { ids: ids},
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        <%} %>
        function SearchWindow() {
            $("#EditModal").modal("show");
            $.ajax({
                url: "order_search_window.aspx?callback=search_&<%=su.URL %>",
                type: "GET",
                cache: false,
                data: {},
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
    </script>

</body>
</html>