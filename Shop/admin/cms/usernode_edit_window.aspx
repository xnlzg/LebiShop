﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.cms.UserNode_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("分类名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label><%=Tag("上级目录")%>：</label>
                <%=Tag(PNode.Name)%>
            </div>
            <%if (PNode.Code == "Info")
            { %>
            <div class="form-group">
                <label for="ShowMode_word"><%=Tag("展示形式")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="ShowMode_word" name="ShowMode" value="word" class="custom-control-input" shop="true" <%=(model.ShowMode=="word" || model.ShowMode=="")?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("文字")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="ShowMode_image" name="ShowMode" value="image" class="custom-control-input" shop="true" <%=model.ShowMode=="image"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("图文")%></span>
                    </label>
                </div>
            </div>
            <%} %>
            <div class="form-group">
                <label><%=Tag("站点语言")%>：</label>
                <%= Shop.Bussiness.Language.SiteLanguageCheckbox("Language_ids", model.Language_ids, CurrentLanguage.Code,CurrentAdmin)%>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
            </div>
            <h5 class="box-title m-t-20"><%=Tag("SEO优化")%></h5>
            <div class="form-group">
                <label for="SEO_Title"><%=Tag("网页标题")%>：</label>
                <input type="text" id="SEO_Title" name="SEO_Title" value="<%=model.SEO_Title %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="SEO_Keywords"><%=Tag("关键词")%>：</label>
                <input type="text" id="SEO_Keywords" name="SEO_Keywords" value="<%=model.SEO_Keywords %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="SEO_Description"><%=Tag("网页描述")%>：</label>
                <input type="text" id="SEO_Description" name="SEO_Description" value="<%=model.SEO_Description %>" class="form-control" shop="true">
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
            <input type="hidden" id="AdminPage_Index" name="AdminPage_Index" value="cms/pagelist.aspx"
                   shop="true" />
            <input type="hidden" id="AdminPage" name="AdminPage" value="<%=PNode.AdminPage %>"
                   shop="true" />
            <input type="hidden" id="haveson" name="haveson" value="0" shop="true" />
            <input type="hidden" id="TypeFlag" name="TypeFlag" value="1" shop="true" />
            <input type="hidden" id="IsThemeNode" name="IsThemeNode" value="0" shop="true" />
            <input type="hidden" id="parentid" name="parentid" value="<%=PNode.id %>" shop="true" />
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
            var url = "<%=site.AdminPath %>/ajax/ajax_node.aspx?__Action=UserNode_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  