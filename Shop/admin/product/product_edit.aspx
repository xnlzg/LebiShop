﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_Edit_Window" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title>
        <%if (model.id > 0) { Response.Write(Shop.Bussiness.Language.Content(model.Name, CurrentLanguage.Code) + "-"); } %><%=Tag("商品管理")%>-<%=site.title%>
    </title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link href="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/multiselect/css/jquery.multiselect2side.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/lightbox/css/lightbox.min.css" rel="stylesheet" />

    <script>
        var AdminPath = "<%=site.AdminPath %>";var WebPath ="<%=site.WebPath %>";var AdminImagePath = "<%=site.AdminImagePath %>";var requestPage = "<%=LB.Tools.RequestTool.GetRequestUrl().ToLower() %>";var refPage = "<%=LB.Tools.RequestTool.GetUrlReferrer().ToLower() %>";
    </script>
</head>
<body class="fix-sidebar fix-header card-no-border">
	
    <div id="main-wrapper">
        <div class="container-fluid">
            <form action="javascript:SaveObj(1);" novalidate>
                <div class="page-titles titles-flex">
                    <div class="row">
                        <div class="col-md-9 align-self-center">
                            <%if (PageReturnMsg == ""){%>
                            <%if (t == "copy"){ %>
                            <button class="btn btn-default" style="cursor:none"><i class="ti-info-alt"></i> <%=Tag("复制")%></button>
                            <%} %>
                            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                            <%}%>
                        </div>
                        <div class="closebtn col-md-3 align-self-center">
                            <div class="d-flex justify-content-end">
                                <button class="btn btn-default" onclick="window.close();"><i class="ti-close"></i> <%=Tag("关闭")%></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row with-titles-flex">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <ul class="nav nav-tabs customtab" role="tablist">
                                    <%
                                    List<DB.LebiShop.Lebi_Language_Code> nav_langs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in nav_langs){
                                    %>
                                    <li class="nav-item"> <a class="nav-link <%if (nav_langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                                    <%}%>
                                </ul>
                                <div class="tab-content m-t-20">
                                    <%
                                    int i = 0;
                                    foreach (DB.LebiShop.Lebi_Language_Code lang in nav_langs){
                                    %>
                                    <div class="tab-pane <%if (nav_langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                                        <div class="form-group">
                                            <label for="Name<%=lang.Code %>"><%=Tag("商品名称")%>：</label>
                                            <div class="input-group">
                                                <input type="text" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name,lang.Code) %>" <%if (nav_langs.FirstOrDefault().Code == lang.Code){%>required<%}%> class="form-control" shop="true">
                                                <%if (CountSon(model.id) > 0 && i == 0){ %>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdateName" name="UpdateName" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                        </div>
                                        <%if (model.id == 0 || (model.id > 0 && model.Product_id == 0)){%>
                                        <div class="form-group">
                                            <label for="Introduction<%=lang.Code %>"><%=Tag("商品简介")%>：</label>
                                            <textarea id="Introduction<%=lang.Code %>" name="Introduction<%=lang.Code %>" class="form-control" style="height:60px;" shop="true"><%=ContentImage(Shop.Bussiness.Language.Content(model.Introduction, lang.Code))%></textarea>
                                            <%if (CountSon(model.id) > 0 && i == 0){ %>
                                            <small class="form-text text-muted">
                                                <label class="custom-control custom-checkbox">
                                                    <input type="checkbox" id="UpdateIntroduction" name="UpdateIntroduction" value="1" class="custom-control-input" shop="true">
                                                    <span class="custom-control-label"><%=Tag("同步更新子商品")%></span>
                                                </label>
                                            </small>
                                            <%} %>
                                            <div class="button-group m-t-5">
                                                <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Introduction<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                                                <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Introduction<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                                            </div>
                                        </div>
                                        <%}%>
                                        <div class="form-group">
                                            <label for="Description<%=lang.Code %>"><%=Tag("详细介绍")%>：</label>
                                            <textarea id="Description<%=lang.Code %>" name="Description<%=lang.Code %>" class="form-control" style="height:60px;" shop="true"><%=ContentImage(Shop.Bussiness.Language.Content(model.Description, lang.Code))%></textarea>
                                            <%if (CountSon(model.id) > 0 && i == 0){ %>
                                            <small class="form-text text-muted">
                                                <label class="custom-control custom-checkbox">
                                                    <input type="checkbox" id="UpdateDescription" name="UpdateDescription" value="1" class="custom-control-input" shop="true">
                                                    <span class="custom-control-label"><%=Tag("同步更新子商品")%></span>
                                                </label>
                                            </small>
                                            <%} %>
                                        </div>
                                        <div class="form-group">
                                            <label for="Specification<%=lang.Code %>"><%=Tag("使用说明")%>：</label>
                                            <textarea id="Specification<%=lang.Code %>" name="Specification<%=lang.Code %>" class="form-control" style="height:60px;" shop="true"><%=ContentImage(Shop.Bussiness.Language.Content(model.Specification, lang.Code))%></textarea>
                                            <%if (CountSon(model.id) > 0 && i == 0){ %>
                                            <small class="form-text text-muted">
                                                <label class="custom-control custom-checkbox">
                                                    <input type="checkbox" id="UpdateSpecification" name="UpdateSpecification" value="1" class="custom-control-input" shop="true">
                                                    <span class="custom-control-label"><%=Tag("同步更新子商品")%></span>
                                                </label>
                                            </small>
                                            <%} %>
                                        </div>
                                        <%if (wap){ %>
                                        <div class="form-group">
                                            <label for="MobileDescription<%=lang.Code %>"><%=Tag("WAP端描述")%>：</label>
                                            <textarea id="MobileDescription<%=lang.Code %>" name="MobileDescription<%=lang.Code %>" class="form-control" style="height:60px;" shop="true"><%=ContentImage(Shop.Bussiness.Language.Content(model.MobileDescription, lang.Code))%></textarea>
                                            <%if (CountSon(model.id) > 0 && i == 0){ %>
                                            <small class="form-text text-muted">
                                                <label class="custom-control custom-checkbox">
                                                    <input type="checkbox" id="UpdateMobileDescription" name="UpdateMobileDescription" value="1" class="custom-control-input" shop="true">
                                                    <span class="custom-control-label"><%=Tag("同步更新子商品")%></span>
                                                </label>
                                            </small>
                                            <%} %>
                                        </div>
                                        <%} %>
                                        <h6 class="nav-tips m-t-20 m-b-10"><%=Tag("SEO优化")%></h6>
                                        <div class="form-group">
                                            <label for="SEO_Title<%=lang.Code %>"><%=Tag("网页标题")%>：</label>
                                            <input type="text" id="SEO_Title<%=lang.Code %>" name="SEO_Title<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.SEO_Title,lang.Code) %>" class="form-control" shop="true">
                                        </div>
                                        <div class="form-group">
                                            <label for="SEO_Keywords<%=lang.Code %>"><%=Tag("关键词")%>：</label>
                                            <input type="text" id="SEO_Keywords<%=lang.Code %>" name="SEO_Keywords<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.SEO_Keywords,lang.Code) %>" class="form-control" shop="true">
                                        </div>
                                        <div class="form-group">
                                            <label for="SEO_Description<%=lang.Code %>"><%=Tag("网页描述")%>：</label>
                                            <input type="text" id="SEO_Description<%=lang.Code %>" name="SEO_Description<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.SEO_Description,lang.Code) %>" class="form-control" shop="true">
                                        </div>
                                        <%if (CountSon(model.id) > 0 && i == 0){ %>
                                        <small class="form-text text-muted">
                                            <label class="custom-control custom-checkbox">
                                                <input type="checkbox" id="UpdateSEO" name="UpdateSEO" value="1" class="custom-control-input" shop="true">
                                                <span class="custom-control-label"><%=Tag("同步更新子商品")%></span>
                                            </label>
                                        </small>
                                        <%} %>
                                    </div>
                                    <%i++;} %>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="Count_Stock"><%=Tag("库存数量")%>：</label>
                                            <div class="input-group">
                                                <%if (IsEditStock){ %>
                                                <input type="text" id="Count_Stock" name="Count_Stock" value="<%=model.Count_Stock %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')" required>
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="ti-help" title="<%=Tag(" 组合商品库存无效")%>"></i></span>
                                                </div>
                                                <%} else { %>
                                                <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_erp")){ %>
                                                <%=Lebi.ERP.Store.ProductStockForAdmin(model) %>
                                                <%} else { %>
                                                <%=model.Count_Stock %>
                                                <%} %>
                                                <%} %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="Count_StockCaution"><%=Tag("警戒库存")%>：</label>
                                            <div class="input-group">
                                                <input type="text" id="Count_StockCaution" name="Count_StockCaution" value="<%=model.Count_StockCaution %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')" required>
                                                <%if (CountSon(model.id) > 0){%>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdateCount_StockCaution" name="UpdateCount_StockCaution" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%if (model.id > 0){%>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="Count_Freeze"><%=Tag("冻结库存")%>：</label>
                                            <div class="input-group">
                                                <input type="text" id="Count_Freeze" name="Count_Freeze" value="<%=model.Count_Freeze %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%} %>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-sm-6">
                                        <label for="Price_Market"><%=Tag("市场价")%>(<%=DefaultCurrency.Msige%>)：</label>
                                        <div class="input-group">
                                            <input type="text" id="Price_Market" name="Price_Market" value="<%=FormatMoney(model.Price_Market," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
                                            <%if (CountSon(model.id) > 0){%>
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <label class="custom-control custom-checkbox">
                                                        <input type="checkbox" id="UpdatePrice_Market" name="UpdatePrice_Market" value="1" class="custom-control-input" shop="true">
                                                        <span class="custom-control-label"><%=Tag("同步")%></span>
                                                    </label>
                                                </span>
                                            </div>
                                            <%} %>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="Price"><%=Tag("销售价")%>(<%=DefaultCurrency.Msige%>)：</label>
                                        <div class="input-group">
                                            <input type="text" id="Price" name="Price" value="<%=FormatMoney(model.Price," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
                                            <%if (CountSon(model.id) > 0){%>
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <label class="custom-control custom-checkbox">
                                                        <input type="checkbox" id="UpdatePrice" name="UpdatePrice" value="1" class="custom-control-input" shop="true">
                                                        <span class="custom-control-label"><%=Tag("同步")%></span>
                                                    </label>
                                                </span>
                                            </div>
                                            <%} %>
                                        </div>
                                    </div>
                                    <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
                                    <div class="form-group col-sm-6">
                                        <label for="Price_Cost"><%=Tag("成本价")%>(<%=DefaultCurrency.Msige%>)：</label>
                                        <div class="input-group">
                                            <input type="text" id="Price_Cost" name="Price_Cost" value="<%=FormatMoney(model.Price_Cost," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
                                            <%if (CountSon(model.id) > 0){%>
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <label class="custom-control custom-checkbox">
                                                        <input type="checkbox" id="UpdatePrice_Cost" name="UpdatePrice_Cost" value="1" class="custom-control-input" shop="true">
                                                        <span class="custom-control-label"><%=Tag("同步")%></span>
                                                    </label>
                                                </span>
                                            </div>
                                            <%} %>
                                        </div>
                                    </div>
                                    <%} %>
                                </div>
                                <div class="form-group">
                                    <label for="Images"><%=Tag("商品类型")%>：</label>
                                    <div class="input-group">
                                        <%=Shop.Bussiness.EX_Type.TypeRadio("ProductType", "Type_id_ProductType", model.Type_id_ProductType, "shop=\"true\" onclick=\"ChangeProductType();\"",CurrentLanguage.Code)%>
                                    </div>
                                    <%if (CountSon(model.id) > 0){%>
                                    <small class="form-text text-muted">
                                        <label class="custom-control custom-checkbox">
                                            <input type="checkbox" id="UpdateType_id_ProductType" name="UpdateType_id_ProductType" value="1" class="custom-control-input" shop="true">
                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                        </label>
                                    </small>
                                    <%} %>
                                </div>
                                <div id="qianggoubody">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <label for="Price_Sale" id="pricename">
                                                    <%if (model.Type_id_ProductType == 321)
                                                    { %><%=Tag("抢购价")%>(<%=DefaultCurrency.Msige%>)<%}
                                                    else if (model.Type_id_ProductType == 322)
                                                    { %>
                                                    %><%=Tag("团购价")%>(<%=DefaultCurrency.Msige%>)<%}
                                                    else if (model.Type_id_ProductType == 323)
                                                    { %>
                                                    %><%=Tag("换购积分")%><%} %>
                                                    ：
                                                </label>
                                                <div class="input-group">
                                                    <input type="text" id="Price_Sale" name="Price_Sale" value="<%=FormatMoney(model.Price_Sale," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="Count_Limit"><%=Tag("限购数量")%>：</label>
                                                <input type="text" id="Count_Limit" name="Count_Limit" value="<%=model.Count_Limit %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <label for="Time_Start"><%=Tag("开始日期")%>：</label>
                                                <input type="text" id="Time_Start" name="Time_Start" value="<%=FormatTime(model.Time_Start) %>" class="form-control" shop="true">
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="Time_Expired"><%=Tag("截止日期")%>：</label>
                                                <input type="text" id="Time_Expired" name="Time_Expired" value="<%=FormatTime(model.Time_Expired) %>" class="form-control" shop="true">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="yudingbody">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <label for="Price_reserve"><%=Tag("预定金额")%>：</label>
                                                <input type="text" id="Price_reserve" name="Price_reserve" value="<%=FormatMoney(model.Price_reserve," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="Reserve_days"><%=Tag("预定周期")%>：</label>
                                                <div class="input-group">
                                                    <input type="text" id="Reserve_days" name="Reserve_days" value="<%=model.Reserve_days%>" class="form-control" shop="true">
                                                    <div class="input-group-append">
                                                        <span class="input-group-text"><%=Tag("天")%></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="m-t-10 m-b-10">
                                <div class="form-group">
                                    <label for="Type_id_ProductStatus"><%=Tag("商品状态")%>：</label>
                                    <div class="input-group">
                                        <%=Shop.Bussiness.EX_Type.TypeRadio("ProductStatus", "Type_id_ProductStatus", model.Type_id_ProductStatus, "shop=\"true\" onclick=\"ChangeProductStatus();\"", CurrentLanguage.Code)%>
                                    </div>
                                </div>
                                <div class="form-group" id="FreezeRemarkbody">
                                    <label for="FreezeRemark"><%=Tag("冻结原因")%>：</label>
                                    <textarea id="FreezeRemark" name="FreezeRemark" class="form-control" style="height:60px;" shop="true"><%=model.FreezeRemark%></textarea>
                                    <div class="button-group m-t-5">
                                        <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('FreezeRemark',100);"><%=Tag("展开")%></button>
                                        <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('FreezeRemark',-100);"><%=Tag("收缩")%></button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="Time_OnSale"><%=Tag("上架日期")%>：</label>
                                            <input type="text" id="Time_OnSale" name="Time_OnSale" value="<%=FormatTime(model.Time_OnSale) %>" class="form-control" shop="true">
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="Sort"><%=Tag("排序序号")%>：</label>
                                            <input type="text" id="Name" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_product_price")){ %>
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for=""><%=Tag("阶梯价格")%>：</label>
                                    <div class="input-group">
                                        <div class="table-responsive">
                                            <table class="table table-hover no-wrap" id="steppricetable">
                                                <thead>
                                                    <tr>
                                                        <th style="width:35%">
                                                            <%=Tag("购买数量")%> >
                                                        </th>
                                                        <th style="width:35%">
                                                            <%=Tag("价格")%>
                                                        </th>
                                                        <th style="width:30%">
                                                            <%=Tag("操作")%> [<a href="javascript:addsteppricerow();"><i class="ti-plus"></i></a>]
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%foreach(Shop.Model.ProductStepPrice stepprice in StepPrices){ %>
                                                    <tr>
                                                        <td>
                                                            <input type="text" name="step_count" value="<%=stepprice.Count %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="step_price" value="<%=FormatMoney(stepprice.Price," Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^.\d]/g,'')" />
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
                                    <%if (CountSon(model.id) > 0){%>
                                    <small class="form-text text-muted">
                                        <label class="custom-control custom-checkbox">
                                            <input type="checkbox" id="UpdateStepPrice" name="UpdateStepPrice" value="1" class="custom-control-input" shop="true">
                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                        </label>
                                    </small>
                                    <%} %>
                                </div>
                                <hr class="m-t-10 m-b-10">
                                <div class="form-group">
                                    <label for=""><%=Tag("分组价格")%>：</label>
                                    <div class="input-group">
                                        <div class="table-responsive">
                                            <table class="table table-hover no-wrap" id="Table6">
                                                <thead>
                                                    <tr>
                                                        <th style="width:35%">
                                                            <%=Tag("会员分组")%> >
                                                        </th>
                                                        <th style="width:35%">
                                                            <%=Tag("价格")%>
                                                        </th>
                                                        <th style="width:30%">
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%foreach(DB.LebiShop.Lebi_UserLevel modellevel in userlevels){ %>
                                                    <tr>
                                                        <td>
                                                            <%=Lang(modellevel.Name) %>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="userlevelprice<%=modellevel.id %>" value="<%=FormatMoney(GetUserLevelPrice(modellevel.id)," Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^.\d]/g,'')" />
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <%} %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <%if (CountSon(model.id) > 0){%>
                                    <small class="form-text text-muted">
                                        <label class="custom-control custom-checkbox">
                                            <input type="checkbox" id="UpdateUserLevelPrice" name="UpdateUserLevelPrice" value="1" class="custom-control-input" shop="true">
                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                        </label>
                                    </small>
                                    <%} %>
                                </div>
                                <hr class="m-t-10 m-b-10">
                                <div class="form-group">
                                    <label for=""><%=Tag("起订量")%>：</label>
                                    <div class="input-group">
                                        <div class="table-responsive">
                                            <table class="table table-hover no-wrap" id="Table7">
                                                <thead>
                                                    <tr>
                                                        <th style="width:35%">
                                                            <%=Tag("会员分组")%> >
                                                        </th>
                                                        <th style="width:35%">
                                                            <%=Tag("数量")%>
                                                        </th>
                                                        <th style="width:30%">
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%foreach(DB.LebiShop.Lebi_UserLevel modellevel in userlevels){ %>
                                                    <tr>
                                                        <td>
                                                            <%=Lang(modellevel.Name) %>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="userlevelcount<%=modellevel.id %>" value="<%=GetUserLevelCount(modellevel.id) %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')" />
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <%} %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <%if (CountSon(model.id) > 0){%>
                                    <small class="form-text text-muted">
                                        <label class="custom-control custom-checkbox">
                                            <input type="checkbox" id="UpdateUserLevelCount" name="UpdateUserLevelCount" value="1" class="custom-control-input" shop="true">
                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                        </label>
                                    </small>
                                    <%} %>
                                </div>
                            </div>
                        </div>
                        <%} %>
                    </div>
                    <div class="col-md-6">
                        <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="Supplier_id"><%=Tag("商家")%>：</label>
                                    <select id="Supplier_id" name="Supplier_id" class="form-control" shop="true">
                                        <option value="0">
                                            <%=Tag("请选择")%>
                                        </option>
                                        <%=Shop.Bussiness.EX_Supplier.SupplierOption(model.Supplier_id, CurrentLanguage.Code)%>
                                    </select>
                                </div>
                                <%if (model.Supplier_ProductType_ids !=""){%>
                                <div class="form-group">
                                    <label for="Supplier_ProductType_ids"><%=Tag("自定义类别")%>：</label>
                                    <select name="Supplier_ProductType_ids" id="Supplier_ProductType_ids" multiple="multiple" size="8" class="form-control" shop="true">
                                        <%=Shop.Bussiness.EX_Product.SupplierTypeOption(model.Supplier_id, 0, model.Supplier_ProductType_ids, 0, CurrentLanguage.Code)%>
                                    </select>
                                </div>
                                <%} %>
                            </div>
                        </div>
                        <%} %>
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="ImageOriginal"><%=Tag("商品主图")%>：</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="image_ImageOriginal"><%if (model.ImageOriginal != ""){%><a href="<%=Image(model.ImageOriginal," big") %>" data-lightbox="bigimage"><img height="20" src="<%=Image(model.ImageOriginal," small")%>" /></a><%}else{ %><i class="ti-image"></i><%}%></span>
                                        </div>
                                        <input type="text" id="ImageOriginal" name="ImageOriginal" value="<%=model.ImageOriginal %>" class="form-control" shop="true">
                                        <div class="input-group-append fileupload">
                                            <span class="input-group-text"><i class="ti-upload"></i></span>
                                            <input type="file" id="file_ImageOriginal" name="file_ImageOriginal" class="upload" onchange="uploadImage('ImageOriginal')">
                                        </div>
                                    </div>
                                </div>
                                <%if (!Shop.Bussiness.EX_Product.IsHaveSon(model.id)){ %>
                                <div class="form-group">
                                    <label for="Images"><%=Tag("展示图")%>：</label>
                                    <div class="input-group">
                                        <textarea id="Images" name="Images" shop="true" class="form-control" style="height: 60px;display: none"><%=model.Images%></textarea>
                                        <div id="imagesdiv">
                                        </div>
                                    </div>
                                </div>
                                <%} %>
                                <%if (model.id == 0 || (model.id > 0 && model.Product_id == 0)){%>
                                <div class="form-group">
                                    <label for="Pro_Type_id"><%=Tag("商品类别")%>：</label>
                                    <div class="input-group" id="ProductType_div"><%=Shop.Bussiness.EX_Product.GetProductTypeList(model.Pro_Type_id, CurrentLanguage.Code, Shop.Bussiness.EX_Admin.Project().Pro_Type_ids, "form-control")%></div>
                                </div>
                                <div class="form-group">
                                    <label for="Supplier_ProductType_ids"><%=Tag("扩展类别")%>：</label>
                                    <select name="Pro_Type_id_other" id="Pro_Type_id_other" multiple="multiple" size="8" class="form-control" shop="true">
                                        <%=Shop.Bussiness.EX_Product.TypeOption(0, model.Pro_Type_id_other, 0, CurrentLanguage.Code, Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
                                    </select>
                                </div>
                                <%} else {%>
                                <input type="hidden" name="Pro_Type_id" shop="true" id="Pro_Type_id" value="<%=model.Pro_Type_id %>" />
                                <%} %>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="Number"><%=Tag("商品编号")%>：</label>
                                            <input type="text" id="Number" name="Number" value="<%=model.Number %>" class="form-control" shop="true">
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="Code"><%=Tag("商品货号")%>：</label>
                                            <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="Units_id"><%=Tag("商品单位")%>：</label>
                                            <div class="input-group">
                                                <select id="Units_id" name="Units_id" class="form-control" shop="true">
                                                    <option value="0"><%=Tag("请选择")%></option>
                                                    <%=Shop.Bussiness.EX_Product.UnitOption(model.Units_id, CurrentLanguage.Code)%>
                                                </select>
                                                <%if (CountSon(model.id) > 0){%>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdateUnits_id" name="UpdateUnits_id" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="Brand_id"><%=Tag("商品品牌")%>：</label>
                                            <div class="input-group">
                                                <select id="Brand_id" name="Brand_id" class="form-control" shop="true">
                                                    <option value="0">
                                                        <%=Tag("请选择")%>
                                                    </option>
                                                    <%=Shop.Bussiness.EX_Product.BrandOption(model.Brand_id,CurrentLanguage.Code)%>
                                                </select>
                                                <%if (CountSon(model.id) > 0){%>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdateBrand_id" name="UpdateBrand_id" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="Location"><%=Tag("库位")%>：</label>
                                            <div class="input-group">
                                                <input type="text" id="Location" name="Location" value="<%=model.Location %>" class="form-control" shop="true">
                                                <%if (CountSon(model.id) > 0){%>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdateLocation" name="UpdateLocation" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="Location"><%=Tag("包装率")%>：</label>
                                            <div class="input-group">
                                                <input type="text" id="PackageRate" name="PackageRate" value="<%=model.PackageRate %>" class="form-control" shop="true"
                                                       onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                                <%if (CountSon(model.id) > 0){%>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdatePackageRate" name="UpdatePackageRate" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="Number"><%=Tag("商品毛重")%>(<%=Tag("KG")%>)：</label>
                                            <div class="input-group">
                                                <input type="text" id="Weight" name="Weight" value="<%=model.Weight %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
                                                <%if (CountSon(model.id) > 0){%>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdateWeight" name="UpdateWeight" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                            <small class="form-text text-muted">
                                                <%=Tag("用来计算订单配送费用")%>
                                            </small>
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="NetWeight"><%=Tag("商品净重")%>(<%=Tag("KG")%>)：</label>
                                            <div class="input-group">
                                                <input type="text" id="NetWeight" name="NetWeight" value="<%=model.NetWeight %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
                                                <%if (CountSon(model.id) > 0){%>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdateNetWeight" name="UpdateNetWeight" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="VolumeL"><%=Tag("包装尺寸")%>(<%=Tag("单位CM")%>)：</label>
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <label for="VolumeL"><%=Tag("长度")%>：</label>
                                            <div class="input-group">
                                                <input type="text" id="VolumeL" name="VolumeL" value="<%=model.VolumeL%>" class="form-control" shop="true" onkeyup="value=value.replace(/[^.\d]/g,'')">
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <label for="VolumeW"><%=Tag("宽度")%>：</label>
                                            <div class="input-group">
                                                <input type="text" id="VolumeW" name="VolumeW" value="<%=model.VolumeW%>" class="form-control" shop="true" onkeyup="value=value.replace(/[^.\d]/g,'')">
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <label for="VolumeH"><%=Tag("高度")%>：</label>
                                            <div class="input-group">
                                                <input type="text" id="VolumeH" name="VolumeH" value="<%=model.VolumeH%>" class="form-control" shop="true" onkeyup="value=value.replace(/[^.\d]/g,'')">
                                            </div>
                                        </div>
                                    </div>
                                    <%if (CountSon(model.id) > 0){%>
                                    <small class="form-text text-muted">
                                        <label class="custom-control custom-checkbox">
                                            <input type="checkbox" id="UpdateVolume" name="UpdateVolume" value="1" class="custom-control-input" shop="true">
                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                        </label>
                                    </small>
                                    <%} %>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <%if (model.id == 0 || (model.id > 0 && model.Product_id == 0)){%>
                                <div class="form-group">
                                    <label for="Tags"><%=Tag("分组商品标签")%>：</label>
                                    <div class="input-group">
                                        <input type="text" id="Tags" name="Tags" value="<%=model.Tags %>" class="form-control" shop="true">
                                        <%if (CountSon(model.id) > 0){%>
                                        <div class="input-group-append">
                                            <span class="input-group-text">
                                                <label class="custom-control custom-checkbox">
                                                    <input type="checkbox" id="UpdateTags" name="UpdateTags" value="1" class="custom-control-input" shop="true">
                                                    <span class="custom-control-label"><%=Tag("同步")%></span>
                                                </label>
                                            </span>
                                        </div>
                                        <%} %>
                                    </div>
                                    <small class="form-text text-muted">
                                        <%=Tag("标签通过匹配商品名称来识别相关商品，多个标签用，隔开")%>
                                    </small>
                                </div>
                                <div class="form-group">
                                    <label for=""><%=Tag("商品标签")%>：</label>
                                    <div class="input-group">
                                        <%foreach (DB.LebiShop.Lebi_Pro_Tag pt in DB.LebiShop.B_Lebi_Pro_Tag.GetList("", "")){ %>
                                        <label class="custom-control custom-checkbox m-r-20">
                                            <input type="checkbox" id="Pro_Tag_id<%=pt.id%>" name="Pro_Tag_id" value="<%=pt.id %>" class="custom-control-input" shop="true" <%=(","+model.Pro_Tag_id+",").Contains(","+pt.id+",")?"checked":"" %>>
                                            <span class="custom-control-label"><%=Shop.Bussiness.Language.Content(pt.Name,CurrentLanguage.Code) %></span>
                                        </label>
                                        <%} %>
                                    </div>
                                </div>
                                <%} %>
                                <div class="form-group">
                                    <label for="Site_ids"><%=Tag("站点")%>：</label>
                                    <div class="input-group">
                                        <%=site.SiteCheckbox("Site_ids",model.Site_ids,CurrentLanguage.Code)%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <div class="card-actions">
                                    <a class="" data-action="collapse"><i class="ti-minus"></i></a>
                                    <a class="btn-minimize" data-action="expand"><i class="ti-fullscreen"></i></a>
                                </div>
                                <h6 class="card-title m-b-0"><%=Tag("组合商品")%></h6>
                            </div>
                            <div class="card-body b-t collapse show">
                                <label class="custom-control custom-checkbox">
                                    <input type="checkbox" id="IsCombo" name="IsCombo" value="1" class="custom-control-input" shop="true" <%=model.IsCombo==1?"checked":""%> onclick="ComboChanged()">
                                    <span class="custom-control-label"><%=Tag("开启")%></span>
                                </label>
                                <div class="input-group">
                                    <div class="table-responsive" id="combotable" style="display:none;">
                                        <table class="table table-hover no-wrap">
                                            <thead>
                                                <tr class="no-wrap">
                                                    <th>
                                                        <%=Tag("编号")%>
                                                    </th>
                                                    <th>
                                                        <%=Tag("数量")%>
                                                    </th>
                                                    <th style="width:40%">
                                                        <%=Tag("名称")%>
                                                    </th>
                                                    <th>
                                                        <%=Tag("操作")%> [<a href="javascript:addcomboproduct();"><%=Tag("增加")%></a>]
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody id="combotbody">
                                                <%foreach(DB.LebiShop.Lebi_Product_Combo combo in comboProducts){
                                                DB.LebiShop.Lebi_Product cp=Shop.Bussiness.EX_Product.GetProduct(combo.Product_id_son);
                                                %>
                                                <tr>
                                                    <td>
                                                        <input type="text" class="input" shop="true" name="combo_Number" style="width: 90px;" value="<%=cp.Number %>" />
                                                    </td>
                                                    <td>
                                                        <input type="text" class="input" shop="true" name="combo_Count" style="width: 70px;" value="<%=combo.Count %>" onkeyup="value=value.replace(/[^.\d]/g,'')" />
                                                    </td>
                                                    <td>
                                                        <%=Lang(cp.Name)%>
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
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <div class="card-actions">
                                    <a class="" data-action="collapse"><i class="ti-minus"></i></a>
                                    <a class="btn-minimize" data-action="expand"><i class="ti-fullscreen"></i></a>
                                </div>
                                <h6 class="card-title m-b-0"><%=Tag("商品属性")%></h6>
                            </div>
                            <div class="card-body b-t collapse show">
                                <div class="table-responsive">
                                    <table class="table table-hover no-wrap" id="shuxing"></table>
                                </div>
                                <%if (CountSon(model.id) > 0){%>
                                <small class="form-text text-muted">
                                    <label class="custom-control custom-checkbox">
                                        <input type="checkbox" id="UpdateProPerty133" name="UpdateProPerty133" value="1" class="custom-control-input" shop="true">
                                        <span class="custom-control-label"><%=Tag("同步")%></span>
                                    </label>
                                </small>
                                <%} %>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="Count_Sales_Show"><%=Tag("销量")%>：</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                        <%=Tag("虚拟")%>：
                                                    </span>
                                                </div>
                                                <input type="text" id="Count_Sales_Show" name="Count_Sales_Show" value="<%=model.Count_Sales_Show%>" class="form-control" shop="true">
                                                <%if (CountSon(model.id) > 0){%>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdateCount_Sales" name="UpdateCount_Sales" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                            <%if (model.id > 0){%>
                                            <small class="form-text text-muted">
                                                <%=Tag("真实")%>：<%=model.Count_Sales %>
                                            </small>
                                            <%} %>
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="Count_Sales_Show"><%=Tag("浏览量")%>：</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                        <%=Tag("虚拟")%>：
                                                    </span>
                                                </div>
                                                <input type="text" id="Count_Sales_Show" name="Count_Sales_Show" value="<%=model.Count_Sales_Show%>" class="form-control" shop="true">
                                                <%if (CountSon(model.id) > 0){%>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <label class="custom-control custom-checkbox">
                                                            <input type="checkbox" id="UpdateCount_Sales" name="UpdateCount_Sales" value="1" class="custom-control-input" shop="true">
                                                            <span class="custom-control-label"><%=Tag("同步")%></span>
                                                        </label>
                                                    </span>
                                                </div>
                                                <%} %>
                                            </div>
                                            <%if (model.id > 0){%>
                                            <small class="form-text text-muted">
                                                <%=Tag("真实")%>：<%=model.Count_Views %>
                                            </small>
                                            <%} %>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="Remarks"><%=Tag("内部备注")%>：</label>
                                    <textarea id="Remarks" name="Remarks" class="form-control" style="height:60px;" shop="true"><%=model.Remarks%></textarea>
                                    <div class="button-group m-t-5">
                                        <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remarks',100);"><%=Tag("展开")%></button>
                                        <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remarks',-100);"><%=Tag("收缩")%></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <%if (model.id>0 && model.Product_id == 0){ %>
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-actions">
                                <a class="" data-action="collapse"><i class="ti-minus"></i></a>
                                <a class="btn-minimize" data-action="expand"><i class="ti-fullscreen"></i></a>
                            </div>
                            <h6 class="card-title m-b-0"><%=Tag("商品规格")%></h6>
                        </div>
                        <div class="card-body b-t collapse show">
                            <div id="getproducts"></div>
                        </div>
                    </div>
                </div>
            </div>
            <%} %>
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

    
<div class="modal fade" id="DeleteConfirm" tabindex="-1" role="dialog" aria-labelledby="DeleteConfirm">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><%=Tag("删除")%></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <p><i class="ti-alert"></i> <%=Tag("确认要删除吗？")%></p>
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
    <script src="<%=site.AdminJsPath %>/custom.min.js"></script>
    <script src="<%=site.AdminJsPath %>/Cookies.js"></script>
    <script src="<%=site.AdminJsPath %>/main.js"></script>
    <script src="<%=site.AdminJsPath %>/messagebox.js"></script>
	<script>
		$(document).on("modal fade show", ".modal", function(){
			$(this).draggable({
				handle: ".modal-header"   // 只能点击头部拖动
				cursor: 'move',
			});
			$(this).css("overflow", "hidden");
		});
	</script>
    
    <script src="<%=site.AdminJsPath %>/validation.js"></script>
    <script src="<%=site.AdminJsPath %>/ajaxfileupload.js"></script>
    <script src="<%=site.WebPath %>/Editor/ckeditor/ckeditor.js"></script>
    <script src="<%=site.WebPath %>/Editor/ckfinder/ckfinder.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/moment/moment.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/multiselect/js/jquery.multiselect2side.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/lightbox/lightbox.min.js"></script>
    <script>
        $('#Time_OnSale').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            timePicker24Hour: true,
            timePicker: true,
            locale: { format: 'YYYY-MM-DD hh:mm:s' }
        });
        $('#Time_Start').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            timePicker24Hour: true,
            timePicker: true,
            locale: { format: 'YYYY-MM-DD hh:mm:s' }
        });
        $('#Time_Expired').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            timePicker24Hour: true,
            timePicker: true,
            locale: { format: 'YYYY-MM-DD hh:mm:s' }
        });
        !function (window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        var langs = "<%=Shop.Bussiness.Language.LanguageCodes()%>"
        var Arrlangs = langs.split(",");
        for (var i = 0; i < Arrlangs.length; i++){
            CKEDITOR.replace('Description'+ Arrlangs[i] +'', {
                height: '150',
                toolbar: 'Basic',
                language: '<%=Tag("CKEditor语言")%>'
            });
            CKEDITOR.replace('Specification' + Arrlangs[i] + '', {
                height: '150',
                toolbar: 'Basic',
                language: '<%=Tag("CKEditor语言")%>'
            });
            <%if (wap) { %>
                CKEDITOR.replace('MobileDescription'+ Arrlangs[i] +'', {
                    height: '150',
                    toolbar: 'Basic',
                    language: '<%=Tag("CKEditor语言")%>'
                });
            <%}%>
        }
        function SaveObj(type) {
            var postData = GetFormJsonData("shop");
            var action = $("#action").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Edit&id=<%=model.id %>";
            RequestAjax(url, postData, function (res) {
                if (type == 1 || '<%=t %>' == 'copy') {
                    MsgBox(1, "<%=Tag("操作成功")%>", "?id=" + res.id);
                } else {
                    MsgBox(1, "<%=Tag("操作成功")%>", refPage);
                }
            });
        }
        function uploadImage(id) {
            $.ajaxFileUpload({
                url: WebPath + '/ajax/imageupload.aspx',
                secureuri: false,
                fileElementId: 'file_' + id,
                dataType: 'json',
                success: function (data, status) {
                    if (data.msg != 'OK') {
                        MsgBox(2, data.msg, "");
                    }
                    else {
                        var imageUrl = data.img;
                        if (imageUrl.length > 0) {
                            $("#image_" + id + "").html('<img src="<%=webconfig.ImageURL%>' + imageUrl + '" height="20">');
                            $("#" + id + "").val(imageUrl);
                        }
                    }
                }
            })
        }
        function ChangePro_Type() {
            var id = $("#Pro_Type_id").val();
            if (id == undefined)
                id = "<%=model.Pro_Type_id %>";
            $.ajax({
                type: "POST",
                url: "product_edit_part.aspx?tid=" + id + "&pid=<%=model.id %>",
                data: '',
                success: function (res) {
                    $("#shuxing").html(res);
                }
            });
        }
        function CreateProduct() {
            var ggs = GetChkCheckedValues("Property131");
            var pid =<%=model.id %>;
            var tid = $("#Pro_Type_id").val();
            var postData = { "ggs": ggs, "pid": pid, "tid": tid };
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=CreateProductGuiGe";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", ""); getsubproducts(); });
        }
        function DeleteConfirm() {
            $("#DeleteConfirm").modal("show");
            $("#DeleteConfirm .btn-success.btn-ok").attr("onclick", "Product_Del();");
        }
        function Product_Del() {
            $("#DeleteConfirm").modal("hide");
            var postData = GetFormJsonData("ShopKeyID");
            var action = $("#action").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Del";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", ""); getsubproducts(); });
        }
        function Product_Edit_muti() {
            var postData = GetFormJsonData("sonproduct");
            var action = $("#action").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Edit_muti_price_store&pid=<%=id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "") });
        }
        function Product_Status_Edit_muti(status) {
            var postData = GetFormJsonData("ShopKeyID");
            var action = $("#action").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Status_Edit_muti&status=" + status;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", ""); getsubproducts(); });
        }
        function Product_Name_Edit(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_name_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id, pid: '<%=id %>' },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Product_Remark_Edit(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_remark_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id, pid: '<%=id %>' },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Product_Image_Edit() {
            var ids = GetChkCheckedValues("sonproductid");
            if (ids == "") {
                MsgBox(2, "<%=Tag("请选择要修改的商品")%>", "");
                return;
            }
            $("#EditModal").modal("show");
            $.ajax({
                url: "product_image_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { ids: ids, id: '<%=id %>' },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function getproducts() {
            <%if (model.id > 0 && model.Product_id != 0) {%>
                return false;
            <%} %>
            var id = $("#Pro_Type_id").val();
            var Property131 = GetChkCheckedValues("Property131");
            var ProPertyMain = $("#ProPertyMain").val();
            $.ajax({
                type: "POST",
                url: "product_edit_list.aspx?tid=" + id + "&pid=<%=model.id %>&Property131=" + Property131 + "&ProPertyMain=" + ProPertyMain,
                data: '',
                success: function (res) {
                    $("#getproducts").html(res);
                }
            });
        }
        function getImages() {
            var images = $("#Images").val();
            $.ajax({
                type: "POST",
                url: "<%=site.AdminPath %>/product/imagesupload.aspx?input=Images&pid=<%=model.id %>",
                data: { "images": images },
                success: function (res) {
                    $("#imagesdiv").html(res);
                }
            });
        }
        function ChangeProductType() {
            $("#qianggoubody").hide();
            $("#yudingbody").hide();
            var Type_id_ProductType = $("input[name='Type_id_ProductType']:checked").val();
            if (Type_id_ProductType == 321) {
                $("#qianggoubody").show();
                $("#pricename").html("<%=Tag("抢购价") %>(<%=DefaultCurrency.Msige%>)");
            } else if (Type_id_ProductType == 322) {
                $("#qianggoubody").show();
                $("#pricename").html("<%=Tag("团购价") %>(<%=DefaultCurrency.Msige%>)");
            } else if (Type_id_ProductType == 323) {
                $("#qianggoubody").show();
                $("#pricename").html("<%=Tag("换购积分") %>");
            } else if (Type_id_ProductType == 324) {
                $("#yudingbody").show();
            }
        }
        function ChangeProductStatus() {
            var Type_id_ProductStatus = $("input[name='Type_id_ProductStatus']:checked").val();
            if (Type_id_ProductStatus == 103) {
                $("#FreezeRemarkbody").show();
            } else {
                $("#FreezeRemarkbody").hide();
            }
        }
        function addsteppricerow() {
            var row = '<tr><td><input type="text" name="step_count" value="" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^\\d]/g,\'\')" /></td>';
            row += '<td><input type="text" name="step_price" value="" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^.\\d]/g,\'\')" /></td>';
            row += '<td><a href="javascript:void(0);" onclick="$(this).parent().parent().remove();"><%=Tag("删除")%></a></td></tr>';
            $("#steppricetable").append(row);
        }
        $(function () {
            ChangePro_Type(); getImages(); ChangeProductType(); ChangeProductStatus(); getproducts(); ComboChanged();
            $("#Pro_Type_id_other").multiselect2side({
                selectedPosition: "right",
                moveOptions: false,
                labelsx: "",
                labeldx: "",
                autoSort: false,
                autoSortAvailable: false
            });
            <%if (model.Supplier_ProductType_ids != "") {%>
            $("#Supplier_ProductType_ids").multiselect2side({
                selectedPosition: "right",
                moveOptions: false,
                labelsx: "",
                labeldx: "",
                autoSort: false,
                autoSortAvailable: false
            });
            <%}%>
        });
        function ComboChanged() {
            var iscombo = 0;
            if ($('#IsCombo').is(':checked')) {
                iscombo = 1;
                $('#combotable').show();
            } else {
                iscombo = 0;
                $('#combotable').hide();
            }
        }
        function addcomboproduct() {
            var row = '<tr><td><input type="text" name="combo_Number" value="" class="form-control form-control-sm" shop="true" /></td>';
            row += '<td><input type="text" name="combo_Count" value="" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^.\\d]/g,\'\')" /></td>';
            row += '<td></td>';
            row += '<td><a href="javascript:void(0);" onclick="$(this).parent().parent().remove();"><%=Tag("删除")%></a></td></tr>';
            $("#combotbody").append(row);
        }
    </script>

</body>
</html>