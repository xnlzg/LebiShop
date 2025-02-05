﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.SearchKey_Edit_window" validateRequest="false"%>

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
                        <label for="Name<%=lang.Code %>"><%=Tag("名称")%>：</label>
                        <input type="text" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name,lang.Code) %>" <%if (langs.FirstOrDefault().Code == lang.Code){%>required<%}%> class="form-control" shop="true">
                    </div>
                </div>
                <%} %>
            </div>
            <h4 class="nav-tips m-t-20 m-b-10"><%=Tag("通用信息")%></h4>
            <div class="form-group">
                <label for="Type_1"><%=Tag("属性")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="Type_1" name="Type" value="1" class="custom-control-input" shop="true" <%=model.Type==1?"checked":"" %> onclick="SetStatus()">
                        <span class="custom-control-label"><%=Tag("内链")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="Type_2" name="Type" value="2" class="custom-control-input" shop="true" <%=model.Type==2?"checked":"" %> onclick="SetStatus()">
                        <span class="custom-control-label"><%=Tag("外链")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group" id="urltr">
                <label for="URL"><%=Tag("网址")%>：</label>
                <input type="text" id="URL" name="URL" value="<%=model.URL %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
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
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=SearchKey_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function SetStatus()
        {
            var Type=$("input[name='Type']:checked").val();
            if(Type=="1")
                $("#urltr").hide();
            else
                $("#urltr").show();   
        }
        SetStatus();
    </script>

  