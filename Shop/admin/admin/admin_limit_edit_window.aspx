﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.admin.admin_limit_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="Name"><%=Tag("权限名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <%if (model.parentid > 0)
            { %>
            <div class="form-group">
                <label for="Code"><%=Tag("权限代码")%>：</label>
                <%=model.Code %>
                <a href="javascript:LimitCode_Del(<%=model.id %>)"><%=Tag("删除") %></a>
            </div>
            <div class="form-group">
                <label for="parentid"><%=Tag("权限分组")%>：</label>
                <select shop="true" name="parentid" id="parentid" class="form-control">
                    <% foreach (DB.LebiShop.Lebi_Admin_Limit l in GetLimit(0))
                    { %>
                    <option value="<%=l.id %>" <%=l.id==model.parentid?"selected":"" %>>
                    <%=Tag(l.Name)%></option>
                    <%} %>
                </select>
            </div>
            <%} %>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true">
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
            var url = "<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=Admin_limit_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", '?')});
        }
        function LimitCode_Del(id) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "LimitCode_Del_obj(" + id +");");
        }
        function LimitCode_Del_obj(id) {
            $("#Modal-Confirm").modal("hide");
            var url = "<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=Admin_limit_Del&id="+id;
            RequestAjax(url,'',function(){MsgBox(1, "<%=Tag("操作成功")%>", '?')});
        }
    </script>

  