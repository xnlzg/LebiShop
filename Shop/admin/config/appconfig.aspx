<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.appconfig" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("APP设置") %>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link rel="stylesheet" type="text/css" href="<%=site.AdminAssetsPath %>/plugins/bigcolorpicker/jquery.bigcolorpicker.css" />

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("APP设置") %></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item active"><%=Tag("APP设置") %></li>
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
                    <div class="row m-b-20">
                        <div class="col-12">
                            <%if (PageReturnMsg == ""){%>
                            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                            <button type="button" class="btn btn-default" onclick="Config();"><i class="ti-settings"></i> <%=Tag("推送配置")%></button>
                            <%}%>
                        </div>
                    </div>
                    <ul class="nav nav-tabs customtab" role="tablist">
                        <%
                        int mi=0;
                        List<DB.LebiShop.Lebi_Language_Code> tablangs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in tablangs){
                        %>
                        <li class="nav-item"> <a class="nav-link <%if (tablangs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                        <%}%>
                    </ul>
                    <div class="tab-content m-t-20">
                        <%foreach (DB.LebiShop.Lebi_Language_Code lang in tablangs){%>
                        <div class="tab-pane <%if (langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                            <div class="form-group">
                                <label for="app_name"><%=Tag("名称")%>：</label>
                                <input type="text" id="app_name<%=lang.Code %>" name="app_name<%=lang.Code %>" value="<%=Lang(app_name,lang.Code) %>" class="form-control" shop="true">
                            </div>
                            <h5 class="box-title m-t-20"><%=Tag("顶部Logo")%></h5>
                            <div class="form-group">
                                <label for="app_toplogo<%=lang.Code %>"><%=Tag("图片地址")%>：</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="image_app_toplogo<%=lang.Code %>"><%if (Lang(app_toplogo,lang.Code) != ""){%><img src="<%=Lang(app_toplogo,lang.Code) %>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                                    </div>
                                    <input type="text" id="app_toplogo<%=lang.Code %>" name="app_toplogo<%=lang.Code %>" value="<%=Lang(app_toplogo,lang.Code) %>" class="form-control" shop="true">
                                    <div class="input-group-append fileupload">
                                        <span class="input-group-text"><i class="ti-upload"></i></span>
                                        <input type="file" id="file_app_toplogo<%=lang.Code %>" name="file_app_toplogo<%=lang.Code %>" class="upload" onchange="uploadImage('app_toplogo<%=lang.Code %>')">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="app_toplogourl<%=lang.Code %>"><%=Tag("URL")%>：</label>
                                <input type="text" id="app_toplogourl<%=lang.Code %>" name="app_toplogourl<%=lang.Code %>" value="<%=Lang(app_toplogourl,lang.Code) %>" class="form-control" shop="true">
                            </div>
                            <h5 class="box-title m-t-20"><%=Tag("左上角图标")%></h5>
                            <div class="form-group">
                                <label for="app_lefticon<%=lang.Code %>"><%=Tag("图片地址")%>：</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="image_app_lefticon<%=lang.Code %>"><%if (Lang(app_lefticon,lang.Code) != ""){%><img src="<%=Lang(app_lefticon,lang.Code) %>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                                    </div>
                                    <input type="text" id="app_lefticon<%=lang.Code %>" name="app_lefticon<%=lang.Code %>" value="<%=Lang(app_lefticon,lang.Code) %>" class="form-control" shop="true">
                                    <div class="input-group-append fileupload">
                                        <span class="input-group-text"><i class="ti-upload"></i></span>
                                        <input type="file" id="file_app_lefticon<%=lang.Code %>" name="file_app_lefticon<%=lang.Code %>" class="upload" onchange="uploadImage('app_lefticon<%=lang.Code %>')">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="app_lefturl<%=lang.Code %>"><%=Tag("URL")%>：</label>
                                <input type="text" id="app_lefturl<%=lang.Code %>" name="app_lefturl<%=lang.Code %>" value="<%=Lang(app_lefturl,lang.Code) %>" class="form-control" shop="true">
                            </div>
                            <h5 class="box-title m-t-20"><%=Tag("右上角图标")%></h5>
                            <div class="form-group">
                                <label for="app_righticon<%=lang.Code %>"><%=Tag("图片地址")%>：</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="image_app_righticon<%=lang.Code %>"><%if (Lang(app_righticon,lang.Code) != ""){%><img src="<%=Lang(app_righticon,lang.Code) %>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                                    </div>
                                    <input type="text" id="app_righticon<%=lang.Code %>" name="app_righticon<%=lang.Code %>" value="<%=Lang(app_righticon,lang.Code) %>" class="form-control" shop="true">
                                    <div class="input-group-append fileupload">
                                        <span class="input-group-text"><i class="ti-upload"></i></span>
                                        <input type="file" id="file_app_righticon<%=lang.Code %>" name="file_app_righticon<%=lang.Code %>" class="upload" onchange="uploadImage('app_righticon<%=lang.Code %>')">
                                    </div>
                                </div>
                            </div>
                            <h5 class="box-title m-t-20"><%=Tag("顶部区域")%></h5>
                            <div class="row">
                                <div class="form-group col-sm-3">
                                    <label for="app_topbackground<%=lang.Code %>"><%=Tag("背景颜色")%>：</label>
                                    <div class="input-group">
                                        <input type="text" id="app_topbackground<%=lang.Code %>" name="app_topbackground<%=lang.Code %>" value="<%=Lang(app_topbackground,lang.Code) %>" class="form-control" shop="true">
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="s_app_topbackground<%=lang.Code %>" style="cursor: pointer;background-color:<%=Lang(app_topbackground,lang.Code) %>">
                                                <i class="ti-paint-bucket"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-3">
                                    <label for="app_topline<%=lang.Code %>"><%=Tag("边框颜色")%>：</label>
                                    <div class="input-group">
                                        <input type="text" id="app_topline<%=lang.Code %>" name="app_topline<%=lang.Code %>" value="<%=Lang(app_topline,lang.Code) %>" class="form-control" shop="true">
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="s_app_topline<%=lang.Code %>" style="cursor: pointer;background-color:<%=Lang(app_topline,lang.Code) %>">
                                                <i class="ti-paint-bucket"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-3">
                                    <label for="app_topcolor<%=lang.Code %>"><%=Tag("文字颜色")%>：</label>
                                    <div class="input-group">
                                        <input type="text" id="app_topcolor<%=lang.Code %>" name="app_topcolor<%=lang.Code %>" value="<%=Lang(app_topcolor,lang.Code) %>" class="form-control" shop="true">
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="s_app_topcolor<%=lang.Code %>" style="cursor: pointer;background-color:<%=Lang(app_topcolor,lang.Code) %>">
                                                <i class="ti-paint-bucket"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <h5 class="box-title m-t-20"><%=Tag("底部区域")%></h5>
                            <div class="row">
                                <div class="form-group col-sm-3">
                                    <label for="app_bottombackground<%=lang.Code %>"><%=Tag("背景颜色")%>：</label>
                                    <div class="input-group">
                                        <input type="text" id="app_bottombackground<%=lang.Code %>" name="app_bottombackground<%=lang.Code %>" value="<%=Lang(app_bottombackground,lang.Code) %>" class="form-control" shop="true">
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="s_app_bottombackground<%=lang.Code %>" style="cursor: pointer;background-color:<%=Lang(app_bottombackground,lang.Code) %>">
                                                <i class="ti-paint-bucket"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-3">
                                    <label for="app_bottomline<%=lang.Code %>"><%=Tag("边框颜色")%>：</label>
                                    <div class="input-group">
                                        <input type="text" id="app_bottomline<%=lang.Code %>" name="app_bottomline<%=lang.Code %>" value="<%=Lang(app_bottomline,lang.Code) %>" class="form-control" shop="true">
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="s_app_bottomline<%=lang.Code %>" style="cursor: pointer;background-color:<%=Lang(app_bottomline,lang.Code) %>">
                                                <i class="ti-paint-bucket"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-sm-3">
                                    <label for="app_bottomcolor<%=lang.Code %>"><%=Tag("文字颜色")%>：</label>
                                    <div class="input-group">
                                        <input type="text" id="app_bottomcolor<%=lang.Code %>" name="app_bottomcolor<%=lang.Code %>" value="<%=Lang(app_bottomcolor,lang.Code) %>" class="form-control" shop="true">
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="s_app_bottomcolor<%=lang.Code %>" style="cursor: pointer;background-color:<%=Lang(app_bottomcolor,lang.Code) %>">
                                                <i class="ti-paint-bucket"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-3">
                                    <label for="app_lefturl<%=lang.Code %>"><%=Tag("菜单数量")%>：</label>
                                    <input type="text" id="app_bottomcount<%=lang.Code %>" name="app_bottomcount<%=lang.Code %>" value="<%=Lang(app_bottomcount,lang.Code) %>" class="form-control" shop="true">
                                </div>
                            </div>
                            <h5 class="box-title m-t-20"><%=Tag("启动图片")%></h5>
                            <div class="row">
                                <div class="form-group col-sm-12">
                                    <label for="app_startimage<%=lang.Code %>"><%=Tag("图片地址")%>：</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="image_app_startimage<%=lang.Code %>"><%if (Lang(app_startimage,lang.Code) != ""){%><img src="<%=Lang(app_startimage,lang.Code) %>" height="20" /><%}else{ %><i class="ti-upload"></i><%}%></span>
                                        </div>
                                        <input type="text" id="app_startimage<%=lang.Code %>" name="app_startimage<%=lang.Code %>" value="<%=Lang(app_startimage,lang.Code) %>" class="form-control">
                                        <div class="input-group-append fileupload">
                                            <span class="input-group-text"><i class="ti-upload"></i></span>
                                            <input type="file" id="file_app_startimage<%=lang.Code %>" name="file_app_startimage<%=lang.Code %>" class="upload" onchange="uploadImage('app_startimage<%=lang.Code %>')">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <label for="app_starturl<%=lang.Code %>"><%=Tag("URL")%>：</label>
                                    <input type="text" id="app_starturl<%=lang.Code %>" name="app_starturl<%=lang.Code %>" value="<%=Lang(app_starturl,lang.Code) %>" class="form-control" shop="true">
                                </div>
                                <div class="form-group col-sm-3">
                                    <label for="app_waittimes<%=lang.Code %>"><%=Tag("停留时间")%>：</label>
                                    <input type="text" id="app_waittimes<%=lang.Code %>" name="app_waittimes<%=lang.Code %>" value="<%=Lang(app_waittimes,lang.Code) %>" class="form-control" shop="true">
                                </div>
                            </div>
                            <h5 class="box-title m-t-20"><%=Tag("升级")%></h5>
                            <div class="row">
                                <div class="form-group col-sm-3">
                                    <label for="app_version<%=lang.Code %>"><%=Tag("版本号")%>：</label>
                                    <input type="text" id="app_version<%=lang.Code %>" name="app_version<%=lang.Code %>" value="<%=Lang(app_version,lang.Code) %>" class="form-control" shop="true">
                                </div>
                                <div class="form-group col-sm-6">
                                    <label for="app_downloadurl<%=lang.Code %>"><%=Tag("下载地址")%>：</label>
                                    <input type="text" id="app_downloadurl<%=lang.Code %>" name="app_downloadurl<%=lang.Code %>" value="<%=Lang(app_downloadurl,lang.Code) %>" class="form-control" shop="true">
                                </div>
                            </div>
                            <h5 class="box-title m-t-20"><%=Tag("APP菜单")%></h5>
                            <div class="table-responsive">
                                <table class="table table-hover no-wrap">
                                    <thead>
                                        <tr>
                                            <th style="width:10%">
                                                <%=Tag("排序")%>
                                            </th>
                                            <th style="width:20%">
                                                <%=Tag("文字")%>
                                            </th>
                                            <th style="width:15%">
                                                <%=Tag("图标")%>
                                            </th>
                                            <th style="width:40%">
                                                <%=Tag("URL")%>
                                            </th>
                                            <th>
                                                <%=Tag("操作")%> [<a href="javascript:addrow('<%=lang.Code %>',$('#mi').val());"><%=Tag("增加")%></a>]
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="menustable<%=lang.Code %>">
                                        <%
                                        foreach(Shop.Model.BaseConfigAppMenu menu in Getmenus(Lang(val,lang.Code))){
                                        mi++;
                                        %>
                                        <tr id="tr<%=mi %>">
                                            <td>
                                                <input type="text" name="menu_sort<%=lang.Code %>" value="<%=menu.Sort %>" onkeyup="value=value.replace(/[^\d]/g,'')" class="form-control form-control-sm" shop="true">
                                            </td>
                                            <td>
                                                <input type="text" name="menu_name<%=lang.Code %>" value="<%=menu.Name %>" class="form-control form-control-sm" shop="true">
                                            </td>
                                            <td>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" id="image_menu_icon<%=lang.Code %>_<%=mi %>"><%if (menu.Icon != ""){%><img src="<%=menu.Icon %>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                                                    </div>
                                                    <input type="text" id="menu_icon<%=lang.Code %>_<%=mi %>" name="menu_icon<%=lang.Code %>" value="<%=menu.Icon %>" class="form-control form-control-sm" shop="true">
                                                    <div class="input-group-append fileupload">
                                                        <span class="input-group-text"><i class="ti-upload"></i></span>
                                                        <input type="file" id="file_menu_icon<%=lang.Code %>_<%=mi %>" name="file_menu_icon<%=lang.Code %>_<%=mi %>" class="upload" onchange="uploadImage('menu_icon<%=lang.Code %>_<%=mi %>')">
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <input type="text" name="menu_url<%=lang.Code %>" value="<%=menu.URL %>" class="form-control form-control-sm" shop="true">
                                            </td>
                                            <td>
                                                <input type="hidden" name="mi<%=lang.Code %>" value="<%=mi %>" shop="true">
                                                <a href="javascript:void(0);" onclick="$(this).parent().parent().remove();"><%=Tag("删除")%></a>
                                            </td>
                                        </tr>
                                        <%
                                        if(menu.Son!=null){
                                        foreach(Shop.Model.BaseConfigAppMenuSon son in menu.Son){
                                        //mi++;
                                        %>
                                        <tr>
                                            <td>
                                                &nbsp;|-<input type="text" name="<%=mi %>menu_sort<%=lang.Code %>" value="<%=son.Sort %>" onkeyup="value=value.replace(/[^\d]/g,'')" class="form-control form-control-sm" shop="true">
                                            </td>
                                            <td>
                                                <input type="text" name="<%=mi %>menu_name<%=lang.Code %>" value="<%=son.Name %>" class="form-control form-control-sm" shop="true">
                                            </td>
                                            <td></td>
                                            <td>
                                                <input type="text" name="<%=mi %>menu_url<%=lang.Code %>" value="<%=son.URL %>" class="form-control form-control-sm" shop="true">
                                            </td>
                                            <td>
                                                <a href="javascript:void(0);" onclick="$(this).parent().parent().remove();"><%=Tag("删除")%></a>
                                            </td>
                                        </tr>
                                        <%}} %>
                                        <%} %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <%} %>
                    </div>
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                    <input type="hidden" id="mi" name="mi" value="<%=mi%>" />
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
	
    <script src="<%=site.AdminAssetsPath %>/plugins/bigcolorpicker/jquery.bigcolorpicker.min.js"></script>
    <script src="<%=site.AdminJsPath %>/ajaxfileupload.js"></script>
    <script>
        function addrow(code,mi)
        {
            mi++;
            $("#mi").val(mi);
            var filename = "menu_icon"+ code +"_"+mi+"";
            var row='<tr id="tr'+mi+'"><td><input type="text" name="menu_sort'+code+'" value="0" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\\d]/g,\'\')" /></td>';
            row+='<td><input type="text" name="menu_name'+code+'" value="" class="form-control form-control-sm" shop="true" /></td>';
            row += '<td><div class="input-group"><div class="input-group-prepend"><span class="input-group-text" id="image_menu_icon' + code + '_' + mi + '"><i class="ti-image"></i></span></div><input type="text" id="menu_icon'+code+'_'+mi+'" name="menu_icon'+code+'" value="" class="form-control form-control-sm" shop="true"><div class="input-group-append fileupload"><span class="input-group-text" id="image_menu_icon'+code+'_'+mi+'"><i class="ti-upload"></i></span><input type="file" id="file_menu_icon'+code+'_'+mi+'" name="file_menu_icon'+code+'_'+mi+'" class="upload" onchange="uploadImage(\''+filename+'\')"></div></div></td>';
            row+='<td><input type="text" name="menu_url'+code+'" value="" class="form-control form-control-sm" shop="true" /></td>';
            row+='<td><a href="javascript:void(0);" onclick="$(this).parent().parent().remove();"><%=Tag("删除")%></a>';
            //row+=' | <a href="javascript:void(0);" onclick="addsonrow(\''+code+'\','+mi+');"><%=Tag("添加子菜单")%></a>';
            row+='<input type="hidden" class="input" shop="true" name="mi" value="'+mi+'" />';
            row+='</td></tr>';
            $("#menustable"+code).append(row);
        }
        function addsonrow(code,i)
        {
            //mi++;
            var row='<tr><td>&nbsp;|-<input type="text" name="'+i+' menu_sort'+code+'" value="0" onkeyup="value=value.replace(/[^\\d]/g,\'\')" class="form-control form-control-sm" shop="true"></td>';
            row+='<td><input type="text" name="'+i+'menu_name'+code+'" value="" class="form-control form-control-sm" shop="true"></td>';
            row+='<td>';
            row+='';
            row+='</td>';
            row+='<td><input type="text" name="'+i+'menu_url'+code+'" value="" class="form-control form-control-sm" shop="true"></td>';
            row+='<td><a href="javascript:void(0);" onclick="$(this).parent().parent().remove();"><%=Tag("删除")%></a></td></tr>';
            $("#tr"+i).after(row);
        }
        <%
        List<DB.LebiShop.Lebi_Language_Code> looplangs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in looplangs){
        %>
        $(function () {
            $("#s_app_topbackground<%=lang.Code %>").bigColorpicker(function (el, color) { $(el).css("background-color", color); $("#app_topbackground<%=lang.Code %>").val(color); });
            $("#s_app_topline<%=lang.Code %>").bigColorpicker(function (el, color) { $(el).css("background-color", color); $("#app_topline<%=lang.Code %>").val(color); });
            $("#s_app_topcolor<%=lang.Code %>").bigColorpicker(function (el, color) { $(el).css("background-color", color); $("#app_topcolor<%=lang.Code %>").val(color); });
            $("#s_app_bottombackground<%=lang.Code %>").bigColorpicker(function (el, color) { $(el).css("background-color", color); $("#app_bottombackground<%=lang.Code %>").val(color); });
            $("#s_app_bottomline<%=lang.Code %>").bigColorpicker(function (el, color) { $(el).css("background-color", color); $("#app_bottomline<%=lang.Code %>").val(color); });
            $("#s_app_bottomcolor<%=lang.Code %>").bigColorpicker(function (el, color) { $(el).css("background-color", color); $("#app_bottomcolor<%=lang.Code %>").val(color); });
        });
        <%} %>
        function uploadImage(id) {
            $.ajaxFileUpload({
	            url: WebPath + '/ajax/imageuploadone.aspx?path=config',
	            secureuri: false,
	            fileElementId: 'file_' + id,
	            dataType: 'json',
	            success: function (data, status) {
	                if (data.msg != 'OK') {
	                    MsgBox(2, data.error, "");
	                }
	                else {
	                    var imageUrl = data.ImageUrl;
	                    if (imageUrl.length > 0) {
	                        $("#image_" + id + "").html('<img src="' + imageUrl + '" height="20" />');
	                        $("#" + id + "").val(imageUrl);
	                        //$("#img" + id + "").attr('src',imageUrl);
	                        //$("#menu_icon" + id + "").val(imageUrl);
	                        //$("#" + id + "").val(imageUrl);
	                        //$("#img" + id + "").show();
	                    }
	                }
	            },
	            error: function (data, status, e) {
	                MsgBox(2, data.msg, "");
	            }
	        })
        }
        function SaveObj() {
            var postData = GetFormJsonData("shop");
            var url="<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=APPMenu_Edit";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
        function Config() {
            $("#EditModal").modal("show");
            $.ajax({
                url: "appconfig_edit_window.aspx",
                type: "GET",
                cache: false,
                data: {},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
    </script>

</body>
</html>