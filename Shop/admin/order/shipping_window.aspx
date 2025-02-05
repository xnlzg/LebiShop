﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.shipping_window" validateRequest="false"%>

    <form action="javascript:Shipping();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("发货")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <div class="table-responsive">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr class="no-wrap">
                                <th>
                                    <%=Tag("商品名称")%>
                                </th>
                                <th>
                                    <%=Tag("待发数量")%>
                                </th>
                                <th style="width: 15%">
                                    <%=Tag("发货数量")%>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%foreach (DB.LebiShop.Lebi_Order_Product pro in pros){
                            int dafa = pro.Count - pro.Count_Shipped;
                            dafa = dafa < 0 ? 0 : dafa;
                            %>
                            <tr>
                                <td>
                                    <img src="<%=Image(pro.ImageOriginal,50,50)%>" style="width: 30px" />
                                    <%=Shop.Bussiness.Language.Content(pro.Product_Name,CurrentLanguage) %>
                                </td>
                                <td>
                                    <%=dafa%>
                                </td>
                                <td>
                                    <%if (pro.IsSupplierTransport != 1)
                                    {
                                    if(pro.Type_id_OrderProductType!=256 || (pro.Type_id_OrderProductType==256 && pro.IsStockOK==1 && pro.IsPaid==1)){
                                    %>
                                    <input type="text" id="Count<%=pro.id %>" name="Count<%=pro.id %>" value="<%=dafa%>" class="form-control form-control-sm" Shipping="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                    <%}
                                    else
                                    {
                                    if(pro.IsStockOK==0)
                                    Response.Write(Tag("未备货"));
                                    if(pro.IsPaid==0)
                                    Response.Write(Tag("未付款"));
                                    }
                                    }
                                    else {
                                    Response.Write(Tag("供应商发货"));
                                    } %>
                                </td>
                            </tr>
                            <%} %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="form-group">
                <label for="Transport_id"><%=Tag("配送方式")%>：</label>
                <select id="Transport_id" name="Transport_id" class="form-control" Shipping="true">
                    <%=Shop.Bussiness.EX_Area.TransportOption(model.Transport_id) %>
                </select>
                <small><%=model.Transport_Mark %></small>
            </div>
            <div class="form-group">
                <label for="Code"><%=Tag("货运单号")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=transport_order.Code %>" class="form-control" Shipping="true" required>
            </div>
            <div class="form-group">
                <label for="Money"><%=Tag("实际运费")%><%=DefaultCurrency.Msige %>：</label>
                <input type="text" id="Money" name="Money" value="<%=model.Money_Transport %>" class="form-control" Shipping="true">
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
        function Shipping() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("Shipping");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_fahuo&id=<%=model.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
    </script>

  