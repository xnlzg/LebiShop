<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Order_Edit" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("订单管理")%>-<%=site.title%></title>

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
                        
    <div class="tools">
        <ul>
            <%if (PageReturnMsg == ""){%>
            <li class="submit"><a href="javascript:void(0);" onclick="SaveOrder();"><b></b><span><%=Tag("保存")%></span></a></li>
            <%}%>
            <li class="rotate"><a href="javascript:void(0);" onclick="history.back();"><b></b><span><%=Tag("返回")%></span></a></li>
            <li class="name"><span id="navIgation"><%=Tag("当前位置")%>：<a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a>
                > <a href="<%=site.AdminPath %>/order/default.aspx"><%=Tag("订单管理")%></a> >
                <%=model.Code %>
            </span></li>
        </ul>
    </div>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <table class="datalist" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr class="title">
            <th colspan="4">
                <%=Tag("基本信息")%>：
            </th>
        </tr>
        <tr class="list">
            <td style="width: 100px;">
                <%=Tag("订单编号")%>：
            </td>
            <td style="width: 350px;">
                <%=model.Code%>
            </td>
            <td style="width: 100px;">
                <%=Tag("订购时间")%>：
            </td>
            <td>
                <%=FormatTime(model.Time_Add) %>
            </td>
        </tr>
        <tr class="list">
            <td>
                <%=Tag("订单金额")%>：
            </td>
            <td colspan="3">
                <%=Tag("总金额")%>：<%=model.Money_Order%>

                <%=Tag("商品")%>：<%=model.Money_Product%>

                <%=Tag("运费")%>：<%=model.Money_Transport%>

                <%=Tag("税金")%>：<%=model.Money_Bill%>
            </td>
        </tr>
        <tr class="list">
            <td>
                <%=Tag("获得积分")%>：
            </td>
            <td colspan="3">
                <%=model.Point%>
            </td>
        </tr>
        <tr class="list">
            <td>
                <%=Tag("配送方式")%>：
            </td>
            <td>
                <%=model.Transport_Name%>
            </td>
            <td>
                <%=Tag("支付方式")%>：
            </td>
            <td>
                <%=Shop.Bussiness.Language.Content(model.Pay,CurrentLanguage)%>
            </td>
        </tr>

    </table>

    <table class="datalist" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr class="title">
            <th colspan="4">
                <%=Tag("收货人信息")%>： <a href="javascript:Editshouhuo();"><%=Tag("编辑")%></a>
            </th>
        </tr>
        <tr class="list">
            <td style="width: 100px;">
                <%=Tag("收货人")%>：
            </td>
            <td style="width: 350px;">
                <%=model.T_Name %>
            </td>
            <td style="width: 100px;">
                <%=Tag("邮箱")%>：
            </td>
            <td>
                <%=model.T_Email %>
            </td>
        </tr>
        <tr class="list">
            <td >
                <%=Tag("手机")%>：
            </td>
            <td >
                <%=model.T_MobilePhone %>
            </td>
            <td >
                <%=Tag("电话")%>：
            </td>
            <td>
                <%=model.T_Phone %>
            </td>
        </tr>
        <tr class="list">
            <td >
                <%=Tag("邮编")%>：
            </td>
            <td >
                <%=model.T_Postalcode %>
            </td>
            <td >
                <%=Tag("地区")%>：
            </td>
            <td >
                <%=Shop.Bussiness.EX_Area.GetAreaName(model.T_Area_id)%>
            </td>
        </tr>
        <tr class="list">
            <td >
                <%=Tag("地址")%>：
            </td>
            <td colspan="3" >
                <%=model.T_Address %>
            </td>
            
        </tr>
    </table>
   
       <table class="datalist" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr class="title">
            <th colspan="4">
                <%=Tag("订单状态")%>： 
            </th>
        </tr>
        <tr class="list">
            <td style="width: 100px;">
                <%=Tag("状态")%>：
            </td>
            
            <td>
                <input type="checkbox" value="1" shop="true" name="IsVerified" <%=model.IsVerified==1?"checked":"" %> />
                <%=Tag("确认")%>
                <input type="checkbox" value="1" shop="true" name="IsPaid" <%=model.IsPaid==1?"checked":"" %> />
                <%=Tag("支付")%>
                <input type="checkbox" value="1" shop="true" name="IsShipped" <%=model.IsShipped==1?"checked":"" %> />
                <%=Tag("发货")%>
                <input type="checkbox" value="1" shop="true" name="IsReceived" <%=model.IsReceived==1?"checked":"" %> />
                <%=Tag("收货")%>
                <input type="checkbox" value="1" shop="true" name="IsCompleted" <%=model.IsCompleted==1?"checked":"" %> />
                <%=Tag("完成")%>
                <input type="checkbox" value="1" shop="true" name="IsInvalid" <%=model.IsInvalid==1?"checked":"" %> />
                <%=Tag("无效")%> 
            </td>
        </tr>

        <tr class="list">
            <td >
                <%=Tag("内部备注")%>：
            </td>
                
            <td>
                <textarea id="Remark_Admin" shop="true" class="input" style="width:600px;height:80px;"><%=model.Remark_Admin%></textarea>
            </td>
        </tr>
    </table>

    <table class="datalist" border="0" cellpadding="0" cellspacing="0" width="100%">
       <tr class="title">
            <th colspan="4">
                <%=Tag("订单商品")%>：<a href="javascript:Pro_Del();"><%=Tag("删除所选")%></a> <a href="javascript:Pro_Save();"><%=Tag("保存")%></a>
            </th>
        </tr>
        <tr class="title">
             <th style="width: 40px" class="selectAll">
                <a href="javascript:void(0);" onclick="$('input[name=\'id\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a>
            </th>
            <th style="width: 100px">
                <%=Tag("图片")%>
            </th>
            <th style="width: 100px">
                <%=Tag("编号")%>
            </th>
            <th >
                <%=Tag("名称")%>
            </th>
            <th style="width: 100px">
                <%=Tag("数量")%>
            </th>
            <th style="width: 100px">
                <%=Tag("金额")%>
            </th>
            <th style="width: 100px">
                <%=Tag("小计")%>
            </th>
        </tr>
        <%foreach (DB.LebiShop.Lebi_Order_Product pro in pros)
          { %>
        <tr class="list">
             <td>
                <input type="checkbox" name="proid" value="<%=pro.id %>" del="true" />
                <input type="hidden" name="proid" value="<%=pro.id %>" pro="true" style="display:none" />
             </td>
             <td>
                <img src="<%=pro.ImageSmall %>" style="width:30px" />
             </td>
             <td>
                
             </td>
             <td>
                <%=Shop.Bussiness.Language.Content(pro.Product_Name,CurrentLanguage) %>
             </td>
             <td>
                <input type="text" class="input" pro="true" name="Count<%=pro.id %>"  id="Count<%=pro.id %>" value="<%=pro.Count %>" onkeyup="value=value.replace(/[^\d]/g,'')" style="width: 70px;" />
             </td>
             <td>
                <input type="text" class="input" pro="true" name="Price<%=pro.id %>" id="Price<%=pro.id %>" value="<%=pro.Price %>" onkeyup="value=value.replace(/[^\d]/g,'')" style="width: 70px;" />
             </td>
             <td>
                <%=pro.Money%>
             </td>
        </tr>
        <% } %>
    </table>
    <script>
        function SaveOrder() {
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function Editshouhuo() {
            var title_ = "<%=Tag("编辑收货人")%>";
            var url_ = "shouhuo_Edit_window.aspx?id=<%=model.id %>";
            var width_ = 600;
            var height_ = "auto";
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_);
        }
        function Pro_Del() {
            if (!confirm("<%=Tag("确认要删除吗？")%>"))
                return false;
            var postData = GetFormJsonData("del");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=OrderPro_Del&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function Pro_Save() {
            var postData = GetFormJsonData("pro");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=OrderPro_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

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