﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.selectproduct_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("编辑订单商品规格")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label><%=Tag("商品编号")%>：</label>
                <%=product.Number %>
            </div>
            <div class="form-group">
                <label><%=Tag("商品名称")%>：</label>
                <%=Lang(product.Name) %>
            </div>
            <div class="form-group">
                <label for="productid"><%=Tag("选择")%>：</label>
                <select id="productid" name="productid" class="form-control" sproduct="true">
                    <%foreach (DB.LebiShop.Lebi_Product model in models)
                    {
                    %>
                    <option value="<%=model.id %>" <%=product.id==model.id?"selected":"" %>><%=getproperty(model.ProPerty131) %><%=model.Type_id_ProductStatus==100?Tag("下架"):""%></option>
                    <%} %>
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
            var postData = GetFormJsonData("sproduct");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=order_product_edit&orderid=<%=order.id %>&id=<%=orderproduct.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
    </script>

  