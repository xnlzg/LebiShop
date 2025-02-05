﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.ServicePanel_Type_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("软件名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Url"><%=Tag("链接地址")%>：</label>
                <input type="text" id="Url" name="Url" value="<%=model.Url %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Text"><%=Tag("提示文字")%>：</label>
                <input type="text" id="Text" name="Text" value="<%=model.Text %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="IsOnline_1"><%=Tag("在线检测")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsOnline_1" name="IsOnline" value="1" class="custom-control-input" shop="true" <%=model.IsOnline==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("支持")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsOnline_0" name="IsOnline" value="0" class="custom-control-input" shop="true" <%=model.IsOnline==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("不支持")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Code"><%=Tag("动态图标")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Face"><%=Tag("静态图标")%>：</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="image_Face"><%if (model.Face != ""){%><img src="<%=site.WebPath + model.Face%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                    </div>
                    <input type="text" id="Face" name="Face" value="<%=model.Face %>" class="form-control" shop="true">
                    <div class="input-group-append fileupload">
                        <span class="input-group-text"><i class="ti-upload"></i></span>
                        <input type="file" id="file_Face" name="file_Face" class="upload" onchange="uploadImage('Face')">
                    </div>
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
	                        $("#image_" + id + "").html('<img src="' + WebPath + imageUrl + '" height="20">');
	                        $("#" + id + "").val(imageUrl);
	                    }
	                }
	            },
	            error: function (data, status, e) {
	                MsgBox(2, data.error, "");
	            }
	        })
        }
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=ServicePanel_Type_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  