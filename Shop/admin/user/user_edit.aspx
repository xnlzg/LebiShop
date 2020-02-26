<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.user.User_Edit" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%if (model.id != 0){ %><%=Tag("编辑会员")%> <%=model.UserName %><%}else{ %><%=Tag("会员添加")%><%}%>-<%=Tag("会员管理")%>-<%=site.title%></title>

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
                        
    <h3 class="text-themecolor m-b-0 m-t-0"><%=Tag("会员管理")%></h3>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a></li>
        <li class="breadcrumb-item"><a href="<%=site.AdminPath %>/user/default.aspx"><%=Tag("会员管理")%></a></li>
        <li class="breadcrumb-item active"><%if (model.id != 0){ %><%=model.UserName %><%}else{ %><%=Tag("会员添加")%><%}%></li>
    </ol>

                    </div>
                </div>
                <div class="row">
					<%if (PageReturnMsg == ""){%>
						
						
					<%}%>
						<%if (PageReturnMsg == ""){%>
						
    <div class="col-xlg-2 col-lg-3 col-md-3">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="card-body inbox-panel p-t-0 p-b-0">
                        <ul class="list-group list-group-full">
                            <li class="list-group-item active"><a href="user_edit.aspx?id=<%=model.id %>"><i class="ti-user"></i> <%if (model.id != 0){ %><%=Tag("编辑会员")%><%}else{ %><%=Tag("会员添加")%><%}%></a></li>
                            <%if (model.id > 0){ %>
                            <li class="list-group-item"><a href="javascript:void(0)" onclick="EditPassword(<%=model.id %>);"><i class="ti-key"></i> <%=Tag("改密")%></a></li>
                            <li class="list-group-item"><a href="javascript:void(0)" onclick="Question(<%=model.id %>);"><i class="ti-lock"></i> <%=Tag("安全问题")%></a></li>
                            <li class="list-group-item"><a href="UserMoney.aspx?user_id=<%=model.id %>" target="_blank"><i class="ti-money"></i> <%=Tag("资金")%></a></li>
                            <li class="list-group-item"><a href="UserPoint.aspx?user_id=<%=model.id %>" target="_blank"><i class="ti-id-badge"></i> <%=Tag("积分")%></a></li>
                            <li class="list-group-item"><a href="../promotion/cardlist.aspx?user_id=<%=model.id %>&type=311" target="_blank"><i class="ti-credit-card"></i> <%=Tag("购物卡")%></a></li>
                            <li class="list-group-item"><a href="../promotion/cardlist.aspx?user_id=<%=model.id %>&type=312" target="_blank"><i class="ti-gift"></i> <%=Tag("代金券")%></a></li>
                            <li class="list-group-item"><a href="Message.aspx?user_id=<%=model.id %>" target="_blank"><i class="ti-email"></i> <%=Tag("站内信")%></a></li>
                            <li class="list-group-item"><a href="OftenBuy.aspx?user_id=<%=model.id %>" target="_blank"><i class="ti-shopping-cart"></i> <%=Tag("常购清单")%></a></li>
                            <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_agent")){ %>
                            <li class="list-group-item"><a href="../agent/agentmoney.aspx?user_id=<%=model.id %>" target="_blank"><i class="ti-money"></i> <%=Tag("佣金")%></a></li>
                            <%} %>
                            <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_productlimit")){%>
                            <li class="list-group-item"><a href="javascript:void(0)" onclick="ProductLimit(<%=model.id %>,'<%=model.UserName%>');"><i class="ti-light-bulb"></i> <%=Tag("商品权限")%></a></li>
                            <%} %>
                            <li class="list-group-item text-danger"><a href="javascript:void(0)" onclick="DeleteConfirm(<%=model.id %>)"><i class="ti-trash"></i> <%=Tag("删除")%></a></li>
                            <li class="list-group-item"><a href="login.aspx?id=<%=model.id %>" target="_blank"><i class="ti-new-window"></i> <%=Tag("管理")%></a></li>
                            <%}%>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <%if (model.id > 0){ %>
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="card-body inbox-panel p-t-0 p-b-0">
                        <ul class="list-group list-group-full">
                            <li class="list-group-item"><a href="../order/?user_id=<%=model.id %>" target="_blank"><i class="ti-shopping-cart"></i> <%=Tag("订单")%></a></li>
                            <li class="list-group-item"><a href="javascript:void(0)" onclick="AddOrder(<%=model.id %>);"><i class="ti-plus"></i> <%=Tag("下单")%></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
    </div>
    <div class="col-xlg-10 col-lg-9 col-md-9">
        <div class="card">
            <div class="card-body">
                <%if (PageReturnMsg == ""){%>
                <form action="javascript:SaveObj();" novalidate>
                    <%if (model.id > 0){ %>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for=""><%=Tag("会员帐号")%>：</label>
                                <%=model.UserName %>
                            </div>
                        </div>
                        <%if (domain3admin){ %>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="Site_id"><%=Tag("站点")%>：</label>
                                <%=SiteName(model.Site_id,model.DT_id, CurrentLanguage.Code)%>
                            </div>
                        </div>
                        <%}%>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for=""><%=Tag("注册日期")%>：</label>
                                <%=FormatTime(model.Time_Reg) %>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for=""><%=Tag("上次登陆")%>：</label>
                                <%=FormatTime(model.Time_Last) %>&nbsp;&nbsp;<%=Tag("IP")%>：<a href="http://www.ip138.com/ips138.asp?ip=<%=model.IP_Last%>&action=2" target="_blank"><%=model.IP_Last %></a>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for=""><%=Tag("最后登陆")%>：</label>
                                <%=FormatTime(model.Time_This) %>&nbsp;&nbsp;<%=Tag("IP")%>：<a href="http://www.ip138.com/ips138.asp?ip=<%=model.IP_This%>&action=2" target="_blank"><%=model.IP_This %></a>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for=""><%=Tag("登录次数")%>：</label>
                                <%=model.Count_Login %>
                            </div>
                        </div>
                    </div>
                    <hr class="m-t-10 m-b-20" />
                    <%}%>
                    <div class="form-group">
                        <label for="Sex_1"><%=Tag("性别")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-radio m-r-20">
                                <input type="radio" id="Sex_1" name="Sex" value="男" class="custom-control-input" shop="true" <%=model.Sex=="男"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("男")%></span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" id="Sex_0" name="Sex" value="女" class="custom-control-input" shop="true" <%=model.Sex=="女"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("女")%></span>
                            </label>
                        </div>
                    </div>
                    <%if (model.id == 0){ %>
                    <div class="form-group">
                        <label for="UserName"><%=Tag("会员帐号")%>：</label>
                        <input type="text" id="UserName" name="UserName" class="form-control" shop="true" onchange="CheckUserName();" required>
                        <small class="form-text text-danger" id="UserName_mes"></small>
                    </div>
                    <div class="form-group">
                        <label for="PWD1"><%=Tag("密码")%>：</label>
                        <input type="password" id="PWD1" name="PWD1" value="" class="form-control" shop="true" required>
                    </div>
                    <div class="form-group">
                        <label for="PWD2"><%=Tag("再次输入")%>：</label>
                        <input type="password" id="PWD2" name="PWD2" class="form-control" shop="true" required>
                    </div>
                    <%}%>
                    <div class="form-group">
                        <label for="RealName"><%=Tag("真实姓名")%>：</label>
                        <input type="text" id="RealName" name="RealName" value="<%=model.RealName %>" class="form-control" shop="true" required>
                    </div>
                    <div class="form-group">
                        <label for="NickName"><%=Tag("昵称")%>：</label>
                        <input type="text" id="NickName" name="NickName" value="<%=model.NickName %>" class="form-control" shop="true" required>
                    </div>
                    <div class="form-group">
                        <label for="Birthday"><%=Tag("出生日期")%>：</label>
                        <input type="text" id="Birthday" name="Birthday" value="<%if (model.id > 0){Response.Write(FormatDate(model.Birthday));} %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="MobilePhone"><%=Tag("手机号码")%>：</label>
                        <input type="text" id="MobilePhone" name="MobilePhone" value="<%=model.MobilePhone %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="Phone"><%=Tag("电话号码")%>：</label>
                        <input type="text" id="Phone" name="Phone" value="<%=model.Phone %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="Fax"><%=Tag("传真号码")%>：</label>
                        <input type="text" id="Fax" name="Fax" value="<%=model.Fax %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="QQ"><%=Tag("QQ号码")%>：</label>
                        <input type="text" id="QQ" name="QQ" value="<%=model.QQ %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="Email"><%=Tag("Email地址")%>：</label>
                        <input type="text" id="Email" name="Email" value="<%=model.Email %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="UserLevel_id"><%=Tag("会员分组")%>：</label>
                        <select id="UserLevel_id" name="UserLevel_id" class="form-control" shop="true">
                            <option value="0"><%=Tag("会员分组")%></option>
                            <%=Shop.Bussiness.EX_User.TypeOption("grade > 0", model.UserLevel_id, CurrentLanguage.Code)%>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="Language"><%=Tag("语言")%>：</label>
                        <select id="Language" name="Language" class="form-control" shop="true">
                            <%= Shop.Bussiness.Language.LanguageOption(model.Language)%>
                        </select>
                    </div>
                    <%if (model.id > 0){%>
                    <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_agent")){ %>
                    <div class="form-group">
                        <label for="User_id_parent"><%=Tag("上级用户")%>：</label>
                        <div class="input-group">
                            <input type="text" id="User_id_parent" name="User_id_parent" value="<%=model.User_id_parent %>" class="form-control" shop="true">
                            <div class="input-group-append">
                                <span class="input-group-text"><a href="../agent/agentuser.aspx?parent_id=<%=model.User_id_parent %>" target="_blank"><%=Shop.Bussiness.EX_User.GetUser(model.User_id_parent).UserName%></a></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for=""><%=Tag("下级用户")%>：</label>
                        <a href="../agent/agentuser.aspx?id=<%=model.id %>" target="_blank"><%=Shop.Bussiness.Common.GetValue("select count(1) from Lebi_User where User_id_parent="+model.id+"") %></a>
                    </div>
                    <%} %>
                    <div class="form-group">
                        <label for=""><%=Tag("绑定")%>：</label>
                        <div class="input-group">
                            <%
                            if (model.bind_weixin_id != "")
                            {
                            Response.Write("<img src=\"" + SYS.platform_weixin_image + "\" height=\"24px\" />");
                            }
                            if (model.bind_weibo_id != "")
                            {
                            Response.Write("<img src=\"" + SYS.platform_weibo_image + "\" height=\"24px\" />");
                            }
                            if (model.bind_qq_id != "")
                            {
                            Response.Write("<img src=\"" + SYS.platform_qq_image + "\" height=\"24px\" />");
                            }
                            if (model.bind_taobao_id != "")
                            {
                            Response.Write("<img src=\"" + SYS.platform_taobao_image + "\" height=\"24px\" />");
                            }
                            if (model.bind_facebook_id != "")
                            {
                            Response.Write("<img src=\"" + SYS.platform_facebook_image + "\" height=\"24px\" />");
                            }
                            %>
                        </div>
                    </div>
                    <%} %>
                    <div class="form-group">
                        <label for="UserNumber"><%=Tag("会员编号")%>：</label>
                        <input type="text" id="UserNumber" name="UserNumber" value="<%=model.UserNumber %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="Time_End"><%=Tag("有效期")%>：</label>
                        <input type="text" id="Time_End" name="Time_End" value="<%=FormatDate(model.Time_End)%>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="Introduce"><%=Tag("内部备注")%>：</label>
                        <textarea id="Introduce" name="Introduce" class="form-control" style="height: 60px;" shop="true" onKeyDown="checkMaxInput(this.form)" onKeyUp="checkMaxInput(this.form)"><%=model.Introduce%></textarea>
                        <small class="form-text text-muted">≤ <span id="remLen">255</span></small>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Introduce',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Introduce',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
                </form>
                <%}%>
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
	
    <script src="<%=site.AdminAssetsPath %>/plugins/moment/moment.js"></script>
    <script src="<%=site.AdminAssetsPath %>/plugins/daterangepicker/daterangepicker.js"></script>
    <script>
        $('#Birthday').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            timePicker24Hour: false,
            timePicker: false,
            locale: { format: 'YYYY-MM-DD' }
        });
        $('#Time_End').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            timePicker24Hour: false,
            timePicker: false,
            locale: { format: 'YYYY-MM-DD' }
        });
        ! function (window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        var maxLen = 255;
        var Introduce = document.getElementById("Introduce");
        function checkMaxInput(form) {
            if (Introduce.value.length > maxLen)
                Introduce.value = Introduce.value.substring(0, maxLen);
            else document.getElementById("remLen").innerHTML = maxLen - Introduce.value.length;
        }
        function SaveObj() {
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=User_Edit&id=<%=model.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "default.aspx") });
        }
        function CheckUserName() {
            var UserName = $("#UserName").val();
            var postData = { "UserName": UserName };
            var url = "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=CheckUserName&id=<%=model.id %>";
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: 'json',
                success: function (res) {
                    if (res.msg == "OK")
                        $("#UserName_mes").html("");
                    else
                        $("#UserName_mes").html("<%=Tag("用户名已经存在") %>");
                }
            });
        }
        function DeleteConfirm(id) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "Delete(" + id + ");");
        }
        function Delete(id) {
            $("#Modal-Confirm").modal("hide");
            var postData = { "ids": id };
            var url = "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=User_Del";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "default.aspx") });
        }
        function EditPassword(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "userpassword_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function Question(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "userquestion_edit_window.aspx",
                type: "GET",
                cache: false,
                data: { id: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
        function AddOrder(id) {
            $("#EditModal").modal("show");
            $.ajax({
                url: "<%=site.AdminPath %>/order/order_add_window.aspx",
                type: "GET",
                cache: false,
                data: { userid: id },
            }).done(function (result) {
                $("#EditModal .modal-content").html(result);
            });
        }
            <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_productlimit")) {%>
            function ProductLimit(id, name) {
                window.open("<%=site.AdminPath %>/product/productlimit_user.aspx?userid=" + id);
                return;
                var title_ = "<%=Tag("商品权限")%>-" + name;
                var url_ = "<%=site.AdminPath %>/product/productlimit_window.aspx?userid=" + id;
                var width_ = 900;
                var height_ = 750;
                var modal_ = true;
                EditWindow(title_, url_, width_, height_, modal_, 'selectproduct');
            }
            <%}%>
    </script>

</body>
</html>