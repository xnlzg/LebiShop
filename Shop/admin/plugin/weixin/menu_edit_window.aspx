﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.plugin.weinxin.menu_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("编辑菜单")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for=""><%=Tag("上级")%>：</label>
                <div class="form-control-label"><%=pmodel.name %></div>
            </div>
            <div class="form-group">
                <label for="name"><%=Tag("名称")%>：</label>
                <input type="text" id="name" name="name" value="<%=model.name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="url"><%=Tag("链接地址")%>：</label>
                <input type="text" id="url" name="url" value="<%=model.url %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="IsLogin_1"><%=Tag("登录验证")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsLogin_1" name="IsLogin" value="1" class="custom-control-input" shop="true" <%=IsLogin==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsLogin_0" name="IsLogin" value="0" class="custom-control-input" shop="true" <%=IsLogin==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Name" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true">
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script type="text/javascript">
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "ajax.aspx?__Action=Menu_Edit&parentid=<%=pmodel.id %>&id=<%=model.id %>";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  