﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Express_Shipper_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="SiteName"><%=Tag("网店名称")%>：</label>
                <input type="text" id="SiteName" name="SiteName" value="<%=model.SiteName %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="UserName"><%=Tag("发货人姓名")%>：</label>
                <input type="text" id="UserName" name="UserName" value="<%=model.UserName %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Address"><%=Tag("发货地址")%>：</label>
                <input type="text" id="Address" name="Address" value="<%=model.Address %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="City"><%=Tag("所在城市")%>：</label>
                <input type="text" id="City" name="City" value="<%=model.City %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="ZipCode"><%=Tag("邮政编码")%>：</label>
                <input type="text" id="ZipCode" name="ZipCode" value="<%=model.ZipCode %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Tel"><%=Tag("电话号码")%>：</label>
                <input type="text" id="Tel" name="Tel" value="<%=model.Tel %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Mobile"><%=Tag("手机号码")%>：</label>
                <input type="text" id="Mobile" name="Mobile" value="<%=model.Mobile %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Status_1"><%=Tag("是否启用")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="Status_1" name="Status" value="1" class="custom-control-input" shop="true" <%=model.Status==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="Status_0" name="Status" value="0" class="custom-control-input" shop="true" <%=model.Status==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Name" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Remark"><%=Tag("自定义信息")%>：</label>
                <textarea id="Remark" name="Remark" class="form-control" style="height: 60px;" shop="true" onKeyDown="checkMaxInput(this.form)" onKeyUp="checkMaxInput(this.form)"><%=model.Remark%></textarea>
                <small>≤ <span id="remLen">255</span></small>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        var maxLen = 255;
        var Remark = document.getElementById("Remark");
        function checkMaxInput(form) {
            if (Remark.value.length > maxLen)
                Remark.value = Remark.value.substring(0, maxLen);
            else document.getElementById("remLen").innerHTML = maxLen - Remark.value.length;
        }
        ! function (window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Express_Shipper_Edit&id=<%=model.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
    </script>

  