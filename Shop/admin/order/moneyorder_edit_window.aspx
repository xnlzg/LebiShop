﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Order_View" validateRequest="false"%>

    <form novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("充值单")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for=""><%=Tag("会员账号")%>：</label>
                <%=model.User_UserName%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("金额")%>：</label>
                <%=model.Money_Order%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("相关订单")%>：</label>
                <%if(model.Order_id>0){
                DB.LebiShop.Lebi_Order co=DB.LebiShop.B_Lebi_Order.GetModel(model.Order_id);
                if(co!=null){%>
                <a href="order_view.aspx?id=<%=co.id%>" target="_blank"><%=co.Code%></a>
                <%}}%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("提交时间")%>：</label>
                <%=FormatTime(model.Time_Add)%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("支付时间")%>：</label>
                <%=model.Time_Paid==model.Time_Add?"-":FormatTime(model.Time_Paid)%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("支付方式")%>：</label>
                <%=Lang(model.Pay)%>
                <%=Lang(model.OnlinePay)%>
            </div>
            <div class="form-group">
                <label for="Remark_Admin"><%=Tag("备注")%>：</label>
                <textarea id="Remark_Admin" name="Remark_Admin" class="form-control" style="height: 60px;" shop="true"><%=model.Remark_Admin%></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark_Admin',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark_Admin',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <%if(model.IsPaid==0){%>
            <button type="button" class="btn btn-success" onclick="SaveObj();"><i class="ti-check"></i> <%=Tag("已支付")%></button>
            <%} %>
        </div>
    </form>
    
    <script>
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=MoneyOrder_paid&id=<%=model.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
    </script>

  