﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.BillingAddress_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("编辑收货人")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="T_Name"><%=Tag("收货人")%>：</label>
                <input type="text" id="T_Name" name="T_Name" value="<%=model.T_Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="T_MobilePhone"><%=Tag("手机")%>：</label>
                <input type="text" id="T_MobilePhone" name="T_MobilePhone" value="<%=model.T_MobilePhone %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="T_Phone"><%=Tag("电话")%>：</label>
                <input type="text" id="T_Phone" name="T_Phone" value="<%=model.T_Phone %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="T_Email"><%=Tag("Email")%>：</label>
                <input type="text" id="T_Email" name="T_Email" value="<%=model.T_Email %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Area_id"><%=Tag("地区")%>：</label>
                <div class="input-group" id="Area_id_div">

                </div>
            </div>
            <div class="form-group">
                <label for="T_Address"><%=Tag("地址")%>：</label>
                <input type="text" id="T_Address" name="T_Address" value="<%=model.T_Address %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="T_Postalcode"><%=Tag("邮编")%>：</label>
                <input type="text" id="T_Postalcode" name="T_Postalcode" value="<%=model.T_Postalcode %>" class="form-control" shop="true">
            </div>
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
            var T_Area_id = $("#Area_id").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_shouhuo_Edit&id=<%=model.id %>&T_Area_id=" + T_Area_id;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        GetAreaList(0,<%=model.T_Area_id %>);
    </script>

  