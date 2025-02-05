﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.inc.viewhistory" validateRequest="false"%><%LoadPage();%>

<ul class="image">
    <% 
        foreach (DB.LebiShop.Lebi_User_Product p in History_Product(10))
        {
            DB.LebiShop.Lebi_Product productmodel = GetProduct(p.Product_id);
            if (productmodel.id == 0)
                continue;
    %>
    <li>
        <div class="image">
            <p><a href="<%=URL("P_Product",p.Product_id) %>"><img src="<%=Image(productmodel.ImageOriginal,"medium") %>" alt="<%=Lang(productmodel.Name) %>" title="<%=Lang(productmodel.Name) %>" /></a></p>
        </div>
        <div class="name">
            <a href="<%=URL("P_Product",p.Product_id) %>" title="<%=Lang(productmodel.Name) %>"><%=Lang(productmodel.Name) %></a>
        </div>
        <div class="price">
            <%=FormatMoney(ProductPrice(productmodel)) %>
        </div>
    </li>
    <%        
        }
    %>
</ul>

  