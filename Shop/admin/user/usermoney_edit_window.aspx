﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.user.UserMoney_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <%if (mode == "scope"){ %>
            <div class="form-group">
                <label for=""><%=Tag("调整范围")%>：</label>
                <%=su.Description == "" ? Tag("全部") : su.Description%>
            </div>
            <%}else{ %>
            <div class="form-group" id="showuser">
                <label for=""><%=Tag("会员账号")%>：</label>
                <div class="input-control">
                    <%if (user_ids != ""){ %>
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
                    <%foreach (DB.LebiShop.Lebi_User u in users){ %>
                    <script type="text/javascript">
                        var temp = '<li ondblclick="delitem();" title="<%=Tag("双击删除") %>" class="iName"><input type="hidden" name="User_ids" id="User_ids" value="<%=u.id %>" shop="true" /><input type="hidden" name="UserName_ids" id="UserName_ids" value="<%=u.UserName %>" shop="true" /><span><%=u.UserName %></span></li>';
                        $('#User_idsList ul').append(temp);
                        $('#User_idsList ul li').selectedElement({ css: 'on' });
                        $("#User_Name_To").attr("min", "");
                    </script>
                    <%}}%>
                    <%if (id > 0){ %>
                    <input type="hidden" id="User_Name_To" name="User_Name_To" value="<%=User_Name %>" /><%=User_Name%>
                    <%}else{ %>
                    <input type="text" id="User_Name_To" name="User_Name_To" value="<%=User_Name %>" class="form-control" style="<%if (user_ids != " "){ %>display:none<%}%>" shop="true">
                    <%} %>
                </div>
            </div>
            <%} %>
            <div class="form-group">
                <label for="Money"><%=Tag("资金")%>：</label>
                <%if (id > 0){ %>
                <div class="form-control-label"><%=Money%></div>
                <%}else{ %>
                    <input type="text" id="Money" name="Money" value="<%=Money %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^-\d\.]/g,'');" required>
                <%} %>
            </div>
            <div class="form-group">
                <label for="Type_id_MoneyType"><%=Tag("类型")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Type.TypeRadio("MoneyType", "Type_id_MoneyType", model.Type_id_MoneyType, "shop=\"true\"",CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Remark"><%=Tag("操作说明")%>：</label>
                <textarea id="Remark" name="Remark" class="form-control" style="height: 60px;" shop="true" onKeyDown="checkMaxInput(this.form)" onKeyUp="checkMaxInput(this.form)"><%=model.Remark%></textarea>
                <small class="form-text text-muted">≤ <span id="remLen">255</span></small>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
            <input type="hidden" name="id" value="<%=id%>" shop="true">
            <input type="hidden" name="mode" value="<%=mode%>" shop="true">
        </div>
    </form>
    <script>
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        var maxLen = 255;
        var Remark = document.getElementById("Remark");
        function checkMaxInput(form) {
            if (Remark.value.length > maxLen)
                Remark.value = Remark.value.substring(0, maxLen);
            else document.getElementById("remLen").innerHTML = maxLen - Remark.value.length;
        }
        function delitem() {
            $("#User_idsList ul li[selectedElement]").remove();
            if ($("#User_idsList ul li").length == 0)
            {
                $("#User_Name_To").show();
                $("#User_Name_To").attr("required","");
                $("#proBox").hide();
            }
        }
        function removeall() {
            $("#User_idsList ul li").remove();
            $("#User_Name_To").show();
            $("#User_Name_To").attr("required","");
            $("#proBox").hide();
        }
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=UserMoney_Edit&<%=su.URL %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", '?')});
        }
    </script>

  