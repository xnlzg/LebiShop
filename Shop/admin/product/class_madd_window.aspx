﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.Class_MAdd_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("批量添加")%></h4>
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
                        <label for="Name<%=lang.Code %>"><%=Tag("分类名称")%>：</label>
                        <textarea id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" class="form-control" style="height: 100px;" shop="true" <%if (langs.FirstOrDefault().Code == lang.Code){%>required<%}%>></textarea>
                        <small class="form-text text-muted"><%=Tag("每行输入一个类别，用回车换行。")%></small>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Name<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Name<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                </div>
                <%} %>
            </div>
            <h4 class="nav-tips m-t-20 m-b-10"><%=Tag("通用信息")%></h4>
            <div class="form-group">
                <label for="Parentid"><%=Tag("上级分类")%>：</label>
                <select id="Parentid" name="Parentid" class="form-control" shop="true">
                    <option value="0">┌<%=Tag("顶级分类")%></option>
                    <%=Shop.Bussiness.EX_Product.TypeOption(0, 0, 0, CurrentLanguage.Code, Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
                </select>
            </div>
            <div class="form-group">
                <label for="IsShow_1"><%=Tag("是否显示")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsShow_1" name="IsShow" value="1" class="custom-control-input" shop="true" checked>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsShow_0" name="IsShow" value="0" class="custom-control-input" shop="true">
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="IsIndexShow_1"><%=Tag("首页显示")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsIndexShow_1" name="IsIndexShow" value="1" class="custom-control-input" shop="true" checked>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsIndexShow_0" name="IsIndexShow" value="0" class="custom-control-input" shop="true">
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Site_ids"><%=Tag("站点")%>：</label>
                <div class="input-group">
                    <%=site.SiteCheckbox("Site_ids","",CurrentLanguage.Code)%>
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
            <%foreach (DB.LebiShop.Lebi_Language_Code lang in Shop.Bussiness.Language.Languages()){%>
            if ($("#Name<%=lang.Code %>").val() == "") {
                MsgBox(2, "<%=Tag("请填写分类名称")%>(<%=lang.Name%>)", "");
                return;
            }
            <%} %>
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Class_MAdd";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  