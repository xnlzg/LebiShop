<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.agent.agentmoney" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("佣金查询")%>-<%=Tag("分销")%>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("佣金查询")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><%=Tag("分销")%></li>
        <li class="breadcrumb-item active"><%=Tag("佣金查询")%></li>
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
                    <div class="col-12 m-b-10">
                        <button class="btn btn-default" data-toggle="modal" data-target="#SearchModal"><i class="ti-search"></i> <%=Tag("搜索")%></button>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr>
                                <th>
                                    <%=Tag("时间")%>
                                </th>
                                <th>
                                    <%=Tag("金额")%>
                                </th>
                                <th>
                                    <%=Tag("会员")%>
                                </th>
                                <th>
                                    <%=Tag("类型")%>
                                </th>
                                <th>
                                    <%=Tag("状态")%>
                                </th>
                                <th>
                                    <%=Tag("订单编号")%>
                                </th>
                                <th>
                                    <%=Tag("下级用户")%>
                                </th>
                                <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
                                <th>
                                    <%=Tag("商家")%>
                                </th>
                                <%} %>
                            </tr>
                        </thead>
                        <tbody>
                            <%decimal total = 0;foreach (DB.LebiShop.Lebi_Agent_Money model in models){%>
                            <tr>
                                <td>
                                    <%=FormatTime(model.Time_add)%>
                                </td>
                                <td>
                                    <%=FormatMoney(model.Money)%>
                                </td>
                                <td>
                                    <a href="?user_id=<%=model.User_id%>"><%=model.User_UserName%></a>
                                </td>
                                <td>
                                    <%=Shop.Bussiness.EX_Type.TypeName(model.Type_id_AgentMoneyType,CurrentLanguage.Code)%>
                                </td>
                                <td>
                                    <%=Shop.Bussiness.EX_Type.TypeName(model.Type_id_AgentMoneyStatus,CurrentLanguage.Code)%>
                                </td>
                                <td>
                                    <%=model.Order_Code%>
                                    <a target="_blank" href="../order/order_view.aspx?id=<%=model.Order_id %>"><i class="ti-new-window"></i></a>
                                </td>
                                <td>
                                    <a href="?user_id=<%=Shop.Bussiness.Order.GetOrder(model.Order_id).User_id%>"></a><%=Shop.Bussiness.Order.GetOrder(model.Order_id).User_UserName%>
                                </td>
                                <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
                                <td>
                                    <%if (model.Supplier_id > 0){ %>
                                    <a href="?supplier_id=<%=model.Supplier_id %>"><%=Shop.Bussiness.EX_Supplier.GetSupplier(model.Supplier_id).Company%></a><%} %>
                                </td>
                                <%} %>
                            </tr>
                            <%total+=model.Money;} %>
                        </tbody>
                        <tfoot>
                            <tr><td><%=Tag("合计")%></td><td colspan="7" style="font-weight:bold"><%=FormatMoney(total)%></td></tr>
                        </tfoot>
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
    <div class="modal fade" id="SearchModal" tabindex="-1" role="dialog" aria-labelledby="SearchModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><%=Tag("搜索")%></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <select name="type" id="type" class="form-control">
                                <option value="0"><%=Tag("类型")%></option>
                                <%=Shop.Bussiness.EX_Type.TypeOption("AgentMoneyType", status)%>
                            </select>
                        </div>
                        <div class="form-group">
                            <select name="status" id="status" class="form-control">
                                <option value="0"><%=Tag("状态")%></option>
                                <%=Shop.Bussiness.EX_Type.TypeOption("AgentMoneyStatus", status)%>
                            </select>
                        </div>
                        <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
                        <div class="form-group">
                            <select id="supplier_id" name="supplier_id" class="form-control">
                                <option value="0"><%=Tag("商家")%></option>
                                <%=Shop.Bussiness.EX_Supplier.SupplierOption(supplier_id, CurrentLanguage.Code)%>
                            </select>
                        </div>
                        <%}else{ %>
                        <input type="hidden" name="Supplier_id" value="0">
                        <%} %>
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
                            <input name="key" type="text" id="key" class="form-control" value="<%=key %>" onkeydown="if(event.keyCode==13){search_();}">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="user_id" value="<%=user_id %>" />
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
                    <button type="button" class="btn btn-success" onclick="search_();"><i class="ti-search"></i> <%=Tag("搜索")%></button>
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
        function search_(scurl) {
            $('#SearchModal').modal("hide");
            var key = $("#key").val();
            var supplier_id = $("#supplier_id").val();
            var user_id = $("#user_id").val();
            var type = $("#type").val();
            var status = $("#status").val();
            var dateFrom = "";
            var dateTo = "";
            var daterange = $("#daterange").val();
            if (daterange.indexOf(" - ") > -1) {
                dateFrom = daterange.split(" - ")[0];
                dateTo = daterange.split(" - ")[1];
            }
            window.location = "?key=" + escape(key) + "&supplier_id=" + supplier_id + "&type=" + type + "&status=" + status + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&user_id=" + user_id;
        }
    </script>

</body>
</html>