<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.Transport_Price" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("配送价格")%>-<%=tmodel.Name %>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("货柜管理")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><a href="Transport.aspx"><%=Tag("配送方式")%></a></li>
        <li class="breadcrumb-item"><a href="Transport.aspx?key=<%=System.Web.HttpUtility.HtmlEncode(tmodel.Name) %>"><%=tmodel.Name %></a></li>
        <li class="breadcrumb-item active"><%=Tag("配送价格")%></li>
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
                        <%if (PageReturnMsg == ""){%>
                        <button class="btn btn-info" onclick="Edit(<%=tmodel.id%>,0);"><i class="ti-plus"></i> <%=Tag("添加")%></button>
                        <button class="btn btn-success" onclick="Update();"><i class="ti-check"></i> <%=Tag("保存")%></button>
                        <button class="btn btn-danger" onclick="DeleteConfirm()"><i class="ti-trash"></i> <%=Tag("删除")%></button>
                        <%}%>
                        <button class="btn btn-default" data-toggle="modal" data-target="#SearchModal"><i class="ti-search"></i> <%=Tag("搜索")%></button>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr>
                                <th class="selectAll" style="width:40px">
                                    <a href="javascript:void(0);" onclick="$('input[name=\'Fid\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a>
                                </th>
                                <th>
                                    <%=Tag("定额运费")%>
                                </th>
                                <th style="width:10%">
                                    <%=Tag("订单金额")%>
                                </th>
                                <th style="width:10%">
                                    <%=Tag("基准运费")%>
                                </th>
                                <th style="width:10%">
                                    <%=Tag("起始重量")%>
                                </th>
                                <th style="width:10%">
                                    <%=Tag("递进重量")%>
                                </th>
                                <th style="width:10%">
                                    <%=Tag("递进价格")%>
                                </th>
                                <th>
                                    <%=Tag("货到付款")%>
                                </th>
                                <th>
                                    <%=Tag("配送地区")%>
                                </th>
                                <th>
                                    <%=Tag("操作")%>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%foreach (DB.LebiShop.Lebi_Transport_Price model in models){%>
                            <tr ondblclick="Edit(<%=tmodel.id+" ,"+model.id %>
                                );">
                                <td>
                                    <label class="custom-control custom-checkbox">
                                        <input type="checkbox" id="checkbox<%=model.id %>" name="Fid" value="<%=model.id %>" class="custom-control-input" del="true">
                                        <span class="custom-control-label"></span>
                                    </label>
                                    <input type="hidden" name="Uid" shop="true" value="<%=model.id %>" />
                                </td>
                                <td>
                                    <%=model.IsOnePrice == 1 ? "<span class=\"label label-success\">" + Tag("是") + "</span>" : "<span class=\"label label-danger\">" + Tag("否") + "</span>"%>
                                </td>

                                <td>
                                    <input type="text" id="OrderMoney<%=model.id %>" name="OrderMoney<%=model.id %>" value="<%=FormatMoney(model.OrderMoney, " Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                </td>
                                <td>
                                    <input type="text" id="Price<%=model.id %>" name="Price<%=model.id %>" value="<%=FormatMoney(model.Price, " Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.\-]/g,'')">
                                </td>
                                <%if (tmodel.Type_id_TransportType == 330)
                                { %>
                                <td>
                                    <input type="text" id="Weight_Start<%=model.id %>" name="Weight_Start<%=model.id %>" value="<%=model.Weight_Start %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                </td>
                                <td>
                                    <input type="text" id="Weight_Step<%=model.id %>" name="Weight_Step<%=model.id %>" value="<%=model.Weight_Step %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                </td>
                                <td>
                                    <input type="text" id="Price_Step<%=model.id %>" name="Price_Step<%=model.id %>" value="<%=FormatMoney(model.Price_Step, " Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.\-]/g,'')">
                                </td>
                                <%}else{ %>
                                <td>-</td>
                                <td>-</td>
                                <td>-</td>
                                <%} %>
                                <td>
                                    <%=model.IsCanofflinePay == 1 ? "<span class=\"label label-success\">" + Tag("支持") + "</span>" : "<span class=\"label label-danger\">" + Tag("不支持") + "</span>"%>
                                </td>
                                <td>
                                    <%=AreaName(model.Area_id)%>
                                </td>
                                <td>
                                    <a href="javascript:void(0)" onclick="Edit(<%=tmodel.id+" ,"+model.id %>);"><%=Tag("编辑")%></a>
                                </td>
                            </tr>
                            <%} %>
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
                            <label for="OnePrice"><%=Tag("定额运费")%>：</label>
                            <div class="input-group">
                                <label class="custom-control custom-radio m-r-20">
                                    <input type="radio" id="OnePrice_2" name="OnePrice" value="2" class="custom-control-input" <%=OnePrice==2?"checked":"" %>>
                                    <span class="custom-control-label"><%=Tag("全部")%></span>
                                </label>
                                <label class="custom-control custom-radio m-r-20">
                                    <input type="radio" id="OnePrice_1" name="OnePrice" value="1" class="custom-control-input" <%=OnePrice==1?"checked":"" %>>
                                    <span class="custom-control-label"><%=Tag("是")%></span>
                                </label>
                                <label class="custom-control custom-radio">
                                    <input type="radio" id="OnePrice_0" name="OnePrice" value="0" class="custom-control-input" <%=OnePrice==0?"checked":"" %>>
                                    <span class="custom-control-label"><%=Tag("否")%></span>
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="OfflinePay"><%=Tag("货到付款")%>：</label>
                            <div class="input-group">
                                <label class="custom-control custom-radio m-r-20">
                                    <input type="radio" id="OfflinePay_2" name="OfflinePay" value="2" class="custom-control-input" <%=OfflinePay==2?"checked":"" %>>
                                    <span class="custom-control-label"><%=Tag("全部")%></span>
                                </label>
                                <label class="custom-control custom-radio m-r-20">
                                    <input type="radio" id="OfflinePay_1" name="OfflinePay" value="1" class="custom-control-input" <%=OfflinePay==1?"checked":"" %>>
                                    <span class="custom-control-label"><%=Tag("支持")%></span>
                                </label>
                                <label class="custom-control custom-radio">
                                    <input type="radio" id="OfflinePay_0" name="OfflinePay" value="0" class="custom-control-input" <%=OfflinePay==0?"checked":"" %>>
                                    <span class="custom-control-label"><%=Tag("不支持")%></span>
                                </label>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
                    <button type="button" class="btn btn-success" onclick="search_();"><i class="ti-search"></i> <%=Tag("搜索")%></button>
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
	
    <script>
        function search_() {
            var OnePrice = $("input[name='OnePrice']:checked").val();
            var OfflinePay = $("input[name='OfflinePay']:checked").val();
            window.location = "?tid=<%=tmodel.id %>&OnePrice=" + OnePrice + "&OfflinePay=" + OfflinePay;
        }
        function Edit(tid,id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "transport_price_edit_window.aspx",
                type: "GET",
                cache: false,
                data: {tid: tid,id: id},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
        function Update() {
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=Transport_Price_Update&tid=<%=tmodel.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
        function DeleteConfirm() {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "DeleteObj();");
        }
        function DeleteObj() {
            $("#Modal-Confirm").modal("hide");
            var postData = GetFormJsonData("del");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=Transport_Price_Del";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

</body>
</html>