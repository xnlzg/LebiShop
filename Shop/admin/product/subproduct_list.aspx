﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.subproduct_list" validateRequest="false"%>

<%foreach (DB.LebiShop.Lebi_Product model in models){%>
<tr ondblclick="Editsonproduct(<%=model.id %>);">
    <td>
        <label class="custom-control custom-checkbox">
            <input type="checkbox" id="checkbox<%=model.id %>" name="sonproductid" value="<%=model.id %>" class="custom-control-input" shopkeyid="true">
            <span class="custom-control-label"></span>
        </label>
    </td>
    <%if (mutiadd_property == 0){ %>
    <td>
        <%if (model.ImageOriginal != ""){%>
        <a href="<%=Image(model.ImageOriginal,"big") %>" data-lightbox="image-list"><img style="height: 30px; width: 30px; vertical-align: middle" src="<%=Image(model.ImageOriginal,"small") %>" /></a>
        <%} %>
    </td>
    <%} %>
    <td>
        <%=model.Number %>
    </td>
    <td>
        <%=getproperty(model.ProPerty131) %>
    </td>
    <%if (mutiadd_property == 0){ %>
    <td style="<%=model.IsCombo==1?"color:blue":""%>">
        <%if (model.IsCombo==1){%><span class="tag green"><span><%=Tag("组合商品")%></span></span><%} %>
        <a href="javascript:void(0)" title="<%=Tag("点击编辑商品名称")%>" onclick="Product_Name_Edit(<%=model.id %>);">
            <%if (Shop.Bussiness.Language.Content(model.Name, CurrentLanguage.Code) != "") { Response.Write(Shop.Bussiness.Language.Content(model.Name, CurrentLanguage.Code)); } else { Response.Write(Tag("编辑")); }%></a>&nbsp;<%if (pid > 0){%><a target="_blank" href="<%=Shop.Bussiness.ThemeUrl.GetURL("P_Product",model.id.ToString(),"",CurrentLanguage.Code)%>"><i class="ti-new-window"></i></a><%} %>
    </td>
    <%} %>
    <td>
        <div class="input-group">
            <%if (mutiadd_property == 1){ %>
            <select id="Operators_Price_Market<%=model.id %>" name="Operators_Price_Market<%=model.id %>" class="form-control form-control-sm" sonproduct="true"><option value="+">+</option><option value="×">×</option><option value=""></option></select>
            <%} %>
            <input type="text" id="Price_Market<%=model.id %>" name="Price_Market<%=model.id %>" value="<%if (model.Price_Market!=0){Response.Write(FormatMoney(model.Price_Market,"Number"));}%>" class="form-control form-control-sm" sonproduct="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
        </div>
    </td>
    <td>
        <div class="input-group">
            <%if (mutiadd_property == 1){ %>
            <select id="Operators_Price<%=model.id %>" name="Operators_Price<%=model.id %>" class="form-control form-control-sm" sonproduct="true"><option value="+">+</option><option value="×">×</option><option value=""></option></select>
            <%} %>
            <input type="text" id="Price<%=model.id %>" name="Price<%=model.id %>" value="<%if (model.Price!=0){Response.Write(FormatMoney(model.Price," Number"));}%>" class="form-control form-control-sm" sonproduct="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
        </div>
    </td>
    <%if (modelp.Type_id_ProductType == 321||modelp.Type_id_ProductType == 322||modelp.Type_id_ProductType == 323){ %>
    <td>
        <input type="text" id="Price_Sale<%=model.id %>" name="Price_Sale<%=model.id %>" value="<%if (model.Price_Sale!=0){Response.Write(FormatMoney(model.Price_Sale,"Number"));}%>" class="form-control form-control-sm" sonproduct="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
    </td>
    <%} %>
    <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
    <td>
        <div class="input-group">
            <%if (mutiadd_property == 1){ %>
            <select id="Operators_Price_Cost<%=model.id %>" name="Operators_Price_Cost<%=model.id %>" class="form-control form-control-sm" sonproduct="true"><option value="+">+</option><option value="×">×</option><option value=""></option></select>
            <%} %>
            <input type="text" id="Price_Cost<%=model.id %>" name="Price_Cost<%=model.id %>" value="<%if (model.Price_Cost!=0){Response.Write(FormatMoney(model.Price_Cost," Number"));}%>" class="form-control form-control-sm" sonproduct="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
        </div>
    </td>
    <%} %>
    <td>
        <div class="input-group">
            <%if (IsEditStock){ %>
            <%if (mutiadd_property == 1){ %>
            <select id="Operators_Count_Stock<%=model.id %>" name="Operators_Count_Stock<%=model.id %>" class="form-control form-control-sm" sonproduct="true"><option value="+">+</option><option value="×">×</option><option value=""></option></select>
            <%} %>
            <input type="text" id="Count_Stock<%=model.id %>" name="Count_Stock<%=model.id %>" value="<%=model.Count_Stock %>" class="form-control form-control-sm" sonproduct="true" onkeyup="value=value.replace(/[^\d]/g,'')">
            <%}else{ %>
            <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_erp")){ %>
            <%=Lebi.ERP.Store.ProductStockForAdmin(model) %>
            <%}else{ %>
            <%=model.Count_Stock %>
            <%} %>
            <%} %>
        </div>
    </td>
    <td>
        <select id="Type_id_ProductStatus<%=model.id %>" name="Type_id_ProductStatus<%=model.id %>" class="form-control form-control-sm" sonproduct="true" style="min-width:60px">
            <%=Shop.Bussiness.EX_Type.TypeOption("ProductStatus", model.Type_id_ProductStatus, CurrentLanguage)%>
        </select>
    </td>
    <%if (mutiadd_property == 0){ %>
    <td>
        
        <a href="product_edit.aspx?id=<%=model.id %>"><%=Tag("编辑")%></a>
    </td>
    <%} %>
</tr>
<%} %>

  