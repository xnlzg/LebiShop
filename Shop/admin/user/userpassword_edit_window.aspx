﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.user.userpassword_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=model.UserName %> - <%=Tag("修改密码")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="PWD1"><%=Tag("新密码")%>：</label>
                <input type="password" id="PWD1" name="PWD1" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="PWD2"><%=Tag("再次输入")%>：</label>
                <input type="password" id="PWD2" name="PWD2" class="form-control" shop="true" required>
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
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/Ajax/ajax_user.aspx?__Action=User_Edit_Password&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  