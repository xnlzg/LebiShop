﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.config.Copyright_window" validateRequest="false"%>

    <div class="modal-header">
        <h4 class="modal-title"><%=Tag("关于")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
    </div>
    <div class="modal-body">
        <div class="form-group">
            <%
            if (!Shop.LebiAPI.Service.Instanse.Check("managelicenese")){
            %>
            <a href="http://www.lebi.cn/" target="_blank"><img src="<%=site.AdminAssetsPath %>/images/lebi.gif" width="137" height="30" style="margin:15px 0" /></a> <font style="padding-top:90px"><%=Tag("版本")%>：V<%=SYS.Version %>.<%=SYS.Version_Son %></font>
            <br /><%=Tag("五六七七零网络科技有限公司 版权所有")%>
            <br />Copyright 2003-<%=DateTime.Now.Year %> www.lebi.cn All Rights Reseved
            <%}%>
            <%else{%>
            <font><%=Tag("版本")%>：V<%=SYS.Version %>.<%=SYS.Version_Son %></font>
            <%}%>
            <br /><br /><span style="font-size:14px"><%=Tag("警告：本计算机程序受著作权法和国际公约的保护，未经授权擅自复制传播本程序的部分或全部，可能受到严厉的民事及刑事制裁，并在法律的许可范围内受到可能的起诉。")%></span>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
    </div>

  