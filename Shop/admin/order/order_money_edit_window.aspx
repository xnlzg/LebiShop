﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Order_Money_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("修改金额")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <%if (model.Type_id_OrderType==212){%>
            <div class="form-group">
                <label for="Money_Give"><%=Tag("退款金额")%>：</label>
                <input type="text" id="Money_Give" name="Money_Give" value="<%=FormatMoney(model.Money_Give," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <div class="form-group">
                <label for="Point"><%=Tag("扣除积分")%>：</label>
                <input type="text" id="Point" name="Point" value="<%=model.Point %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <%}else{%>
            <div class="form-group">
                <label for="Money_Product"><%=Tag("商品金额")%>：</label>
                <input type="text" id="Money_Product" name="Money_Product" value="<%=FormatMoney(model.Money_Product," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <div class="form-group">
                <label for="Money_Bill"><%=Tag("发票税金")%>：</label>
                <input type="text" id="Money_Bill" name="Money_Bill" value="<%=FormatMoney(model.Money_Bill," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <div class="form-group">
                <label for="Money_Tax"><%=Tag("税金")%>：</label>
                <input type="text" id="Money_Tax" name="Money_Tax" value="<%=FormatMoney(model.Money_Tax," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <div class="form-group">
                <label for="Money_Property"><%=Tag("其它金额")%>：</label>
                <input type="text" id="Money_Property" name="Money_Property" value="<%=FormatMoney(model.Money_Property," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <div class="form-group">
                <label for="Money_Give"><%=Tag("返还金额")%>：</label>
                <input type="text" id="Money_Give" name="Money_Give" value="<%=FormatMoney(model.Money_Give," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <div class="form-group">
                <label for="Point"><%=Tag("积分")%>：</label>
                <input type="text" id="Point" name="Point" value="<%=FormatMoney(model.Point," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <%}%>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        ! function (window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_Money_Edit&id=<%=model.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
    </script>

  