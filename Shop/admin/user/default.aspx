<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.user.Default" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("会员管理")%>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("会员管理")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item active"><%=Tag("会员管理")%> <%=su.Description%></li>
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
                        <button class="btn btn-info" onclick="Edit(0)"><i class="ti-plus"></i> <%=Tag("添加")%></button>
                        <button class="btn btn-danger" onclick="DeleteConfirm()"><i class="ti-trash"></i> <%=Tag("删除")%></button>
                        <button class="btn btn-default" onclick="WriteSMS('')"><i class="ti-mobile"></i> <%=Tag("手机短信")%></button>
                        <button class="btn btn-default" onclick="EditMoney('')"><i class="ti-money"></i> <%=Tag("调资金")%></button>
                        <button class="btn btn-default" onclick="EditPoint('')"><i class="ti-id-badge"></i> <%=Tag("调积分")%></button>
                        <button class="btn btn-default" onclick="SendCard(311,'<%=Tag("购物卡")%>','')"><i class="ti-credit-card"></i> <%=Tag("购物卡")%></button>
                        <button class="btn btn-default" onclick="SendCard(312,'<%=Tag("代金券")%>','')"><i class="ti-gift"></i> <%=Tag("代金券")%></button>
                        <%
                        if (Shop.LebiAPI.Service.Instanse.Check("plugin_usercsv")){
                        %>
                        <button class="btn btn-default" onclick="Export()"><i class="ti-export"></i> <%=Tag("导出")%></button>
                        <%}%>
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
                            <tr class="no-wrap">
                                <th class="selectAll" style="width:40px">
                                    <a href="javascript:void(0);" onclick="$('input[name=\'sid\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a>
                                </th>
                                <th>
                                    <%=Tag("ID")%>
                                </th>
                                <th style="width:15%" onclick="OrderBy('<%=OrderByName(OrderBy,"UserNameDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"UserNameDesc","icon")%>"><%=Tag("会员帐号")%></div>
                                <th style="width:10%" onclick="OrderBy('<%=OrderByName(OrderBy,"RealNameDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"RealNameDesc","icon")%>"><%=Tag("姓名")%></div>
                                <th>
                                    <%=Tag("短信")%>
                                </th>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy,"UserLevelDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"UserLevelDesc","icon")%>"><%=Tag("等级")%></div>
                                </th>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy,"MoneyDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"MoneyDesc","icon")%>"><%=Tag("余额")%>(<%=DefaultCurrency.Msige%>)</div>
                                </th>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy,"PointDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"PointDesc","icon")%>"><%=Tag("积分")%></div>
                                </th>
                                <%if (domain3admin)
                                { %>
                                <th>
                                    <%=Tag("站点") %>
                                </th>
                                <%} %>
                                <th onclick="OrderBy('<%=OrderByName(OrderBy,"Time_LastDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"Time_LastDesc","icon")%>"><%=Tag("最后登陆")%></div>
                                </th>
                                <th>
                                    <%=Tag("操作")%>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%foreach (DB.LebiShop.Lebi_User model in models){%>
                            <tr ondblclick="Edit(<%=model.id %>);">
                                <td>
                                    <label class="custom-control custom-checkbox">
                                        <input type="checkbox" id="checkbox<%=model.id %>" name="sid" value="<%=model.id %>" class="custom-control-input">
                                        <span class="custom-control-label"></span>
                                    </label>
                                </td>
                                <td>
                                    <%=model.id%>
                                </td>
                                <td title="<%=Tag(" 昵称")%>
                                    ：<%=model.NickName %>">
                                    <%=model.UserName %>
                                </td>
                                <td>
                                    <%=model.RealName %>
                                </td>
                                <td>
                                    <a href="javascript:void(0);" onclick="Write('<%=model.UserName %>');"><i class="ti-email" title="<%=Tag("发信息")%>"></i></a>
                                </td>
                                <td>
                                    <%=Shop.Bussiness.EX_User.TypeName(model.UserLevel_id, CurrentLanguage.Code)%>
                                </td>

                                <td>
                                    <%=FormatMoney(model.Money) %>
                                </td>
                                <td>
                                    <%=model.Point %>
                                </td>
                                <%if (domain3admin){ %>
                                <td><%if (site.SiteCount > 1){ %><%=SiteName(model.Site_id,model.DT_id, CurrentLanguage.Code)%><%} %></td>
                                <%} %>
                                <td>
                                    <%=FormatTime(model.Time_Last) %>
                                </td>
                                <td>
                                    <div class="menu">
                                        <a href="user_edit.aspx?id=<%=model.id %>" target="_blank"><%=Tag("编辑")%></a>
                                        | <a href="javascript:void(0)" onclick="EditPassword(<%=model.id %>);"><%=Tag("改密")%></a>
                                        | <a href="login.aspx?id=<%=model.id %>" target="_blank"><%=Tag("管理")%></a>
                                    </div>
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
            if(scurl==undefined || scurl=='')
                scurl='<%=su.URL %>';
            window.location = "?key=" + escape(key) + "&OrderBy=<%=OrderBy%>&"+scurl;
        }
        function OrderBy(url) {
            MsgBox(4, "<%=Tag("正在排序，请稍后")%> ……", url+"&<%=su.URL %>");
        }
        function Edit(id) {
            window.location = "user_edit.aspx?id=" + id;
        }
        function DeleteConfirm() {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "Delete();");
        }
        function Delete() {
            $("#Modal-Confirm").modal("hide");
            var ids = GetChkCheckedValues("sid");
            var postData = { "ids": ids };
            var url = "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=User_Del";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function Write(User_Name) {
            var ids = GetChkCheckedValues("sid");
            if (User_Name !=""){
                var url_ = "message_write_window.aspx?User_Name="+User_Name+"&<%=su.URL %>";
            }else{
                var url_ = "message_write_window.aspx?ids="+ids+"&<%=su.URL %>";
            }
            $("#EditModal").modal("show");
            $.ajax({
                url: url_,
                type: "GET",
                cache: false,
                data: {},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
        function WriteSMS(User_Name) {
            var ids = GetChkCheckedValues("sid");
            if (User_Name !=""){
                var url_ = "sms_write_window.aspx?User_Name="+User_Name+"&<%=su.URL %>";
            }else{
                var url_ = "sms_write_window.aspx?ids="+ids+"&<%=su.URL %>";
            }
            $("#EditModal").modal("show");
            $.ajax({
                url: url_,
                type: "GET",
                cache: false,
                data: {},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
        function EditPassword(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "userpassword_edit_window.aspx",
                type: "GET",
                cache: false,
                data: {id:id},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
        function EditMoney(User_Name) {
            var title_ = "<%=Tag("添加资金")%>";
            var ids = GetChkCheckedValues("sid");
            if (User_Name !=""){
                var url_ = "usermoney_edit_window.aspx?User_Name="+User_Name+"&<%=su.URL %>";
            }else{
                var url_ = "usermoney_edit_window.aspx?ids="+ids+"&<%=su.URL %>";
            }
            $("#EditModal").modal("show");
            $.ajax({
                url: url_,
                type: "GET",
                cache: false,
                data: {title:title_},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
        function EditPoint(User_Name) {
            var title_ = "<%=Tag("添加积分")%>";
            var ids = GetChkCheckedValues("sid");
            if (User_Name !=""){
                var url_ = "UserPoint_Edit_window.aspx?User_Name="+User_Name+"&<%=su.URL %>";
            }else{
                var url_ = "UserPoint_Edit_window.aspx?ids="+ids+"&<%=su.URL %>";
            }
            $("#EditModal").modal("show");
            $.ajax({
                url: url_,
                type: "GET",
                cache: false,
                data: {title:title_},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
        function SendCard(id,title_,User_Name) {
            var title_ = "<%=Tag("购物卡")%>";
            if (id ==312)
                var title_ = "<%=Tag("代金券")%>";
            var ids = GetChkCheckedValues("sid");
            if (User_Name !=""){
                var url_ = "usercard_edit_window.aspx?cardtype="+id+"&User_Name="+User_Name+"&<%=su.URL %>";
            }else{
                var url_ = "usercard_edit_window.aspx?cardtype="+id+"&ids="+ids+"&<%=su.URL %>";
            }
            $("#EditModal").modal("show");
            $.ajax({
                url: url_,
                type: "GET",
                cache: false,
                data: {title:title_},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
        function SearchWindow() {
            $("#EditModal").modal("show");
            $.ajax({
                url: "user_search_window.aspx?callback=search_&<%=su.URL %>",
                type: "GET",
                cache: false,
                data: {},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
        <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_usercsv")){  %>
        function Export(){
            var ids = GetChkCheckedValues("sid");
            if (ids == ""){
                MsgBox(2, "<%=Tag("请先选择")%>", "");
                return;
            }
            var title_ = "<%=Tag("批量导出")%>";
            $("#EditModal").modal("show");
            $.ajax({
                url: "<%=site.AdminPath %>/plugin/Lebi.UserCsv/export_window.aspx",
                type: "GET",
                cache: false,
                data: { ids: ids},
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        <%} %>
    </script>

</body>
</html>