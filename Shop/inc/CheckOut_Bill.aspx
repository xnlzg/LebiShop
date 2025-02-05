﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.inc.CheckOut_Bill" validateRequest="false"%><%LoadPage();%>

<input type="text" id="money_bill" value="" style="display:none"/>
<div id="bill_edit">
<div class="dl-table clearfix">
    <%
        foreach (DB.LebiShop.Lebi_BillType model in models)
        {
    %>
    <dl>
        <dt><input type="radio" name="billtype_id" value="<%=model.id %>" billtype="<%=model.Type_id_BillType %>" billcontent="<%=model.Content %>" TaxRate="<%=model.TaxRate %>" order="true" onclick="Changebilltype()" <%=model.id==billtype.id?"checked":"" %> billmoney="<%=model.TaxRate * (basket.Money_Product + basket.Money_Property - basket.Money_Cut - basket.Money_Give)%>" /> <%=Lang(model.Name)%></dt>
        <dd><em><%=Lang(model.Description)%></em><%if (model.TaxRate > 0){ %>&nbsp;&nbsp;<%=Tag("税金")%>：<%=FormatMoney(model.TaxRate * (basket.Money_Product + basket.Money_Property - basket.Money_Cut - basket.Money_Give))%><%} %></dd>
    </dl>
    <%if (model.Type_id_BillType == 151){ %>
    <div style="display: none;" id="bill151">
    <div class="dl-table clearfix">
    <dl>
        <dt><%=Tag("抬头")%>：</dt>
        <dd><label><input type="radio" name="billtitletype" value="1" order="true" onclick="Changebilltitletype(1);" checked /> <%=Tag("个人")%></label>
            <label><input type="radio" name="billtitletype" value="2" order="true" onclick="Changebilltitletype(2);" /> <%=Tag("单位")%></label></dd>
    </dl>
    <dl id="billtitlecont" style="display: none">
        <dt><%=Tag("单位名称")%>：</dt>
        <dd><input type="text" id="billtitle" name="billtitle" min="notnull" size="30" value="" class="input" order="true" /></dd>
    </dl>
    <dl id="billcondiv">
        <dt><%=Tag("发票内容")%>：</dt>
        <dd><div id="billcon"></div></dd>
    </dl>
    </div>
    </div>
    <%} %>
    <%if (model.Type_id_BillType == 152){ %>
    <div style="display: none;" id="bill152">
    <div class="dl-table clearfix">
    <dl>
        <dt><%=Tag("单位名称")%>：</dt>
        <dd><input type="text" id="Company_Name" name="Company_Name" min="notnull" size="30" value="" class="input" order="true" /></dd>
    </dl>
    <dl>
        <dt><%=Tag("纳税人识别号")%>：</dt>
        <dd><input type="text" id="Company_Code" name="Company_Code" min="notnull" size="30" value="" class="input" order="true" /></dd>
    </dl>
    <dl>
        <dt><%=Tag("注册地址")%>：</dt>
        <dd><input type="text" id="Company_Address" name="Company_Address" min="notnull" size="30" value="" class="input" order="true" /></dd>
    </dl>
    <dl>
        <dt><%=Tag("注册电话")%>：</dt>
        <dd><input type="text" id="Company_Phone" name="Company_Phone" min="notnull" size="30" value="" class="input" order="true" /></dd>
    </dl>
    <dl>
        <dt><%=Tag("开户银行")%>：</dt>
        <dd><input type="text" id="Company_Bank" name="Company_Bank" min="notnull" size="30" value="" class="input" order="true" /></dd>
    </dl>
    <dl>
        <dt><%=Tag("银行帐户")%>：</dt>
        <dd><input type="text" id="Company_Bank_User" name="Company_Bank_User" min="notnull" size="30" value="" class="input" order="true" /></dd>
    </dl>
    </div>
    </div>
    <%} %>
    <%} %>
</div>
</div>
<script type="text/javascript">
    Changebilltype(); //初始化发票信息表单
    Setmoney(<%=sid %>); //计算总金额
</script>

  