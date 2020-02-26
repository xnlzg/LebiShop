<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.admin.product.datainout" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title>
        <%=Tag("数据导入导出")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("数据导入导出")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item active"><%=Tag("数据导入导出")%></li>
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
                <h4 class="card-title"><%=Tag("数据导入")%></h4>
                <form action="javascript:tb_product_in();" novalidate>
                    <div class="form-group">
                        <label for="tb_typeid"><%=Tag("导入分类")%>：</label>
                        <div id="shopnick" class="input-group">
                            <select id="tb_typeid" name="tb_typeid" shop="true" class="form-control">
                                <%=Shop.Bussiness.EX_Product.TypeOption(0,0,0,CurrentLanguage.Code)%>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="datatype"><%=Tag("数据格式")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio">
                                <input type="checkbox" id="datatype" name="datatype" value="1" class="custom-control-input" shop="true" checked>
                                <span class="custom-control-label"><%=Tag("淘宝CSV")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="tb_file"><%=Tag("数据文件")%>：</label>
                        <div class="input-group">
                            <input type="text" id="tb_file" name="tb_file" shop="true" class="form-control">
                            <div class="input-group-append fileupload">
                                <span class="input-group-text" id="image_tb_file"><i class="ti-upload"></i></span>
                                <input type="file" id="file_tb_file" name="file_tb_file" class="upload" onchange="uploadImage('tb_file')">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="tb_folder"><%=Tag("图片文件夹")%>：</label>
                        <input type="text" id="tb_folder" name="tb_folder" class="form-control" shop="true">
                        <small class="form-text text-muted"><%=Tag("相对安装路径，以/开头和结尾")%></small>
                    </div>
                    <div class="form-group">
                        <label for="tb_split_2"><%=Tag("分隔符")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="tb_split_2" name="tb_split" value="2" class="custom-control-input" shop="true" checked>
                                <span class="custom-control-label"><%=Tag("逗号(,)")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="tb_split_1" name="tb_split" value="1" class="custom-control-input" shop="true">
                                <span class="custom-control-label"><%=Tag("制表符(/t)")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="tbin_lang"><%=Tag("语言")%>：</label>
                        <select id="tbin_lang" name="tbin_lang" class="form-control" shop="true">
                            <%=Shop.Bussiness.Language.LanguageOption(CurrentLanguage.Code)%>
                        </select>
                    </div>
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("提交")%></button>
                    <%}%>
                </form>
            </div>
        </div>
        <div class="card">
            <div class="card-body">
                <h4 class="card-title"><%=Tag("数据导出")%></h4>
                <form action="javascript:tb_product_out();" novalidate>
                    <div class="form-group">
                        <label for=""><%=Tag("导出范围")%>：</label>
                        <div class="input-group">
                            <a href="javascript:void(0);" onclick="SearchWindow();"><%=Tag("高级搜索")%></a>
                            <%=sp.Description%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Wornings"><%=Tag("数量")%>：</label>
                        <div class="input-group">
                            <%=DB.LebiShop.B_Lebi_Product.Counts("Product_id=0 "+sp.SQL) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="tb_lang"><%=Tag("语言")%>：</label>
                        <select id="tb_lang" name="tb_lang" class="form-control" shop="true">
                            <%=Shop.Bussiness.Language.LanguageOption(CurrentLanguage.Code)%>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="datatype2"><%=Tag("数据格式")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio">
                                <input type="checkbox" id="datatype2" name="datatype2" value="1" class="custom-control-input" shop="true" checked>
                                <span class="custom-control-label"><%=Tag("淘宝CSV")%></span>
                            </label>
                        </div>
                    </div>
                    <div id="tr_down" class="form-group">
                        <label for=""><%=Tag("下载")%>：</label>
                        <div id="down_url" class="input-group">
                        </div>
                    </div>
                    <%if (PageReturnMsg == ""){%>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("提交")%></button>
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
	
    <script src="<%=site.AdminJsPath %>/ajaxfileupload.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/multiselect/js/jquery.multiselect2side.js"></script>
    <script>
        function tb_product_in() {
            var tb_typeid = $("#tb_typeid").val();
            var tb_file = $("#tb_file").val();
            var tb_folder = $("#tb_folder").val();
            var tb_split = $("input[name='tb_split']:checked").val();
            var tbin_lang = $("#tbin_lang").val();
            var url = "<%=site.AdminPath %>/ajax/export.aspx?__Action=taobao_product_in";
            var postData = { "tb_typeid": tb_typeid, "tb_file": tb_file, "tb_folder": tb_folder, "tb_split": tb_split, "tbin_lang": tbin_lang };
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: 'json',
                beforeSend: function () {
                    MsgBox(4, "正在处理 ……", "-");
                },
                success: function (res) {
                    if (res.msg == "OK") {
                        MsgBox(1, "<%=Tag("操作成功") %>：" + res.count, "");
                    }
                    else {
                        MsgBox(2, res.msg, "");
                        return false;
                    }
                }
            });
        }
        function SearchWindow() {
            var url_ = "../product/product_search_window.aspx?callback=search_&<%=sp.URL %>";
            $("#EditModal").modal("show");
            $.ajax({
                url: url_,
                type: "GET",
                cache: false,
                data: {},
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function search_(scurl) {
            window.location = "?" + scurl;
        }
        function tb_product_out() {
            var lang = $("#tb_lang").val();
            var url = "<%=site.AdminPath %>/ajax/export.aspx?__Action=taobao_product_out&lang=" + lang + "&<%=sp.URL %>";
            $.ajax({
                type: "POST",
                url: url,
                data: '',
                dataType: 'json',
                beforeSend: function () {
                    MsgBox(4, "<%=Tag("正在处理") %> ……", "-");
                },
                success: function (res) {
                    if (res.msg == "OK") {
                        $("#tr_down").show()
                        $("#down_url").html("<a href=\"" + res.url + "\" target=\"_blank\">" + res.url + "</a>");
                        MsgBox(1, "<%=Tag("操作成功") %>", "");
                    }
                    else {
                        MsgBox(2, res.msg, "");
                        return false;
                    }
                }
            });
        }
    </script>

</body>
</html>