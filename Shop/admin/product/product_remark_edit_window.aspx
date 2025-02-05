﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_remark_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("内部备注")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Units_id"><%=Tag("商品单位")%>：</label>
                <select id="Units_id" name="Units_id" class="form-control" subproduct_shop="true">
                    <%=Shop.Bussiness.EX_Product.UnitOption(model.Units_id)%>
                </select>
            </div>
            <div class="form-group">
                <label for="Sub_Remarks"><%=Tag("内部备注")%>：</label>
                <textarea id="Sub_Remarks" name="Sub_Remarks" class="form-control" style="height:60px;" subproduct_shop="true"><%=model.Remarks%></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Sub_Remarks',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Sub_Remarks',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script> 
        function SavePNameObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("subproduct_shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Remark_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "");getsubproducts();});
        }
        function getsubproducts() {
            $.ajax({
                type: "POST",
                url: "subproduct_list.aspx?pid=<%=pid %>&randnum=<%=randnum %>",
                data: '',
                success: function (res) {
                    $("#subproducts").html(res);
                }
            });
        }
    </script>

  