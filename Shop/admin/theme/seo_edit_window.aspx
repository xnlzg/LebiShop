﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.theme.Page_Edit_window" validateRequest="false"%>

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
                        <label for=""><%=Tag("名称")%>：</label>
                        <%=Lang(model.Name) %>
                    </div>
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
                        <textarea id="SEO_Description<%=lang.Code %>" name="SEO_Description<%=lang.Code %>" shop="true" class="form-control" style="height:60px;"><%=Shop.Bussiness.Language.Content(model.SEO_Description,lang.Code) %></textarea>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('SEO_Description<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('SEO_Description<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                </div>
                <%} %>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_theme.aspx?__Action=ThemeSEO_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  