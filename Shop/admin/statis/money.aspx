﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.statis.money" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("资金统计")%>-<%=site.title%></title>

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
							</li>
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
							</li>
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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("资金统计") %></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item active"><%=Tag("资金统计")%></li>
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
                    <div class="col-md-12">
                        <%if (PageReturnMsg == ""){%>
                        <button class="btn btn-info" onclick="Export();"><i class="ti-export"></i> <%=Tag("导出")%></button>
                        <%}%>
                    </div>
                    <div class="col-md-12 m-t-10">
                        <ul class="nav nav-tabs customtab" role="tablist">
                            <li class="nav-item"><a class="nav-link <%if (type == 0){Response.Write(" active");} %>" href="money.aspx?time=<%=time %>" role="tab"><%=Tag("金额")%></a></li>
                            <li class="nav-item"><a class="nav-link <%if (type == 1){Response.Write(" active");} %>" href="money.aspx?type=1&time=<%=time %>" role="tab"><%=Tag("笔数")%></a></li>
                        </ul>
                    </div>
                    <div class="col-md-12 m-t-10">
                        <ul class="nav nav-tabs customtab" role="tablist">
                            <li class="nav-item"><a class="nav-link <%if (time == 0){Response.Write(" active");} %>" href="?time=0&type=<%=type %>" role="tab"><%=Tag("今日")%></a></li>
                            <li class="nav-item"><a class="nav-link <%if (time == 1){Response.Write(" active");} %>" href="?time=1&type=<%=type %>" role="tab"><%=Tag("昨日")%></a></li>
                            <li class="nav-item"><a class="nav-link <%if (time == 2){Response.Write(" active");} %>" href="?time=2&type=<%=type %>" role="tab"><%=Tag("最近7日")%></a></li>
                            <li class="nav-item"><a class="nav-link <%if (time == 3){Response.Write(" active");} %>" href="?time=3&type=<%=type %>" role="tab"><%=Tag("最近30日")%></a></li>
                        </ul>
                    </div>
                </div>
                <div class="row m-t-20 m-b-20">
                    <div id="container" style="width:100%;height:400px"></div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr>
                                <th>
                                    <%
                                    switch(time) {
                                    case 0:
                                    Response.Write(Tag("时间"));
                                    break;
                                    case 1:
                                    Response.Write(Tag("时间"));
                                    break;
                                    case 2:
                                    Response.Write(Tag("日期"));
                                    break;
                                    case 3:
                                    Response.Write(Tag("日期"));
                                    break;
                                    }
                                    %>
                                </th>
                                <%
                                foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <th><%=model.Name%></th>
                                <%
                                }
                                %>
                                <th><%=Tag("合计")%></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%if (type == 0)
                            { %>
                            <%if (time == 0)
                            { %>
                            <%var i = 1;for(i=1; i<=24; i++){%>
                            <tr>
                                <td><%=i-1 %>:00</td>
                                <%
                                decimal total = 0;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1) %></td>
                                <%
                                total+=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1);
                                }
                                %>
                                <td style="font-weight:bold"><%=total%></td>
                            </tr>
                            <%} %>
                            <tr>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                                <%
                                foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-29).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                }
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-29).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyStatus = 181") %></td>
                            </tr>
                            <%} %>
                            <%if (time == 1)
                            { %>
                            <%var i = 1;for(i=1; i<=24; i++){%>
                            <tr>
                                <td><%=i-1 %>:00</td>
                                <%
                                decimal total = 0;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1) %></td>
                                <%
                                total+=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1);
                                }
                                %>
                                <td style="font-weight:bold"><%=total%></td>
                            </tr>
                            <%} %>
                            <tr>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                                <%
                                foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                }
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyStatus = 181") %></td>
                            </tr>
                            <%} %>
                            <%if (time == 2)
                            { %>
                            <%var i = 1;for(i=1; i<=7; i++){%>
                            <tr>
                                <td><%=System.DateTime.Now.AddDays(-7+i).Month.ToString()%>-<%=System.DateTime.Now.AddDays(-7 + i).Day.ToString()%></td>
                                <%
                                decimal total = 0;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-7 + i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-7 + i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                total+=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-7 + i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-7 + i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181");
                                }
                                %>
                                <td style="font-weight:bold"><%=total%></td>
                            </tr>
                            <%} %>
                            <tr>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                                <%
                                foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-6).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                }
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-6).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyStatus = 181") %></td>
                            </tr>
                            <%} %>
                            <%if (time == 3)
                            { %>
                            <%var i = 1;for(i=1; i<=30; i++){%>
                            <tr>
                                <td><%=System.DateTime.Now.AddDays(-30+i).Month.ToString()%>-<%=System.DateTime.Now.AddDays(-30 + i).Day.ToString()%></td>
                                <%
                                decimal total = 0;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-30 + i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-30 + i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                total+=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-30 + i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-30 + i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181");
                                }
                                %>
                                <td style="font-weight:bold"><%=total%></td>
                            </tr>
                            <%} %>
                            <tr>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                                <%
                                foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-29).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                }
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-29).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyStatus = 181") %></td>
                            </tr>
                            <%} %>
                            <%} %>
                            <%if (type == 1)
                            { %>
                            <%if (time == 0)
                            { %>
                            <%var i = 1;for(i=1; i<=24; i++){%>
                            <tr>
                                <td><%=i-1 %>:00</td>
                                <%
                                int total = 0;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1) %></td>
                                <%
                                total+=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181");
                                }
                                %>
                                <td style="font-weight:bold"><%=total%></td>
                            </tr>
                            <%} %>
                            <tr>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                                <%
                                foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                }
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyStatus = 181") %></td>
                            </tr>
                            <%} %>
                            <%if (time == 1)
                            { %>
                            <%var i = 1;for(i=1; i<=24; i++){%>
                            <tr>
                                <td><%=i-1 %>:00</td>
                                <%
                                int total = 0;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1) %></td>
                                <%
                                total+=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181");
                                }
                                %>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                            </tr>
                            <%} %>
                            <tr>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                                <%
                                foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                }
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyStatus = 181") %></td>
                            </tr>
                            <%} %>
                            <%if (time == 2)
                            { %>
                            <%var i = 1;for(i=1; i<=7; i++){%>
                            <tr>
                                <td><%=System.DateTime.Now.AddDays(-7+i).Month.ToString()%>-<%=System.DateTime.Now.AddDays(-7+i).Day.ToString()%></td>
                                <%
                                int total = 0;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-7+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-7+i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                total+=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-7+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-7+i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181");
                                }
                                %>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                            </tr>
                            <%} %>
                            <tr>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                                <%
                                foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-6).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                }
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-6).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyStatus = 181") %></td>
                            </tr>
                            <%} %>
                            <%if (time == 3)
                            { %>
                            <%var i = 1;for(i=1; i<=30; i++){%>
                            <tr>
                                <td><%=System.DateTime.Now.AddDays(-30+i).Month.ToString()%>-<%=System.DateTime.Now.AddDays(-30 + i).Day.ToString()%></td>
                                <%
                                int total = 0;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-30+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-30+i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                total+=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-30+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-30+i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181");
                                }
                                %>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                            </tr>
                            <%} %>
                            <tr>
                                <td style="font-weight:bold"><%=Tag("合计") %></td>
                                <%
                                foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
                                {
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-29).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %></td>
                                <%
                                }
                                %>
                                <td style="font-weight:bold"><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-29).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyStatus = 181") %></td>
                            </tr>
                            <%} %>
                            <%} %>
                        </tbody>
                    </table>
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
	
    <script src="<%=site.AdminAssetsPath %>/plugins/highcharts/highcharts.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/highcharts/exporting.js"></script>
    <%if (type == 0){ %>
    <%if (time == 0){ %>
    <script type="text/javascript">
        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {type: 'spline',renderTo: 'container',reflow:false},
                title: {text: '<%=Tag("资金统计") %>',align: 'left',x: 5,style:{font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'}},
                subtitle: {text: ''},
                xAxis: {categories: [<%var i = 1;for(i=1; i<=24; i++){%>'<%=(i-1)%>:00'<%if (i <24){Response.Write(", ");} %><%} %>],lineWidth:1},
            yAxis: {min: 0,title: {text: ''},lineWidth:1},
        tooltip: {crosshairs: true,shared: true},
        plotOptions: {column: {pointPadding: 1,borderWidth: 0}},
        series: [
    <%
        int types = 1;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
        {
        %>
        {name: '<%=model.Name%>',data: [<%for(i=1; i<=24; i++){%><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1) %><%if (i <24){Response.Write(", ");} %><%} %>]}<%if(types<Shop.Bussiness.EX_Type.GetTypes("MoneyType").Count){ %>,<%} %>
        <%
        types+=1;}
 %>
        ]
        });});
    </script>
    <%} %>
    <%if (time == 1){ %>
    <script type="text/javascript">
        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {type: 'spline',renderTo: 'container',reflow:false},
                title: {text: '<%=Tag("资金统计") %>',align: 'left',x: 5,style:{font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'}},
                subtitle: {text: ''},
                xAxis: {categories: [<%var i = 1;for(i=1; i<=24; i++){%>'<%=(i-1)%>:00'<%if (i <24){Response.Write(", ");} %><%} %>],lineWidth:1},
            yAxis: {min: 0,title: {text: ''},lineWidth:1},
        tooltip: {crosshairs: true,shared: true},
        plotOptions: {column: {pointPadding: 1,borderWidth: 0}},
        series: [
    <%
        int types = 1;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
        {
        %>
        {name: '<%=model.Name%>',data: [<%for(i=1; i<=24; i++){%><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1) %><%if (i <24){Response.Write(", ");} %><%} %>]}<%if(types<Shop.Bussiness.EX_Type.GetTypes("MoneyType").Count){ %>,<%} %>
        <%
        types+=1;}
 %>
        ]
        });});
    </script>
    <%} %>
    <%if (time == 2){ %>
    <script type="text/javascript">
        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {type: 'spline',renderTo: 'container',reflow:false},
                title: {text: '<%=Tag("资金统计") %>',align: 'left',x: 5,style:{font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'}},
                subtitle: {text: ''},
                xAxis: {categories: [<%var i = 1;for(i=1; i<=7; i++){%>'<%=System.DateTime.Now.AddDays(-7+i).Month.ToString()%>-<%=System.DateTime.Now.AddDays(-7+i).Day.ToString()%>'<%if (i <7){Response.Write(", ");} %><%} %>],lineWidth:1},
            yAxis: {min: 0,title: {text: ''},lineWidth:1},
        //legend: {align: 'center',x:0,y:-179,floating: true,shadow: true,verticalAlign: 'middle',borderWidth:0},
        tooltip: {crosshairs: true,shared: true},
        plotOptions: {column: {pointPadding: 1,borderWidth: 0}},
        series: [
    <%
        int types = 1;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
        {
        %>
        {name: '<%=model.Name%>',data: [<%for(i=1; i<=7; i++){%><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-7+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-7+i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %><%if (i <7){Response.Write(", ");} %><%} %>]}<%if(types<Shop.Bussiness.EX_Type.GetTypes("MoneyType").Count){ %>,<%} %>
        <%
        types+=1;}
 %>
        ]
        });});
    </script>
    <%} %>
    <%if (time == 3){ %>
    <script type="text/javascript">
        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {type: 'spline',renderTo: 'container',reflow:false},
                title: {text: '<%=Tag("资金统计") %>',align: 'left',x: 5,style:{font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'}},
                subtitle: {text: ''},
                xAxis: {categories: [<%var i = 1;var m = 1;for(i=1; i<=30; i++){%>'<%if (System.DateTime.Now.AddDays(-30+i).Month.ToString()==System.DateTime.Now.Month.ToString()){%><%if (m == 1){ %><%=System.DateTime.Now.Month.ToString() %>m<%}else{ %><%=System.DateTime.Now.AddDays(-30+i).Day.ToString()%><%} %><%m=m+1; %><%}else{%><%=System.DateTime.Now.AddDays(-30+i).Day.ToString()%><%} %>'<%if (i <30){Response.Write(", ");} %><%} %>],lineWidth:1},
            yAxis: {min: 0,title: {text: ''},lineWidth:1},
        //legend: {align: 'center',x:0,y:-179,floating: true,shadow: true,verticalAlign: 'middle',borderWidth:0},
        tooltip: {crosshairs: true,shared: true},
        plotOptions: {column: {pointPadding: 1,borderWidth: 0}},
        series: [
    <%
        int types = 1;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
        {
        %>
        {name: '<%=model.Name%>',data: [<%for(i=1; i<=30; i++){%><%=Shop.Bussiness.EX_User.GetMoney_UserMoney(System.DateTime.Now.AddDays(-30+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-30+i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %><%if (i <30){Response.Write(", ");} %><%} %>]}<%if(types<Shop.Bussiness.EX_Type.GetTypes("MoneyType").Count){ %>,<%} %>
        <%
        types+=1;}
 %>
        ]
        });});
    </script>
    <%} %>
    <%} %>
    <%if (type == 1){ %>
    <%if (time == 0){ %>
    <script type="text/javascript">
        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {type: 'spline',renderTo: 'container',reflow:false},
                title: {text: '<%=Tag("资金统计") %>',align: 'left',x: 5,style:{font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'}},
                subtitle: {text: ''},
                xAxis: {categories: [<%var i = 1;for(i=1; i<=24; i++){%>'<%=(i-1)%>:00'<%if (i <24){Response.Write(", ");} %><%} %>],lineWidth:1},
            yAxis: {min: 0,title: {text: ''},lineWidth:1},
        tooltip: {crosshairs: true,shared: true},
        plotOptions: {column: {pointPadding: 1,borderWidth: 0}},
        series: [
    <%
        int types = 1;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
        {
        %>
        {name: '<%=model.Name%>',data: [<%for(i=1; i<=24; i++){%><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(0).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1) %><%if (i <24){Response.Write(", ");} %><%} %>]}<%if(types<Shop.Bussiness.EX_Type.GetTypes("MoneyType").Count){ %>,<%} %>
        <%
        types+=1;}
 %>
        ]
        });});
    </script>
    <%} %>
    <%if (time == 1){ %>
    <script type="text/javascript">
        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {type: 'spline',renderTo: 'container',reflow:false},
                title: {text: '<%=Tag("资金统计") %>',align: 'left',x: 5,style:{font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'}},
                subtitle: {text: ''},
                xAxis: {categories: [<%var i = 1;for(i=1; i<=24; i++){%>'<%=(i-1)%>:00'<%if (i <24){Response.Write(", ");} %><%} %>],lineWidth:1},
            yAxis: {min: 0,title: {text: ''},lineWidth:1},
        tooltip: {crosshairs: true,shared: true},
        plotOptions: {column: {pointPadding: 1,borderWidth: 0}},
        series: [
    <%
        int types = 1;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
        {
        %>
        {name: '<%=model.Name%>',data: [<%for(i=1; i<=24; i++){%><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181",i-1) %><%if (i <24){Response.Write(", ");} %><%} %>]}<%if(types<Shop.Bussiness.EX_Type.GetTypes("MoneyType").Count){ %>,<%} %>
        <%
        types+=1;}
 %>
        ]
        });});
    </script>
    <%} %>
    <%if (time == 2){ %>
    <script type="text/javascript">
        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {type: 'spline',renderTo: 'container',reflow:false},
                title: {text: '<%=Tag("资金统计") %>',align: 'left',x: 5,style:{font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'}},
                subtitle: {text: ''},
                xAxis: {categories: [<%var i = 1;for(i=1; i<=7; i++){%>'<%=System.DateTime.Now.AddDays(-7+i).Month.ToString()%>-<%=System.DateTime.Now.AddDays(-7+i).Day.ToString()%>'<%if (i <7){Response.Write(", ");} %><%} %>],lineWidth:1},
            yAxis: {min: 0,title: {text: ''},lineWidth:1},
        //legend: {align: 'center',x:0,y:-179,floating: true,shadow: true,verticalAlign: 'middle',borderWidth:0},
        tooltip: {crosshairs: true,shared: true},
        plotOptions: {column: {pointPadding: 1,borderWidth: 0}},
        series: [
    <%
        int types = 1;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
        {
        %>
        {name: '<%=model.Name%>',data: [<%for(i=1; i<=7; i++){%><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-7+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-7+i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %><%if (i <7){Response.Write(", ");} %><%} %>]}<%if(types<Shop.Bussiness.EX_Type.GetTypes("MoneyType").Count){ %>,<%} %>
        <%
        types+=1;}
 %>
        ]
        });});
    </script>
    <%} %>
    <%if (time == 3){ %>
    <script type="text/javascript">
        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {type: 'spline',renderTo: 'container',reflow:false},
                title: {text: '<%=Tag("资金统计") %>',align: 'left',x: 5,style:{font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'}},
                subtitle: {text: ''},
                xAxis: {categories: [<%var i = 1;var m = 1;for(i=1; i<=30; i++){%>'<%if (System.DateTime.Now.AddDays(-30+i).Month.ToString()==System.DateTime.Now.Month.ToString()){%><%if (m == 1){ %><%=System.DateTime.Now.Month.ToString() %>m<%}else{ %><%=System.DateTime.Now.AddDays(-30+i).Day.ToString()%><%} %><%m=m+1; %><%}else{%><%=System.DateTime.Now.AddDays(-30+i).Day.ToString()%><%} %>'<%if (i <30){Response.Write(", ");} %><%} %>]},
            yAxis: {min: 0,title: {text: ''}},
        tooltip: {crosshairs: true,shared: true},
        plotOptions: {column: {pointPadding: 1,borderWidth: 0}},
        series: [
    <%
        int types = 1;foreach (DB.LebiShop.Lebi_Type model in Shop.Bussiness.EX_Type.GetTypes("MoneyType"))
        {
        %>
        {name: '<%=model.Name%>',data: [<%for(i=1; i<=30; i++){%><%=Shop.Bussiness.EX_User.GetCount_UserMoney(System.DateTime.Now.AddDays(-30+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-30+i).ToString("yyyy-MM-dd"),"Type_id_MoneyType = " + model.id + " and Type_id_MoneyStatus = 181") %><%if (i <30){Response.Write(", ");} %><%} %>]}<%if(types<Shop.Bussiness.EX_Type.GetTypes("MoneyType").Count){ %>,<%} %>
        <%
        types+=1;}
 %>
        ]
        });});
    </script>
    <%} %>
    <%} %>
    <script>
        function Export(){
            MsgBox(1, "<%=Tag("正在处理，请等待")%>", "<%=site.AdminPath %>/ajax/export.aspx?__Action=Statis_Money&time=<%=time %>&type=<%=type %>")
        }
    </script>

</body>
</html>