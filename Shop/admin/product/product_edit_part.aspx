﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_Edit_part" validateRequest="false"%>

    
<%
if (tid > 0){
    foreach (DB.LebiShop.Lebi_ProPerty pro in pros)
    {
%>
<tr>
    <th class="no-wrap">
        <%=Shop.Bussiness.Language.Content(pro.Name, CurrentLanguage.Code)%>：
    </th>
    <td>
        <%=GetproList(pro) %>
    </td>
</tr>
<%
    }
}else{
%>
<tr>
    <th>
    </th>
    <td>
        <%=Tag("请先选择商品类别")%>
    </td>
</tr>
<%
}
%>
<tr>
    <th class="no-wrap">
        <%=Tag("订购表单")%>：
    </th>
    <td>
        <%=Property(model.ProPerty134, 134)%>
    </td>
</tr>

  