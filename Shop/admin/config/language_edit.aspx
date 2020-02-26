<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.sorteConfig.Language_Edit" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=model.SubName %>-<%=Tag("站点设置")%>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("站点设置")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><a href="language.aspx"><%=Tag("站点设置")%></a></li>
        <li class="breadcrumb-item active"><%=model.SubName %></li>
    </ol>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <div class="col-12">
        <form action="javascript:SaveObj();" novalidate>
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-12">
                            <%if (PageReturnMsg == ""){%>
                            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                            <%if (models.Count > 1 && model.id > 1){ %>
                            <button type="button" class="btn btn-danger" onclick="DeleteSiteConfirm(<%=model.id %>)"><i class="ti-trash"></i> <%=Tag("删除")%></button>
                            <%} %>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <div class="card-actions">
                        <a class="" data-action="collapse"><i class="ti-minus"></i></a>
                    </div>
                    <h5 class="card-title m-b-0"><%=Tag("基本信息")%></h5>
                </div>
                <div class="card-body b-t collapse show">
                    <div class="form-group">
                        <label for="Path"><%=Tag("站点路径")%>：</label>
                        <div class="input-group">
                            <input type="text" id="Path" name="Path" value="<%=model.Path %>" class="form-control" shop="true">
                            <div class="input-group-append">
                                <span class="input-group-text">
                                    <a href="<%if (model.Domain==""){ %><%=models.FirstOrDefault().Domain=="" ? site.WebPath + model.Path : "http://"+ models.FirstOrDefault().Domain + model.Path%><%}else{ %>http://<%=model.Domain%><%} %>" target="_blank"><i class="ti-new-window"></i></a>
                                </span>
                            </div>
                        </div>
                        <small class="form-text text-muted"><%=site.WebPath %></small>
                    </div>
                    <div class="form-group">
                        <label for="SubName"><%=Tag("站点简称")%>：</label>
                        <input type="text" id="SubName" name="SubName" value="<%=model.SubName %>" class="form-control" shop="true" required>
                    </div>
                    <div class="form-group">
                        <label for="IsMobile_1"><%=Tag("WAP站点")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsMobile_1" name="IsMobile" value="1" class="custom-control-input" shop="true" <%=model.IsMobile==1?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsMobile_0" name="IsMobile" value="0" class="custom-control-input" shop="true" <%=model.IsMobile==0?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
                    <%if (domain3admin || Shop.Bussiness.ShopCache.GetMainSite().id==model.id) {%>
                    <div class="form-group">
                        <label for="Domain"><%=Tag("站点域名")%>：</label>
                        <input type="text" id="Domain" name="Domain" value="<%=model.Domain %>" class="form-control" shop="true" required>
                        <small class="form-text text-muted"><%=Tag("不带http://")%><%=domain3admin ? ","+ Tag("不使用独立域名请留空") +"" : ""%></small>
                    </div>
                    <%} %>
                    <div class="form-group">
                        <label for="Sort"><%=Tag("排序序号")%>：</label>
                        <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <div class="card-actions">
                        <a class="" data-action="collapse"><i class="ti-minus"></i></a>
                    </div>
                    <h5 class="card-title m-b-0"><%=Tag("站点信息")%></h5>
                </div>
                <div class="card-body b-t collapse show">
                    <ul class="nav nav-tabs customtab" role="tablist">
                        <%
                        List
                        <DB.LebiShop.Lebi_Language>
                            sitelangs = Shop.Bussiness.Language.SiteLanguages(model.id);foreach (DB.LebiShop.Lebi_Language lang in sitelangs){
                            %>
                            <li class="nav-item"> <a class="nav-link <%if (sitelangs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                            <%
                            }
                            %>
                            <li class="nav-item"> <a class="nav-link" role="tab" href="javascript:void(0)" onclick="AddLanguage(<%=model.id %>)"><span class="hidden-xs-down"><%=Tag("添加")%></span></a> </li>
                    </ul>
                    <div class="tab-content m-t-10">
                        <%foreach (DB.LebiShop.Lebi_Language lang in sitelangs)
                        {%>
                        <div class="tab-pane <%if (sitelangs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                            <div class="row m-b-10">
                                <div class="col-12">
                                    <button type="button" class="btn btn-success btn-xs btn-sm" onclick="CreateTheme(<%=lang.id %>);"><i class="ti-loop"></i> <%=Tag("生成页面")%></button>
                                    <button type="button" class="btn btn-danger btn-xs btn-sm" onclick="DeleteConfirm(<%=lang.id %>)"><i class="ti-trash"></i> <%=Tag("删除语种")%></button>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="Name<%=lang.Code %>"><%=Tag("网站名称")%>：</label>
                                <input type="text" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name, lang.Code)%>" class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="Title<%=lang.Code %>"><%=Tag("网站标题")%>：</label>
                                <input type="text" id="Title<%=lang.Code %>" name="Title<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Title, lang.Code)%>" class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="Keywords<%=lang.Code %>"><%=Tag("网站关键词")%>：</label>
                                <textarea id="Keywords<%=lang.Code %>" name="Keywords<%=lang.Code %>" class="form-control" style="height: 60px;" shop="true"><%=Shop.Bussiness.Language.Content(model.Keywords, lang.Code)%></textarea>
                                <div class="button-group m-t-5">
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Keywords<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Keywords<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="Description<%=lang.Code %>"><%=Tag("网站描述")%>：</label>
                                <textarea id="Description<%=lang.Code %>" name="Description<%=lang.Code %>" class="form-control" style="height: 60px;" shop="true"><%=Shop.Bussiness.Language.Content(model.Description, lang.Code)%></textarea>
                                <div class="button-group m-t-5">
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="QQ<%=lang.Code %>"><%=Tag("QQ号码")%>：</label>
                                <input type="text" id="QQ<%=lang.Code %>" name="QQ<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.QQ, lang.Code)%>" class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="Phone<%=lang.Code %>"><%=Tag("电话号码")%>：</label>
                                <input type="text" id="Phone<%=lang.Code %>" name="Phone<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Phone, lang.Code)%>" class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="Fax<%=lang.Code %>"><%=Tag("传真号码")%>：</label>
                                <input type="text" id="Fax<%=lang.Code %>" name="Fax<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Fax, lang.Code)%>" class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="Email<%=lang.Code %>"><%=Tag("电子邮件")%>：</label>
                                <input type="text" id="Email<%=lang.Code %>" name="Email<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Email, lang.Code)%>" class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="FootHtml<%=lang.Code %>"><%=Tag("底部Html")%>：</label>
                                <textarea id="FootHtml<%=lang.Code %>" name="FootHtml<%=lang.Code %>" class="form-control" style="height: 60px;" shop="true"><%=Shop.Bussiness.Language.Content(model.FootHtml, lang.Code)%></textarea>
                                <div class="button-group m-t-5">
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('FootHtml<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('FootHtml<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="Copyright<%=lang.Code %>"><%=Tag("底部版权")%>：</label>
                                <textarea id="Copyright<%=lang.Code %>" name="Copyright<%=lang.Code %>" class="form-control" style="height: 60px;" shop="true"><%=Shop.Bussiness.Language.Content(model.Copyright, lang.Code)%></textarea>
                                <div class="button-group m-t-5">
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Copyright<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Copyright<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="Logoimg<%=lang.Code %>"><%=Tag("网站Logo")%>：</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="image_Logoimg<%=lang.Code %>"><%if (Lang(model.Logoimg, lang.Code) != ""){%><img src="<%=site.WebPath + Lang(model.Logoimg,lang.Code)%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                                    </div>
                                    <input type="text" id="Logoimg<%=lang.Code %>" name="Logoimg<%=lang.Code %>" value="<%=Lang(model.Logoimg,lang.Code)%>" class="form-control" shop="true">
                                    <div class="input-group-append fileupload">
                                        <span class="input-group-text"><i class="ti-upload"></i></span>
                                        <input type="file" id="file_Logoimg<%=lang.Code %>" name="file_Logoimg<%=lang.Code %>" class="upload" onchange="uploadImage('Logoimg<%=lang.Code %>')">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="ServiceP<%=lang.Code %>"><%=Tag("服务协议")%>：</label>
                                <textarea id="ServiceP<%=lang.Code %>" name="ServiceP<%=lang.Code %>" class="form-control" style="height: 60px;" shop="true"><%=Shop.Bussiness.Language.Content(model.ServiceP, lang.Code)%></textarea>
                                <div class="button-group m-t-5">
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('ServiceP<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('ServiceP<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                                </div>
                            </div>
                            <%DB.LebiShop.Lebi_Language clang = GetLanguage(lang.Code, model.id); %>
                            <div class="form-group">
                                <label for="Name<%=clang.id %>"><%=Tag("语言名称")%>：</label>
                                <input type="text" id="Name<%=clang.id %>" name="Name<%=clang.id %>" value="<%=clang.Name %>" class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="ImageUrl<%=clang.id %>"><%=Tag("图标")%>：</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="image_ImageUrl<%=clang.id %>"><%if (clang.ImageUrl != ""){%><img src="<%=site.WebPath + clang.ImageUrl%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                                    </div>
                                    <input type="text" id="ImageUrl<%=clang.id %>" name="ImageUrl<%=clang.id %>" value="<%=clang.ImageUrl%>" class="form-control" shop="true">
                                    <div class="input-group-append fileupload">
                                        <span class="input-group-text"><i class="ti-upload"></i></span>
                                        <input type="file" id="file_ImageUrl<%=clang.id %>" name="file_ImageUrl<%=clang.id %>" class="upload" onchange="uploadImage('ImageUrl<%=clang.id %>')">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="Currency_id<%=clang.id %>"><%=Tag("货币")%>：</label>
                                <select id="Currency_id<%=clang.id %>" name="Currency_id<%=clang.id %>" class="form-control" shop="true">
                                    <option value="0">
                                        <%=Tag("请选择")%>
                                    </option>
                                    <%=Currencylist(clang.Currency_id)%>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="TopAreaid<%=clang.id %>"><%=Tag("收货区域")%>：</label>
                                <select id="TopAreaid<%=clang.id %>" name="TopAreaid<%=clang.id %>" class="form-control" shop="true">
                                    <option value="0">
                                        <%=Tag("全部") %>
                                    </option>
                                    <%=areas(clang.TopAreaid)%>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="Theme_id<%=clang.id %>"><%=Tag("使用主题")%>：</label>
                                <select id="Theme_id<%=clang.id %>" name="Theme_id<%=clang.id %>" class="form-control" shop="true">
                                    <option value="0">
                                        <%=Tag("请选择")%>
                                    </option>
                                    <%=Themeslist(clang.Theme_id)%>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="Path<%=clang.id %>"><%=Tag("生成路径")%>：</label>
                                <input type="text" id="Path<%=clang.id %>" name="Path<%=clang.id %>" value="<%=clang.Path %>" class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="IsLazyLoad<%=clang.id %>_1"><%=Tag("图片延迟加载")%>：</label>
                                <div class="input-group">
                                    <label class="custom-control custom-radio m-r-20">
                                        <input type="radio" id="IsLazyLoad<%=clang.id %>_1" name="IsLazyLoad<%=clang.id %>" value="1" class="custom-control-input" shop="true" <%=clang.IsLazyLoad==1?"checked":"" %>>
                                        <span class="custom-control-label"><%=Tag("开启")%></span>
                                    </label>
                                    <label class="custom-control custom-radio">
                                        <input type="radio" id="IsLazyLoad<%=clang.id %>_0" name="IsLazyLoad<%=clang.id %>" value="0" class="custom-control-input" shop="true" <%=clang.IsLazyLoad==0?"checked":"" %>>
                                        <span class="custom-control-label"><%=Tag("关闭")%></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <%} %>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <div class="card-actions">
                        <a class="" data-action="collapse"><i class="ti-plus"></i></a>
                    </div>
                    <h5 class="card-title m-b-0"><%=Tag("微信登录设置")%></h5>
                </div>
                <div class="card-body b-t collapse">
                    <div class="form-group">
                        <label for="platform_weixin_number"><%=Tag("微信号")%>：</label>
                        <input type="text" id="platform_weixin_number" name="platform_weixin_number" value="<%=model.platform_weixin_number %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="platform_weixin_id"><%=Tag("Appid")%>：</label>
                        <input type="text" id="platform_weixin_id" name="platform_weixin_id" value="<%=model.platform_weixin_id %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="platform_weixin_secret"><%=Tag("AppSecret")%>：</label>
                        <input type="text" id="platform_weixin_secret" name="platform_weixin_secret" value="<%=model.platform_weixin_secret %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="platform_weixin_image_qrcode"><%=Tag("二维码")%>：</label>
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
                    <div class="form-group">
                        <label for="platform_weixin_custemtoken"><%=Tag("Token")%>：</label>
                        <input type="text" id="platform_weixin_custemtoken" name="platform_weixin_custemtoken" value="<%=model.platform_weixin_custemtoken %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="platform_weixin_subscribe_automsg"><%=Tag("关注自动回复消息")%>：</label>
                        <input type="text" id="platform_weixin_subscribe_automsg" name="platform_weixin_subscribe_automsg" value="<%=model.platform_weixin_subscribe_automsg %>" class="form-control" shop="true">
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
        function AddLanguage(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "language_add_window.aspx",
                type: "GET",
                cache: false,
                data: {id: id},
            }).done(function(result){
                $("#EditModal .modal-content").html(result);
            });
        }
        function DeleteConfirm(id) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "DeleteObj(" + id + ");");
        }
        function DeleteObj(id) {
            $("#Modal-Confirm").modal("hide");
            var postData = { "id": id };
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=SiteLanguage_Del";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?id=<%=model.id %>&tab=language")});
        }
        function DeleteSiteConfirm(id) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "DelSite(" + id + ");");
        }
        function DelSite(id)
        {
            $("#Modal-Confirm").modal("hide");
            var postData = { "id": id };
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=Site_Del";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function AddSite(id)
        {
            var postData = '';
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=AddSite";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "?id=<%=model.id %>&tab=language")});
        }
        function CreateTheme(Language_id) {
            var postData = { "Language_id": Language_id };
            var url="<%=site.AdminPath %>/ajax/ajax_aspx.aspx?__Action=CreateLanguageTheme";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
        function SaveObj()
        {
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=Site_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
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
                },
                error: function (data, status, e) {
                    MsgBox(2, data.msg, "");
                }
            })
        }
        function setpath(){
            var path=$("#Path").val();
            if(path=='/')
                path='';
            path=WebPath+path;
            $('.pathem').html(path);
        }
        setpath();
    </script>

</body>
</html>