﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.FriendLink_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("链接名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Url"><%=Tag("链接地址")%>：</label>
                <input type="text" id="Url" name="Url" value="<%=model.Url %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Logo"><%=Tag("图片Logo")%>：</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="image_Logo"><%if (model.Logo != ""){%><img src="<%=site.WebPath + model.Logo%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                    </div>
                    <input type="text" id="Logo" name="Logo" value="<%=model.Logo %>" class="form-control" shop="true">
                    <div class="input-group-append fileupload">
                        <span class="input-group-text"><i class="ti-upload"></i></span>
                        <input type="file" id="file_Logo" name="file_Logo" class="upload" onchange="uploadImage('Logo')">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="IsPic_1"><%=Tag("图片链接")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsPic_1" name="IsPic" value="1" class="custom-control-input" shop="true" <%=model.IsPic==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsPic_0" name="IsPic" value="0" class="custom-control-input" shop="true" <%=model.IsPic==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="IsShow_1"><%=Tag("是否显示")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsShow_1" name="IsShow" value="1" class="custom-control-input" shop="true" <%=model.IsShow==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsShow_0" name="IsShow" value="0" class="custom-control-input" shop="true" <%=model.IsShow==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Language_ids"><%=Tag("显示语言")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.Language.SiteLanguageCheckbox("Language_ids",model.Language_ids,CurrentLanguage.Code)%>
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
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=FriendLink_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function uploadImage(id) {
            $.ajaxFileUpload({
	            url: WebPath + '/ajax/imageuploadone.aspx?path=friendlink',
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
    </script>

  