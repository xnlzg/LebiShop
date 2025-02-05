﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.ServicePanel_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Account"><%=Tag("软件帐号")%>：</label>
                <input type="text" id="Account" name="Account" value="<%=model.Account %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Name"><%=Tag("客服名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="ServicePanel_Type_id"><%=Tag("软件名称")%>：</label>
                <select name="ServicePanel_Type_id" id="ServicePanel_Type_id" class="form-control" shop="true">
                    <%=GetOptionServicePanel_Type(model.ServicePanel_Type_id)%>
                </select>
            </div>
            <div class="form-group">
                <label for="ServicePanel_Group_id"><%=Tag("部门名称")%>：</label>
                <select name="ServicePanel_Group_id" id="ServicePanel_Group_id" class="form-control" shop="true">
                    <%=GetOptionServicePanel_Group(model.ServicePanel_Group_id)%>
                </select>
            </div>
            <div class="form-group">
                <label for="Language_ids"><%=Tag("语言")%>：</label>
                <div class="form-control-label">
                    <%= Shop.Bussiness.Language.SiteLanguageCheckbox("Language_ids", model.Language_ids,CurrentLanguage.Code,CurrentAdmin)%>
                </div>
            </div>
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
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=ServicePanel_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  