﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.cash_edit_window" validateRequest="false"%>

    <form novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("提现管理")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for=""><%=Tag("金额")%>：</label>
                <%=FormatMoney(model.Money-model.Fee) %> = <%=FormatMoney(model.Money) %> - <%=FormatMoney(model.Fee) %>(<%=Tag("手续费")%>)
            </div>
            <div class="form-group">
                <label for=""><%=Tag("用户")%>：</label>
                <%if (model.User_id > 0)
                {%>
                [<%=Tag("会员") %>]<%=model.User_UserName %>
                <%}
                else
                { %>
                [<%=Tag("供应商") %>]<%=model.Supplier_SubName%>
                <%} %>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("收款方式")%>：</label>
                <%=model.PayType == "alipay"?Tag("支付宝"):Tag("银行转账")%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("姓名")%>：</label>
                <%=model.AccountName%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("账号")%>：</label>
                <%=model.AccountCode%>
            </div>
            <%if (model.PayType == "bank"){ %>
            <div class="form-group">
                <label for=""><%=Tag("银行")%>：</label>
                <%=model.Bank%>
            </div>
            <%} %>
            <div class="form-group">
                <label for=""><%=Tag("管理员")%>：</label>
                <%=model.Admin_UserName%>
            </div>
            <div class="form-group">
                <label for="Remark"><%=Tag("备注")%>：</label>
                <textarea id="Remark" name="Remark" class="form-control" style="height: 60px;" shop="true"><%=model.Remark%></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <%if(model.Type_id_CashStatus==401){ %>
            <button type="button" class="btn btn-success" onclick="SaveObj(402);"><i class="ti-check"></i> <%=Tag("已付款")%></button>
            <button type="button" class="btn btn-danger" onclick="SaveObj(403);"><i class="ti-trash"></i> <%=Tag("无效")%></button>
            <%} %>
        </div>
    </form>
    <script>
        function SaveObj(t) {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Cash_Edit&id=<%=model.id %>&t=" + t;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
    </script>

  