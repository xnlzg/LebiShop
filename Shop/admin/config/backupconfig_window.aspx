﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.BackUPConfig" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("备份配置")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="DataBase_BackPath"><%=Tag("备份路径")%>：</label>
                <input type="text" id="DataBase_BackPath" name="DataBase_BackPath" value="<%=model.DataBase_BackPath %>" class="form-control" shop="true" />
            </div>
            <div class="form-group">
                <label for="DataBase_BackName"><%=Tag("备份文件扩展名")%>：</label>
                <input type="text" id="DataBase_BackName" name="DataBase_BackName" value="<%=model.DataBase_BackName %>" class="form-control" shop="true" />
            </div>
            <div class="form-group">
                <label for="DataBase_BackUpTime"><%=Tag("备份间隔")%>：</label>
                <input type="text" id="DataBase_BackUpTime" name="DataBase_BackUpTime" value="<%=model.DataBase_BackUpTime %>" class="form-control" shop="true" />
                <small class="form-text text-muted"><%=Tag("单位：分钟") %> <%=Tag("0 表示不备份") %></small>
            </div>
            <%if (!IsEnable)
            { %>
            <div class="form-group">
                <%=Tag("数据库与网站程序不在同一服务器，备份功能不可用")%>
            </div>
            <%} %>
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
            var url="<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=BackUPConfig_Edit";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
    </script>

  