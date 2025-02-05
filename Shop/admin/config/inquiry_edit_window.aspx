﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Config.Inquiry_Edit_window" validateRequest="false"%>

    <div class="modal-header">
        <h4 class="modal-title"><%=Tag("编辑")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="form-group col-md-6">
                <label><%=Tag("昵称")%>：</label>
                <div class="form-control-label">
                    <%=model.UserName%>
                </div>
            </div>
            <div class="form-group col-md-6">
                <label><%=Tag("电子邮件")%>：</label>
                <div class="form-control-label">
                    <a href="mailto:<%=model.Email %>?subject=RE:<%=model.Subject %>"><%=model.Email %></a>
                </div>
            </div>
            <div class="form-group col-md-6">
                <label><%=Tag("电话")%>：</label>
                <div class="form-control-label">
                    <%=model.Phone%>
                </div>
            </div>
            <div class="form-group col-md-6">
                <label><%=Tag("时间")%>：</label>
                <div class="form-control-label">
                    <%=FormatTime(model.Time_Add)%>
                </div>
            </div>
            <div class="form-group col-md-6">
                <label><%=Tag("状态")%>：</label>
                <div class="form-control-label">
                    <%=Shop.Bussiness.EX_Type.TypeName(model.Type_id_InquiryStatus)%>
                </div>
            </div>
            <div class="form-group col-md-6">
                <label><%=Tag("更新时间")%>：</label>
                <div class="form-control-label">
                    <%=FormatTime(model.Time_Update)%>
                </div>
            </div>
            <div class="form-group col-md-12">
                <label><%=Tag("标题")%>：</label>
                <div class="form-control-label">
                    <%=model.Subject%>
                </div>
            </div>
            <div class="form-group col-md-12">
                <label><%=Tag("内容")%>：</label>
                <div class="form-control-label">
                    <%=model.Content%>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
        <%if(model.Type_id_InquiryStatus==411){ %>
        <button type="button" class="btn btn-danger" onclick="SaveObj(413);"><i class="ti-check"></i> <%=Tag("无效")%></button>
        <button type="button" class="btn btn-success" onclick="SaveObj(412);"><i class="ti-check"></i> <%=Tag("已回复")%></button>
        <%} %>
    </div>
    <script>
        function SaveObj(t) {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=Inquiry_Edit&id=<%=model.id %>&t="+t;
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  