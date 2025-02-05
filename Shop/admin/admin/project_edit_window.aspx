﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.admin.Project_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="Name"><%=Tag("名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Pro_Type_ids"><%=Tag("管理分类")%>：</label>
                <div class="input-group">
                    <%=Pro_TypeCheckbox("Pro_Type_ids", model.Pro_Type_ids, CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Site_ids"><%=Tag("管理站点")%>：</label>
                <div class="input-group">
                    <%=site.SiteCheckbox("Site_ids",model.Site_ids,CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Site_ids"><%=Tag("供应商")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Supplier.SupplierCheckbox("Supplier_ids",model.Supplier_ids,CurrentLanguage.Code)%>
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
        ! function (window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            if (!CheckForm("shop", "span"))
                return false;
            var url = "<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=Project_Edit&id=<%=model.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", '?') });
        }
    </script>

  