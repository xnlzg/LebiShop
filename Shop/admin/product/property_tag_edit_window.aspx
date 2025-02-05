﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.ProPerty_Tag_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("标签名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Name"><%=Tag("类型")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Type.TypeRadio("ProPertyType", "Type_id_ProPertyType", model.Type_id_ProPertyType, "shop=\"true\" onclick=\"SetType();\"")%>
                </div>
            </div>
            <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
            <div class="form-group">
                <label for="Supplier_id"><%=Tag("商家")%>：</label>
                <select id="Supplier_id" name="Supplier_id" class="form-control" shop="true">
                    <option value="0"><%=Tag("请选择")%></option>
                    <%=Shop.Bussiness.EX_Supplier.SupplierOption(model.Supplier_id, CurrentLanguage.Code)%>
                </select>
            </div>
            <%} %>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
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
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Property_Tag_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  