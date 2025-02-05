﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.admin.menu_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("编辑菜单")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="parentid"><%=Tag("上级菜单")%>：</label>
                <select name="parentid" id="parentid" class="form-control" shop="true">
                    <option value="0"><%=Tag("顶级分类")%></option>
                    <%=GetParent(model.parentid) %>
                </select>
            </div>
            <div class="form-group">
                <label for="Name"><%=Tag("名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Code"><%=Tag("代码")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="URL"><%=Tag("链接")%>：</label>
                <input type="text" id="URL" name="URL" value="<%=model.URL %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Image"><%=Tag("图标")%>：</label>
                <div class="input-group">
                    <input type="text" id="Image" name="Image" value="<%=model.Image %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text">
                            <a href="../plugin/icon-themify.aspx" target="_blank"><i class="ti-new-window"></i></a>
                        </span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="IsSYS_1"><%=Tag("系统菜单")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsSYS_1" name="IsSYS" value="1" class="custom-control-input" shop="true" <%=model.IsSYS==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsSYS_0" name="IsSYS" value="0" class="custom-control-input" shop="true" <%=model.IsSYS==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true">
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <%if (model.id > 0){%>
            <button type="button" class="btn btn-danger" onclick="DeleteConfirm();"><i class="ti-trash"></i> <%=Tag("删除")%></button>
            <%}%>
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
        var url = "<%=site.AdminPath %>/ajax/ajax_admin.aspx?__Action=Menu_Edit&id=<%=model.id %>";
        RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
    }
    function DeleteConfirm() {
        $("#Modal-Confirm").modal("show");
        $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
        $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "DeleteObj();");
    }
        function DeleteObj() {
        $("#EditModal").modal("hide");
        $("#Modal-Confirm").modal("hide");
        var url = "<%=site.AdminPath %>/ajax/ajax_admin.aspx?__Action=Menu_Del&id=<%=model.id %>";
        RequestAjax(url,'',function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
    }
    </script>

  