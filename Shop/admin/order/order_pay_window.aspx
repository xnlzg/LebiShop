﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Order_Pay_window" validateRequest="false"%>

    <form action="javascript:IsPaidConfirm();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("余额支付")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for=""><%=Tag("订单总额")%>：</label>
                <%=FormatMoney(model.Money_Order)%>
                <%=FormatMoney(model.Money_Order,model.Currency_Code)%>
            </div>
            <%if (model.Money_Pay>0){ %>
            <div class="form-group">
                <label for=""><%=Tag("应付金额")%>：</label>
                <%=FormatMoney(model.Money_Pay)%>
                <%=FormatMoney(model.Money_Pay, model.Currency_Code)%>
            </div>
            <%} %>
            <div class="form-group">
                <label for="BillType_id"><%=Tag("支付状态")%>：</label>
                <div class="input-group-text" id="paystatus">
                    <%=Tag("未支付")%>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("已支付")%></button>
        </div>
    </form>
    <script>
        function IsPaidConfirm() {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认操作吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "SaveObj();");
        }
        function SaveObj() {
            $("#Modal-Confirm").modal("hide");
            $("#EditModal").modal("hide");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_type&id=<%=id%>&model=IsPaid";
            $.ajax({
                type: "POST",
                url: url,
                data: { "t": 1 },
                dataType: 'json',
                success: function (res) {
                    if (res.msg == "OK") {
                        var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_Pay_Check";
                        RequestAjax(url, { "id": "<%=id%>" }, function (data) {
                            $("#paystatus").html(data.mes);
                            if (data.status == 1) {
                                MsgBox(1, "<%=Tag("操作成功")%>", "?");
                            } else {
                                MsgBox(2, "<%=Tag("操作失败")%>", "");
                            }
                        });
                    }
                    else {
                        return false;
                    }
                }
            });
        }
    </script>

  