﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Order_Money_Transport_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("修改金额")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <%if (model.Type_id_OrderType!=212){%>
            <div class="form-group">
                <label for="Money_Transport"><%=Tag("运费")%>：</label>
                <input type="text" id="Money_Transport" name="Money_Transport" value="<%=FormatMoney(model.Money_Transport," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
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
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_Money_Transport_Edit&id=<%=model.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
    </script>

  