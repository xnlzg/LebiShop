﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Config.Card_Create_window" validateRequest="false"%>

    <form action="javascript:Create();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("生成优惠券")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for=""><%=Tag("类型")%>：</label>
                <%=Tag("名称")%>：<%=Shop.Bussiness.Language.Content(model.Name,CurrentLanguage.Code) %>,
                <%=Tag("面值")%>：<%=model.Money %>,
                <%=Tag("头字母")%>：<%=model.IndexCode %>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("有效期")%>：</label>
                <%=FormatDate(model.Time_Begin) %> - <%=FormatDate(model.Time_End) %>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("号码段")%>：</label>
                <%=model.NO_Start %> -  <%=model.NO_End %>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("生成进度")%>：</label>
                <div class="input-group">
                    <span id="status"></span><span id="code"><%=model.NO_Now %></span> 
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("生成")%></button>
        </div>
    </form>
    <script>
        var no_now=<%=model.NO_Now %>;
        function Create() { 
            var url = "<%=site.AdminPath %>/ajax/ajax_sale.aspx?__Action=Card_Create";
            $.ajax({
            type: "POST",
            url: url,
            data: {'CardType':<%=model.id %>},
            dataType: 'json',
            success: function (res) {
                if (res.msg == "OK") {
                    $("#code").html(res.code);
                    if(res.status!='OK'){
                        $("#status").html("<%=Tag("正在生成") %>");
                        Create();
                    }else{
                        $("#status").html("<%=Tag("生成完毕") %>");
                    }
                    return false;
                }
                else {
                    MsgBox(2, res.msg, "");
                    return false;
                }
            }
        });
        }
    </script>

  