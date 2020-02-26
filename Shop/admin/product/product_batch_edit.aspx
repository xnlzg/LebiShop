<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_batch_edit" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("批量修改")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link href="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/lightbox/css/lightbox.min.css" rel="stylesheet" />


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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("批量修改")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/product/"><%=Tag("商品列表")%></a></li>
        <li class="breadcrumb-item active"><%=Tag("批量修改")%></li>
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
                        <button class="btn btn-success" onclick="Update()"><i class="ti-check"></i> <%=Tag("保存")%></button>
                        <button class="btn btn-default" onclick="Product_Status_Edit_muti(1);"><i class="ti-arrow-up"></i> <%=Tag("上架")%></button>
                        <button class="btn btn-default" onclick="Product_Status_Edit_muti(0);"><i class="ti-arrow-down"></i> <%=Tag("下架")%></button>
                        <%}%>
                    </div>
                    <div class="col-md-3 m-b-10">
                        <div class="input-group">
                            <input type="text" id="key" name="key" value="<%=key %>" class="form-control" onkeydown="if(event.keyCode==13){search_();}">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-primary" onclick="search_();"><i class="ti-search"></i></button>
                                <button class="btn btn-default" data-toggle="modal" data-target="#SearchModal"><i class="ti-filter"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive sorttable">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr>
                                <th width="40" class="selectAll">
                                    <a href="javascript:void(0);" onclick="$('input[name=\'sonproductid\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a>
                                </th>
                                <th>
                                    <%=Tag("图片")%>
                                </th>
                                <th style="width:7%">
                                    <%=Tag("编号")%>
                                </th>
                                <th>
                                    <%=Tag("商品名称")%>
                                </th>
                                <th style="width:7%" onclick="OrderBy('<%=OrderByName(OrderBy,"Price_MarketDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"Price_MarketDesc","icon")%>"><%=Tag("市场价")%></div>
                                </th>
                                <th style="width:7%" onclick="OrderBy('<%=OrderByName(OrderBy,"PriceDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"PriceDesc","icon")%>"><%=Tag("销售价")%></div>
                                </th>
                                <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
                                <th style="width:7%" onclick="OrderBy('<%=OrderByName(OrderBy,"Price_CostDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"Price_CostDesc","icon")%>"><%=Tag("成本价")%></div>
                                </th>
                                <%} %>
                                <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_product_price")){ %>
                                <%foreach(DB.LebiShop.Lebi_UserLevel ul in userlevels){ %>
                                <th>
                                    <%=Lang(ul.Name) %>
                                </th>
                                <%} %>
                                <%}%>
                                <%if (!IsEditStock){ %>
                                <th style="width:7%" onclick="OrderBy('<%=OrderByName(OrderBy,"CountDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"CountDesc","icon")%>"><%=Tag("库存")%></div>
                                </th>
                                <%}%>
                                <th style="width:7%" onclick="OrderBy('<%=OrderByName(OrderBy,"FreezeDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"FreezeDesc","icon")%>"><%=Tag("冻结库存")%></div>
                                </th>
                                <th style="width:7%" onclick="OrderBy('<%=OrderByName(OrderBy,"SalesDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"SalesDesc","icon")%>"><%=Tag("销量")%></div>
                                </th>
                                <th style="width:7%" onclick="OrderBy('<%=OrderByName(OrderBy,"ViewsDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"ViewsDesc","icon")%>"><%=Tag("浏览量")%></div>
                                </th>
                                <th style="width:7%" onclick="OrderBy('<%=OrderByName(OrderBy,"SortDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"SortDesc","icon")%>"><%=Tag("排序")%></div>
                                </th>
                                <th style="width:10%" onclick="OrderBy('<%=OrderByName(OrderBy,"StatusDesc")%>');">
                                    <div class="th-inner sort <%=OrderByName(OrderBy,"StatusDesc","icon")%>"><%=Tag("状态")%></div>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%foreach (DB.LebiShop.Lebi_Product model in models){
                            List<Shop.Model.ProductUserLevelPrice> ulps = Shop.Bussiness.EX_Product.UserLevelPrice(model.UserLevelPrice);
                            %>
                                <tr>
                                    <td>
                                        <label class="custom-control custom-checkbox">
                                            <input type="checkbox" id="checkbox<%=model.id %>" name="sonproductid" value="<%=model.id %>" class="custom-control-input" ShopKeyID="true">
                                            <span class="custom-control-label"></span>
                                        </label>
                                        <input type="hidden" name="IDS" shop="true" value="<%=model.id %>" />
                                    </td>
                                    <td>
                                        <a href="<%=Image(model.ImageOriginal,"big") %>" data-lightbox="image<%=model.id %>"><img style="height: 30px;width: 30px;vertical-align:middle" src="<%=Image(model.ImageOriginal,50,50) %>" /></a>
                                    </td>
                                    <td>
                                        <input type="text" id="Number<%=model.id %>" name="Number<%=model.id %>" value="<%=model.Number%>" class="form-control form-control-sm" shop="true">
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <%int i = 0; foreach (DB.LebiShop.Lebi_Language_Code batchlang in Shop.Bussiness.Language.Languages())
                                            {%><input type="<%if (lang == batchlang.Code){%>text<%}else{ %>hidden<%} %>" id="Name<%=batchlang.Code %><%=model.id %>" name="Name<%=model.id %><%=batchlang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name, batchlang.Code)%>" class="form-control form-control-sm" shop="true"><%i = i+1;
                                            } %>
                                            <div class="input-group-append">
                                                <span class="input-group-text" onclick="Product_Name_Edit(<%=model.id %>);" style="cursor:pointer"><i class="ti-pencil-alt"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="text" id="Price_Market<%=model.id %>" name="Price_Market<%=model.id %>" value="<%=FormatMoney(model.Price_Market," Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                    </td>
                                    <td>
                                        <input type="text" id="Price<%=model.id %>" name="Price<%=model.id %>" value="<%=FormatMoney(model.Price,"Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                    </td>
                                    <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
                                    <td>
                                        <input type="text" id="Price_Cost<%=model.id %>" name="Price_Cost<%=model.id %>" value="<%=FormatMoney(model.Price_Cost,"Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                    </td>
                                    <%} %>
                                    <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_product_price")){ %>
                                    <%foreach(DB.LebiShop.Lebi_UserLevel ul in userlevels){ %>
                                    <td>
                                        <input type="text" id="UserLevelPrice<%=model.id %>_<%=ul.id %>" name="UserLevelPrice<%=model.id %>_<%=ul.id %>" value="<%=FormatMoney(GetUserLevelPrice(ulps,ul.id),"Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                    </td>
                                    <%} %>
                                    <%} %>
                                    <%if (!IsEditStock){ %>
                                    <td>
                                        <%if (CountSon(model.id) == 0){ %>
                                        <input type="text" id="Count_Stock<%=model.id %>" name="Count_Stock<%=model.id %>" value="<%=model.Count_Stock %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                        <%}else{ %>
                                        <input type="hidden" id="Count_Stock<%=model.id %>" name="Count_Stock<%=model.id %>" value="<%=model.Count_Stock %>" shop="true"><%=model.Count_Stock %>
                                        <%} %>
                                    </td>
                                    <%}%>
                                    <td>
                                        <input type="text" id="Count_Freeze<%=model.id %>" name="Count_Freeze<%=model.id %>" value="<%=model.Count_Freeze %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                    </td>
                                    <td>
                                        <input type="text" id="Count_Sales_Show<%=model.id %>" name="Count_Sales_Show<%=model.id %>" value="<%=model.Count_Sales_Show %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                    </td>
                                    <td>
                                        <input type="text" id="Count_Views_Show<%=model.id %>" name="Count_Views_Show<%=model.id %>" value="<%=model.Count_Views_Show %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                    </td>
                                    <td>
                                        <input type="text" id="Sort<%=model.id %>" name="Sort<%=model.id %>" value="<%=model.Sort %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                                    </td>
                                    <td>
                                        <select id="ProductStatus<%=model.id %>" name="ProductStatus<%=model.id %>" class="form-control form-control-sm" shop="true">
                                            <%=Shop.Bussiness.EX_Type.TypeOption("ProductStatus", model.Type_id_ProductStatus, CurrentLanguage)%>
                                        </select>
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
    <div class="modal fade" id="SearchModal" tabindex="-1" role="dialog" aria-labelledby="SearchModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><%=Tag("高级搜索")%></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <select id="lang" name="lang" class="form-control">
                                <option value=""><%=Tag("语言")%></option>
                                <%=Shop.Bussiness.Language.LanguageOption(lang) %>
                            </select>
                        </div>
                        <div class="form-group">
                            <select id="status" name="status" class="form-control">
                                <option value="0"><%=Tag("状态")%></option>
                                <%=Shop.Bussiness.EX_Type.TypeOption("ProductStatus", status, CurrentLanguage)%>
                            </select>
                        </div>
                        <div class="form-group">
                            <select id="Type_id_ProductType" name="Type_id_ProductType" class="form-control">
                                <option value="320"><%=Tag("商品类型")%></option>
                                <%=Shop.Bussiness.EX_Type.TypeOption("ProductType", Type_id_ProductType, CurrentLanguage)%>
                            </select>
                        </div>
                        <div class="form-group">
                            <select id="Pro_Type_id" name="Pro_Type_id" class="form-control">
                                <option value=""><%=Tag("全部类别")%></option>
                                <%=Shop.Bussiness.EX_Product.TypeOption(0,Pro_Type_id,0,CurrentLanguage.Code,Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
                            </select>
                        </div>
                        <div class="form-group">
                            <select id="brand" name="brand" class="form-control">
                                <option value="0"><%=Tag("商品品牌")%></option>
                                <%=Shop.Bussiness.EX_Product.BrandOption(brand, CurrentLanguage.Code)%>
                            </select>
                        </div>
                        <div class="form-group">
                            <select id="tag" name="tag" class="form-control">
                                <option value="0"><%=Tag("商品标签")%></option>
                                <%=Shop.Bussiness.EX_Product.Pro_TagOption(tag, CurrentLanguage.Code)%>
                            </select>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <input type="text" name="daterange" id="daterange" class="form-control">
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <span class="ti-calendar"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="text" id="key" name="key" class="form-control" value="<%=key %>" onkeydown="if(event.keyCode==13){modal_search_();}">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
                    <button type="button" class="btn btn-success" onclick="modal_search_();"><i class="ti-search"></i> <%=Tag("搜索")%></button>
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
	
    <script src="<%=site.AdminAssetsPath %>/plugins/lightbox/lightbox.min.js"></script>
    
<script src="<%=site.AdminAssetsPath %>/plugins/moment/moment.js"></script>
<script src="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.js"></script>
<script>
    $('#daterange').daterangepicker({
        startDate: '<%if (dateFrom !=""){%><%=dateFrom%><%}else{%><%=FormatDate(System.DateTime.Now)%><%}%>',
        endDate: '<%if (dateTo !=""){%><%=dateTo%><%}else{%><%=FormatDate(System.DateTime.Now)%><%}%>',
        autoUpdateInput: true,
        ranges: {
            '<%=Tag("今日")%>': [moment(), moment()],
            '<%=Tag("昨日")%>': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '<%=Tag("最近7日")%>': [moment().subtract(6, 'days'), moment()],
            '<%=Tag("最近30日")%>': [moment().subtract(29, 'days'), moment()],
            '<%=Tag("本月")%>': [moment().startOf('month'), moment().endOf('month')],
            '<%=Tag("上个月")%>': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        locale: {
            format: 'YYYY-MM-DD',
            applyLabel: '<%=Tag("确定")%>',
            cancelLabel: '<%=Tag("取消")%>',
            startLabel: '<%=Tag("开始日期")%>',
            endLabel: '<%=Tag("结束日期")%>',
            customRangeLabel: '<%=Tag("自定义")%>',
            firstDay: 1
        }
    });
</script>

    <script>
        function search_() {
            var key = $("#key").val();
            window.location = "?key=" + escape(key) + "&OrderBy=<%=OrderBy%>";
        }
        function modal_search_() {
            $("#SearchModal").modal("hide");
            var lang = $("#lang").val();
            var key = $("#key").val();
            var brand = $("#brand").val();
            var Pro_Type_id = $("#Pro_Type_id").val();
            var tag = $("#tag").val();
            var dateFrom = $("#dateFrom").val();
            var dateTo = $("#dateTo").val();
            var status = $("#status").val();
            var Type_id_ProductType = $("#Type_id_ProductType").val();
            window.location = "?key=" + escape(key) + "&brand=" + brand + "&tag=" + tag + "&Pro_Type_id=" + Pro_Type_id + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&status=" + status + "&lang=" + lang + "&Type_id_ProductType=" + Type_id_ProductType + "&OrderBy=<%=OrderBy%>";
        }
        function Update() {
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Batch_Update";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function Product_Name_Edit(id) {
            var lang = $("#lang").val();
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_name_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id, removelang: lang },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function OrderBy(url) {
            MsgBox(4, "<%=Tag("正在排序，请稍后")%> ……", url);
        }
        function Product_Status_Edit_muti(status) {
            var postData = GetFormJsonData("ShopKeyID");
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Status_Edit_muti&status=" + status;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
    </script>

</body>
</html>