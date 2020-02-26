<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Login" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=Tag("管理登陆")%>-<%=site.title%></title>

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
	
    <section id="wrapper" class="login-register login-sidebar" style="background-image:url('<%=Shop.Bussiness.ShopCache.GetBaseConfig().system_login_background %>');">
        <div class="login-box card">
            <div class="card-body">
                <form id="loginform" action="javascript:Login();" novalidate>
                    <a href="javascript:void(0)" class="text-center db"><img src="<%=Shop.Bussiness.ShopCache.GetBaseConfig().system_login_logo %>" /></a>
                    <div class="form-group m-t-40">
                        <div class="col-xs-12">
                            <input type="text" id="adminUserName" name="adminUserName" value="<%=LB.Tools.CookieTool.GetCookieString("AdminUserName") %>" class="form-control" required placeholder="<%=Tag("请输入用户名")%>" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-12">
                            <input type="password" id="adminPwd" name="adminPwd" class="form-control" required placeholder="<%=Tag("请输入密码")%>" />
                        </div>
                    </div>
                    <%if (SYS.Verifycode_AdminLogin=="1"){ %>
                    <div id="code" class="form-group" <%if (LoginError != true){ %>style="display:none"<%}else{ %>style="display:" <%} %>>
                        <div class="col-xs-12">
                            <div class="input-group">
                                <input type="text" id="txt_yz" name="txt_yz" class="form-control" placeholder="<%=Tag("验证码")%>" />
                                <div class="input-group-append">
                                   <img class="verifycode" id="img1" src="../code.aspx" title="<%=Tag("点击刷新验证码")%>" onclick="refresh('img1')" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <%} %>
                    <div class="form-group">
                        <div class="d-flex no-block align-items-center">
                            <div class="custom-control custom-checkbox p-t-0">
                                <input type="checkbox" id="saveusername" name="saveusername" value="1" class="custom-control-input" checked />
                                <span class="custom-control-label"><%=Tag("记住用户名")%></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group text-center m-t-20">
                        <div class="col-xs-12">
                            <button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light" type="submit"><%=Tag("登陆")%></button>
                        </div>
                    </div>
                    <div class="form-group m-b-0">
                        <div id="mes" class="col-sm-12 text-center">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>

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
    <script>
        ! function (window, document, $) {
            "use strict";
            $("input").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function Login() {
            var userName = $("#adminUserName").val();
            var userPwd = $("#adminPwd").val();
            var code = $("#txt_yz").val();
            var saveusername = $("#saveusername").val();
            if (userName == "" || userName == "<%=Tag("请输入用户名")%>") {
                $("#mes").html("<%=Tag("请输入用户名")%>");
                return;
            }
            if (userPwd == "" || userPwd == "<%=Tag("请输入密码")%>") {
                $("#mes").html("<%=Tag("请输入密码")%>");
                return;
            }
            <%if (LoginError && SYS.Verifycode_AdminLogin == "1") { %>
            if (code == "") {
                $("#mes").html("<%=Tag("请输入验证码")%>");
                return;
            }
            <%} %>
            $.ajax({
                type: "POST",
                url: "<%=site.AdminPath%>/ajax/ajax_login.aspx?__Action=AdminLogin",
                data: { UserName: userName, UserPWD: userPwd, code: code, saveusername: saveusername },
                beforeSend: function () {
                    $("#mes").html("<%=Tag("正在登录")%>……");
                },
                success: function (res) {
                    if (res == "OK") {
                        $("#mes").html("<%=Tag("登录成功，请稍后")%>……");
                        location.href = "<%=url%>";
                    }
                    else {
                        $("#mes").html(res);
                        $("#code").show();
                    }
                }
            });
        }
        function refresh(id) {
            $("#" + id + "").attr("src", "../code.aspx?t=" + Math.random());
        }
    </script>

</body>
</html>