﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.Class_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <ul class="nav nav-tabs customtab" role="tablist">
                <%
                List
                <DB.LebiShop.Lebi_Language_Code>
                    langs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in langs){
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
                        <label for="Name<%=lang.Code %>"><%=Tag("分类名称")%>：</label>
                        <input type="text" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name,lang.Code) %>" <%if (langs.FirstOrDefault().Code == lang.Code){%>required<%}%> class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label class="custom-control custom-checkbox">
                            <input type="checkbox" id="IsUrl<%=lang.Code %>" name="IsUrl<%=lang.Code %>" value="1" class="custom-control-input" <%=Shop.Bussiness.Language.Content(model.Url,lang.Code)!=""?"checked":"" %> onclick="DivShow('IsUrl<%=lang.Code %>')">
                            <span class="custom-control-label"><%=Tag("自定义链接")%></span>
                        </label>
                    </div>
                    <div class="form-group" id="IsUrl<%=lang.Code %>show" <%=Shop.Bussiness.Language.Content(model.Url,lang.Code)!=""?"":"style=\"display:none\"" %>>
                        <div class="input-group">
                            <input type="text" id="Url<%=lang.Code %>" name="Url<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Url,lang.Code) %>" class="form-control" shop="true">
                        </div>
                        <small>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="IsUrlrewrite<%=lang.Code %>" name="IsUrlrewrite<%=lang.Code %>" value="1" class="custom-control-input" shop="true" <%=Shop.Bussiness.Language.Content(model.IsUrlrewrite,lang.Code)=="1"?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("生成URL重写规则")%></span>
                            </label>
                        </small>
                    </div>
                    <div class="form-group">
                        <label class="custom-control custom-checkbox">
                            <input type="checkbox" id="Seo<%=lang.Code %>" name="Seo<%=lang.Code %>" value="1" class="custom-control-input" onclick="DivShow('Seo<%=lang.Code %>')">
                            <span class="custom-control-label"><%=Tag("SEO优化")%></span>
                        </label>
                    </div>
                    <div id="Seo<%=lang.Code %>show" style="display:none;">
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
                </div>
                <%} %>
            </div>
            <h4 class="nav-tips m-t-20 m-b-10"><%=Tag("通用信息")%></h4>
            <div class="form-group">
                <label for="Parentid"><%=Tag("上级分类")%>：</label>
                <select id="Parentid" name="Parentid" class="form-control" shop="true">
                    <option value="0"><%=Tag("顶级分类")%></option>
                    <%=Shop.Bussiness.EX_Product.TypeOption(0, pmodel.id, 0, CurrentLanguage.Code, Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
                </select>
            </div>
            <div class="form-group">
                <label for="ImageSmall"><%=Tag("小图标")%>：</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="image_ImageSmall"><%if (model.ImageSmall != ""){%><img src="<%=site.WebPath + model.ImageSmall%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                    </div>
                    <input type="text" id="ImageSmall" name="ImageSmall" value="<%=model.ImageSmall %>" shop="true" class="form-control">
                    <div class="input-group-append fileupload">
                        <span class="input-group-text"><i class="ti-upload"></i></span>
                        <input type="file" id="file_ImageSmall" name="file_ImageSmall" class="upload" onchange="uploadImage('ImageSmall')">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="ImageUrl"><%=Tag("图标")%>：</label>
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
                <label for="IsIndexShow_1"><%=Tag("首页显示")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsIndexShow_1" name="IsIndexShow" value="1" class="custom-control-input" shop="true" <%=model.IsIndexShow==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsIndexShow_0" name="IsIndexShow" value="0" class="custom-control-input" shop="true" <%=model.IsIndexShow==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="IsIndexShow_1"><%=Tag("商品属性")%>：</label>
                <div class="input-group">
                    <%=Property(model.ProPerty132,132)%>
                </div>
            </div>
            <div class="form-group">
                <label for="IsIndexShow_1"><%=Tag("商品规格")%>：</label>
                <div class="input-group">
                    <%=Property(model.ProPerty131,131)%>
                </div>
            </div>
            <div class="form-group">
                <label for="IsIndexShow_1"><%=Tag("文字属性")%>：</label>
                <div class="input-group">
                    <%=Property(model.ProPerty133,133)%>
                </div>
            </div>
            <div class="form-group">
                <label for="IsIndexShow_1"><%=Tag("订购表单")%>：</label>
                <div class="input-group">
                    <%=Property(model.ProPerty134,134)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
            </div>
            <div class="form-group">
                <label for="Site_ids"><%=Tag("站点")%>：</label>
                <div class="input-group">
                    <%=site.SiteCheckbox("Site_ids",model.Site_ids,CurrentLanguage.Code)%>
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
        function SaveObj() { $("#EditModal").modal("hide"); var postData = GetFormJsonData("shop"); var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Class_Edit&id=<%=model.id %>"; RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") }) } function uploadImage(id) { $.ajaxFileUpload({ url: WebPath + '/ajax/imageuploadone.aspx?path=producttype', secureuri: false, fileElementId: 'file_' + id, dataType: 'json', success: function (data, status) { if (data.msg != 'OK') { MsgBox(2, data.msg, "") } else { var imageUrl = data.ImageUrl; if (imageUrl.length > 0) { $("#image_" + id + "").html('<img src="' + WebPath + imageUrl + '" height="20">'); $("#" + id + "").val(imageUrl) } } } }) }
        function DivShow(id) {
            var value = $("input[name='" + id +"']:checked").val();
            if (value == "1")
                $("#" + id +"show").show();
            else
                $("#" + id + "show").hide();  
        }
    </script>

  