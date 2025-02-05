﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.Transport_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("配送方式")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Code"><%=Tag("配送方式代码")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true">
                <small class="form-text text-muted"><a href="http://code.google.com/p/kuaidi-api/wiki/Open_API_API_URL" target="_blank"><%=Tag("代码对照表")%></a></small>
            </div>
            <div class="form-group">
                <label for="Description"><%=Tag("配送描述")%>：</label>
                <textarea id="Description" name="Description" class="form-control" style="height: 60px;" shop="true"><%=model.Description%></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
            <div class="form-group">
                <label for="IsCanofflinePay_1"><%=Tag("货到付款")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsCanofflinePay_1" name="IsCanofflinePay" value="1" class="custom-control-input" shop="true" <%=model.IsCanofflinePay==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("开启")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsCanofflinePay_0" name="IsCanofflinePay" value="0" class="custom-control-input" shop="true" <%=model.IsCanofflinePay==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("关闭")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Type_id_TransportType"><%=Tag("配送类型")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Type.TypeRadio("TransportType", "Type_id_TransportType", model.Type_id_TransportType, "shop=\"true\"", CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true">
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=Transport_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  