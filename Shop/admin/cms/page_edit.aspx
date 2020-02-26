<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.cms.Page_Edit" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=pnode.Name%>-<%=Tag(node.Name)%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <link href="<%=site.AdminAssetsPath %>/plugins/bigcolorpicker/jquery.bigcolorpicker.css" rel="stylesheet" />
    <link href="<%=site.AdminAssetsPath %>/plugins/lightbox/css/lightbox.min.css" rel="stylesheet" />
    <link href="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/multiselect/css/jquery.multiselect2side.css" rel="stylesheet">

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=node.Name%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><a href="UserNodeList.aspx?code=<%=pnode.Code %>"><%=pnode.Name%></a></li>
        <li class="breadcrumb-item"><a href="<%=Shop.Bussiness.NodePage.AdminIndexPage(node) %>"><%=node.Name%></a></li>
        <%if (page.Name !="") {%>
        <li class="breadcrumb-item active"><%=page.Name%></li><%} %>
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
                    <%if (node.haveson == 1)
                    { %>
                    <div class="form-group">
                        <label for="Node_id"><%=Tag("分类")%>：</label>
                        <select name="Node_id" id="Node_id" class="form-control" shop="true">
                            <%=GetOptionTreeString(0, pnode.id, node.id)%>
                        </select>
                    </div>
                    <%}else{ %>
                    <input type="hidden" name="Node_id" id="Node_id" value="<%=node.id %>" shop="true">
                    <%} %>
                    <div class="form-group">
                        <label for="Name"><%=Tag("标题")%>：</label>
                        <div class="input-group">
                            <input type="text" id="Name" name="Name" value="<%=page.Name %>" style="color:<%=page.NameColor %>" class="form-control" shop="true" required>
                            <div class="input-group-append">
                                <span class="input-group-text" id="s_NameColor" style="cursor: pointer;background-color:<%=page.NameColor %>">
                                    <i class="ti-paint-bucket"></i>
                                </span>
                            </div>
                            <input type="hidden" id="NameColor" name="NameColor" value="<%=page.NameColor %>" shop="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Description"><%=Tag("摘要")%>：</label>
                        <textarea id="Description" name="Description" class="form-control" style="height: 60px;" shop="true"><%=page.Description%></textarea>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Content"><%=Tag("内容")%>：</label>
                        <textarea name="Content" id="Content" class="form-control" style="height: 200px;" shop="true"><%=page.Content%></textarea>
                    </div>
                    <%if (node.Code != "News" && node.Code != "Help" && node.Code != "About")
                    { %>
                    <div class="form-group">
                        <label for="source"><%=Tag("来源")%>：</label>
                        <input type="text" id="source" name="source" value="<%=page.source %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="ImageSmall"><%=Tag("图片地址")%>：</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="image_ImageSmall"><%if (page.ImageSmall != ""){%><a href="<%=site.WebPath + page.ImageSmall%>" data-lightbox="image-list"><img src="<%=site.WebPath + page.ImageSmall%>" height="20" /></a><%}else{ %><i class="ti-image"></i><%}%></span>
                            </div>
                            <input type="text" id="ImageSmall" name="ImageSmall" value="<%=page.ImageSmall %>" class="form-control" shop="true">
                            <div class="input-group-append fileupload">
                                <span class="input-group-text"><i class="ti-upload"></i></span>
                                <input type="file" id="file_ImageSmall" name="file_ImageSmall" class="upload" onchange="uploadImage('ImageSmall')">
                            </div>
                        </div>
                    </div>
                    <%} %>
                    <div class="form-group">
                        <label for="url"><%=Tag("跳转页面")%>：</label>
                        <div class="input-group">
                            <input type="text" id="url" name="url" value="<%=page.url %>" class="form-control" shop="true">
                            <div class="input-group-append">
                                <select name="target" shop="true" class="form-control">
                                    <option value="_self" <%=page.target=="_self"?"selected":"" %>><%=Tag("当前窗口")%></option>
                                    <option value="_blank" <%=page.target=="_blank"?"selected":"" %>><%=Tag("新窗口")%></option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="Count_Views"><%=Tag("浏览次数")%>：</label>
                                <input type="text" id="Count_Views" name="Count_Views" value="<%=page.Count_Views %>" class="form-control" shop="true">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="Sort"><%=Tag("排序序号")%>：</label>
                                <input type="text" id="Sort" name="Sort" value="<%=page.Sort %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="Time_Add"><%=Tag("提交时间")%>：</label>
                                <input type="text" id="Time_Add" name="Time_Add" value="<%=page.Time_Add %>" class="form-control" shop="true">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Language_ids"><%=Tag("语言")%>：</label>
                        <%=Shop.Bussiness.Language.SiteLanguageCheckbox("Language_ids", page.Language_ids,CurrentLanguage.Code,CurrentAdmin)%>
                    </div>
                    <h5 class="box-title m-t-20"><%=Tag("SEO优化")%></h5>
                    <div class="form-group">
                        <label for="SEO_Title"><%=Tag("网页标题")%>：</label>
                        <input type="text" id="SEO_Title" name="SEO_Title" value="<%=page.SEO_Title %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="SEO_Keywords"><%=Tag("关键词")%>：</label>
                        <input type="text" id="SEO_Keywords" name="SEO_Keywords" value="<%=page.SEO_Keywords %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="SEO_Description"><%=Tag("网页描述")%>：</label>
                        <input type="text" id="SEO_Description" name="SEO_Description" value="<%=page.SEO_Description %>" class="form-control" shop="true">
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
    <script src="<%=site.AdminAssetsPath %>/plugins/lightbox/lightbox.min.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/bigcolorpicker/jquery.bigcolorpicker.min.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/moment/moment.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.js"></script>
    <script src="<%=site.AdminJsPath %>/ajaxfileupload.js"></script>
    <script>
        $('#Time_Add').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            timePicker24Hour: true,
            timePicker: true,
            locale: { format: 'YYYY-MM-DD hh:mm:s' }
        });
        $(function () {
            $("#NameColor").bigColorpicker("NameColor");
            $("#s_NameColor").bigColorpicker(function (el, color) { $(el).css("background-color", color); $("#NameColor").val(color); $("#Name").css("color", color); });
        });
        ! function (window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        CKEDITOR.replace('Content', {
            height: '200',
            width: '98%',
            language: '<%=Tag("CKEditor语言")%>'
        });
        function uploadImage(id) {
            $.ajaxFileUpload({
                url: WebPath + '/ajax/imageuploadone.aspx?path=cms',
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
                            $("#image_" + id + "").html('<img src="' + WebPath + imageUrl + '" height="20">');
                            $("#" + id + "").val(imageUrl);
                        }
                    }
                },
                error: function (data, status, e) {
                    MsgBox(2, data.error, "");
                }
            })
        }
        function SaveObj() {
            var postData = GetFormJsonData("shop");
            var nodeid = $("#Node_id").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_node.aspx?__Action=Page_Edit&id=<%=page.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "pagelist.aspx?Node_id=" + nodeid + "") });
        }
    </script>

</body>
</html>