<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Express_Print" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=model.Name %>-<%=Tag("单据打印")%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
<style>body{background:#fff;margin:0;padding:0;font-size:12px;text-align:left;overflow:scroll}input{font-size:12px}.box{margin:0;POSITION: relative;width:<%=model.Width %>px;height:<%=model.Height %>px;background:url(<%=WebPath + model.Background %>) no-repeat;overflow:hidden}</style>
<style media=print>.box{POSITION: relative;width:<%=model.Width %>px;height:<%=model.Height %>px;background:none;overflow:hidden}.print-btn{display:none;}</style>

    <script>
        var AdminPath = "<%=site.AdminPath %>";var WebPath ="<%=site.WebPath %>";var AdminImagePath = "<%=site.AdminImagePath %>";var requestPage = "<%=LB.Tools.RequestTool.GetRequestUrl().ToLower() %>";var refPage = "<%=LB.Tools.RequestTool.GetUrlReferrer().ToLower() %>";
    </script>
</head>
<body class="fix-sidebar fix-header card-no-border">
	
    <div id="main-wrapper">
        <div class="container-fluid">
            <div class="row page-titles print-btn">
                <div class="col-md-12 col-12 align-self-center">
                    <button class="btn btn-info" onclick="Print('<%=id %>',<%=Tid %>,<%=Eid %>);"><i class="ti-printer"></i> <%=Tag("打印")%></button>
                    <button class="btn btn-default" onclick="window.close();"><i class="ti-close"></i> <%=Tag("关闭")%></button>
                </div>
            </div>
            <div class="row with-titles-flex">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <% PrintTable(); %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function Print(id, Tid, Eid) {
            var postData = "";
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Express_Print&id=" + id + "&Tid=" + Tid + "&Eid=" + Eid;
            RequestAjax(url, postData, function () { $("#div_error").dialog('close'); setTimeout(function () { window.print(); }, 1000); });
        }
    </script>

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
    
</body>
</html>