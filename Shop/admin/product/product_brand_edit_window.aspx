﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_brand_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("商品品牌")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Brand_id"><%=Tag("商品品牌")%>：</label>
                <select id="Brand_id" name="Brand_id" class="form-control" shop="true">
                    <%=Shop.Bussiness.EX_Product.BrandOption(0)%>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Brand_Edit&ids=<%=ids %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?"); });
        }
    </script>

  