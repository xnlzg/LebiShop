﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.theme.page_create_window" validateRequest="false"%>

    <form action="javascript:GreateHtml();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("生成静态页")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for=""><%=Tag("页面")%>：</label>
                [<%=model.Code%>]<%=Lang(model.Name) %>
            </div>
            <%if(showlanguage){ %>
            <div class="form-group">
                <label for=""><%=Tag("语言")%>：</label>
                <%=GetLanguage()%>
            </div>
            <%} %>
            <%=Select%>
            <div class="form-group">
                <label for="Type_id_PublishType"><%=Tag("进度")%>：</label>
                <div class="input-group" id="progressbar">
                    <div id="progress" style="background:#cccccc;height:10px;width:0%;">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("生成")%></button>
            <button id="pagemsg" style="display:none;"><%=Tag("正在处理")%>...</button>
        </div>
    </form>
    <script>
        var pageindex=1;
        var pagesize = 10;
        var progressvalue = 1;
        var progress;
        function GreateHtml() {
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_html.aspx?__Action=CreatePage&id=<%=model.id %>&pageindex=" + pageindex + "&pagesize=" + pagesize;
            $("#progressbar").show();
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: 'json',
                beforeSend: function () {
                    //MsgBox(4, "<%=Tag("正在处理") %> ……", "-");
                    $("#pagemsg").show();
                },
                success: function (res) {
                    if (res.msg == "OK") {
                        progressvalue = res.per;
                        pageindex = pageindex + 1;
                        $("#progress").css("width", progressvalue + "%");
                        if (res.per < 100)
                            GreateHtml();
                        else
                            MsgBox(1, '<%=Tag("操作成功") %>', "");

                    }
                    else {
                        MsgBox(2, res.msg, "");
                        return false;
                    }
                }
            });
        }
        $().ready(function () {
            $('.mutiselect').multiselect2side({
                selectedPosition: 'right',
                moveOptions: false,
                //search: "<img src='img/search.gif' align=\"absmiddle\" /> ",
                labelsx: '',
                labeldx: '',
                autoSort: false,
                autoSortAvailable: false
            });
        }); 
    </script>

  