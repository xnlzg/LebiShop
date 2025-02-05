﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.User.Message_Write_window" validateRequest="false"%>

    <form action="javascript:SendMSG();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("发信息")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <ul class="nav nav-tabs customtab" role="tablist">
                <%
                List<DB.LebiShop.Lebi_Language_Code> langs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in langs){
                %>
                <li class="nav-item"> <a class="nav-link <%if (langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                <%
                }
                %>
            </ul>
            <div class="tab-content m-t-20">
                <%
                foreach (DB.LebiShop.Lebi_Language_Code lang in langs)
                {%>
                <div class="tab-pane <%if (langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                    <div class="form-group">
                        <label for="Title<%=lang.Code %>"><%=Tag("标题")%>：</label>
                        <input type="text" id="Title<%=lang.Code %>" name="Title<%=lang.Code %>" class="form-control" shop="true" <%if (langs.FirstOrDefault().Code == lang.Code){%>required<%}%>>
                    </div>
                    <div class="form-group">
                        <label for="Content<%=lang.Code %>"><%=Tag("内容")%>：</label>
                        <textarea id="Content<%=lang.Code %>" name="Content<%=lang.Code %>" class="form-control" style="height: 60px;" shop="true" <%if (langs.FirstOrDefault().Code == lang.Code){%>required<%}%>></textarea>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                </div>
                <%} %>
            </div>
            <h4 class="nav-tips m-t-20 m-b-10"><%=Tag("通用信息")%></h4>
            <%if (ids == "" && User_Name == ""){ %>
            <div class="form-group">
                <label for="Time_Update"><%=Tag("发送范围")%>：</label>
                <%=su.Description == "" ? Tag("全部") : su.Description%>
            </div>
            <%}else{ %>
            <div class="form-group" id="showuser">
                <label for=""><%=Tag("会员账号")%>：</label>
                <div class="input-control">
                    <%if (ids != ""){ %>
                    <div class="row" id="proBox" style="overflow:hidden">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <a class="btn btn-danger btn-xs btn-sm" href="javascript:void(0);" onclick="delitem();"><i class="ti-close"></i> <%=Tag("删除")%></a>
                                    <a class="btn btn-danger btn-xs btn-sm" href="javascript:void(0);" onclick="removeall();"><i class="ti-trash"></i> <%=Tag("清空")%></a>
                                </div>
                                <div class="card-body b-t">
                                    <div class="multi-list" id="User_idsList"><ul></ul></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%foreach (DB.LebiShop.Lebi_User u in user){ %>
                    <script>
                        var temp = '<li ondblclick="delitem();" title="<%=Tag("双击删除") %>" class="iName"><input type="hidden" name="User_ids" id="User_ids" value="<%=u.id %>" shop="true" /><input type="hidden" name="UserName_ids" id="UserName_ids" value="<%=u.UserName %>" shop="true" /><span><%=u.UserName %></span></li>';
                        $('#User_idsList ul').append(temp);
                        $('#User_idsList ul li').selectedElement({ css: 'on' });
                        $("#User_Name_To").attr("required", "false");
                    </script>
                    <%}}%>
                    <%if (ids == ""){ %>
                    <input type="text" id="User_Name_To" name="User_Name_To" value="<%=User_Name %>" class="form-control" shop="true" required>
                    <%}%>
                </div>
            </div>
            <%}%>
            <div class="form-group">
                <label for="Time_Update"><%=Tag("类别")%>：</label>
                <select id="type_id" name="type_id" class="form-control" shop="true">
                    <%=Shop.Bussiness.Message.Message_TypeOption(350,"0", CurrentLanguage.Code)%>
                    <option value="0">
                        <%=Tag("系统消息") %>
                    </option>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function UType(n){
	        if (n==0){
                $("#User_Name_To").attr("required","true");
		        $("#showuser").show();
                $("#showuserlevel").hide();
	        }else if (n==1){
                $("#User_Name_To").attr("required","false");
		        $("#showuser").hide();
                $("#showuserlevel").show();
	        }
        }
        function delitem() {
            $("#User_idsList ul li[selectedElement]").remove();
            if ($("#User_idsList ul li").length == 0)
            {
                $("#User_Name_To").show();
                $("#User_Name_To").attr("required", "true");
                $("#proBox").hide();
            }
        }
        function removeall() {
            $("#User_idsList ul li").remove();
            $("#User_Name_To").show();
            $("#User_Name_To").attr("required", "true");
            $("#proBox").hide();
        }
        function SendMSG() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=Message_Write&<%=su.URL %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
    </script>

  