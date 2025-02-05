﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.user.userquestion_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("安全问题")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <%if (recordCount == 0){ %>
            <div class="form-group">
                <label for="Question_id1"><%=Tag("问题")%>：</label>
                <select name="Question_id1" id="Question_id1" class="form-control" shop="true">
                    <%foreach (DB.LebiShop.Lebi_User_Question model in user_questions)
                    {%>
                    <option value="<%=model.id %>"><%=Lang(model.Name)%></option>
                    <%} %>
                </select>
            </div>
            <div class="form-group">
                <label for="Answer1"><%=Tag("答案")%>：</label>
                <input type="text" id="Answer1" name="Answer1" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Question_id2"><%=Tag("问题")%>：</label>
                <select name="Question_id2" id="Question_id2" class="form-control" shop="true">
                    <%foreach (DB.LebiShop.Lebi_User_Question model in user_questions)
                    {%>
                    <option value="<%=model.id %>"><%=Lang(model.Name)%></option>
                    <%} %>
                </select>
            </div>
            <div class="form-group">
                <label for="Answer2"><%=Tag("答案")%>：</label>
                <input type="text" id="Answer2" name="Answer2" class="form-control" shop="true" required>
            </div>
            <%}else{ %>
            <%foreach (DB.LebiShop.Lebi_User_Answer model in user_answers){%>
            <div class="form-group">
                <label for=""><%=Tag("问题")%>：</label>
                <div class="form-control-label">
                    <%=QuestionName(model.User_Question_id) %>
                </div>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("答案")%>：</label>
                <div class="form-control-label">
                    ******
                </div>
            </div>
            <%}} %>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <%if (recordCount == 0){ %>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
            <%}else{ %>
            <button type="button" class="btn btn-success" onclick="DeleteConfirm();"><i class="ti-check"></i> <%=Tag("重置")%></button>
            <%} %>
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
            var url = "<%=site.AdminPath %>/Ajax/ajax_user.aspx?__Action=Question_Edit&id=<%=id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
        function DeleteConfirm() {
            $("#DeleteConfirm").modal("show");
            $("#DeleteConfirm .btn-success.btn-ok").attr("onclick","Delete_Question();");
        }
        function Delete_Question() {
            $("#DeleteConfirm").modal("hide");
            var url = "<%=site.AdminPath %>/Ajax/ajax_user.aspx?__Action=Question_Del&id=<%=id %>";
            RequestAjax(url,"",function(){MsgBox(1, "<%=Tag("操作成功")%>", "");Question(<%=id %>);});
        }
    </script>

  