﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.config.EmailJob_Edit_window" validateRequest="false"%>

    <div class="modal-header">
        <h4 class="modal-title"><%=Tag("查看")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
    </div>
    <div class="modal-body" style="max-height:500px;overflow-y:auto;">
        <div class="form-group">
            <label><%=Tag("邮箱")%>：</label>
            <%=model.Email %>
        </div>
        <div class="form-group">
            <label><%=Tag("用户")%>：</label>
            <%=model.User_Name %>
        </div>
        <div class="form-group">
            <label><%=Tag("主题")%>：</label>
            <%=model.Title%>
        </div>
        <div class="form-group">
            <label><%=Tag("内容")%>：</label>
            <%=model.Content%>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
    </div>

  