﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.admin.Log_Edit_window" validateRequest="false"%>

    <div class="modal-header">
        <h4 class="modal-title"><%=Tag("日志详情")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-md-6 form-group">
                <label><%=Tag("系统用户")%>：</label>
                <%=model.AdminName %>
            </div>
            <div class="col-md-6 form-group">
                <label><%=Tag("数据表")%>：</label>
                <%=model.TableName %>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 form-group">
                <label><%=Tag("IP地址")%>：</label>
                <%=model.IP_Add%> <a href="http://www.ip138.com/ips138.asp?ip=<%=model.IP_Add%>&action=2" target="_blank"><i class="ti-new-window"></i></a>
            </div>
            <div class="col-md-6 form-group">
                <label><%=Tag("时间")%>：</label>
                <%=FormatTime(model.Time_Add)%>
            </div>
        </div>
        <%if (model.Keyid != ""){ %>
        <div class="form-group">
            <label><%=Tag("主键")%>：</label>
            <textarea class="form-control" id="message-text"><%=model.Keyid %></textarea>
        </div>
        <%} %>
        <div class="form-group">
            <label><%=Tag("内容")%>：</label>
            <textarea class="form-control" id="message-text"><%=model.Content %></textarea>
        </div>
        <%if (model.Description != ""){ %>
        <div class="form-group">
            <label><%=Tag("描述")%>：</label>
            <textarea class="form-control" id="message-text"><%=model.Description %></textarea>
        </div>
        <%} %>
        <div class="form-group">
            <label><%=Tag("URL")%>：</label>
            <textarea class="form-control" id="message-text"><%=model.URL %></textarea>
        </div>
        <%if (model.RefererURL != ""){ %>
        <div class="form-group">
            <label><%=Tag("来源URL")%>：</label>
            <textarea class="form-control" id="message-text"><%=model.RefererURL %></textarea>
        </div>
        <%} %>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
    </div>

  