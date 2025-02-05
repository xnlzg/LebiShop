﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.cms.customnode_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <%if (Topnode.IsLanguages == 1)
            { %>
            <ul class="nav nav-tabs customtab" role="tablist">
                <%
                List
                <DB.LebiShop.Lebi_Language_Code> langs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in langs){
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
                        <label for="Sort"><%=Tag("名称")%>：</label>
                        <input type="text" class="form-control" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" shop="true" value="<%=Shop.Bussiness.Language.Content(model.Name,lang.Code) %>" <%if (langs.FirstOrDefault().Code == lang.Code){%>required<%}%>>
                    </div>
                </div>
                <%} %>
            </div>
            <%} %>
            <%if (Topnode.IsLanguages == 0)
            { %>
            <div class="form-group">
                <label for="Name"><%=Tag("名称")%>：</label>
                <input type="text" class="form-control" id="Name" name="Name" shop="true" required value="<%=model.Name %>">
            </div>
            <%} %>
            <div class="form-group">
                <label for="parentid"><%=Tag("上级结点")%>：</label>
                <select name="parentid" id="parentid" class="form-control" shop="true">
                    <option value="<%=Topnode.id%>"><%=Topnode.Name%></option>
                    <%if (Topnode.haveson == 1)
                    { %>
                    <%=GetOptionTreeString(0, Topnode.id, PNode.id)%>
                    <%} %>
                </select>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" class="form-control" id="Sort" name="Sort" shop="true" value="<%=model.Sort %>" onkeyup="value=value.replace(/[^\d]/g,'')">
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
            var url = "<%=site.AdminPath %>/ajax/ajax_node.aspx?__Action=CustomNode_Edit&id=<%=model.id %>&parentcode=<%=Topnode.Code %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  