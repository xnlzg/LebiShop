﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.inc.CheckOut_Transport" validateRequest="false"%><%LoadPage();%>

<div style="<%=havedefault?"": "display:none;" %>" id="transport_show">
<div class="dl-table clearfix">
    <%foreach (Shop.Model.BasketShop shop in Shops)
      {
          if (shop.Shop.id > 0)
          {
              Response.Write("<tr><th><span class=\"shopname\">" + Lang(shop.Shop.Name) + "</span></th></tr>");
          }
          else { 
            if(basket.Shops.Count>1)
                Response.Write("<tr><th><span class=\"shopname\">" + Tag("自营") + "</span></th></tr>");
          }
          DB.LebiShop.Lebi_Transport tran=GetTransport(shop.Shop.id);
    %>
    <dl>
        <dt><%=tran.Name%></dt>
        <dd><%if (GetYunFei(shop) > 0){ %><%=Tag("运费")%>：<%=FormatMoney(GetYunFei(shop))%><%} %>
            [<a class="click" href="javascript:Edittransport();"><%=Tag("修改")%></a>]
            <input type="text" name="money_transport" value="<%=GetYunFei(shop)%>" style="display: none" />
        </dd>
    </dl>
    <%if(tran.Type_id_TransportType==332){ 
    DB.LebiShop.Lebi_PickUp pickup=GetPickup(CurrentUser.PickUp_id,shop);
    if(pickup!=null){
    %>

    <dl>
        <dt></dt>
        <dd>
            <%=Tag("自提点") %>：<%=pickup.Name %><br/>
            <%=Tag("自提日期") %>：<%=CurrentUser.PickUp_Date.ToString("yyyy-MM-dd") %>
        </dd>
    </dl>

    <%}}} %>
</div>
</div>
<div style="<%=havedefault==false?"": "display:none;" %>" id="transport_edit">
<div class="dl-table clearfix">
    <%foreach (Shop.Model.BasketShop shop in basket.Shops)
      {
          if (shop.Shop.id > 0) {
              Response.Write("<dl><dd class=\"title\"><span class=\"shopname\">" + Lang(shop.Shop.Name) + "</span></dd></dl>");
          }
          else
          {
              if (basket.Shops.Count > 1)
                  Response.Write("<dl><dd class=\"title\"><span class=\"shopname\">" + Tag("自营") + "</span></dd></dl>");
          }
          List<DB.LebiShop.Lebi_Transport_Price> TPrices = GetTPrices(address.Area_id, shop.Shop.id);
          if (TPrices.Count == 0)
          {
              Response.Write("<dl><dd class=\"title\">" + Tag("不在配送区域，无法送达") + "</dd></dl>");
              Response.End();
          }
          int checkedid = GetRadioCheckedId(TPrices);
          foreach (DB.LebiShop.Lebi_Transport_Price model in TPrices)
          {
              DB.LebiShop.Lebi_Transport Tran = DB.LebiShop.B_Lebi_Transport.GetModel(model.Transport_id);
              if (Transport == null)
                  continue;

    %>
    <dl>
        <dt><label><input type="radio" name="transport_id<%=shop.Shop.id %>" lebitype="<%=Tran.Type_id_TransportType %>" value="<%=model.id %>" order="true" <%=checkedid==model.id?"checked":"" %> onclick="SetTransport(<%=shop.Shop.id %>);" /> <%=Tran.Name%></dt>
        <%if (GetYunFei(model, shop) > 0){ %><dd class="list"><%=Tag("运费")%>：<%=FormatMoney(GetYunFei(model, shop))%></dd><%} %>
        <dd class="list"><em><%=Tran.Description%></em>
        </dd>
    </dl>
    <%if (Tran.Type_id_TransportType == 332)//自提
    { %>
    <dl class="pickup" id="pickup<%=shop.Shop.id %>" style="display:none;">
        <dd class="list">
            <div class="dl-table clearfix" id="pickuplist">
            <% 
                foreach (DB.LebiShop.Lebi_PickUp pickup in GetPickups(shop))
                {
                %>
                <dl>
                    <dt><label><input type="radio" name="pickup_id<%=shop.Shop.id %>" value="<%=pickup.id %>" <%=(","+CurrentUser.PickUp_id+",").Contains(","+pickup.id+",")?"checked":"" %> order="true" onclick="changepickup(<%=pickup.id %>);" /> <%=pickup.Name%></label></dt>
                    <dd><%=pickup.Description%></dd>
                </dl>
                <dl pickupdatedl="true" id="pickupdatedl_<%=pickup.id %>" <%=(","+CurrentUser.PickUp_id+",").Contains(","+pickup.id+",")?"":"style=\"display:none\"" %>>
                    <dd><%=Tag("取货日期") %>：
                        <input type="text" id="pickupdate_<%=pickup.id %>" name="pickupdate_<%=pickup.id %>" value="<%=GetdefaultPickDate(pickup) %>" order="true" onclick="changepickupdate(<%=pickup.id %>);" size="12" class="input-calendar" readonly /></dd>
                </dl>
                <%} %>
            </div>
        </dd>
    </dl>
    <%} %>
    <script type="text/javascript">SetTransport(<%=shop.Shop.id %>);</script>
    <%}
      }%>
    <dl class="dl-btn">
        <dt></dt>
        <dd><a href="javascript:void(0);" onclick="Settransport();" class="btn btn-7"><s></s><%=Tag("确定")%></a></dd>
    </dl>
</div>
</div>
<script type="text/javascript">
    LoadPage("<%=WebPath%>/inc/CheckOut_Pay.aspx?sid=<%=sid %>", "checkout_pay");
    Setmoney(<%=sid %>); //计算总金额
    <%if(havedefault==false){ %>
    HighlightDiv("transport_edit");
    <%} %>
    function Settransport() {
        var transport_id = '';
        var pickup_id='';
        var id='';
        var pickid='';
        <%foreach (Shop.Model.BasketShop shop in basket.Shops)
        {
        %>
        id = $("input[name='transport_id<%=shop.Shop.id %>']:checked").val();
        pickid = $("input[name='pickup_id<%=shop.Shop.id %>']:checked").val();
        if(id!=undefined)
            transport_id=transport_id+','+id;
        if(pickid!=undefined)
            pickup_id=pickid;
        <%}%>
        var pickupdate=$("#pickupdate_"+pickup_id).val();
        var postData = { "transport_id": transport_id,"pickup_id":pickup_id,"pickupdate":pickupdate };
        var url = path+"/ajax/ajax_order.aspx?__Action=transport_Set";
        RequestAjax(url, postData, function (res) { 
            LoadPage("<%=WebPath%>/inc/CheckOut_Transport.aspx?sid=<%=sid %>", "checkout_transport");
            LoadPage("<%=WebPath%>/inc/CheckOut_Pay.aspx?sid=<%=sid %>", "checkout_pay");
            MsgBoxClose("","error");
            HighlightDivHide();
        });
    }
    function changepickupdate(pickid){
            var selectedday=$('#pickupdate_'+pickid).val();
            var title_ = "<%=Tag("选择日期")%>";
            var url_ = "<%=WebPath%>/inc/selectpickupdate.aspx?pickupid=" + pickid+"&selectedday="+selectedday+"&callback=changepickupdateOK";
            var width_ = 630;
            var height_ = 700;
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_,'selectdatewindow');
    }
    function changepickupdateOK()
    {
        $('#selectdatewindow').dialog('close');
    }
    function changepickup(id){
        $("[pickupdatedl]").each(function (i) {
             $(this).hide();
        });
        $('#pickupdatedl_'+id).show();
    }
</script>

  