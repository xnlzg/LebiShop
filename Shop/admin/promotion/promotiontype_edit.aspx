<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.promotion.PromotionType_Edit" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title>
        <%if (model.id != 0)
          { %>
        <%=Tag("编辑促销")%>
        <%}
          else
          { %><%=Tag("添加促销")%>
        <%}%>-<%=Tag("优惠促销")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link href="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.css" rel="stylesheet">

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=model.id ==0?Tag("添加规则"):Tag("编辑规则")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><a href="Default.aspx"><%=Tag("优惠促销")%></a></li>
        <li class="breadcrumb-item active"><%=model.id == 0 ? Tag("添加促销") : Tag("编辑促销")%></li>
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
                    <div class="row">
                        <div class="col-12 m-b-10">
                            <%if (PageReturnMsg == ""){%>
                            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                            <button class="btn btn-default" onclick="PromotionEdit(<%=model.id %>);"><i class="ti-settings"></i> <%=Tag("编辑规则")%></button>
                            <%}%>
                        </div>
                    </div>
                    <ul class="nav nav-tabs customtab" role="tablist">
                        <%
                        List<DB.LebiShop.Lebi_Language_Code> tab_langs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in tab_langs){
                        %>
                        <li class="nav-item"> <a class="nav-link <%if (tab_langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                        <%
                        }
                        %>
                    </ul>
                    <div class="tab-content m-t-20">
                        <%foreach (DB.LebiShop.Lebi_Language_Code lang in tab_langs){%>
                        <div class="tab-pane <%if (tab_langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                            <div class="form-group">
                                <label for="Name<%=lang.Code %>"><%=Tag("名称")%>：</label>
                                <input type="text" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name,lang.Code) %>" <%if (tab_langs.FirstOrDefault().Code == lang.Code){%>required<%}%> class="form-control" shop="true">
                            </div>
                            <div class="form-group">
                                <label for="Content<%=lang.Code %>"><%=Tag("介绍")%>：</label>
                                <textarea id="Content<%=lang.Code %>" name="Content<%=lang.Code %>" class="form-control" style="height: 200px;" shop="true"><%=Shop.Bussiness.Language.Content(model.Content, lang.Code)%></textarea>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <h5 class="box-title m-t-20 m-b-20"><%=Tag("通用信息")%></h5>
                    <div class="form-group">
                        <label for="UserLevel_ids"><%=Tag("会员分组")%>：</label>
                        <div class="input-group">
                            <%foreach (DB.LebiShop.Lebi_UserLevel l in userlevels){ %>
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="UserLevel_ids<%=l.id %>" name="UserLevel_ids" value="<%=l.id %>" class="custom-control-input" shop="true" <%=CheckStatus(model.UserLevel_ids,l.id) %>>
                                <span class="custom-control-label"><%=Lang(l.Name) %></span>
                            </label>
                            <%} %>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Time_Start"><%=Tag("时间")%>：</label>
                        <div class="input-daterange input-group">
                            <input type="text" id="Time_Start" name="Time_Start" value="<%=FormatTime(model.Time_Start) %>" class="form-control" shop="true">
                            <div class="input-group-append">
                                <span class="input-group-text bg-info b-0 text-white">-</span>
                            </div>
                            <input type="text" id="Time_End" name="Time_End" value="<%=FormatTime(model.Time_End) %>" class="form-control" shop="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Type_id_PromotionType"><%=Tag("类型")%>：</label>
                        <div class="input-group">
                            <%=Shop.Bussiness.EX_Type.TypeRadio("PromotionType", "Type_id_PromotionType", model.Type_id_PromotionType, "shop=\"true\" onclick=\"ChangeType();\"")%>
                            <select style="display:none;" shop="true" id="Supplier_id" name="Supplier_id"><%=GetShops(model.Supplier_id)%></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Type_id_PromotionStatus"><%=Tag("状态")%>：</label>
                        <div class="input-group">
                            <%=Shop.Bussiness.EX_Type.TypeRadio("PromotionStatus", "Type_id_PromotionStatus", model.Type_id_PromotionStatus, "shop=\"true\"")%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="IsRefuseOther_1"><%=Tag("排斥其它")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="IsRefuseOther_1" name="IsRefuseOther" value="1" class="custom-control-input" shop="true" <%=model.IsRefuseOther==1?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="IsRefuseOther_0" name="IsRefuseOther" value="0" class="custom-control-input" shop="true" <%=model.IsRefuseOther==0?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Sort"><%=Tag("优先级")%>：</label>
                        <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                    <div class="form-group">
                        <label for="Remark"><%=Tag("内部备注")%>：</label>
                        <textarea id="Remark" name="Remark" class="form-control" style="height: 60px;" shop="true"><%=model.Remark%></textarea>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',-100);"><%=Tag("收缩")%></button>
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
	
    <script src="<%=site.WebPath %>/Editor/ckeditor/ckeditor.js"></script>
    <script src="<%=site.WebPath %>/Editor/ckfinder/ckfinder.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/moment/moment.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.js"></script>
    <script>
        $('#Time_Start').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });        $('#Time_End').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        var langs = "<%=Shop.Bussiness.Language.LanguageCodes()%>"
        var Arrlangs = langs.split(",");
        for (var i = 0; i < Arrlangs.length; i++){
            CKEDITOR.replace('Content'+ Arrlangs[i] +'', {
                height: '150',
                toolbar: 'Basic',
                language: '<%=Tag("CKEditor语言")%>'
            });
        }
        function SaveObj() {
            var postData = GetFormJsonData("shop");
            var url="<%=site.AdminPath %>/ajax/ajax_sale.aspx?__Action=PromotionType_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "?id="+res.id)});
        }
        function PromotionEdit(id)
        {
            window.location="promotion.aspx?tid="+id;
        }
        function ChangeType()
        {
            var t=$("input[name='Type_id_PromotionType']:checked").val();
            if(t==422)
                $('#Supplier_id').show();
            else
                $('#Supplier_id').hide();
        }
        ChangeType();
    </script>

</body>
</html>