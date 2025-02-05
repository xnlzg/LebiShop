﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.theme.Page_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Code"><%=Tag("代码")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Name"><%=Tag("名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Type_id_PublishType"><%=Tag("发布类型")%>：</label>
                <div class="input-group">
                    <%=TypeRadio("PublishType", "Type_id_PublishType", model.Type_id_PublishType, "shop=\"true\"",CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="PageName"><%=Tag("页面名称")%>：</label>
                <input type="text" id="PageName" name="PageName" value="<%=model.PageName %>" class="form-control" shop="true">
            </div>
            <%if (model.IsCustom == 1){ %>
            <div class="form-group">
                <label for="PageParameter"><%=Tag("页面参数")%>：</label>
                <input type="text" id="PageParameter" name="PageParameter" value="<%=model.PageParameter %>" class="form-control" shop="true">
                <small class="form-text text-muted"><%=para%></small>
            </div>
            <div class="form-group">
                <label for="StaticPageName"><%=Tag("静态地址")%>：</label>
                <input type="text" id="StaticPageName" name="StaticPageName" value="<%=model.StaticPageName %>" class="form-control" shop="true">
            </div>
            <%} %>
            <%if (model.IsAllowHtml == 1){ %>
            <div class="form-group">
                <label for="StaticPath"><%=Tag("静态路径")%>：</label>
                <input type="text" id="StaticPath" name="StaticPath" value="<%=model.StaticPath %>" class="form-control" shop="true">
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
            var url = "<%=site.AdminPath %>/ajax/ajax_theme.aspx?__Action=ThemePage_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  