<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.subproduct_edit_all" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%if (model.id > 0) { Response.Write(Shop.Bussiness.Language.Content(model.Name, CurrentLanguage.Code) + "-"); } %><%=Tag("商品管理")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link href="<%=site.AdminAssetsPath %>/plugins/multiselect/css/jquery.multiselect2side.css" rel="stylesheet">
    <script type="text/javascript" src="<%=site.AdminJsPath %>/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=site.WebPath %>/Editor/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="<%=site.WebPath %>/Editor/ckfinder/ckfinder.js"></script>
    <script type="text/javascript" src="<%=site.AdminJsPath %>/dialog.js"></script>
    <script type="text/javascript" src="<%=site.AdminJsPath %>/jquery-ui/timepicker-addon.js"></script>
    <%if (CurrentLanguage.Code=="CN"){%><script type="text/javascript" src="<%=site.AdminJsPath %>/jquery-ui/timepicker-zh-CN.js"></script><%}%>
    <link rel="stylesheet" type="text/css" href="<%=site.AdminJsPath %>/jquery-ui/timepicker-addon.css" />
    <script type="text/javascript">
        $(function () {
            $(".input-calendar").datetimepicker({dateFormat:"yy-mm-dd",showSecond:true,timeFormat:"HH:mm:ss",stepHour:1,stepMinute:1,tepSecond:1});
        });
    </script>
    <script src="<%=site.AdminAssetsPath %>/plugins/multiselect/js/jquery.multiselect2side.js"></script>
    <link rel="stylesheet" href="<%=site.AdminJsPath %>/multiselect/css/jquery.multiselect2side.css" type="text/css" media="screen" />
    <style>
        .steppricetable{border: 1px solid #cccccc;}
        .steppricetable tr th{text-align:center;}
        .steppricetable tr td{text-align:center;}
        .bottom{height: 0;overflow: hidden;display: none;}
    </style>

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
                        
    <div class="tools">
    <ul>
    <%if (PageReturnMsg == ""){%>
    <%if (id > 0 && randnum > 0){ %><li class="tip"><a href="javascript:void(0);"><b></b><span><%=Tag("复制")%></span></a></li><%} %>
    <%if (model.id > 0 && randnum == 0) {%>
    <li class="submit"><a href="javascript:void(0);" onclick="SaveObj(0);"><b></b><span><%=Tag("保存")%></span></a></li>
    <li class="bonus"><a href="product_price.aspx?id=<%=model.id%>" target="_blank"><b></b><span><%=Tag("会员价格")%></span></a></li>
    <%}else{ %>
    <li class="submit"><a href="javascript:void(0);" onclick="SaveObj(1);"><b></b><span><%=Tag("保存并返回")%></span></a></li>
    <li class="submit"><a href="javascript:void(0);" onclick="SaveObj(2);"><b></b><span><%=Tag("保存并添加")%></span></a></li>
    <%} %>
    <%}%>
    <li class="rotate"><a href="javascript:void(0);" onclick="javascript:history.back();"><b></b><span><%=Tag("返回")%></span></a></li>
    <li class="name"><span id="navIgation"><%=Tag("当前位置")%>：<a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a> > <a href="<%=site.AdminPath %>/product/default.aspx"><%=Tag("商品管理")%></a> > <%=LB.Tools.Utils.CutString(Shop.Bussiness.Language.Content(model.Name, CurrentLanguage.Code),30,true) %><%if (id > 0 && randnum > 0){ %>（<%=Tag("复制")%>）<%} %></span></li>
    </ul>
    </div>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
<div class="mainbody_top">
    <ul class="tablist">
        <li onclick="Edit(1)" id="p1" class="selected"><a><span><%=Tag("基本信息")%></span></a></li>
        <li onclick="Edit(2)" id="p2"><a><span><%=Tag("通用信息")%></span></a></li>
        <li onclick="Edit(5);" id="p5"><a><span><%=Tag("商品价格")%></span></a></li>
        <li onclick="Edit(3);getproducts();" id="p3"><a><span><%=Tag("属性规格")%></span></a></li>
    </ul>
</div>

					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <div id="table1">
    <%=Shop.Bussiness.Language.AdminLanguageTab("") %>
    <table class="table">
        <%foreach (DB.LebiShop.Lebi_Language_Code lang in Shop.Bussiness.Language.Languages())
          {%>
        <tbody id="lang_<%=lang.Code %>" class="lang_table" style="display: none">
            <tr>
                <th>
                    <%=Tag("商品名称")%>：
                </th>
                <td>
                    <input type="text" id="Name<%=lang.Code %>" shop="true" style="width: 500px;" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name, lang.Code) %>" class="input" />
                </td>
            </tr>
            <tr>
                <th style="vertical-align:top">
                    <%=Tag("详细介绍")%>：
                </th>
                <td>
                    <textarea name="Description<%=lang.Code %>" shop="true" id="Description<%=lang.Code %>" class="text"><%=Shop.Bussiness.Language.Content(model.Description, lang.Code)%></textarea>
                    <script type="text/javascript">
                        CKEDITOR.replace('Description<%=lang.Code %>', {
                            height: '200',
                            width: '98%',
                            language: '<%=Tag("CKEditor语言")%>'
                        });
                    </script>
                </td>
            </tr>
            <%if (wap)
              { %>
            <tr>
                <th style="vertical-align:top">
                    <%=Tag("WAP端描述")%>：
                </th>
                <td>
                    <textarea style="height: 60px; width: 500px;" shop="true" name="MobileDescription<%=lang.Code %>" id="MobileDescription<%=lang.Code %>" class="input"><%=Shop.Bussiness.Language.Content(model.MobileDescription, lang.Code)%></textarea>
                    <script type="text/javascript">
                        CKEDITOR.replace('MobileDescription<%=lang.Code %>', {
                            height: '150',
                            width: '98%',
                            language: '<%=Tag("CKEditor语言")%>'
                        });
                    </script>
                </td>
            </tr>
            <%} %>
        </tbody>
        <%} %>
    </table>
    </div>
    <div id="table2" style="display: none">
    <table class="table">
    <input type="hidden" name="Pro_Type_id" shop="true" id="Pro_Type_id" value="<%=model.Pro_Type_id %>" />
        <tr>
            <th>
                <%=Tag("商品编号")%>：
            </th>
            <td>
                <input type="text" id="Number" shop="true" min="notnull" name="Number" class="input" value="<%=model.Number %>" />
            </td>
        </tr>
        
        <tr>
            <th>
                <%=Tag("商品货号")%>：
            </th>
            <td>
                <input type="text" id="Code" shop="true" name="Code" class="input" value="<%=model.Code %>" />
            </td>
        </tr>
        
        <tr>
            <th>
                <%=Tag("商品单位")%>：
            </th>
            <td>
                <select id="Units_id" shop="true" name="Units_id">
                    <%=Shop.Bussiness.EX_Product.UnitOption(model.Units_id)%>
                </select>
            </td>
        </tr>
        
        <%if (!Shop.Bussiness.EX_Product.IsHaveSon(model.id))
          { %>
        <tr>
            <th>
                <%=Tag("库存数量")%>：
            </th>
            <td>
                 <%if (IsEditStock){ %>
                <input type="text" id="Count_Stock" shop="true" min="notnull" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" name="Count_Stock" class="input" style="width: 70px;" value="<%=model.Count_Stock %>" />
                <%}else{ %>
                <%=model.Count_Stock %>
                <%} %>
            </td>
        </tr>
        <%} %>
        <tr>
            <th>
                <%=Tag("警戒库存")%>：
            </th>
            <td>
                <input type="text" shop="true" min="notnull" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" id="Count_StockCaution" name="Count_StockCaution" class="input" style="width: 70px;" value="<%=model.Count_StockCaution %>" />
            </td>
        </tr>
        
        <tr>
            <th>
                <%=Tag("包装率")%>：
            </th>
            <td>
                <input type="text" shop="true" name="PackageRate" value="<%=model.PackageRate %>" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" id="PackageRate" class="input" style="width: 70px;" />
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("商品毛重")%>：
            </th>
            <td>
                <input type="text" shop="true" min="notnull" value="<%=model.Weight %>" class="input" onkeyup="value=value.replace(/[^\d\.]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d\.]/g,''))" id="Weight" name="Weight" style="width: 70px;" />
                <%=Tag("KG")%>
                <em><%=Tag("用来计算订单配送费用")%></em>
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("商品净重")%>：
            </th>
            <td>
                <input type="text" shop="true" min="notnull" value="<%=model.NetWeight %>" class="input" onkeyup="value=value.replace(/[^\d\.]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d\.]/g,''))" id="NetWeight" name="NetWeight" style="width: 70px;" />
                <%=Tag("KG")%>
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("包装尺寸")%>：
            </th>
            <td>
                <%=Tag("L")%>：<input type="text" shop="true" name="VolumeL" value="<%=model.VolumeL %>" onkeyup="value=value.replace(/[^.\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^.\d]/g,''))" id="VolumeL" class="input" style="width: 70px;" />
                <%=Tag("W")%>：<input type="text" shop="true" name="VolumeW" value="<%=model.VolumeW %>" onkeyup="value=value.replace(/[^.\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^.\d]/g,''))" id="VolumeW" class="input" style="width: 70px;" />
                <%=Tag("H")%>：<input type="text" shop="true" name="VolumeH" value="<%=model.VolumeH %>" onkeyup="value=value.replace(/[^.\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^.\d]/g,''))" id="VolumeH" class="input" style="width: 70px;" /> <em><%=Tag("单位CM")%></em>
            </td>
        </tr>
        <tr>
            <th style="vertical-align:top">
                <%=Tag("商品主图")%>：
            </th>
            <td>
                <div id="image_ImageOriginal">
                    <%if (model.ImageOriginal != "")
                      {%>
                    <a href="<%=Image(model.ImageOriginal,"big")%>" data-lightbox="bigimage"><img height="30" src="<%=Image(model.ImageOriginal,"small")%>" /></a>
                    <%} %>
                </div>
                <input type="hidden" shop="true" id="ImageOriginal" name="ImageOriginal" value="<%=model.ImageOriginal%>" />
                <input id="file_ImageOriginal" name="file_ImageOriginal" class="input" type="file" onchange="uploadImage('ImageOriginal')" />
                
                <em>
                    <%=Tag("如果含有子商品，将使用自动提取首个子商品图片")%></em>
            </td>
        </tr>
         <%if (!Shop.Bussiness.EX_Product.IsHaveSon(model.id))
           { %>
        <tr>
            <th style="vertical-align:top">
                <%=Tag("展示图")%>：
            </th>
            <td>
                <textarea id="Images" name="Images" shop="true" class="textarea" style="height: 60px; width: 450px;display:none"><%=model.Images%></textarea>
                <div id="imagesdiv"></div>
            </td>
        </tr>
        <%} %>
        
        <tr>
            <th>
                <%=Tag("商品类型")%>：
            </th>
            <td style="text-align: left;">
                <%=Shop.Bussiness.EX_Type.TypeRadio("ProductType", "Type_id_ProductType", model.Type_id_ProductType, "shop=\"true\" onclick=\"ChangeProductType();\"",CurrentLanguage.Code)%>
            </td>
        </tr>
        <tbody id="qianggoubody">
        <tr>
            <th>
                <span id="pricename">
                    <%if (model.Type_id_ProductType == 321)
                        { %><%=Tag("抢购价")%>(<%=DefaultCurrency.Msige%>)<%}
                        else if (model.Type_id_ProductType == 322)
                        { %>
                    %><%=Tag("团购价")%>(<%=DefaultCurrency.Msige%>)<%}
                        else if (model.Type_id_ProductType == 323)
                        { %>
                    %><%=Tag("换购积分")%><%} %></span>：
            </th>
            <td>
                <input type="text" class="input" id="Price_Sale" shop="true" min="notnull" name="Price_Sale" style="width: 70px;" value="<%=FormatMoney(model.Price_Sale,"Number") %>" onkeyup="value=value.replace(/[^.\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^.\d]/g,''))" />
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("限购数量")%>：
            </th>
            <td>
                <input type="text" shop="true" name="Count_Limit" value="<%=model.Count_Limit %>" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" id="Count_Limit" class="input" style="width: 70px;" />
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("开始日期")%>：
            </th>
            <td>
                <input type="text" shop="true" name="Time_Start" value="<%=FormatTime(model.Time_Start) %>"
                    id="Time_Start" class="input-calendar" style="width: 200px" />
                <em></em>
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("截止日期")%>：
            </th>
            <td>
                <input type="text" shop="true" name="Time_Expired" value="<%=FormatTime(model.Time_Expired) %>" id="Time_Expired" class="input-calendar" style="width:200px" /> <em></em>
            </td>
        </tr>
        </tbody>
        <tr>
            <th>
                <%=Tag("商品状态")%>：
            </th>
            <td style="text-align: left;">
                <%=Shop.Bussiness.EX_Type.TypeRadio("ProductStatus", "Type_id_ProductStatus", model.Type_id_ProductStatus, "shop=\"true\" onclick=\"ChangeProductStatus();\"", CurrentLanguage.Code)%>
            </td>
        </tr>
        <tr id="FreezeRemarkbody">
            <th style="vertical-align:top">
                <%=Tag("冻结原因")%>：
            </th>
            <td>
                <textarea id="FreezeRemark" shop="true" name="FreezeRemark" class="textarea" style="height: 60px;width: 500px;"><%=model.FreezeRemark%></textarea>
                <div class="tools clear">
                    <ul>
                        <li class="plus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('FreezeRemark',100);"><b></b><span><%=Tag("展开")%></span></a></li>
                        <li class="minus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('FreezeRemark',-100)"><b></b><span><%=Tag("收缩")%></span></a></li>
                    </ul>
                </div>
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("上架日期")%>：
            </th>
            <td>
                <input type="text" shop="true" name="Time_OnSale" value="<%=FormatTime(model.Time_OnSale) %>" id="Time_OnSale" class="input-calendar" style="width: 200px" />
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("销量")%>：
            </th>
            <td>
                <%=Tag("真实")%>：<%=model.Count_Sales %>
                <%=Tag("虚拟")%>：<input type="text" id="Count_Sales_Show" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')"
                    name="Count_Sales_Show" class="input" style="width: 70px;" value="<%=model.Count_Sales_Show %>" />
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("浏览量")%>：
            </th>
            <td>
                <%=Tag("真实")%>：<%=model.Count_Views %>
                <%=Tag("虚拟")%>：<input type="text" id="Count_Views_Show" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')"
                    name="Count_Views_Show" class="input" style="width: 70px;" value="<%=model.Count_Views_Show %>" />
            </td>
        </tr>
        <tr>
            <th style="vertical-align:top">
                <%=Tag("内部备注")%>：
            </th>
            <td>
                <textarea id="Remarks" shop="true" name="Remarks" class="textarea" style="height: 60px; width: 500px;"><%=model.Remarks %></textarea>
                <div class="tools clear">
                    <ul>
                        <li class="plus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Remarks',100);"><b></b><span><%=Tag("展开")%></span></a></li>
                        <li class="minus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Remarks',-100)"><b></b><span><%=Tag("收缩")%></span></a></li>
                    </ul>
                </div>
            </td>
        </tr>
    </table>
    </div>
    <div id="table3" style="display: none">
    <table class="table">
        <tr>
            <th>
                <%=Tag("组合商品")%>：
            </th>
            <td>
                <input type="checkbox" onclick="ComboChanged()" <%=model.IsCombo==1?"checked":""%> name="IsCombo" id="IsCombo" shop="true" value="1"><br />
                <table cellpadding="0" cellspacing="0" style="width:700px;display:none;" class="steppricetable" align="left" id="combotable">
                    <tr>
                        <th style="width:100px;text-align:center;">
                            <%=Tag("编号")%>
                        </th>
                        <th style="width:80px;text-align:center;">
                            <%=Tag("数量")%>
                        </th>
                        <th style="width:420px;text-align:center;">
                            <%=Tag("名称")%>
                        </th>
                        <th style="width:100px;text-align:center;">
                            <%=Tag("操作")%> [<a href="javascript:addcomboproduct();"><%=Tag("增加")%></a>]
                        </th>
                    </tr>
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
                </table>

            </td>
        </tr>
        <tbody id="shuxing">
        </tbody>
    </table>
    </div>
    <div id="table4">
    </div>
    <div id="table5" style="display: none">
    <table class="table">
        <tr>
            <th>
                <%=Tag("市场价")%>(<%=DefaultCurrency.Msige%>)：
            </th>
            <td>
                <input type="text" id="Price_Market" shop="true" min="notnull" name="Price_Market"
                    class="input" style="width: 70px;" value="<%=FormatMoney(model.Price_Market,"Number") %>" onkeyup="value=value.replace(/[^.\d]/g,'')"
                    onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^.\d]/g,''))" />
            </td>
        </tr>
        <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
        <tr>
            <th>
                <%=Tag("成本价")%>(<%=DefaultCurrency.Msige%>)：
            </th>
            <td>
                <input type="text" class="input" shop="true" min="notnull" id="Price_Cost" name="Price_Cost"
                    style="width: 70px;" value="<%=FormatMoney(model.Price_Cost,"Number") %>" onkeyup="value=value.replace(/[^.\d]/g,'')"
                    onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^.\d]/g,''))" />
               
            </td>
        </tr>
        <%} %>
        <tr>
            <th>
                <%=Tag("销售价")%>(<%=DefaultCurrency.Msige%>)：
            </th>
            <td>
                <input type="text" class="input" id="Price" shop="true" min="notnull" name="Price"
                    style="width: 70px;" value="<%=FormatMoney(model.Price,"Number") %>" onkeyup="value=value.replace(/[^.\d]/g,'')"
                    onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^.\d]/g,''))" />
              
            </td>
        </tr>
        <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_product_price")){ %>
        <tr>
            <th style="vertical-align:top">
                <%=Tag("阶梯价格")%>：
            </th>
            <td align="left">
                 <table cellpadding="0" cellspacing="0" style="width:350px" class="steppricetable" align="left" id="steppricetable">
                    <tr>
                        <th style="width:150px;text-align:center;">
                            <%=Tag("购买数量")%> >
                        </th>
                        <th style="width:150px;text-align:center;">
                            <%=Tag("价格")%>
                        </th>
                        <th style="width:100px;text-align:center;">
                            <%=Tag("操作")%> [<a href="javascript:addsteppricerow();"><%=Tag("增加")%></a>]
                        </th>
                    </tr>
                    <%foreach(Shop.Model.ProductStepPrice stepprice in StepPrices){ %>
                    <tr>
                        <td>
                            <input type="text" class="input"  shop="true"  name="step_count" style="width: 70px;" value="<%=stepprice.Count %>" onkeyup="value=value.replace(/[^\d]/g,'')" />
                        </td>
                        <td>
                            <input type="text" class="input"  shop="true"  name="step_price" style="width: 70px;" value="<%=FormatMoney(stepprice.Price,"Number") %>" onkeyup="value=value.replace(/[^.\d]/g,'')" />
                        </td>
                        <td>
                            <a href="javascript:void(0);" onclick="$(this).parent().parent().remove();"><%=Tag("删除")%></a>
                        </td>
                    </tr>
                    <%} %>
                 </table>
            </td>
        </tr>
        <tr>
            <th style="vertical-align:top">
                <%=Tag("分组价格")%>：
            </th>
            <td align="left">
                 <table cellpadding="0" cellspacing="0" style="width:350px" class="steppricetable" align="left" id="Table6">
                    <tr>
                        <th style="width:150px;text-align:center;">
                            <%=Tag("会员分组")%> 
                        </th>
                        <th style="width:150px;text-align:center;">
                            <%=Tag("价格")%>
                        </th>
                        <th style="width:100px;text-align:center;"></th>
                    </tr>
                    <%foreach(DB.LebiShop.Lebi_UserLevel modellevel in userlevels){ %>
                    <tr>
                        <td>
                            <%=Lang(modellevel.Name) %>
                        </td>
                        <td>
                            <input type="text" class="input"  shop="true"  name="userlevelprice<%=modellevel.id %>" style="width: 70px;" value="<%=FormatMoney(GetUserLevelPrice(modellevel.id),"Number") %>" onkeyup="value=value.replace(/[^.\d]/g,'')" />
                        </td>
                        <td></td>
                    </tr>
                    <%} %>
                 </table>
            </td>
        </tr>
        <tr>
            <th style="vertical-align:top">
                <%=Tag("起订量")%>：
            </th>
            <td align="left">
                 <table cellpadding="0" cellspacing="0" style="width:350px" class="steppricetable" align="left" id="Table7">
                    <tr>
                        <th style="width:150px;text-align:center;">
                            <%=Tag("会员分组")%> 
                        </th>
                        <th style="width:150px;text-align:center;">
                            <%=Tag("数量")%>
                        </th>
                        <th style="width:100px;text-align:center;"></th>
                    </tr>
                    <%foreach(DB.LebiShop.Lebi_UserLevel modellevel in userlevels){ %>
                    <tr>
                        <td>
                            <%=Lang(modellevel.Name) %>
                        </td>
                        <td>
                            <input type="text" class="input"  shop="true"  name="userlevelcount<%=modellevel.id %>" style="width: 70px;" value="<%=GetUserLevelCount(modellevel.id) %>" onkeyup="value=value.replace(/[^\d]/g,'')" />
                        </td>
                        <td></td>
                    </tr>
                    <%} %>
                 </table>
            </td>
        </tr>
        <%}%>
    </table>
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
	
</body>
</html>