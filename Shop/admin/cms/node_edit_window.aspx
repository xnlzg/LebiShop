﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.cms.Node_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="parentid"><%=Tag("上级结点")%>：</label>
                <select name="parentid" id="parentid" class="form-control" shop="true">
                    <option value="0">
                        <%=Tag("根结点")%>
                    </option>
                    <%=GetOptionTreeString(0, 0, PNode.id)%>
                </select>
            </div>
            <div class="form-group">
                <label for="Code"><%=Tag("结点代码")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="TypeFlag"><%=Tag("结点类型")%>：</label>
                <select name="TypeFlag" id="TypeFlag" class="form-control" shop="true">
                    <option value="1" <%=model.TypeFlag==1?"selected":"" %>>
                    <%=Tag("页面分类")%></option>
                    <option value="2" <%=model.TypeFlag==2?"selected":"" %>>
                    <%=Tag("结点分类")%></option>
                    <option value="3" <%=model.TypeFlag==3?"selected":"" %>>
                    <%=Tag("独立内容")%></option>
                </select>
            </div>
            <div class="form-group">
                <label for="url"><%=Tag("链接页面")%>：</label>
                <input type="text" id="url" name="url" value="<%=model.url %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="AdminPage_Index"><%=Tag("管理首页")%>：</label>
                <input type="text" id="AdminPage_Index" name="AdminPage_Index" value="<%=model.AdminPage_Index %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="AdminPage"><%=Tag("管理内页")%>：</label>
                <input type="text" id="AdminPage" name="AdminPage" value="<%=model.AdminPage %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="target_self"><%=Tag("打开方式")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="target_self" name="target" value="_self" class="custom-control-input" shop="true" <%=model.target=="_self"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("当前窗口")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="target_blank" name="target" value="_blank" class="custom-control-input" shop="true" <%=model.target=="_blank"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("新窗口")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="IsLanguages_0"><%=Tag("多语言")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsLanguages_0" name="IsLanguages" value="0" class="custom-control-input" shop="true" <%=model.IsLanguages==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsLanguages_1" name="IsLanguages" value="1" class="custom-control-input" shop="true" <%=model.IsLanguages==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="haveson_0"><%=Tag("子结点")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="haveson_0" name="haveson" value="0" class="custom-control-input" shop="true" <%=model.haveson==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("不允许")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="haveson_1" name="haveson" value="1" class="custom-control-input" shop="true" <%=model.haveson==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("允许")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" class="form-control" id="Sort" name="Sort" shop="true" value="<%=model.Sort %>" onkeyup="value=value.replace(/[^\d]/g,'')">
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
            var url = "<%=site.AdminPath %>/ajax/ajax_node.aspx?__Action=Node_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  