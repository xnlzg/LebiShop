﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.pickup_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Supplier_id"><%=Tag("供应商")%>：</label>
                <select id="Supplier_id" name="Supplier_id" class="form-control" shop="true">
                    <option value="0"><%=Tag("商城") %></option>
                    <%=SupplierOptions(model.Supplier_id) %>
                </select>
            </div>
            <div class="form-group">
                <label for="Description"><%=Tag("描述")%>：</label>
                <textarea id="Description" name="Description" class="form-control" style="height: 60px;" shop="true"><%=model.Description %></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
            <div class="form-group">
                <label for="IsCanWeekend_1"><%=Tag("周末服务")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsCanWeekend_1" name="IsCanWeekend" value="1" class="custom-control-input" shop="true" <%=model.IsCanWeekend==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsCanWeekend_0" name="IsCanWeekend" value="0" class="custom-control-input" shop="true" <%=model.IsCanWeekend==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="NoServiceDays"><%=Tag("暂停服务日期")%>：</label>
                <textarea id="NoServiceDays" name="NoServiceDays" class="form-control" style="height: 60px;" shop="true"><%=model.NoServiceDays %></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('NoServiceDays',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('NoServiceDays',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
            <div class="form-group">
                <label for="BeginDays"><%=Tag("备货天数")%>：</label>
                <input type="text" id="BeginDays" name="BeginDays" value="<%=model.BeginDays %>" class="form-control" shop="true">
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
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=pickup_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  