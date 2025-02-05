﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.User.SMS_Write_window" validateRequest="false"%>

    <form action="javascript:SendSMS();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("手机短信")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Content"><%=Tag("内容")%>：</label>
                <textarea id="Content" name="Content" class="form-control" style="height: 60px;" shop="true" required></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Content',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
            <%if (ids == "" && User_Name == ""){ %>
            <div class="form-group">
                <label for=""><%=Tag("发送范围")%>：</label>
                <%=su.Description == "" ? Tag("全部") : su.Description%>
            </div>
            <%}else{ %>
            <div class="form-group" id="showuser">
                <label for="" id="typename"><%=Tag("会员账号")%>：</label>
                <div class="input-control">
                    <%if (ids != ""){ %>
                    <div class="row" id="proBox" style="overflow:hidden">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <a class="btn btn-danger btn-xs btn-sm" href="javascript:void(0);" onclick="delitem();"><i class="ti-close"></i> <%=Tag("删除")%></a>
                                    <a class="btn btn-danger btn-xs btn-sm" href="javascript:void(0);" onclick="removeall(0);"><i class="ti-trash"></i> <%=Tag("清空")%></a>
                                </div>
                                <div class="card-body b-t">
                                    <div class="multi-list" id="User_idsList"><ul></ul></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%foreach (DB.LebiShop.Lebi_User u in user){ %>
                    <script type="text/javascript">
                        var temp = '<li ondblclick="delitem();" title="<%=Tag("双击删除") %>" class="iName"><input type="hidden" name="User_ids" id="User_ids" value="<%=u.id %>" sms="true" /><input type="hidden" name="UserName_ids" id="UserName_ids" value="<%=u.UserName %>" sms="true" /><span><%=u.UserName %></span></li>';
                        $('#User_idsList ul').append(temp);
                        $('#User_idsList ul li').selectedElement({ css: 'on' });
                        $("#User_Name_To").attr("min", "");
                    </script>
                    <%}}%>
                </div>
            </div>
            <%} %>
            <div class="form-group" id="PhoneNoList" style="display:none">
                <label for="PhoneNo"><%=Tag("手机号码")%>：</label>
                <textarea id="PhoneNo" name="PhoneNo" class="form-control" style="height: 60px;" shop="true"></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('PhoneNo',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('PhoneNo',-100);"><%=Tag("收缩")%></button>
                </div>
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
                $("#PhoneNo").attr("required","true");
		        $("#showuser").show();
                $("#showuserlevel").hide();
	        }else if (n==1){
                $("#PhoneNo").attr("required","false");
		        $("#showuser").hide();
                $("#showuserlevel").show();
	        }
        }
        function delitem() {
            $("#User_idsList ul li[selectedElement]").remove();
            if ($("#User_idsList ul li").length == 0)
            {
                $("#PhoneNoList").show();
                $("#PhoneNo").attr("required", "true");
                $("#proBox").hide();
            }
        }
        function removeall(type) {
            if (type == 0){
                $("#User_idsList ul li").remove();
                $("#showuser").hide();
                $("#PhoneNoList").show();
                $("#PhoneNo").attr("required", "true");
            }else{
                var flag=$("#custom").is(":checked");
                if(!flag){
                    $("#PhoneNoList").hide();
                    $("#PhoneNo").attr("required", "false");
                    $("#PhoneNo").html("");
                }else{
                    $("#PhoneNoList").show();
                    $("#PhoneNo").attr("required", "true");
                }
            }
            $("#proBox").hide();
        }
        function SendSMS() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("sms");
            var url = "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=SMS_Write&<%=su.URL %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
    </script>

  