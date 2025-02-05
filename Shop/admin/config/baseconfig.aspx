﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.BaseConfig_edit" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("基本设置") %>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("基本设置")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item active"><%=Tag("基本设置")%></li>
    </ol>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <div class="col-12">
        <div class="card">
            <div class="col-md-12 m-t-15">
                <ul class="nav nav-tabs customtab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" href="#info" role="tab"><%=Tag("基本设置")%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#tax" role="tab"><%=Tag("退税设置")%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#code" role="tab"><%=Tag("验证码")%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#check" role="tab"><%=Tag("文章审核")%></a>
                    </li>
                </ul>
            </div>
            <div class="card-body">
                <form action="javascript:SaveObj();" novalidate>
                    <div class="form-group">
                        <label for="BillFlag_1"><%=Tag("开启发票")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="BillFlag_1" name="BillFlag" value="1" class="custom-control-input" shop="true" <%=model.BillFlag=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="BillFlag_0" name="BillFlag" value="0" class="custom-control-input" shop="true" <%=model.BillFlag=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsAnonymousUser_1"><%=Tag("匿名购买")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsAnonymousUser_1" name="IsAnonymousUser" value="1" class="custom-control-input" shop="true" <%=model.IsAnonymousUser=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsAnonymousUser_0" name="IsAnonymousUser" value="0" class="custom-control-input" shop="true" <%=model.IsAnonymousUser=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsBasketAction_1"><%=Tag("购物车提示页")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsBasketAction_1" name="IsBasketAction" value="1" class="custom-control-input" shop="true" <%=model.IsBasketAction=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsBasketAction_0" name="IsBasketAction" value="0" class="custom-control-input" shop="true" <%=model.IsBasketAction=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsReduceBasketStep_1"><%=Tag("减少购物车步骤")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsReduceBasketStep_1" name="IsReduceBasketStep" value="1" class="custom-control-input" shop="true" <%=model.IsReduceBasketStep=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsReduceBasketStep_0" name="IsReduceBasketStep" value="0" class="custom-control-input" shop="true" <%=model.IsReduceBasketStep=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsNullStockDown_1"><%=Tag("0库存自动下架")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsNullStockDown_1" name="IsNullStockDown" value="1" class="custom-control-input" shop="true" <%=model.IsNullStockDown=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsNullStockDown_0" name="IsNullStockDown" value="0" class="custom-control-input" shop="true" <%=model.IsNullStockDown=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsNullStockSale_1"><%=Tag("允许负库存销售")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsNullStockSale_1" name="IsNullStockSale" value="1" class="custom-control-input" shop="true" <%=model.IsNullStockSale=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsNullStockSale_0" name="IsNullStockSale" value="0" class="custom-control-input" shop="true" <%=model.IsNullStockSale=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ProductStockFreezeTime_1"><%=Tag("冻结库存时机")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="ProductStockFreezeTime_1" name="ProductStockFreezeTime" value="orderadd" class="custom-control-input" shop="true" <%=model.ProductStockFreezeTime=="orderadd"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("下单")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="ProductStockFreezeTime_0" name="ProductStockFreezeTime" value="orderconfirm" class="custom-control-input" shop="true" <%=model.ProductStockFreezeTime=="orderconfirm"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("确认订单")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsOpenPaidOrderConfirm_1"><%=Tag("已付款订单自动确认")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsOpenPaidOrderConfirm_1" name="IsOpenPaidOrderConfirm" value="1" class="custom-control-input" shop="true" <%=model.IsOpenPaidOrderConfirm=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsOpenPaidOrderConfirm_0" name="IsOpenPaidOrderConfirm" value="0" class="custom-control-input" shop="true" <%=model.IsOpenPaidOrderConfirm=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsPointToMoney_1"><%=Tag("积分兑换余额")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsPointToMoney_1" name="IsPointToMoney" value="1" class="custom-control-input" shop="true" <%=model.IsPointToMoney=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsPointToMoney_0" name="IsPointToMoney" value="0" class="custom-control-input" shop="true" <%=model.IsPointToMoney=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsClosetuihuo_1"><%=Tag("开启退换货")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsClosetuihuo_1" name="IsClosetuihuo" value="1" class="custom-control-input" shop="true" <%=model.IsClosetuihuo=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsClosetuihuo_0" name="IsClosetuihuo" value="0" class="custom-control-input" shop="true" <%=model.IsClosetuihuo=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsSupplierCash_1"><%=Tag("开启供应商收款")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsSupplierCash_1" name="IsSupplierCash" value="1" class="custom-control-input" shop="true" <%=model.IsSupplierCash=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsSupplierCash_0" name="IsSupplierCash" value="0" class="custom-control-input" shop="true" <%=model.IsSupplierCash=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsMutiCurrencyShow_1"><%=Tag("前台多币种展示金额")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsMutiCurrencyShow_1" name="IsMutiCurrencyShow" value="1" class="custom-control-input" shop="true" <%=model.IsMutiCurrencyShow=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsMutiCurrencyShow_0" name="IsMutiCurrencyShow" value="0" class="custom-control-input" shop="true" <%=model.IsMutiCurrencyShow=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsOpenUserEnd_1"><%=Tag("开启会员有效期")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsOpenUserEnd_1" name="IsOpenUserEnd" value="1" class="custom-control-input" shop="true" <%=model.IsOpenUserEnd=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsOpenUserEnd_0" name="IsOpenUserEnd" value="0" class="custom-control-input" shop="true" <%=model.IsOpenUserEnd=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                            <div class="input-group">
                                <input type="text" id="DefaultUserEndDays" name="DefaultUserEndDays" value="<%=model.DefaultUserEndDays %>" placeholder="<%=Tag(" 默认有效期天数")%>" class="form-control" style="width:70px;" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                                <div class="input-group-append">
                                    <span class="input-group-text"><%=Tag("天")%></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_productlimit")){%>
                    <div class="form-group">
                        <label for="ProductLimitType_1"><%=Tag("商品权限设置")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="ProductLimitType_1" name="ProductLimitType" value="1" class="custom-control-input" shop="true" <%=model.ProductLimitType=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("选中表示允许")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="ProductLimitType_0" name="ProductLimitType" value="0" class="custom-control-input" shop="true" <%=model.ProductLimitType=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("选中表示拒绝")%></span>
                            </label>
                        </div>
                    </div>
                    <%}%>
                    <div class="form-group">
                        <label for="UserRegCheckedType_1"><%=Tag("会员注册验证类型")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="UserRegCheckedType_1" name="UserRegCheckedType" value="mobilephone" class="custom-control-input" shop="true" <%=model.UserRegCheckedType.Contains("mobilephone")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("手机")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="UserRegCheckedType_0" name="UserRegCheckedType" value="email" class="custom-control-input" shop="true" <%=model.UserRegCheckedType.Contains("email")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("Email")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsMobilePhoneMutiReg_1"><%=Tag("同手机号多次注册")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsMobilePhoneMutiReg_1" name="IsMobilePhoneMutiReg" value="1" class="custom-control-input" shop="true" <%=model.IsMobilePhoneMutiReg=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsMobilePhoneMutiReg_0" name="IsMobilePhoneMutiReg" value="0" class="custom-control-input" shop="true" <%=model.IsMobilePhoneMutiReg=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                        <small class="form-text text-muted"><%=Tag("开启手机短信注册验证时有效")%></small>
                    </div>
                    <div class="form-group">
                        <label for="WM_PicPath"><%=Tag("商品编号规则")%>：</label>
                        <div class="row">
                            <div class="col-sm-6">
                                <label for="ProductNumberPrefix"><%=Tag("前缀")%>：</label>
                                <div class="input-group">
                                    <input type="text" id="ProductNumberPrefix" name="ProductNumberPrefix" value="<%=model.ProductNumberPrefix%>" class="form-control" shop="true">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label for="ProductNumberLength"><%=Tag("长度")%>：</label>
                                <div class="input-group">
                                    <input type="text" id="ProductNumberLength" name="ProductNumberLength" value="<%=model.ProductNumberLength%>" class="form-control" shop="true">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ClickFlag_0"><%=Tag("点击数假象规律")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio col-6">
                                <input type="radio" id="ClickFlag_0" name="ClickFlag" value="0" class="custom-control-input" shop="true" <%=model.ClickFlag=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("增加固定数字")%></span>
                                <input type="text" id="ClickNum1" name="ClickNum1" value="<%=model.ClickNum1%>" class="form-control" shop="true" onkeyup="setCount2(this);">
                                <small class="form-text text-muted"><%=Tag("填写1-50之间的数字")%></small>
                            </label>
                            <label class="custom-control custom-radio col-6">
                                <input type="radio" id="ClickFlag_1" name="ClickFlag" value="0" class="custom-control-input" shop="true" <%=model.ClickFlag=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("增加随机数字")%></span>
                                <input type="text" id="ClickNum2" name="ClickNum2" value="<%=model.ClickNum2%>" class="form-control" shop="true" onkeyup="setCount2(this);">
                                <small class="form-text text-muted"><%=Tag("随机生成数字的最大值，最大值设定为50")%></small>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="SalesFlag_0"><%=Tag("销售数假象规律")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio col-6">
                                <input type="radio" id="SalesFlag_0" name="SalesFlag" value="0" class="custom-control-input" shop="true" <%=model.SalesFlag=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("增加固定数字")%></span>
                                <input type="text" id="SalesNum1" name="SalesNum1" value="<%=model.SalesNum1%>" class="form-control" shop="true" onkeyup="setCount2(this);">
                                <small class="form-text text-muted"><%=Tag("填写1-50之间的数字")%></small>
                            </label>
                            <label class="custom-control custom-radio col-6">
                                <input type="radio" id="SalesFlag_1" name="SalesFlag" value="0" class="custom-control-input" shop="true" <%=model.SalesFlag=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("增加随机数字")%></span>
                                <input type="text" id="SalesNum2" name="SalesNum2" value="<%=model.SalesNum2%>" class="form-control" shop="true" onkeyup="setCount2(this);">
                                <small class="form-text text-muted"><%=Tag("随机生成数字的最大值，最大值设定为50")%></small>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="TaxRate"><%=Tag("消费税")%>：</label>
                        <div class="input-group">
                            <input type="text" id="TaxRate" name="TaxRate" value="<%=model.TaxRate %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                            <div class="input-group-append">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="TakeMoneyLimit"><%=Tag("最低提现金额")%>：</label>
                        <div class="input-group">
                            <input type="text" id="TakeMoneyLimit" name="TakeMoneyLimit" value="<%=model.TakeMoneyLimit %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                            <div class="input-group-append">
                                <span class="input-group-text"><%=DefaultCurrency.Msige %></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="WithdrawalFeeRate"><%=Tag("提现手续费")%>：</label>
                        <div class="input-group">
                            <input type="text" id="WithdrawalFeeRate" name="WithdrawalFeeRate" value="<%=model.WithdrawalFeeRate %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                            <div class="input-group-append">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="CommentPoint"><%=Tag("商品评分奖励积分")%>：</label>
                        <input type="text" id="CommentPoint" name="CommentPoint" value="<%=model.CommentPoint %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'');">
                    </div>
                    <div class="form-group">
                        <label for="OrderReceivedDays"><%=Tag("订单自动收货")%>：</label>
                        <div class="input-group">
                            <input type="text" id="OrderReceivedDays" name="OrderReceivedDays" value="<%=model.OrderReceivedDays %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                            <div class="input-group-append">
                                <span class="input-group-text"><%=Tag("天")%></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="OrderCompleteDays"><%=Tag("订单自动完结")%>：</label>
                        <div class="input-group">
                            <input type="text" id="OrderCompleteDays" name="OrderCompleteDays" value="<%=model.OrderCompleteDays %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                            <div class="input-group-append">
                                <span class="input-group-text"><%=Tag("天")%></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IntOrderMoney_1"><%=Tag("订单金额整数")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IntOrderMoney_1" name="IntOrderMoney" value="1" class="custom-control-input" shop="true" <%=model.IntOrderMoney=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IntOrderMoney_0" name="IntOrderMoney" value="0" class="custom-control-input" shop="true" <%=model.IntOrderMoney=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="UpLoadLimit"><%=Tag("文件上传限制")%>：</label>
                        <div class="input-group">
                            <input type="text" id="UpLoadLimit" name="UpLoadLimit" value="<%=model.UpLoadLimit %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                            <div class="input-group-append">
                                <span class="input-group-text">MB</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="UpLoadPath"><%=Tag("文件上传路径")%>：</label>
                        <input type="text" id="UpLoadPath" name="UpLoadPath" value="<%=model.UpLoadPath %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="UpLoadRName"><%=Tag("文件上传前缀")%>：</label>
                        <input type="text" id="UpLoadRName" name="UpLoadRName" value="<%=model.UpLoadRName %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="UpLoadSaveName_1"><%=Tag("文件上传命名")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="UpLoadSaveName_1" name="UpLoadSaveName" value="1" class="custom-control-input" shop="true" <%=model.UpLoadSaveName=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("保持原名")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="UpLoadSaveName_0" name="UpLoadSaveName" value="0" class="custom-control-input" shop="true" <%=model.UpLoadSaveName=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("当前时间")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="AdminLanguages"><%=Tag("后台使用语言")%>：</label>
                        <input type="text" id="AdminLanguages" name="AdminLanguages" value="<%=model.AdminLanguages %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="Filter"><%=Tag("非法词过滤")%>：</label>
                        <textarea id="Filter" name="Filter" rows="6" class="form-control" style="height:60px;" shop="true"><%=model.Filter%></textarea>
                        <small class="form-text text-muted"><%=Tag("多个词用/隔开")%></small>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Filter',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Filter',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="APIPassWord"><%=Tag("API密码")%>：</label>
                        <input type="text" id="APIPassWord" name="APIPassWord" value="<%=model.APIPassWord %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="IsAllowOutSideAjax_1"><%=Tag("允许站外AJAX请求")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsAllowOutSideAjax_1" name="IsAllowOutSideAjax" value="1" class="custom-control-input" shop="true" <%=model.IsAllowOutSideAjax=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsAllowOutSideAjax_0" name="IsAllowOutSideAjax" value="0" class="custom-control-input" shop="true" <%=model.IsAllowOutSideAjax=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="SafeIPs"><%=Tag("信任IP")%>：</label>
                        <textarea id="SafeIPs" name="SafeIPs" rows="6" class="form-control" style="height:60px;" shop="true"><%=model.SafeIPs%></textarea>
                        <small class="form-text text-muted"><%=Tag("多个词用,隔开")%></small>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('SafeIPs',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('SafeIPs',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="NewEventTimes"><%=Tag("新事件刷新时间")%>：</label>
                        <div class="input-group">
                            <input type="text" id="NewEventTimes" name="NewEventTimes" value="<%=model.NewEventTimes %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                            <div class="input-group-append">
                                <span class="input-group-text"><%=Tag("毫秒")%></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="NewEventPlayAudio_1"><%=Tag("新事件播放声音")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="NewEventPlayAudio_1" name="NewEventPlayAudio" value="1" class="custom-control-input" shop="true" <%=model.NewEventPlayAudio=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="NewEventPlayAudio_0" name="NewEventPlayAudio" value="0" class="custom-control-input" shop="true" <%=model.NewEventPlayAudio=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="HTTPServer_1"><%=Tag("网页传输")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="HTTPServer_1" name="HTTPServer" value="http" class="custom-control-input" shop="true" <%=model.HTTPServer=="http"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("不加密")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="HTTPServer_0" name="HTTPServer" value="https" class="custom-control-input" shop="true" <%=model.HTTPServer=="https"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("加密")%></span>
                            </label>
                        </div>
                    </div>
                    <a name="tax"></a>
                    <h5 class="box-title m-t-20"><%=Tag("退税设置")%></h5>
                    <div class="form-group">
                        <label for="Refund_MinMoney"><%=Tag("最低购物总额")%>：</label>
                        <input type="text" id="Refund_MinMoney" name="Refund_MinMoney" value="<%=model.Refund_MinMoney %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                    </div>
                    <div class="form-group">
                        <label for="Refund_VAT"><%=Tag("增值税率")%>：</label>
                        <div class="input-group">
                            <input type="text" id="Refund_VAT" name="Refund_VAT" value="<%=model.Refund_VAT %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                            <div class="input-group-append">
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Refund_VAT"><%=Tag("函数率")%>：</label>
                        <div class="input-group">
                            <div class="table-responsive">
                                <table class="table table-hover no-wrap stepRtable" id="stepRtable">
                                    <thead>
                                        <tr>
                                            <th style="width:30%;">
                                                <%=Tag("购物总额")%> >
                                            </th>
                                            <th style="width:30%;">
                                                <%=Tag("函数率")%>
                                            </th>
                                            <th>
                                                <%=Tag("操作")%> [<a href="javascript:addstepR();"><%=Tag("增加")%></a>]
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%foreach(Shop.Model.BaseConfigStepR stepR in stepRs){ %>
                                        <tr>
                                            <td>
                                                <input type="text" name="Refund_Step_S" value="<%=stepR.S %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                                            </td>
                                            <td>
                                                <input type="text" name="Refund_Step_R" value="<%=stepR.R %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^.\d]/g,'')">
                                            </td>
                                            <td>
                                                <a href="javascript:void(0);" onclick="$(this).parent().parent().remove();"><%=Tag("删除")%></a>
                                            </td>
                                        </tr>
                                        <%} %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <a name="code"></a>
                    <h5 class="box-title m-t-20"><%=Tag("验证码")%></h5>
                    <div class="form-group">
                        <label for="Verifycode_UserRegister_1"><%=Tag("会员注册")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="Verifycode_UserRegister_1" name="Verifycode_UserRegister" value="1" class="custom-control-input" shop="true" <%=model.Verifycode_UserRegister=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="Verifycode_UserRegistero_0" name="Verifycode_UserRegister" value="0" class="custom-control-input" shop="true" <%=model.Verifycode_UserRegister=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Verifycode_UserLogin_1"><%=Tag("会员登录")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="Verifycode_UserLogin_1" name="Verifycode_UserLogin" value="1" class="custom-control-input" shop="true" <%=model.Verifycode_UserLogin=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="Verifycode_UserLogin_0" name="Verifycode_UserLogin" value="0" class="custom-control-input" shop="true" <%=model.Verifycode_UserLogin=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Verifycode_ForgetPassword_1"><%=Tag("忘记密码")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="Verifycode_ForgetPassword_1" name="Verifycode_ForgetPassword" value="1" class="custom-control-input" shop="true" <%=model.Verifycode_ForgetPassword=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="Verifycode_ForgetPassword_0" name="Verifycode_ForgetPassword" value="0" class="custom-control-input" shop="true" <%=model.Verifycode_ForgetPassword=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Verifycode_SupplierRegister_1"><%=Tag("商家注册")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="Verifycode_SupplierRegister_1" name="Verifycode_SupplierRegister" value="1" class="custom-control-input" shop="true" <%=model.Verifycode_SupplierRegister=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="Verifycode_SupplierRegister_0" name="Verifycode_SupplierRegister" value="0" class="custom-control-input" shop="true" <%=model.Verifycode_SupplierRegister=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Verifycode_SupplierLogin_1"><%=Tag("商家登录")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="Verifycode_SupplierLogin_1" name="Verifycode_SupplierLogin" value="1" class="custom-control-input" shop="true" <%=model.Verifycode_SupplierLogin=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="Verifycode_SupplierLogin_0" name="Verifycode_SupplierLogin" value="0" class="custom-control-input" shop="true" <%=model.Verifycode_SupplierLogin=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Verifycode_AdminLogin_1"><%=Tag("管理登陆")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="Verifycode_AdminLogin_1" name="Verifycode_AdminLogin" value="1" class="custom-control-input" shop="true" <%=model.Verifycode_AdminLogin=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="Verifycode_AdminLogin_0" name="Verifycode_AdminLogin" value="0" class="custom-control-input" shop="true" <%=model.Verifycode_AdminLogin=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
                        </div>
                    </div>
                    <a name="check"></a>
                    <h5 class="box-title m-t-20"><%=Tag("文章审核")%></h5>
                    <div class="form-group">
                        <label for="CommFlag_1"><%=Tag("评论")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="CommFlag_1" name="CommFlag" value="1" class="custom-control-input" shop="true" <%=model.CommFlag=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("开启")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="CommFlag_0" name="CommFlag" value="0" class="custom-control-input" shop="true" <%=model.CommFlag=="0"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("关闭")%></span>
                            </label>
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
	
    <script>
        function SaveObj() {
            var postData = GetFormJsonData("shop");
            var url="<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=BaseConfig_Edit";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
        function addstepR()
        {
            var row='<tr><td><input type="text" name="Refund_Step_S" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\\d]/g,\'\')"></td>';
            row+='<td><input type="text" name="Refund_Step_R" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^.\\d]/g,\'\')"></td>';
            row+='<td><a href="javascript:void(0);" onclick="$(this).parent().parent().remove();"><%=Tag("删除")%></a></td></tr>';
            $("#stepRtable").append(row);
        }
        function setCount2(entity) {
            var gnum = parseInt(entity.value);
            var sumc = 50;
            if (isNaN(gnum)) { gnum = 1; }
            if (gnum > sumc) {
                entity.value = sumc;
            }
            else if (gnum <= 1) {
                entity.value = 1;
            } else {
                entity.value = gnum;
            }
        }
    </script>

</body>
</html>