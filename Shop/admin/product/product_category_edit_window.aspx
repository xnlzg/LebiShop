﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_category_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("商品类别")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Pro_Type_id"><%=Tag("商品类别")%>：</label>
                <select id="Pro_Type_id" name="Pro_Type_id" class="form-control" shop="true">
                    <%=Shop.Bussiness.EX_Product.TypeOption(0, 0, 0, CurrentLanguage.Code,Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
                </select>
            </div>
            <div class="form-group">
                <label for="Pro_Type_id_other"><%=Tag("扩展类别")%>：</label>
                <select id="Pro_Type_id_other" name="Pro_Type_id_other" multiple="multiple" size="8" shop="true">
                    <%=Shop.Bussiness.EX_Product.TypeOption(0, 0, 0, CurrentLanguage.Code,Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
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
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Category_Edit&ids=<%=ids %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?"); });
        }
        $(function () {
            $("#Pro_Type_id_other").multiselect2side({
                selectedPosition: "right",
                moveOptions: false,
                //search: "<img src='img/search.gif' align=\"absmiddle\" /> ",
                labelsx: "",
                labeldx: "",
                autoSort: false,
                autoSortAvailable: false
            });
        });
    </script>

  