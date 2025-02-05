﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.Transport_Container_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("货柜名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Volume"><%=Tag("体积")%>：</label>
                <div class="input-group">
                    <input type="text" id="Volume" name="Volume" value="<%=model.Volume %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text"><%=Tag("立方米")%></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="Weight"><%=Tag("重量")%>：</label>
                <div class="input-group">
                    <input type="text" id="Weight" name="Weight" value="<%=model.Weight %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text"><%=Tag("吨")%></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="Description"><%=Tag("货柜描述")%>：</label>
                <textarea id="Description" name="Description" class="form-control" style="height: 60px;" shop="true"><%=model.Description%></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description',-100);"><%=Tag("收缩")%></button>
                </div>
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
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=Transport_Container_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  