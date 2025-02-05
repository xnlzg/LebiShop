﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_tag_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("商品标签")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for=""><%=Tag("商品标签")%>：</label>
                <div class="input-group">
                    <% foreach (DB.LebiShop.Lebi_Pro_Tag t in DB.LebiShop.B_Lebi_Pro_Tag.GetList("", "")){ %>
                    <label class="custom-control custom-checkbox m-r-20">
                        <input type="checkbox" id="Pro_Tag_id_<%=t.id %>" name="Pro_Tag_id" value="<%=t.id %>" class="custom-control-input" shop="true">
                        <span class="custom-control-label"><%=Shop.Bussiness.Language.Content(t.Name,CurrentLanguage.Code) %></span>
                    </label>
                    <%} %>
                </div>
            </div>
            <div class="form-group">
                <label for="Tags"><%=Tag("分组商品标签")%>：</label>
                <input type="text" id="Tags" name="Tags" class="form-control" shop="true">
                <small class="form-text text-muted"><%=Tag("标签通过匹配商品名称来识别相关商品，多个标签用，隔开")%></small>
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
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Tag_Edit&ids=<%=ids %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?");});
        }
    </script>

  