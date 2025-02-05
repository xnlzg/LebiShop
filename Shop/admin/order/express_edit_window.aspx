﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Express_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("单据名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Transport_id"><%=Tag("关联配送方式")%>：</label>
                <select id="Transport_id" name="Transport_id" class="form-control" shop="true">
                    <%=GetOptionTransport(model.Transport_id)%>
                </select>
            </div>
            <div class="form-group">
                <label for="Background"><%=Tag("背景图片")%>：</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="image_Background"><%if (model.Background != ""){%><img src="<%=site.WebPath + model.Background%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                    </div>
                    <input type="text" id="Background" name="Background" value="<%=model.Background %>" class="form-control">
                    <div class="input-group-append fileupload">
                        <span class="input-group-text"><i class="ti-upload"></i></span>
                        <input type="file" id="file_Background" name="file_Background" class="upload" onchange="uploadImage('Background')">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="Width"><%=Tag("单据宽度")%>：</label>
                <div class="input-group">
                    <input type="text" id="Width" name="Width" value="<%=model.Width%>" class="form-control" shop="true" required>
                    <div class="input-group-append">
                        <span class="input-group-text">px</span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="Height"><%=Tag("单据高度")%>：</label>
                <div class="input-group">
                    <input type="text" id="Height" name="Height" value="<%=model.Height%>" class="form-control" shop="true" required>
                    <div class="input-group-append">
                        <span class="input-group-text">px</span>
                    </div>
                </div>
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
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Express_Edit_Window&id=<%=model.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        function uploadImage(id) {
            $.ajaxFileUpload({
                url: WebPath + '/ajax/imageuploadone.aspx?path=config',
                secureuri: false,
                fileElementId: 'file_' + id,
                dataType: 'json',
                success: function (data, status) {
                    if (data.msg != 'OK') {
                        MsgBox(2, data.msg, "");
                    }
                    else {
                        var imageUrl = data.ImageUrl;
                        if (imageUrl.length > 0) {
                            $("#image_" + id + "").html('<img src="' + imageUrl + '" height="20">');
                            $("#" + id + "").val(imageUrl);
                        }
                    }
                },
                error: function (data, status, e) {
                    MsgBox(2, data.error, "");
                }
            })
        }
    </script>

  