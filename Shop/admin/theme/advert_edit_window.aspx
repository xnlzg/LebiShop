﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.theme.Advert_Edit_window" validateRequest="false"%>

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
                <label for="Description"><%=Tag("描述")%>：</label>
                <input type="text" id="Description" name="Description" value="<%=model.Description %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Width"><%=Tag("尺寸")%>：</label>
                <div class="row">
                    <div class="col-sm-6">
                        <label for="Width"><%=Tag("宽度")%>：</label>
                        <input type="text" id="Width" name="Width" value="<%=model.Width%>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                    <div class="col-sm-6">
                        <label for="Height"><%=Tag("高度")%>：</label>
                        <input type="text" id="Height" name="Height" value="<%=model.Height%>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="Content"><%=Tag("内容")%>：</label>
                <textarea class="form-control" id="Content" name="Content" style="height: 200px;" shop="true"><%=model.Content%></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true">
            </div>
        </div>
        <div class="modal-footer">
            <input type="hidden" name="Theme_id" id="Theme_id" value="<%=model.Theme_id %>" shop="true">
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
            var url="<%=site.AdminPath %>/ajax/ajax_theme.aspx?__Action=Advert_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  