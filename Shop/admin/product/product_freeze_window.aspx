﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_freeze_window" validateRequest="false"%>

    <div class="modal-header">
        <h4 class="modal-title"><%=Tag("冻结库存")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
    </div>
    <div class="modal-body" style="max-height:500px;overflow-y:auto;">
        <table class="table table-hover no-wrap">
            <thead>
                <tr>
                    <th>
                        <%=Tag("订购日期")%>
                    </th>
                    <th>
                        <%=Tag("订单编号")%>
                    </th>
                    <th>
                        <%=Tag("商品编号")%>
                    </th>
                    <th>
                        <%=Tag("冻结数量")%>
                    </th>
                    <th>
                        <%=Tag("单价")%>
                    </th>
                    <th>
                        <%=Tag("小计")%>
                    </th>
                </tr>
            </thead>
            <tbody>
                <%
                int count_freeze = 0; decimal price = 0; decimal money = 0;
                foreach (DB.LebiShop.Lebi_Order_Product pro in pros){
                count_freeze = count_freeze + (pro.Count - pro.Count_Shipped);
                price = price + pro.Price;
                money = money + pro.Money;
                %>
                <tr>
                    <td>
                        <%=pro.Time_Add%>
                    </td>
                    <td>
                        <%=pro.Order_Code%>
                    </td>
                    <td>
                        <%=pro.Product_Number%>
                    </td>
                    <td>
                        <%=pro.Count - pro.Count_Shipped%>
                    </td>
                    <td>
                        <%=FormatMoney(pro.Price)%>
                    </td>
                    <td>
                        <%=FormatMoney(pro.Money)%>
                    </td>
                </tr>
                <%} %>
                <tr>
                    <td>
                        <%=Tag("合计")%>
                    </td>
                    <td></td>
                    <td></td>
                    <td>
                        <strong><%=count_freeze%></strong>
                    </td>
                    <td>
                        <strong><%=FormatMoney(price)%></strong>
                    </td>
                    <td>
                        <strong><%=FormatMoney(money)%></strong>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
    </div>

  