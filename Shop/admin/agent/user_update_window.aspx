﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.agent.User_Update_Window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("批量设置")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="Angent1_Commission"><%=Tag("一级佣金")%>：</label>
                <input type="text" class="form-control" id="Angent1_Commission" name="Angent1_Commission" shop="true">
                <small class="form-text text-muted">% <%=Tag("继承填写")%>-1</small>
            </div>
            <div class="form-group">
                <label for="Angent2_Commission"><%=Tag("二级佣金")%>：</label>
                <input type="text" class="form-control" id="Angent2_Commission" name="Angent2_Commission" shop="true">
                <small class="form-text text-muted">% <%=Tag("继承填写")%>-1</small>
            </div>
            <div class="form-group">
                <label for="Angent3_Commission"><%=Tag("三级佣金")%>：</label>
                <input type="text" class="form-control" id="Angent3_Commission" name="Angent3_Commission" shop="true">
                <small class="form-text text-muted">% <%=Tag("继承填写")%>-1</small>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script type="text/javascript">
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url= "<%=site.AdminPath %>/ajax/ajax_agent.aspx?__Action=User_Update&id=<%=id %>";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "?");});
        }
    </script>

  