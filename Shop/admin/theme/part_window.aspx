﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.theme.part_window" validateRequest="false"%>

    <%
    string folder = "page";
    string Path_Skin = "";
    if (ispage==1){
    folder = "page";
    }else if (ispage==0){
    folder = "block";
    Path_Skin = "inc/";
    }else if (ispage==2){
    folder = "layout";
    Path_Skin = "layout/";
    }
    %>
    <div class="modal-header">
        <h4 class="modal-title"><%=Tag("系统模板")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
    </div>
    <div class="modal-body" style="max-height:500px;overflow-y:auto;">
        <div class="row">
            <div class="col-md-12">
                <ul class="nav nav-tabs customtab m-t-15" role="tablist">
                    <li class="nav-item"><a class="nav-link active" href="javascript:void(0);" onclick="getpartlist('<%=folder %>');$('#li-web').attr('class','selected');$('#li-wap').attr('class','');" role="tab">WEB</a></li>
                    <li class="nav-item"><a class="nav-link" href="javascript:void(0);" onclick="getpartlist('wap/<%=folder %>');$('#li-web').attr('class','');$('#li-wap').attr('class','selected');" role="tab">WAP</a></li>
                </ul>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr>
                                <th>
                                    <%=Tag("名称")%>
                                </th>
                                <th>
                                    <%=Tag("说明")%>
                                </th>
                                <th>
                                    <%=Tag("限制")%>
                                </th>
                                <th>
                                    <%=Tag("更新时间")%>
                                </th>
                                <th>
                                    <%=Tag("操作")%>
                                </th>
                            </tr>
                        </thead>
                        <tbody id="partlist"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
    </div>
    <script>
        function Load(name) {
            window.location = "?file=" + name;
        }
        function LoadSystemPage(filename) {
            var url = "<%=site.AdminPath %>/ajax/ajax_theme.aspx?__Action=GetSkinContent&filename=" + filename;
            if (filename.substring(0, 4) == "wap/") { filename = filename.replace("wap/", ""); }
            if (filename.substring(0, 6) == "block/") { filename = filename.replace("block/", "inc/"); }
            if (filename.substring(0, 5) == "page/") { filename = filename.replace("page/", ""); }
            LoadHtml(url, "", function (res) { $("#EditModal").modal("hide"); $("#SkinContent").val(res); $("#Path_Skin").val(filename); });
        }
        function LoadHtml(url, jsondata, callback) {
            $.ajax({
                type: "POST",
                url: url,
                data: jsondata,
                dataType: 'html',
                success: function (res) {
                    callback(res);
                    return false;
                }
            });
        }
        function getpartlist(folder) {
            $.ajax({
                type: "POST",
                url: "part_window_list.aspx?folder=" + folder,
                data: '',
                success: function (res) {
                    $("#partlist").html(res);
                }
            });
        }
        $(function () {
            getpartlist("<%=folder %>");
        });
    </script>

  