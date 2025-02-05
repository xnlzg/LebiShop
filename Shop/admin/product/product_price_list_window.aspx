﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Product.product_price_list_window" validateRequest="false"%>

    <div class="table-responsive">
        <table class="table m-t-10 table-hover no-wrap">
            <thead>
                <tr>
                    <th>
                        <%=Tag("账号")%>
                    </th>
                    <th>
                        <%=Tag("姓名")%>
                    </th>
                    <th>
                        <%=Tag("分组")%>
                    </th>
                    <th style="width: 20%">
                        <%=Tag("价格")%>
                    </th>
                </tr>
            </thead>
            <tbody>
                <%foreach (DB.LebiShop.Lebi_User model in users){
                DB.LebiShop.Lebi_Product_Price price=GetPriceInfo(model);
                %>
                <tr>
                    <td>
                        <%=model.UserName %>
                    </td>
                    <td style="max-width:400px;word-wrap: break-word;">
                        <%=model.RealName %>
                    </td>
                    <td>
                        <%=GetlevelName(model.UserLevel_id) %>
                    </td>
                    <td>
                        <input type="text" id="Price<%=model.id%>" name="Price<%=model.id%>" value="<%=FormatMoney(price.Price," Number") %>" class="form-control form-control-sm" shop="true" onkeyup="value=value.replace(/[^.\d]/g,'')">
                        <input type="hidden" name="userid" value="<%=model.id%>" shop="true">
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
    </div>
    <div class="row">
        <div class="col-12">
            <nav aria-label="Page navigation ">
                <%=PageString%>
            </nav>
        </div>
    </div>

  