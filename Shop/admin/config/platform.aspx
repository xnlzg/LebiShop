<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Config.platform" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("第三方配置")%>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("第三方配置")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item active"><%=Tag("第三方配置")%></li>
    </ol>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
<div class="col-12">
    <form action="javascript:SaveObj();" class="form-horizontal" novalidate>
        <div class="card">
            <div class="card-header">
                <div class="card-actions">
                    <a class="" data-action="collapse"><i class="ti-minus"></i></a>
                </div>
                <h5 class="card-title m-b-0"><%=Tag("QQ登录")%> <a target="_blank" href="http://connect.qq.com/"><i class="ti-new-window"></i></a></h5>
            </div>
            <div class="card-body b-t collapse show">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="platform_qq_id">Appid：</label>
                            <input type="text" id="platform_qq_id" name="platform_qq_id" value="<%=model.platform_qq_id %>" class="form-control" shop="true">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="platform_qq_id">Appkey：</label>
                            <input type="text" id="platform_qq_key" name="platform_qq_key" value="<%=model.platform_qq_key %>" class="form-control" shop="true">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="platform_qq_image"><%=Tag("图标")%>：</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="image_platform_qq_image"><%if (model.platform_qq_image != ""){%><img src="<%=site.WebPath + model.platform_qq_image%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                                </div>
                                <input type="text" id="platform_qq_image" name="platform_qq_image" value="<%=model.platform_qq_image %>" class="form-control" shop="true">
                                <div class="input-group-append fileupload">
                                    <span class="input-group-text"><i class="ti-upload"></i></span>
                                    <input type="file" id="file_platform_qq_image" name="file_platform_qq_image" class="upload" onchange="uploadImage('platform_qq_image')">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="platform_qq_adduser"><%=Tag("新用户注册")%>：</label>
                            <div class="input-group">
                                <label class="custom-control custom-checkbox">
                                    <input type="checkbox" id="platform_qq_adduser" name="platform_qq_adduser" value="1" class="custom-control-input" shop="true" <%=model.platform_qq_adduser=="1"?"checked":"" %>>
                                    <span class="custom-control-label"><%=Tag("启用")%></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="platform_login_qq"><%=Tag("状态")%>：</label>
                            <div class="input-group">
                                <label class="custom-control custom-checkbox">
                                    <input type="checkbox" id="platform_login_qq" name="platform_login" value="qq" class="custom-control-input" shop="true" <%=isselect("qq") %>>
                                    <span class="custom-control-label"><%=Tag("启用")%></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            <div class="row">
                <div class="col-12">
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
    </form>
    <form action="javascript:SaveObj();" class="form-horizontal" novalidate>
    <div class="card">
        <div class="card-header">
            <div class="card-actions">
                <a class="" data-action="collapse"><i class="ti-minus"></i></a>
            </div>
            <h5 class="card-title m-b-0"><%=Tag("新浪微博登录")%> <a target="_blank" href="http://open.weibo.com/"><i class="ti-new-window"></i></a></h5>
        </div>
        <div class="card-body b-t collapse show">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weibo_id">Appkey：</label>
                        <input type="text" id="platform_weibo_id" name="platform_weibo_id" value="<%=model.platform_weibo_id %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weibo_key">AppSecret：</label>
                        <input type="text" id="platform_weibo_key" name="platform_weibo_key" value="<%=model.platform_weibo_key %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weibo_image"><%=Tag("图标")%>：</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="image_platform_weibo_image"><%if (model.platform_weibo_image != ""){%><img src="<%=site.WebPath + model.platform_weibo_image%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                            </div>
                            <input type="text" id="platform_weibo_image" name="platform_weibo_image" value="<%=model.platform_weibo_image %>" class="form-control" shop="true">
                            <div class="input-group-append fileupload">
                                <span class="input-group-text"><i class="ti-upload"></i></span>
                                <input type="file" id="file_platform_weibo_image" name="file_platform_weibo_image" class="upload" onchange="uploadImage('platform_weibo_image')">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weibo_adduser"><%=Tag("新用户注册")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="platform_weibo_adduser" name="platform_weibo_adduser" value="1" class="custom-control-input" shop="true" <%=model.platform_weibo_adduser=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("启用")%></span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_login_weibo"><%=Tag("状态")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="platform_login_weibo" name="platform_login" value="weibo" class="custom-control-input" shop="true" <%=isselect("weibo") %>>
                                <span class="custom-control-label"><%=Tag("启用")%></span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
    </form>
    <form action="javascript:SaveObj();" class="form-horizontal" novalidate>
    <div class="card">
        <div class="card-header">
            <div class="card-actions">
                <a class="" data-action="collapse"><i class="ti-minus"></i></a>
            </div>
            <h5 class="card-title m-b-0"><%=Tag("淘宝登录")%> <a target="_blank" href="http://open.taobao.com/"><i class="ti-new-window"></i></a></h5>
        </div>
        <div class="card-body b-t collapse show">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_taobao_key">Appkey：</label>
                        <input type="text" id="platform_taobao_key" name="platform_taobao_key" value="<%=model.platform_taobao_key %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_taobao_secret">AppSecret：</label>
                        <input type="text" id="platform_taobao_secret" name="platform_taobao_secret" value="<%=model.platform_taobao_secret %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_taobao_image"><%=Tag("图标")%>：</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="image_platform_taobao_image"><%if (model.platform_taobao_image != ""){%><img src="<%=site.WebPath + model.platform_taobao_image%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                            </div>
                            <input type="text" id="platform_taobao_image" name="platform_taobao_image" value="<%=model.platform_taobao_image %>" class="form-control" shop="true">
                            <div class="input-group-append fileupload">
                                <span class="input-group-text"><i class="ti-upload"></i></span>
                                <input type="file" id="file_platform_taobao_image" name="file_platform_taobao_image" class="upload" onchange="uploadImage('platform_taobao_image')">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_taobao_adduser"><%=Tag("新用户注册")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="platform_taobao_adduser" name="platform_taobao_adduser" value="1" class="custom-control-input" shop="true" <%=model.platform_taobao_adduser=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("启用")%></span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_login_taobao"><%=Tag("状态")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="platform_login_taobao" name="platform_login" value="taobao" class="custom-control-input" shop="true" <%=isselect("taobao") %>>
                                <span class="custom-control-label"><%=Tag("启用")%></span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
    </form>
    <form action="javascript:SaveObj();" class="form-horizontal" novalidate>
    <div class="card">
        <div class="card-header">
            <div class="card-actions">
                <a class="" data-action="collapse"><i class="ti-minus"></i></a>
            </div>
            <h5 class="card-title m-b-0"><%=Tag("Facebook登录")%> <a target="_blank" href="https://developers.facebook.com/"><i class="ti-new-window"></i></a></h5>
        </div>
        <div class="card-body b-t collapse show">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_facebook_id">Appid：</label>
                        <input type="text" id="platform_facebook_id" name="platform_facebook_id" value="<%=model.platform_facebook_id %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_facebook_secret">AppSecret：</label>
                        <input type="text" id="platform_facebook_secret" name="platform_facebook_secret" value="<%=model.platform_facebook_secret %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_facebook_image"><%=Tag("图标")%>：</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="image_platform_facebook_image"><%if (model.platform_facebook_image != ""){%><img src="<%=site.WebPath + model.platform_facebook_image%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                            </div>
                            <input type="text" id="platform_facebook_image" name="platform_facebook_image" value="<%=model.platform_facebook_image %>" class="form-control" shop="true">
                            <div class="input-group-append fileupload">
                                <span class="input-group-text"><i class="ti-upload"></i></span>
                                <input type="file" id="file_platform_facebook_image" name="file_platform_facebook_image" class="upload" onchange="uploadImage('platform_facebook_image')">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_facebook_adduser"><%=Tag("新用户注册")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="platform_facebook_adduser" name="platform_facebook_adduser" value="1" class="custom-control-input" shop="true" <%=model.platform_facebook_adduser=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("启用")%></span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_login_facebook"><%=Tag("状态")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="platform_login_facebook" name="platform_login" value="facebook" class="custom-control-input" shop="true" <%=isselect("facebook") %>>
                                <span class="custom-control-label"><%=Tag("启用")%></span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
    </form>
    <form action="javascript:SaveObj();" class="form-horizontal" novalidate>
    <div class="card">
        <div class="card-header">
            <div class="card-actions">
                <a class="" data-action="collapse"><i class="ti-minus"></i></a>
            </div>
            <h5 class="card-title m-b-0"><%=Tag("微信登录")%> <a target="_blank" href="https://mp.weixin.qq.com/"><i class="ti-new-window"></i></a></h5>
        </div>
        <div class="card-body b-t collapse show">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weixin_number"><%=Tag("微信号")%>：</label>
                        <input type="text" id="platform_weixin_number" name="platform_weixin_number" value="<%=model.platform_weixin_number %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weixin_id">Appid：</label>
                        <input type="text" id="platform_weixin_id" name="platform_weixin_id" value="<%=model.platform_weixin_id %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weixin_secret">AppSecret：</label>
                        <input type="text" id="platform_weixin_secret" name="platform_weixin_secret" value="<%=model.platform_weixin_secret %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weixin_custemtoken">Token：</label>
                        <input type="text" id="platform_weixin_custemtoken" name="platform_weixin_custemtoken" value="<%=model.platform_weixin_custemtoken %>" class="form-control" shop="true">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weixin_image"><%=Tag("图标")%>：</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="image_platform_weixin_image"><%if (model.platform_weixin_image != ""){%><img src="<%=site.WebPath + model.platform_weixin_image%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                            </div>
                            <input type="text" id="platform_weixin_image" name="platform_weixin_image" value="<%=model.platform_weixin_image %>" class="form-control" shop="true">
                            <div class="input-group-append fileupload">
                                <span class="input-group-text"><i class="ti-upload"></i></span>
                                <input type="file" id="file_platform_weixin_image" name="file_platform_weixin_image" class="upload" onchange="uploadImage('platform_weixin_image')">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weixin_image_qrcode"><%=Tag("二维码") %>：</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="image_platform_weixin_image_qrcode"><%if (model.platform_weixin_image_qrcode != ""){%><img src="<%=site.WebPath + model.platform_weixin_image_qrcode%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                            </div>
                            <input type="text" id="platform_weixin_image_qrcode" name="platform_weixin_image_qrcode" value="<%=model.platform_weixin_image_qrcode %>" class="form-control" shop="true">
                            <div class="input-group-append fileupload">
                                <span class="input-group-text"><i class="ti-upload"></i></span>
                                <input type="file" id="file_platform_weixin_image_qrcode" name="file_platform_weixin_image_qrcode" class="upload" onchange="uploadImage('platform_weixin_image_qrcode')">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weixin_subscribe_automsg"><%=Tag("关注自动回复消息")%>：</label>
                        <textarea id="platform_weixin_subscribe_automsg" name="platform_weixin_subscribe_automsg" class="form-control" style="height: 60px;" shop="true"><%=model.platform_weixin_subscribe_automsg%></textarea>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('platform_weixin_subscribe_automsg',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('platform_weixin_subscribe_automsg',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_weixin_adduser"><%=Tag("新用户注册")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="platform_weixin_adduser" name="platform_weixin_adduser" value="1" class="custom-control-input" shop="true" <%=model.platform_weixin_adduser=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("启用")%></span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="platform_login_weixin"><%=Tag("状态")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="platform_login_weixin" name="platform_login" value="weixin" class="custom-control-input" shop="true" <%=isselect("weixin") %>>
                                <span class="custom-control-label"><%=Tag("启用")%></span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
    </form>
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
        function SaveObj() {
            var postData = GetFormJsonData("shop");
            var url="<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=PlatformConfig_Edit";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
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
                            $("#image_" + id + "").html('<img src="' + WebPath + imageUrl + '" height="20" />');
                            $("#" + id + "").val(imageUrl);
                        }
                    }
                }
            })
        }
    </script>

</body>
</html>