﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.User.productlimit_list_window" validateRequest="false"%>

<%foreach (DB.LebiShop.Lebi_User model in users){
    DB.LebiShop.Lebi_Product_Limit limit=GetLimitInfo(model);      
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
        <label class="custom-control custom-checkbox">
            <input type="checkbox" id="IsShow<%=model.id%>" name="IsShow<%=model.id%>" cname="IsShow" value="1" class="custom-control-input" limit="true" <%=limit.IsShow==1?"checked":""%>>
            <span class="custom-control-label"></span>
        </label>
    </td>
    <td>
        <label class="custom-control custom-checkbox">
            <input type="checkbox" id="IsPriceShow<%=model.id%>" name="IsPriceShow<%=model.id%>" cname="IsPriceShow" value="1" class="custom-control-input" limit="true" <%=limit.IsPriceShow==1?"checked":""%>>
            <span class="custom-control-label"></span>
        </label>
    </td>
    <td>
        <label class="custom-control custom-checkbox">
            <input type="checkbox" id="IsBuy<%=model.id%>" name="IsBuy<%=model.id%>" cname="IsBuy" value="1" class="custom-control-input" limit="true" <%=limit.IsBuy==1?"checked":""%>>
            <span class="custom-control-label"></span>
        </label>
        <input type="hidden" name="limituserid" value="<%=model.id%>" limit="true" />
    </td>
    </tr>
    <%} %>
    <tr>
    <td colspan="6">
    <%=PageString %>
    </td>
    </tr>
    <%if(userlevel.id>0){%>
    <tr >
        <td colspan="6">
            <%=Lang(userlevel.Name)%>：
            <label class="custom-control custom-checkbox">
                <input type="checkbox" id="IsShow<%=userlevel.id%>" name="IsShow<%=userlevel.id%>" value="1" class="custom-control-input" limit="true" <%=userlevellimit.IsShow==1?"checked":""%>>
                <span class="custom-control-label"><%=Tag("禁止购买")%></span>
            </label>
            <label class="custom-control custom-checkbox">
                <input type="checkbox" id="IsPriceShow<%=userlevel.id%>" name="IsPriceShow<%=userlevel.id%>" value="1" class="custom-control-input" limit="true" <%=userlevellimit.IsPriceShow==1?"checked":""%>>
                <span class="custom-control-label"><%=Tag("禁止看价")%></span>
            </label>
            <label class="custom-control custom-checkbox">
                <input type="checkbox" id="IsBuy<%=userlevel.id%>" name="IsBuy<%=userlevel.id%>" value="1" class="custom-control-input" limit="true" <%=userlevellimit.IsBuy==1?"checked":""%>>
                <span class="custom-control-label"><%=Tag("禁止购买")%></span>
            </label>
        </td>
    </tr>
    <%}%>

  