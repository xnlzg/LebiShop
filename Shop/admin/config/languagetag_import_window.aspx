﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.config.LanguageTag_Import_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("导入")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="languagecode"><%=Tag("语言")%>：</label>
                <select id="languagecode" class="form-control" shop="true">
                    <%foreach (DB.LebiShop.Lebi_Language_Code code in langs)
                    {%>
                    <option value="<%=code.Code %>"><%=code.Name %></option>
                    <%} %>
                </select>
            </div>
            <div class="form-group">
                <label for="Type"><%=Tag("匹配类型")%>：</label>
                <select id="Type" class="form-control" shop="true">
                    <option value="0"><%=Tag("标签")%></option>
                    <option value="1">ID</option>
                </select>
            </div>
            <div class="form-group">
                <label for="uploadfile"><%=Tag("数据文件")%>：</label>
                <div class="input-group">
                    <input type="text" id="uploadfile" name="uploadfile" class="form-control">
                    <div class="input-group-append fileupload">
                        <span class="input-group-text"><i class="ti-upload"></i></span>
                        <input type="file" id="file_uploadfile" name="file_uploadfile" class="upload" onchange="uploadFile('uploadfile')">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("提交")%></button>
        </div>
    </form>
    <script>
        function SaveObj() {
            $("#EditModal").modal("hide");
            var languagecode = $("#languagecode").val();
            var Type = $("#Type").val();
            var uploadfile = $("#uploadfile").val();
            var url = "<%=site.AdminPath %>/ajax/export.aspx?__Action=LanguageTag_Import";
            var postData = {"languagecode": languagecode,"Type": Type,"uploadfile": uploadfile};
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: 'json',
                beforeSend: function () {
                    MsgBox(4, "<%=Tag("正在处理") %> ……", "-");
                },
                success: function (res) {
                    if (res.msg == "OK") {
                        MsgBox(1, "<%=Tag("操作成功") %>", "?");
                    }
                    else {
                        MsgBox(2, res.msg, "");
                        return false;
                    }
                }
            });
        }
    </script>

  