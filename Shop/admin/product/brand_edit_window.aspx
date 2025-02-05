﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.Brand_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <ul class="nav nav-tabs customtab" role="tablist">
                <%
                List<DB.LebiShop.Lebi_Language_Code> langs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in langs){
                %>
                <li class="nav-item"> <a class="nav-link <%if (langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                <%
                }
                %>
            </ul>
            <div class="tab-content m-t-20">
                <%
                foreach (DB.LebiShop.Lebi_Language_Code lang in langs)
                {%>
                <div class="tab-pane <%if (langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                    <div class="form-group">
                        <label for="Name<%=lang.Code %>"><%=Tag("品牌名称")%>：</label>
                        <input type="text" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name,lang.Code) %>" <%if (langs.FirstOrDefault().Code == lang.Code){%>required<%}%> class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="Description<%=lang.Code %>"><%=Tag("品牌介绍")%>：</label>
                        <textarea id="Description<%=lang.Code %>" name="Description<%=lang.Code %>" class="form-control" style="height:60px;" shop="true"><%=Shop.Bussiness.Language.Content(model.Description, lang.Code)%></textarea>
                        <script type="text/javascript">
                        CKEDITOR.replace('Description<%=lang.Code %>', {
                            height: '150',
                            toolbar: 'Basic',
                            language: '<%=Tag("CKEditor语言")%>'
                        });
                        </script>
                    </div>
                    <h4 class="nav-tips m-t-20 m-b-10"><%=Tag("SEO优化")%></h4>
                    <div class="form-group">
                        <label for="SEO_Title<%=lang.Code %>"><%=Tag("网页标题")%>：</label>
                        <input type="text" id="SEO_Title<%=lang.Code %>" name="SEO_Title<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.SEO_Title,lang.Code) %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="SEO_Keywords<%=lang.Code %>"><%=Tag("关键词")%>：</label>
                        <input type="text" id="SEO_Keywords<%=lang.Code %>" name="SEO_Keywords<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.SEO_Keywords,lang.Code) %>" class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="SEO_Description<%=lang.Code %>"><%=Tag("网页描述")%>：</label>
                        <input type="text" id="SEO_Description<%=lang.Code %>" name="SEO_Description<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.SEO_Description,lang.Code) %>" class="form-control" shop="true">
                    </div>
                </div>
                <%} %>
            </div>
            <h4 class="nav-tips m-t-20 m-b-10"><%=Tag("通用信息")%></h4>
            <div class="form-group">
                <label for="ImageUrl"><%=Tag("图片")%>：</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="image_ImageUrl"><%if (model.ImageUrl != ""){%><img src="<%=site.WebPath + model.ImageUrl%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                    </div>
                    <input type="text" id="ImageUrl" name="ImageUrl" value="<%=model.ImageUrl %>" shop="true" class="form-control">
                    <div class="input-group-append fileupload">
                        <span class="input-group-text"><i class="ti-upload"></i></span>
                        <input type="file" id="file_ImageUrl" name="file_ImageUrl" class="upload" onchange="uploadImage('ImageUrl')">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="FirstLetter"><%=Tag("首字母")%>：</label>
                <input type="text" id="FirstLetter" name="FirstLetter" value="<%=model.FirstLetter %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="IsRecommend_1"><%=Tag("推荐")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsRecommend_1" name="IsRecommend" value="1" class="custom-control-input" shop="true" <%=model.IsRecommend==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsRecommend_0" name="IsRecommend" value="0" class="custom-control-input" shop="true" <%=model.IsRecommend==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="IsVAT_1"><%=Tag("是否含税")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsVAT_1" name="IsVAT" value="1" class="custom-control-input" shop="true" <%=model.IsVAT==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsVAT_0" name="IsVAT" value="0" class="custom-control-input" shop="true" <%=model.IsVAT==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("关联分类")%>：</label>
                <div class="input-group">
                    <select name="Pro_Type_id" id="Pro_Type_id" multiple="multiple" size="8" shop="true">
                        <%=Shop.Bussiness.EX_Product.TypeOption(0, model.Pro_Type_id, 0, CurrentLanguage.Code, Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
                    </select>
                </div>
            </div>
            <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
            <div class="form-group">
                <label for="Supplier_id"><%=Tag("商家")%>：</label>
                <select id="Supplier_id" name="Supplier_id" class="form-control" shop="true">
                    <option value="0"><%=Tag("请选择")%></option>
                    <%=Shop.Bussiness.EX_Supplier.SupplierOption(model.Supplier_id, CurrentLanguage.Code)%>
                </select>
            </div>
            <%} %>
            <div class="form-group">
                <label for="Type_id_BrandStatus"><%=Tag("状态")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Type.TypeRadio("BrandStatus", "Type_id_BrandStatus", model.Type_id_BrandStatus, "shop=\"true\"", CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Pro_Type_id"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
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
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Brand_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function uploadImage(id) {
            $.ajaxFileUpload({
	            url: WebPath + '/ajax/imageuploadone.aspx?path=brand',
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
        $().ready(function () {
            $('#Pro_Type_id').multiselect2side({
                selectedPosition: 'right',
                moveOptions: false,
                labelsx: '',
                labeldx: '',
                autoSort: false,
                autoSortAvailable: false
            });
        }); 
    </script>

  