<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Default" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("管理首页")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link href="<%=site.AdminAssetsPath %>/plugins/css-chart/css-chart.css" rel="stylesheet">

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("管理首页") %></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item active"><%if (Tips()!=""){ %><%=Tips() %><%} %></li>
    </ol>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <div class="col-12">
        <div class="row">
            <div class="col-md-6 col-lg-3">
                <div class="card card-body">
                    <a href="<%=site.AdminPath %>/order/default.aspx?type=1">
                    <div class="row">
                        <div class="col p-r-0 align-self-center">
                            <h2 class="font-light m-b-0" id="count_unVerified"></h2>
                            <h6 class="text-muted"><%=Tag("未确认")%></h6>
                        </div>
                        <div class="col text-right align-self-center">
                            <div id="percent_unVerified" class="css-bar m-b-0 css-bar-info css-bar-20"></div>
                        </div>
                    </div>
                    </a>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card card-body">
                    <a href="<%=site.AdminPath %>/order/default.aspx?type=4">
                    <div class="row">
                        <div class="col p-r-0 align-self-center">
                            <h2 class="font-light m-b-0" id="count_Paid"></h2>
                            <h6 class="text-muted"><%=Tag("已支付")%></h6>
                        </div>
                        <div class="col text-right align-self-center">
                            <div id="percent_Paid" class="css-bar m-b-0 css-bar-success css-bar-20"></div>
                        </div>
                    </div>
                    </a>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card card-body">
                    <a href="<%=site.AdminPath %>/order/default.aspx?type=5">
                    <div class="row">
                        <div class="col p-r-0 align-self-center">
                            <h2 class="font-light m-b-0" id="count_unShipped"></h2>
                            <h6 class="text-muted"><%=Tag("未发货")%></h6>
                        </div>
                        <div class="col text-right ">
                            <div id="percent_unShipped" class="css-bar m-b-0 css-bar-primary css-bar-40"></div>
                        </div>
                    </div>
                    </a>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card card-body">
                    <a href="<%=site.AdminPath %>/order/default.aspx?type=9">
                    <div class="row">
                        <div class="col p-r-0 align-self-center">
                            <h2 class="font-light m-b-0" id="count_Received"></h2>
                            <h6 class="text-muted"><%=Tag("已收货")%></h6>
                        </div>
                        <div class="col text-right align-self-center">
                            <div id="percent_Received" class="css-bar m-b-0 css-bar-danger css-bar-60"></div>
                        </div>
                    </div>
                    </a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <a href="<%=site.AdminPath %>/user/Message.aspx?dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&type=0">
                            <div class="d-flex flex-row">
                                <div class="round round-lg align-self-center round-info"><i class="ti-email"></i></div>
                                <div class="m-l-10 align-self-center">
                                    <h3 class="m-b-0 font-light"><%=Shop.Bussiness.Message.GetCount_Message(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "User_id_To = 0")%></h3>
                                    <h5 class="text-muted m-b-0"><%=Tag("站内信")%></h5>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <a href="<%=site.AdminPath %>/product/Comment.aspx?dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>">
                            <div class="d-flex flex-row">
                                <div class="round round-lg align-self-center round-warning"><i class="ti-comments"></i></div>
                                <div class="m-l-10 align-self-center">
                                    <h3 class="m-b-0 font-lgiht"><%=Shop.Bussiness.Comment.GetCount_Comment(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "TableName = 'Product'")%></h3>
                                    <h5 class="text-muted m-b-0"><%=Tag("商品评价")%></h5>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <a href="<%=site.AdminPath %>/user/default.aspx?dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&datetype=1">
                            <div class="d-flex flex-row">
                                <div class="round round-lg align-self-center round-primary"><i class="ti-user"></i></div>
                                <div class="m-l-10 align-self-center">
                                    <h3 class="m-b-0 font-lgiht"><%=Shop.Bussiness.EX_User.GetCount_User(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "",0)%></h3>
                                    <h5 class="text-muted m-b-0"><%=Tag("新增会员")%></h5>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <a href="<%=site.AdminPath %>/user/default.aspx?dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&datetype=3">
                            <div class="d-flex flex-row">
                                <div class="round round-lg align-self-center round-danger"><i class="ti-calendar"></i></div>
                                <div class="m-l-10 align-self-center">
                                    <h3 class="m-b-0 font-lgiht"><%=Shop.Bussiness.EX_User.GetCount_User(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "",1)%></h3>
                                    <h5 class="text-muted m-b-0"><%=Tag("过生日会员")%></h5>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-12">
                        <div id="container" style="width: 99%; height: 100%; margin: 0 auto"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th colspan="2">
                                            <%=Tag("今日业务量")%>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="no-wrap">
                                        <td>
                                            <%=Tag("订单总数")%>：
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "Type_id_OrderType = 211")%></a>
                                        </td>
                                    </tr>
                                    <tr class="no-wrap">
                                        <td>
                                            <%=Tag("退货订单总数")%>：
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?t=212&dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "Type_id_OrderType = 212")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("未确认订单")%>：
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&type=1"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "Type_id_OrderType = 211 and IsVerified = 0 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("未支付订单")%>：
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&type=3"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "Type_id_OrderType = 211 and IsVerified = 1 and IsPaid = 0 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr class="no-wrap">
                                        <td>
                                            <%=Tag("未发货订单")%>：
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&type=5"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "Type_id_OrderType = 211 and IsVerified = 1 and IsShipped = 0 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("未收货订单")%>：
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.ToString("yyyy-MM-dd")%>&type=8"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.ToString("yyyy-MM-dd"), System.DateTime.Now.ToString("yyyy-MM-dd"), "Type_id_OrderType = 211 and IsVerified = 1 and IsReceived = 0 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th colspan="2">
                                            <%=Tag("昨日业务量")%>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <%=Tag("订单总数")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), "Type_id_OrderType = 211")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("已确认订单")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&type=2"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), "Type_id_OrderType = 211 and IsVerified = 1 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("已支付订单")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&type=4"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), "Type_id_OrderType = 211 and IsVerified = 1 and IsPaid = 1 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("已发货订单")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&type=6"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), "Type_id_OrderType = 211 and IsVerified = 1 and IsShipped = 1 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("已收货订单")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&type=9"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), "Type_id_OrderType = 211 and IsVerified = 1 and IsReceived = 1 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("已完成订单")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?dateFrom=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&dateTo=<%=System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")%>&type=10"><%=Shop.Bussiness.Order.GetCount_Order(System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), System.DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd"), "Type_id_OrderType = 211 and IsVerified = 1 and IsCompleted = 1")%></a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th colspan="2">
                                            <%=Tag("待处理事务")%>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <%=Tag("未确认订单")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?type=1"><%=Shop.Bussiness.Order.GetCount_Order("", "", "Type_id_OrderType = 211 and IsVerified = 0 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("未支付订单")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?type=3"><%=Shop.Bussiness.Order.GetCount_Order("", "", "Type_id_OrderType = 211 and IsVerified = 1 and IsPaid = 0 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("未发货订单")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?type=5"><%=Shop.Bussiness.Order.GetCount_Order("", "", "Type_id_OrderType = 211 and IsVerified = 1 and IsShipped = 0 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("未收货订单")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx?type=8"><%=Shop.Bussiness.Order.GetCount_Order("", "", "Type_id_OrderType = 211 and IsVerified = 1 and IsReceived = 0 and IsInvalid = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("站内信")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/user/Message.aspx?type=0"><%=Shop.Bussiness.Message.GetCount_Message("", "", "User_id_To = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("商品评价")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/product/Comment.aspx?status=280"><%=Shop.Bussiness.Comment.GetCount_Comment("", "", "TableName = 'Product' and Status = 280")%></a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th colspan="2">
                                            <%=Tag("数据统计")%>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <%=Tag("上架商品总数")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/product/default.aspx?status=101"><%=Shop.Bussiness.EX_Product.GetCount_Product("", "", "Type_id_ProductStatus = 101 and Product_id = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("下架商品总数")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/product/default.aspx?status=100"><%=Shop.Bussiness.EX_Product.GetCount_Product("", "", "Type_id_ProductStatus = 100 and Product_id = 0")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("订单总数")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/order/default.aspx"><%=Shop.Bussiness.Order.GetCount_Order("", "", "Type_id_OrderType = 211")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("会员总数")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/user/default.aspx"><%=Shop.Bussiness.EX_User.GetCount_User("", "", "",0)%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("站内信总数")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/user/Message.aspx"><%=Shop.Bussiness.Message.GetCount_Message("", "", "")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Tag("商品评价总数")%>
                                        </td>
                                        <td>
                                            <a href="<%=site.AdminPath %>/product/Comment.aspx"><%=Shop.Bussiness.Comment.GetCount_Comment("", "", "TableName = 'Product'")%></a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
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
	
    <script src="<%=site.AdminAssetsPath %>/plugins/highcharts/highcharts.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/highcharts/exporting.js"></script>
    <script>
        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {renderTo: 'container',reflow:false,borderRadius:'0'},
                title: {text: '<%=Tag("订单统计") %>',align: 'left',x: 5,style:{font: '14px "Trebuchet MS", Verdana, sans-serif'}},
                subtitle: {text: ''},
                xAxis: {categories: [<%var i = 1;for(i=1; i<=15; i++){%>'<a href=Order/default.aspx?dateFrom=<%=System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd") %>&dateTo=<%=System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd") %>><%=System.DateTime.Now.AddDays(-15+i).Month.ToString()%>-<%=System.DateTime.Now.AddDays(-15+i).Day.ToString()%></a>'<%if (i <15){Response.Write(", ");} %><%} %>],lineWidth:1},
                yAxis: {min: 0,title: {text: ''},lineWidth:1},
                legend: {align: 'center',verticalAlign: 'bottom',borderWidth:0},
                tooltip: {},
                plotOptions: {column: {pointPadding: 1,borderWidth: 0}},
                series: [
                {name: '<%=Tag("未确认") %>',data: [<%for(i=1; i<=15; i++){%><%=FormatMoney(Shop.Bussiness.Order.GetMoney_Order(System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),"Type_id_OrderType = 211 and IsVerified = 0 and IsInvalid = 0"),"Number") %><%if (i <15){Response.Write(", ");} %><%} %>]},
                {name: '<%=Tag("未支付") %>',data: [<%for(i=1; i<=15; i++){%><%=FormatMoney(Shop.Bussiness.Order.GetMoney_Order(System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),"Type_id_OrderType = 211 and IsPaid = 0"),"Number") %><%if (i <15){Response.Write(", ");} %><%} %>]},
                {name: '<%=Tag("已支付") %>',data: [<%for(i=1; i<=15; i++){%><%=FormatMoney(Shop.Bussiness.Order.GetMoney_Order(System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),"Type_id_OrderType = 211 and IsVerified = 1 and IsPaid = 1 and IsInvalid = 0"),"Number") %><%if (i <15){Response.Write(", ");} %><%} %>]},
                {name: '<%=Tag("未发货") %>',data: [<%for(i=1; i<=15; i++){%><%=FormatMoney(Shop.Bussiness.Order.GetMoney_Order(System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),"Type_id_OrderType = 211 and IsVerified = 1 and IsShipped = 0 and IsInvalid = 0"),"Number") %><%if (i <15){Response.Write(", ");} %><%} %>]},
                {name: '<%=Tag("已发货") %>',data: [<%for(i=1; i<=15; i++){%><%=FormatMoney(Shop.Bussiness.Order.GetMoney_Order(System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),"Type_id_OrderType = 211 and IsVerified = 1 and IsShipped = 1"),"Number") %><%if (i <15){Response.Write(", ");} %><%} %>]},
                {name: '<%=Tag("已收货") %>',data: [<%for(i=1; i<=15; i++){%><%=FormatMoney(Shop.Bussiness.Order.GetMoney_Order(System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),"Type_id_OrderType = 211 and IsVerified = 1 and IsReceived = 1 and IsInvalid = 0"),"Number") %><%if (i <15){Response.Write(", ");} %><%} %>]},
                {name: '<%=Tag("已完成") %>',data: [<%for(i=1; i<=15; i++){%><%=FormatMoney(Shop.Bussiness.Order.GetMoney_Order(System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),System.DateTime.Now.AddDays(-15+i).ToString("yyyy-MM-dd"),"Type_id_OrderType = 211 and IsVerified = 1 and IsCompleted = 1"),"Number") %><%if (i <15){Response.Write(", ");} %><%} %>]}]
            });
        });
        function NewEvent() {
            GetNewEvent();
            setTimeout(function () { NewEvent(); },<%=SYS.NewEventTimes %>);
        }
        function PlayAudio() {
        <%if (config.NewEventPlayAudio == "1") {%>
                $('#sound').html('<audio autoplay="autoplay"><source src="<%=site.AdminAssetsPath %>/images/msg.mp3" type="audio/mpeg"><source src="<%=site.AdminAssetsPath %>/images/msg.wav" type="audio/wav"></audio>');
        <%}%>
        }
        NewEvent();
        setTimeout(function () { NewEvent(); },<%=LeftNewEventTimes %>);
    </script>

</body>
</html>