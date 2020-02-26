<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.user.UserLevel_Edit" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Shop.Bussiness.Language.Content(model.Name, CurrentLanguage.Code) %>-<%=Tag("会员分组")%>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("会员分组")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/user/default.aspx"><%=Tag("会员管理")%></a></li>
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/user/UserLevel.aspx"><%=Tag("会员分组")%></a></li>
        <li class="breadcrumb-item active"><%=Shop.Bussiness.Language.Content(model.Name, CurrentLanguage.Code) %></li>
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
                <form action="javascript:SaveObj();" novalidate>
                    <ul class="nav nav-tabs customtab" role="tablist">
                        <%
                        List<DB.LebiShop.Lebi_Language_Code> nav_langs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in nav_langs){
                        %>
                        <li class="nav-item"> <a class="nav-link <%if (nav_langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                        <%
                        }
                        %>
                    </ul>
                    <div class="tab-content m-t-20">
                        <%
                        foreach (DB.LebiShop.Lebi_Language_Code lang in nav_langs)
                        {%>
                        <div class="tab-pane <%if (nav_langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                            <div class="form-group">
                                <label for="Name<%=lang.Code %>"><%=Tag("分组名称")%>：</label>
                                <input type="text" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name,lang.Code) %>" <%if (nav_langs.FirstOrDefault().Code == lang.Code){%>required<%}%> class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="PriceName<%=lang.Code %>"><%=Tag("价格文字")%>：</label>
                                <input type="text" id="PriceName<%=lang.Code %>" name="PriceName<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.PriceName,lang.Code) %>" <%if (nav_langs.FirstOrDefault().Code == lang.Code){%>required<%}%> class="form-control" shop="true">
                            </div>
                        </div>
                        <%} %>
                    </div>
                    <h5 class="box-title m-t-20 m-b-20"><%=Tag("通用信息")%></h5>
                    <div class="form-group">
                        <label for="Grade"><%=Tag("等级ID")%>：</label>
                        <input type="text" id="Grade" name="Grade" value="<%=model.Grade %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                        <small class="form-text text-muted"><%=Tag("填0表示未登录的访客")%></small>
                    </div>
                    <div class="form-group">
                        <label for="Lpoint"><%=Tag("升级积分")%>：</label>
                        <input type="text" id="Lpoint" name="Lpoint" value="<%=model.Lpoint %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                        <small class="form-text text-muted"><%=Tag("升级会员等级所需积分")%></small>
                    </div>
                    <div class="form-group">
                        <label for="Price"><%=Tag("会员价格")%>：</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><%=Tag("销售价")%>× </span>
                            </div>
                            <input type="text" id="Price" name="Price" value="<%=model.Price %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                        </div>
                        <small class="form-text text-muted"><%=Tag("1~100的数字")%></small>
                    </div>
                    <div class="form-group">
                        <label for="ImageUrl"><%=Tag("等级图标")%>：</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="image_ImageUrl"><%if (model.ImageUrl != ""){%><img src="<%=site.WebPath + model.ImageUrl%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                            </div>
                            <input type="text" id="ImageUrl" name="ImageUrl" value="<%=model.ImageUrl %>" class="form-control" shop="true">
                            <div class="input-group-append fileupload">
                                <span class="input-group-text"><i class="ti-upload"></i></span>
                                <input type="file" id="file_ImageUrl" name="file_ImageUrl" class="upload" onchange="uploadImage('ImageUrl')">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="MoneyToPoint"><%=Tag("积分比率")%>：</label>
                        <input type="text" id="MoneyToPoint" name="MoneyToPoint" value="<%=model.MoneyToPoint %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                        <small class="form-text text-muted"><%=Tag("消费1元可获得积分")%></small>
                    </div>
                    <div class="form-group">
                        <label for="PointToMoney"><%=Tag("积分兑换规则")%>：</label>
                        <input type="text" id="PointToMoney" name="PointToMoney" value="<%=model.PointToMoney %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                        <small class="form-text text-muted">100:1,200:2,500:5,1000:10</small>
                    </div>
                    <div class="form-group">
                        <label for="RegisterType_1"><%=Tag("会员注册")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="RegisterType_1" name="RegisterType" value="1" class="custom-control-input" shop="true" <%=model.RegisterType==1?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="RegisterType_0" name="RegisterType" value="0" class="custom-control-input" shop="true" <%=model.RegisterType==0?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="RegisterType_2" name="RegisterType" value="2" class="custom-control-input" shop="true" <%=model.RegisterType==2?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("邀请")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsUsedAgent_1"><%=Tag("推广佣金")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsUsedAgent_1" name="IsUsedAgent" value="1" class="custom-control-input" shop="true" <%=model.IsUsedAgent==1?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsUsedAgent_0" name="IsUsedAgent" value="0" class="custom-control-input" shop="true" <%=model.IsUsedAgent==0?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsHidePrice_1"><%=Tag("隐藏价格")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsHidePrice_1" name="IsHidePrice" value="1" class="custom-control-input" shop="true" <%=model.IsHidePrice==1?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsHidePrice_0" name="IsHidePrice" value="0" class="custom-control-input" shop="true" <%=model.IsHidePrice==0?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="BuyRight_1"><%=Tag("购买权限")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="BuyRight_1" name="BuyRight" value="1" class="custom-control-input" shop="true" <%=model.BuyRight==1?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="BuyRight_0" name="BuyRight" value="0" class="custom-control-input" shop="true" <%=model.BuyRight==0?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Comment_1"><%=Tag("评论审核")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="Comment_1" name="Comment" value="1" class="custom-control-input" shop="true" <%=model.Comment==1?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="Comment_0" name="Comment" value="0" class="custom-control-input" shop="true" <%=model.Comment==0?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Status"><%=Tag("订单提交")%>：</label>
                        <div class="row">
                            <div class="col-sm-6">
                                <label for="OrderSubmit"><%=Tag("金额大于")%>：</label>
                                <input type="text" id="OrderSubmit" name="OrderSubmit" value="<%=model.OrderSubmit%>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                            </div>
                            <div class="col-sm-6">
                                <label for="OrderSubmitCount"><%=Tag("数量大于")%>：</label>
                                <input type="text" id="OrderSubmitCount" name="OrderSubmitCount" value="<%=model.OrderSubmitCount%>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Status"><%=Tag("登录积分")%>：</label>
                        <div class="row">
                            <div class="col-sm-6">
                                <label for="LoginPointCut"><%=Tag("增加")%>：</label>
                                <input type="text" id="LoginPointCut" name="LoginPointCut" value="<%=model.LoginPointCut%>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                            </div>
                            <div class="col-sm-6">
                                <label for="LoginPointAdd"><%=Tag("减少")%>：</label>
                                <input type="text" id="LoginPointAdd" name="LoginPointAdd" value="<%=model.LoginPointAdd%>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Remark"><%=Tag("内部备注")%>：</label>
                        <textarea id="remark" name="remark" rows="6" class="form-control" style="height:60px;" shop="true"><%=model.remark%></textarea>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('remark',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('remark',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                    <%}%>
                </form>
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
	
    <script src="<%=site.AdminJsPath %>/ajaxfileupload.js"></script>
    <script>
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function uploadImage(id) {
            $.ajaxFileUpload({
	            url: WebPath + '/ajax/imageuploadone.aspx?path=config',
	            secureuri: false,
	            fileElementId: 'file_' + id,
	            dataType: 'json',
	            success: function (data, status) {
	                if (data.msg != 'OK') {
	                    MsgBox(2, data.msg, "");
	                }
	                else {
	                    var imageUrl = data.ImageUrl;
	                    if (imageUrl.length > 0) {
	                        $("#image_" + id + "").html('<img src="' + WebPath + imageUrl + '" height="20">');
	                        $("#" + id + "").val(imageUrl);
	                    }
	                }
	            },
	            error: function (data, status, e) {
	                MsgBox(2, data.error, "");
	            }
	        })
        }
        function SaveObj() {
            var postData = GetFormJsonData("shop");
            var url= "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=UserLevel_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "userLevel.aspx");});
        }
    </script>

</body>
</html>