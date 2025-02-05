﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.agent.areaagent_mutiadd_window" validateRequest="false"%>

<table class="table">
   
    <tr>
        <th>
            <%=Tag("地区")%>：
        </th>
        <td>
           <div id="Area_id_div"></div> 
           <em>将选定地区的所有下级地区添加到代理地区</em>
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("价格")%>(<%=DefaultCurrency.Msige %>)：
        </th>
        <td>
             <input type="text" id="Price" name="Price" value="<%=model.Price %>" class="input" onkeyup="value=value.replace(/[^\d\.]/g,'')"  shop="true" min="notnull" />
            <em>(<%=Tag("年") %>)</em>
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("佣金比例")%>：
        </th>
        <td>
            <input type="text" id="Commission_1" name="Commission_1" value="<%=model.Commission_1 %>" class="input" onkeyup="value=value.replace(/[^\d]/g,'')" shop="true" min="notnull" />
            <em>% 按收货地址</em>
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("佣金比例")%>：
        </th>
        <td>
            <input type="text" id="Commission_2" name="Commission_2" value="<%=model.Commission_2 %>" class="input" onkeyup="value=value.replace(/[^\d]/g,'')"  shop="true" min="notnull" />
            <em>% 按籍贯</em>
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("赠送代金券")%>：
        </th>
        <td style="text-align: left;">
            <select id="CardOrder_id" name="CardOrder_id" shop="true">
                <option value="0"><%=Tag("不赠送") %></option>
                <%foreach (DB.LebiShop.Lebi_CardOrder co in cos)
                  { %>
                  <option value="<%=co.id %>" <%=(co.id==model.CardOrder_id?"selected":"") %>><%=co.IndexCode %> - <%=Tag("面值") %>:<%=co.Money %>
                  <%=Tag("数量") %>:<%=count_card(co.id)%>
                  <%=Tag("剩余") %>:<%=count_card_no(co.id)%>
                  </option>
                <%} %>
            </select>
        </td>
    </tr>
    <tr>
        <th style="vertical-align:top">
            <%=Tag("内部备注")%>：<br>
            <em>≤ <span id="remLen">255</span></em>
        </th>
        <td>
            <textarea name="Remark" id="Remark" shop="true" rows="3" cols="60" class="input" onKeyDown="checkMaxInput(this.form)" onKeyUp="checkMaxInput(this.form)" style="height: 55px;width: 100%;"><%=model.Remark%></textarea>
            <div class="tools clear">
                <ul>
                    <li class="plus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Remark',100);"><b></b><span><%=Tag("展开")%></span></a></li>
                    <li class="minus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Remark',-100)"><b></b><span><%=Tag("收缩")%></span></a></li>
                </ul>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="action">
        <div class="tools tools-m clear">
            <ul>
                <li class="submit"><a href="javascript:void(0);" onclick="SaveObj();"><b></b><span><%=Tag("保存")%></span></a></li>
            </ul>
        </div>
        </td>
    </tr>
</table>
<script type="text/javascript">
    GetAreaList(0,<%=model.Area_id %>,'Area_id_div');
    function SaveObj() {
        var postData = GetFormJsonData("shop");
        if (!CheckForm("shop", "span"))
            return false;
        var Area_id=$("#Area_id").val();
        var PArea_id=$("#Area_id").prev().val();
        var url = "<%=site.AdminPath %>/ajax/ajax_agent.aspx?__Action=AreaAgent_MutiAdd&id=<%=model.id %>&Area_id="+Area_id+"&PArea_id="+PArea_id;
        RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        //RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
    }
</script>

  