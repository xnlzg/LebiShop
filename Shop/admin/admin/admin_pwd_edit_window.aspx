﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.admin.Admin_pwd_Edit_window" validateRequest="false"%>

    <form action="javascript:UpdateAdminPassword();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("修改密码")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <%if (!Shop.Bussiness.EX_Admin.Power("admin_pwd", "编辑系统用户密码")){%>
            <div class="form-group">
                <label for="PWD"><%=Tag("原始密码")%>：</label>
                <input type="password" pwd="true" id="PWD" name="PWD" class="form-control" required>
            </div>
            <%}%>
            <div class="form-group">
                <label for="PWD1"><%=Tag("新密码")%>：</label>
                <input type="password" class="form-control" id="PWD1" name="PWD1" pwd="true" required>
            </div>
            <div class="form-group">
                <label for="PWD2"><%=Tag("再次输入")%>：</label>
                <input type="password" class="form-control" id="PWD2" name="PWD2" pwd="true" required>
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
        function UpdateAdminPassword() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("pwd");
            var url = "<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=Admin_PWD&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  