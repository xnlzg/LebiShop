﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Product.Ask_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("回复")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <%if (model.Parentid == 0){ %>
            <div class="form-group">
                <label for="Content"><%=Tag("内容")%>：</label>
                <textarea id="Content" name="Content" rows="6" class="form-control" style="height:60px;" shop="true" required></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("回复")%></button>
            <hr class="m-t-20 m-b-20">
            <%}%>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label for=""><%=Tag("商品名称")%>：</label>
                        <div class="input-group">
                            <% if (GetProduct(model.Keyid).ImageSmall != ""){ %>
                            <img style="height: 30px;width: 30px;vertical-align:middle" src="<%=Image(GetProduct(model.Keyid).ImageOriginal,50,50) %>" />
                            <%} %>
                            <%=Lang(GetProduct(model.Keyid).Name)%>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for=""><%=Tag("会员账号")%>：</label>
                        <%=model.User_UserName%>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for=""><%=Tag("状态")%>：</label>
                        <%=Shop.Bussiness.EX_Type.TypeName(model.Status, CurrentLanguage)%>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for=""><%=Tag("语言")%>：</label>
                        <%=model.Language_Code%>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for=""><%=Tag("时间")%>：</label>
                        <%=FormatTime(model.Time_Add)%>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("内容")%>：</label>
                <textarea id="message-text" class="form-control"><%=model.Content %></textarea>
            </div>
            <%if (model.Parentid == 0){ %>
            <%foreach (DB.LebiShop.Lebi_Comment modellist in models){%>
            <div id="content<%=modellist.id %>" class="form-group">
                <label for=""><a href="javascript:void(0);" onclick="DeleteItemConfirm(<%=modellist.id %>)"><%=Tag("删除") %></a> <%=modellist.Time_Add%>：</label>
                <div class="input-group">
                    <%=modellist.Content.Replace("\r\n", "<br />")%>
                </div>
            </div>
            <%}%>
            <%}%>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
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
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Ask_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function DeleteItemConfirm(id) {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "delitem(" + id + ");");
        }
        function delitem(id) {
            $("#Modal-Confirm").modal("hide");
            var postData = "";
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Ask_Del&Delid="+ id;
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "");$("#content"+ id).remove();});
        }
    </script>

  