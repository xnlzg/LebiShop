﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.User.Message_Reply_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%if (model.User_id_From == 0){ %><%=Tag("阅读")%><%}else{ %><%=Tag("回复")%><%} %></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <%if (model.User_id_To == 0){ %>
            <div class="form-group">
                <label for="Title"><%=Tag("标题")%>：</label>
                <input type="text" id="Title" name="Title" value="Re <%=model.Title %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Content"><%=Tag("内容")%>：</label>
                <textarea id="Content" name="Content" rows="6" class="form-control" style="height:60px;" shop="true"><%=model.Content%></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("回复")%></button>
            <hr class="m-t-20 m-b-20">
            <%}%>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for=""><%=Tag("收件人")%>：</label>
                        <%=model.User_Name_To %>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for=""><%=Tag("发件人")%>：</label>
                        <%=model.User_Name_From%>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for=""><%=Tag("语言")%>：</label>
                        <%=model.Language%>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for=""><%=Tag("时间")%>：</label>
                        <%=FormatTime(model.Time_Add)%>
                    </div>
                </div>
            </div>
            <%if (model.Message_Type_id != 0){ %>
            <div class="form-group">
                <label for=""><%=Tag("类别")%>：</label>
                <%=Lang(Shop.Bussiness.Message.Message_Type(model.Message_Type_id).Name)%>
            </div>
            <%} %>
            <div class="form-group">
                <label for=""><%=Tag("标题")%>：</label>
                <%=model.Title%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("内容")%>：</label>
                <textarea class="form-control" id="message-text"><%=model.Content %></textarea>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("IP地址")%>：</label>
                <%=model.IP%> <a href="http://www.ip138.com/ips138.asp?ip=<%=model.IP%>&action=2" target="_blank"><i class="ti-new-window"></i></a>
            </div>
            <%if (model.User_id_To == 0){ %>
            <%foreach (DB.LebiShop.Lebi_Message modellist in models){%>
            <div id="content<%=modellist.id %>" class="form-group">
                <label for=""><%=modellist.User_Name_From %>：</label>
                <%=modellist.Content.Replace("\r\n", "<br />")%><em>(<%=modellist.Time_Add%>)</em>
            </div>
            <%}%>
            <%}%>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
        </div>
    </form>
    <script>
v
            var url = "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=Message_Reply&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
    </script>

  