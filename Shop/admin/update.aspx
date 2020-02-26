<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.update" validateRequest="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
	<meta name="author" content="LebiShop" />
	
    <title><%=model.Version%>.<%=model.Version_Son%>-<%=site.title%></title>

    <link href="<%=site.AdminAssetsPath %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=site.AdminAssetsPath %>/plugins/jqueryui/jquery-ui.min.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/style.css" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/colors/blue.css" id="theme" rel="stylesheet">
    <link href="<%=site.AdminCssPath %>/custom.css" rel="stylesheet">
    
    
    <style>
        .input-group div {
            width: 100%;
        }
    </style>
    <style media=print>
        .print-btn {
            display: none;
        }
    </style>

    <script>
        var AdminPath = "<%=site.AdminPath %>";var WebPath ="<%=site.WebPath %>";var AdminImagePath = "<%=site.AdminImagePath %>";var requestPage = "<%=LB.Tools.RequestTool.GetRequestUrl().ToLower() %>";var refPage = "<%=LB.Tools.RequestTool.GetUrlReferrer().ToLower() %>";
    </script>
</head>
<body class="fix-sidebar fix-header card-no-border">
	
    <div id="main-wrapper">
        <div class="container-fluid">
            <div class="row page-titles print-btn">
                <div class="col-md-12 col-12 align-self-center">
                    <div class="row">
                        <div class="col-md-9 align-self-center">
                            <%if (model.IsUpdate != 1){ %>
                            <button class="btn btn-success" onclick="update();"><i class="ti-check"></i> <%=Tag("开始升级")%></button>
                            <%if (model.Path_rar != ""){%>
                            <button class="btn btn-danger" onclick="Version_UpdateOK(<%=model.id%>);"><i class="ti-na"></i> <%=Tag("已更新")%></button>
                            <button class="btn btn-default" onclick="location.href='<%=Shop.LebiAPI.Service.Instanse.downurl %><%=model.Path_rar%>'"><i class="ti-download"></i> <%=Tag("下载")%></button>
                            <%}%>
                            <%}%>
                        </div>
                        <div class="col-md-3 align-self-center">
                            <div class="d-flex justify-content-end">
                                <button class="btn btn-info m-r-5" onclick="window.print();"><i class="ti-printer"></i> <%=Tag("打印")%></button>
                                <button class="btn btn-default" onclick="window.close();"><i class="ti-close"></i> <%=Tag("关闭")%></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="box-title"><%=model.Version%>.<%=model.Version_Son%></h3>
                            <%if (model.IsUpdate == 1){ %>
                            <div class="form-group">
                                <label><%=Tag("状态")%>：</label>
                                <%=Tag("已更新")%>
                            </div>
                            <%}else{ %>
                            <div class="form-group">
                                <label><%=Tag("下载")%>：</label>
                                <span class="form-control-label" id="status_down"><%=IsDown?Tag("已下载"):"-" %></span>
                            </div>
                            <div class="form-group">
                                <label><%=Tag("升级数据库")%>：</label>
                                <span class="form-control-label" id="status_db">-</span>
                            </div>
                            <div class="form-group">
                                <label><%=Tag("部署文件")%>：</label>
                                <span class="form-control-label" id="status_file">-</span>
                            </div>
                            <%if (model.IsSystemPageUpdate == 1){ %>
                            <div class="form-group">
                                <label><%=Tag("刷新系统页面")%>：</label>
                                <span class="form-control-label" id="status_systempage">-</span>
                            </div>
                            <%} %>
                            <%if (model.IsThemePageUpdate == 1){ %>
                            <div class="form-group">
                                <label><%=Tag("刷新前台页面")%>：</label>
                                <span class="form-control-label" id="status_webpage">-</span>
                            </div>
                            <%} %>
                            <div class="form-group">
                                <label><%=Tag("更新缓存")%>：</label>
                                <span class="form-control-label" id="status_cache">-</span>
                            </div>
                            <%} %>
                            <div class="form-group">
                                <label><%=Tag("更新说明")%>：</label>
                                <div class="input-group">
                                    <%=model.Content %>
                                </div>
                            </div>
                        </div>
                    </div>
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
    
    <script type="text/javascript">
        var loading = '<img src="/theme/system/images/load.gif">';
        function update(id) {
        <%if (IsDown) {%>
                UpdateDB(id);
        <%}
            else {%>
        var postData = { "id": <%=model.id %>};
                var url = "<%=site.AdminPath %>/ajax/ajax_service.aspx?__Action=Version_DownLoad";
                $.ajax({
                    type: "POST",
                    url: url,
                    data: postData,
                    dataType: "json",
                    beforeSend: function () {
                        $('#status_down').html(loading);
                    },
                    success: function (res) {
                        if (res.msg == "OK") {
                            $('#status_down').html('OK!');
                            UpdateDB(id);
                        } else {
                            $('#status_down').html(res.msg);
                        }
                    }
                });
        <%}%>
}
        //升级数据库
        function UpdateDB() {
            var postData = { "id": <%=model.id %>};
            var url = "<%=site.AdminPath %>/ajax/ajax_service.aspx?__Action=Version_DBUpdate";
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: "json",
                beforeSend: function () {
                    $('#status_db').html(loading);
                },
                success: function (res) {
                    if (res.msg == "OK") {
                        $('#status_db').html('OK!');
                        UpdateFile();
                    } else {
                        $('#status_db').html(res.msg);
                    }
                }
            });
        }
        //部署文件
        function UpdateFile() {
            var postData = { "id": <%=model.id %>};
            var url = "<%=site.AdminPath %>/ajax/ajax_service.aspx?__Action=Version_FileUpdate";
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: "json",
                beforeSend: function () {
                    $('#status_file').html(loading);
                },
                success: function (res) {
                    if (res.msg == "OK") {
                        $('#status_file').html('OK!');
                        UpdatePage_system();
                    } else {
                        $('#status_file').html(res.msg);
                    }
                }
            });
        }
        //刷新系统文件
        function UpdatePage_system() {
        <%if (model.IsSystemPageUpdate == 1) {%>
        var postData = { "id": <%=model.id %>};
                //var url = "<%=site.AdminPath%>/ajax/ajax_service.aspx?__Action=Version_AdminUpdate";
                var url = "<%=site.AdminPath%>/updatepage.aspx";
                $.ajax({
                    type: "POST",
                    url: url,
                    data: postData,
                    dataType: "html",
                    beforeSend: function () {
                        $('#status_systempage').html(loading);
                    },
                    success: function (res) {
                        if (res == "OK") {
                            $('#status_systempage').html('OK!');
                            UpdatePage();
                        } else {
                            $('#status_systempage').html('<%=Tag("操作失败") %>，<a href="javascript:UpdatePage_system();"><%=Tag("刷新系统页面")%></a>。');
                        }
                    }
                });
        <%}
            else {%>
                UpdatePage();
        <%}%>
}
        //刷新前台文件
        function UpdatePage() {
        <%if (model.IsThemePageUpdate == 1) {%>
        var postData = { "id": <%=model.id %>};
                var url = "<%=site.AdminPath%>/ajax/ajax_service.aspx?__Action=Version_WebUpdate";
                $.ajax({
                    type: "POST",
                    url: url,
                    data: postData,
                    dataType: "json",
                    beforeSend: function () {
                        $('#status_webpage').html(loading);
                    },
                    success: function (res) {
                        if (res.msg == "OK") {
                            $('#status_webpage').html('OK!');
                            UpdateCache();
                        } else {
                            $('#status_webpage').html('<%=Tag("操作失败") %>，<a href="javascript:UpdatePage();"><%=Tag("刷新前台页面")%></a>。');
                        }
                    }
                });
        <%}
            else {%>
                UpdateCache();
        <%}%>
}
        //刷新缓存
        function UpdateCache() {
            $.ajax({
                type: "POST",
                url: "<%=site.AdminPath %>/ajax/ajax_db.aspx?__Action=CacheReset",
                data: { 'datatype': 'config' },
                dataType: "json",
                beforeSend: function () {
                    $('#status_cache').html(loading);
                },
                success: function (res) {
                    if (res.msg == "OK") {
                        $('#status_cache').html('OK!');
                        alert("<%=Tag("升级完毕") %>");
                    } else {
                        $('#status_cache').html(res.msg);
                    }
                }
            });
        }
        function DownLoad(id) {
            var postData = { "id": id };
            var url = "<%=site.AdminPath %>/ajax/ajax_service.aspx?__Action=Version_DownLoad";
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: "json",
                beforeSend: function () {
                    MsgBox(4, "<%=Tag("下载文件") %> ……", "-");
                },
                success: function (res) {
                    if (res.msg == "OK") {
                        MsgBox(4, "<%=Tag("下载文件完毕") %>", "-");
                        FileUpdate(id);
                        //CheckVersion();
                    } else {
                        MsgBox(2, res.msg, "");
                    }
                }
            });
        }
        function Version_UpdateOK(id) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认已经手动更新了吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "Version_UpdateOK_obj(" + id + ");");
        }
        function Version_UpdateOK_obj(id) {
            $("#Modal-Confirm").modal("hide");
            var postData = { "id": id };
            var url = "<%=site.AdminPath %>/ajax/ajax_service.aspx?__Action=Version_UpdateOK";
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: "json",
                beforeSend: function () {
                    MsgBox(4, "<%=Tag("正在提交") %> ……", "-");
                },
                success: function (res) {
                    if (res.msg == "OK") {
                        MsgBox(1, "<%=Tag("操作成功")%>", "?");
                    } else {
                        MsgBox(2, res.msg, "");
                    }
                }
            });
        }
    </script>

</body>
</html>