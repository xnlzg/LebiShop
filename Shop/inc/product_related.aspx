﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.inc.product_related" validateRequest="false"%><%LoadPage();%>

<div class="productrelated" >
	<ul class="image">
        <%foreach (DB.LebiShop.Lebi_Product model in products){%><li>
            <div class="proimg"><a href="<%=URL("P_Product",model.id)%>" target="_blank"><img border="0" src="<%=Image(model.ImageOriginal,"medium") %>" alt="<%=Lang(model.Name)%>" /></a></div>
            <div class="proname"><a href="<%=URL("P_Product",model.id)%>" title="<%=Lang(model.Name)%>" target="_blank"><%=Lang(model.Name)%></a></div>
            <div class="proprice"><%if (model.Price_Market > 0){ %><div class="marketprice"><i><%=Tag("市场价")%>：</i><strong><%=FormatMoney(model.Price_Market) %></strong></div><%} %><div class="buyprice"><i><%=Lang(CurrentUserLevel.PriceName) %>：</i><strong><%=FormatMoney(ProductPrice(model)) %></strong></div></div>
        </li><%} %>
	</ul>
</div>

  