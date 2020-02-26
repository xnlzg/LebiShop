<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.SMSConfig" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("短信设置")%>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("短信设置")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item active"><%=Tag("短信设置")%></li>
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
                    <div class="form-group">
                        <label for="SMS_server"><%=Tag("短信平台")%>：</label>
                        <select name="SMS_server" id="SMS_server" class="form-control" shop="true" onchange="changeserver();">
                            <option value="0" <%=model.SMS_server=="0"?"selected":"" %>>时代互联</option>
                            <option value="1" <%=model.SMS_server=="1"?"selected":"" %>>yunsms.cn</option>
                            <option value="999" <%=model.SMS_server=="999"?"selected":"" %>>通用HTTP接口</option>
                        </select>
                    </div>
                    <div id="httpapi" class="form-group">
                        <label for="SMS_httpapi"><%=Tag("接口地址")%>：</label>
                        <input type="text" id="SMS_httpapi" name="SMS_httpapi" value="<%=model.SMS_httpapi %>" class="form-control" shop="true">
                        <small class="form-text text-muted">
                            {$username}：<%=Tag("短信帐号")%> {$password}：<%=Tag("短信帐号")%> {$phonenumber}：<%=Tag("手机号码")%> {$content}：<%=Tag("内容")%>
                            <br /><%=Tag("示例")%>：http://sms.xxx.com/send/?user={$username}&pwd={$password}&phone={$phonenumber}&content={$content}
                        </small>
                    </div>
                    <div class="form-group">
                        <label for="SMS_user"><%=Tag("短信帐号")%>：</label>
                        <input type="text" id="SMS_user" name="SMS_user" value="<%=model.SMS_user %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="SMS_password"><%=Tag("短信密码")%>：</label>
                        <input type="password" id="SMS_password" name="SMS_password" value="<%=SMS_password %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="SMS_lastmsg"><%=Tag("短信后缀")%>：</label>
                        <input type="text" id="SMS_lastmsg" name="SMS_lastmsg" value="<%=model.SMS_lastmsg %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="SMS_state_1"><%=Tag("状态")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="SMS_state_1" name="SMS_state" value="1" class="custom-control-input" shop="true" <%=model.SMS_state=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="SMS_state_0" name="SMS_state" value="0" class="custom-control-input" shop="true" <%=model.SMS_state=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="SMSTPL_newuser"><%=Tag("发给会员")%>：</label>
                        <div class="input-group">
                            <%string ms = model.SMS_sendmode;
                            if (ms == null)
                            ms = "";
                            %>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_newuser" name="SMS_sendmode" value="SMSTPL_newuser" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_newuser")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("新用户注册")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_ordersubmit" name="SMS_sendmode" value="SMSTPL_ordersubmit" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_ordersubmit")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("订单提交")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_ordershipping" name="SMS_sendmode" value="SMSTPL_ordershipping" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_ordershipping")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("订单发货")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_orderpickup" name="SMS_sendmode" value="SMSTPL_orderpickup" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_orderpickup")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("订单自提确认")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_balance" name="SMS_sendmode" value="SMSTPL_balance" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_balance")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("余额提醒")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_getpwd" name="SMS_sendmode" value="SMSTPL_getpwd" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_getpwd")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("找回密码")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_getnewpwd" name="SMS_sendmode" value="SMSTPL_getnewpwd" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_getnewpwd")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("获取新密码")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_comment" name="SMS_sendmode" value="SMSTPL_comment" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_comment")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("商品评论")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_ask" name="SMS_sendmode" value="SMSTPL_ask" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_ask")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("商品咨询")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_message" name="SMS_sendmode" value="SMSTPL_message" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_message")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("站内信")%></span>
                            </label>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="SMSTPL_reserveok" name="SMS_sendmode" value="SMSTPL_reserveok" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_reserveok")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("预定到货提醒")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="SMSTPL_Admin_newuser"><%=Tag("发给管理员")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_Admin_newuser" name="SMS_sendmode" value="SMSTPL_Admin_newuser" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_Admin_newuser")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("新用户注册")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_Admin_ordersubmit" name="SMS_sendmode" value="SMSTPL_Admin_ordersubmit" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_Admin_ordersubmit")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("订单提交")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_Admin_orderpaid" name="SMS_sendmode" value="SMSTPL_Admin_orderpaid" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_Admin_orderpaid")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("订单付款")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_Admin_orderrecive" name="SMS_sendmode" value="SMSTPL_Admin_orderrecive" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_Admin_orderrecive")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("订单收货")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_Admin_ordercomment" name="SMS_sendmode" value="SMSTPL_Admin_ordercomment" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_Admin_ordercomment")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("订单留言")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_Admin_inquiry" name="SMS_sendmode" value="SMSTPL_Admin_inquiry" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_Admin_inquiry")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("留言反馈")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_Admin_comment" name="SMS_sendmode" value="SMSTPL_Admin_comment" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_Admin_comment")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("商品评论")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_Admin_ask" name="SMS_sendmode" value="SMSTPL_Admin_ask" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_Admin_ask")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("商品咨询")%></span>
                            </label>
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="SMSTPL_Admin_message" name="SMS_sendmode" value="SMSTPL_Admin_message" class="custom-control-input" shop="true" <%=ms.Contains("SMSTPL_Admin_message")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("站内信")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="SMS_reciveno"><%=Tag("手机号码")%>：</label>
                        <input type="text" id="SMS_reciveno" name="SMS_reciveno" value="<%=model.SMS_reciveno %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="SMS_maxlen"><%=Tag("最大字数")%>：</label>
                        <input type="text" id="SMS_maxlen" name="SMS_maxlen" value="<%=model.SMS_maxlen %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group sdhl">
                        <label for="SMS_serverport"><%=Tag("端口号")%>：</label>
                        <input type="text" id="SMS_serverport" name="SMS_serverport" value="<%=model.SMS_serverport %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group sdhl">
                        <label for="SMS_apitype"><%=Tag("发送通道")%>：</label>
                        <select name="SMS_apitype" class="form-control" shop="true">
                            <option value="3" <%=model.SMS_apitype=="3"?"selected":"" %>>即时通道(客服类推荐) (发送1条扣去1.3条)</option>
                            <option value="2" <%=model.SMS_apitype=="2"?"selected":"" %>>普通通道(发送1条扣去1条)</option>
                        </select>
                    </div>
                    <div class="form-group sdhl">
                        <label for="SMS_serverport"><%=Tag("短信余额")%>：</label>
                        <div class="form-control-label"><%=account%></div>
                    </div>
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                    <%}%>
                </form>
            </div>
        </div>
        <%
        if (!Shop.LebiAPI.Service.Instanse.Check("managelicenese")){
        %>
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">时代互联通道说明</h4>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        普通通道：会对短信内容进行严格审核，不允许发送含有任何营销内容的短信；<br />
                        即时通道：专为需即时发送的客户开辟的绿色通道，发送速度很快，支持回复短信。<br />
                        注意：在短信发送高峰时期，有时短信网关及通道接口有可能会出现涌堵现象，这时为节省发送时间，建议您更换通道来发送。<br />
                        短信购买：<a href="http://web.56770.com/mobile/" target="_blank">http://web.56770.com/mobile/</a>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
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
            var url="<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=SMSConfig_Edit";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
        function changeserver()
        {
            var st=$("#SMS_server").val();
            if(st=='0')
                $('.sdhl').show();
            else
                $('.sdhl').hide();
            if(st=='999')
                $('#httpapi').show();
            else
                $('#httpapi').hide();
        }
        changeserver();
    </script>

</body>
</html>