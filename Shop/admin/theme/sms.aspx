<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.theme.SMSTPL" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("短信模板") %>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("短信模板") %></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item active"><%=Tag("短信模板") %></li>
    </ol>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <div class="col-xlg-2 col-lg-3 col-md-3">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="card-body inbox-panel p-t-0 p-b-0">
                        <ul class="list-group list-group-full">
                            <li class="list-group-item<%if (type!="admin"){ %> active<%} %>"><a href="?type=user"><i class="ti-file"></i> <%=Tag("会员模板")%></a></li>
                            <li class="list-group-item<%if (type=="admin"){ %> active<%} %>"><a href="?type=admin"><i class="ti-file"></i> <%=Tag("管理员模板")%></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xlg-10 col-lg-9 col-md-9">
        <div class="card">
            <form action="javascript:SaveObj();" novalidate>
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <ul class="nav nav-tabs customtab m-t-15" role="tablist">
                        <%
                        List
                        <DB.LebiShop.Lebi_Language_Code>
                            tablangs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in langs){
                            %>
                            <li class="nav-item"> <a class="nav-link <%if (tablangs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                            <%
                            }
                            %>
                    </ul>
                    <div class="tab-content m-t-20">
                        <%
                        foreach (DB.LebiShop.Lebi_Language_Code lang in tablangs)
                        {%>
                        <div class="tab-pane <%if (tablangs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                            <%if (type == "user"){ %>
                            <div class="form-group">
                                <label for="SMSTPL_newuser<%=lang.Code %>"><%=Tag("新用户注册")%>：</label>
                                <textarea id="SMSTPL_newuser<%=lang.Code %>" name="SMSTPL_newuser<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_newuser, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_ordersubmit<%=lang.Code %>"><%=Tag("订单提交")%>：</label>
                                <textarea id="SMSTPL_ordersubmit<%=lang.Code %>" name="SMSTPL_ordersubmit<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_ordersubmit, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_orderpickup<%=lang.Code %>"><%=Tag("订单自提确认")%>：</label>
                                <textarea id="SMSTPL_orderpickup<%=lang.Code %>" name="SMSTPL_orderpickup<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_orderpickup, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_ordershipping<%=lang.Code %>"><%=Tag("订单发货")%>：</label>
                                <textarea id="SMSTPL_ordershipping<%=lang.Code %>" name="SMSTPL_ordershipping<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_ordershipping, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_balance<%=lang.Code %>"><%=Tag("余额提醒")%>：</label>
                                <textarea id="SMSTPL_balance<%=lang.Code %>" name="SMSTPL_balance<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_balance, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_getpwd<%=lang.Code %>"><%=Tag("找回密码")%>：</label>
                                <textarea id="SMSTPL_getpwd<%=lang.Code %>" name="SMSTPL_getpwd<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_getpwd, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_getnewpwd<%=lang.Code %>"><%=Tag("获取新密码")%>：</label>
                                <textarea id="SMSTPL_getnewpwd<%=lang.Code %>" name="SMSTPL_getnewpwd<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_getnewpwd, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_comment<%=lang.Code %>"><%=Tag("商品评论")%>：</label>
                                <textarea id="SMSTPL_comment<%=lang.Code %>" name="SMSTPL_comment<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_comment, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_ask<%=lang.Code %>"><%=Tag("商品咨询")%>：</label>
                                <textarea id="SMSTPL_ask<%=lang.Code %>" name="SMSTPL_ask<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_ask, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_message<%=lang.Code %>"><%=Tag("站内信")%>：</label>
                                <textarea id="SMSTPL_message<%=lang.Code %>" name="SMSTPL_message<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_message, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_checkcode<%=lang.Code %>"><%=Tag("手机验证码")%>：</label>
                                <textarea id="SMSTPL_checkcode<%=lang.Code %>" name="SMSTPL_checkcode<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_checkcode, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_reserveok<%=lang.Code %>"><%=Tag("预定到货提醒")%>：</label>
                                <textarea id="SMSTPL_reserveok<%=lang.Code %>" name="SMSTPL_reserveok<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_reserveok, lang.Code)%></textarea>
                            </div>
                            <%}else{ %>
                            <div class="form-group">
                                <label for="SMSTPL_Admin_newuser<%=lang.Code %>"><%=Tag("新用户注册")%>：</label>
                                <textarea id="SMSTPL_Admin_newuser<%=lang.Code %>" name="SMSTPL_Admin_newuser<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_Admin_newuser, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_Admin_ordersubmit<%=lang.Code %>"><%=Tag("订单提交")%>：</label>
                                <textarea id="SMSTPL_Admin_ordersubmit<%=lang.Code %>" name="SMSTPL_Admin_ordersubmit<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_Admin_ordersubmit, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_Admin_orderpaid<%=lang.Code %>"><%=Tag("订单付款")%>：</label>
                                <textarea id="SMSTPL_Admin_orderpaid<%=lang.Code %>" name="SMSTPL_Admin_orderpaid<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_Admin_orderpaid, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_Admin_orderrecive<%=lang.Code %>"><%=Tag("订单收货")%>：</label>
                                <textarea id="SMSTPL_Admin_orderrecive<%=lang.Code %>" name="SMSTPL_Admin_orderrecive<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_Admin_orderrecive, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_Admin_ordercomment<%=lang.Code %>"><%=Tag("订单留言")%>：</label>
                                <textarea id="SMSTPL_Admin_ordercomment<%=lang.Code %>" name="SMSTPL_Admin_ordercomment<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_Admin_ordercomment, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_Admin_inquiry<%=lang.Code %>"><%=Tag("留言反馈")%>：</label>
                                <textarea id="SMSTPL_Admin_inquiry<%=lang.Code %>" name="SMSTPL_Admin_inquiry<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_Admin_inquiry, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_Admin_comment<%=lang.Code %>"><%=Tag("商品评论")%>：</label>
                                <textarea id="SMSTPL_Admin_comment<%=lang.Code %>" name="SMSTPL_Admin_comment<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_Admin_comment, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_Admin_ask<%=lang.Code %>"><%=Tag("商品咨询")%>：</label>
                                <textarea id="SMSTPL_Admin_ask<%=lang.Code %>" name="SMSTPL_Admin_ask<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_Admin_ask, lang.Code)%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="SMSTPL_Admin_message<%=lang.Code %>"><%=Tag("站内信")%>：</label>
                                <textarea id="SMSTPL_Admin_message<%=lang.Code %>" name="SMSTPL_Admin_message<%=lang.Code %>" class="form-control" style="height: 55px;" shop="true"><%=Shop.Bussiness.Language.Content(model.SMSTPL_Admin_message, lang.Code)%></textarea>
                            </div>
                            <%}%>
                        </div>
                        <%} %>
                    </div>
                </div>
                <%if (PageReturnMsg == ""){%>
                <div class="col-md-12 col-sm-12 col-xs-12 m-b-20">
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                </div>
                <%}%>
            </form>
        </div>
        <div class="card">
            <div class="card-body">
                <h4 class="card-title"><%=Tag("标签规则")%></h4>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <%if (type == "user")
                        { %>
                        <%=Tag("用户名")%>：{$UserName}<br/>
                        <%=Tag("用户ID")%>：{$UserID}<br />
                        <%=Tag("真实姓名")%>：{$RealName}<br />
                        <%=Tag("密码")%>：{$Password}<br />
                        <%=Tag("自提点")%>：{$PickUpStation}<br />
                        <%=Tag("自提时间")%>：{$PickUpTime}<br />
                        <%} %>
                        <%=Tag("用户昵称")%>：{$NickName}<br />
                        <%=Tag("订单号码")%>：{$OrderNO}<br />
                        <%=Tag("快递公司")%>：{$ExpressCompany}<br />
                        <%=Tag("快递单号")%>：{$ExpressNumber}<br />
                        <%if (type == "admin")
                        { %>
                        <%=Tag("配送方式")%>：{$Transport}<br />
                        <%} %>
                        <%=Tag("金额")%>：{$Money}<br />
                        <%=Tag("时间")%>：{$Time}<br />
                        <%=Tag("标题")%>：{$Title}<br />
                        <%=Tag("内容")%>：{$Content}<br />
                        <%=Tag("客服电话")%>：{$Phone}<br />
                        <%=Tag("客服传真")%>：{$Fax}<br />
                        <%=Tag("客服邮箱")%>：{$Email}<br />
                        <%=Tag("客服QQ")%>：{$QQ}<br />
                        <%=Tag("域名")%>：{$Domain}<br />
                        <%=Tag("站点名称")%>：{$SiteName}<br />
                        <%=Tag("验证码")%>：{$CheckCode}
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
	
    <script>
        function SaveObj() {
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=SMSTPL_Edit&type=<%=type %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
    </script>

</body>
</html>