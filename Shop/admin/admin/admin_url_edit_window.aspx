﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.admin.Admin_url_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("编辑过滤页面")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="Url"><%=Tag("URL")%>：</label>
                <input type="text" class="form-control" id="Url" name="Url" value="<%=model.Url %>" shop="true" required>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var Url = $("#Url").val();
            var url = "<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=Admin_url_Edit&id=<%=model.id %>&Url="+Url+"&gid=<%=group.id %>";
            RequestAjax(url,'',function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  