﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.user.usercard_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <%if (mode == "scope"){ %>
            <div class="form-group">
                <label for=""><%=Tag("发放范围")%>：</label>
                <%=su.Description == "" ? Tag("全部") : su.Description%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("发放数量")%>：</label>
                <%=DB.LebiShop.B_Lebi_User.Counts("id>0 "+su.SQL)%>
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
                    <%if (user_ids == ""){ %>
                    <input type="text" id="User_Name_To" name="User_Name_To" value="<%=User_Name %>" class="form-control" shop="true" required>
                    <%} %>
                </div>
            </div>
            <%} %>
            <div class="form-group">
                <label for="orderid"><%=Tag("批次")%>：</label>
                <select id="orderid" name="orderid" class="form-control" shop="true">
                    <%foreach (DB.LebiShop.Lebi_CardOrder co in cos){ %>
                    <option value="<%=co.id %>">
                        <%=Lang(co.Name)%>
                        <%=co.IndexCode %> - <%=Tag("面值") %>:<%=co.Money %>
                        <%=Tag("数量") %>:<%=count_card(co.id)%>
                        <%=Tag("剩余") %>:<%=count_card_no(co.id)%>
                    </option>
                    <%} %>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
            <input type="hidden" name="cardtype" value="<%=cardtype%>" shop="true">
            <input type="hidden" name="mode" value="<%=mode%>" shop="true">
        </div>
    </form>
    <script>
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function delitem() {
            $("#User_idsList ul li[selectedElement]").remove();
            if ($("#User_idsList ul li").length == 0)
            {
                $("#User_Name_To").show();
                $("#User_Name_To").attr("min","notnull");
                $("#proBox").hide();
            }
        }
        function remove() {
            $("#User_idsList ul li").remove();
            $("#User_Name_To").show();
            $("#User_Name_To").attr("min","notnull");
            $("#proBox").hide();
        }
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_user.aspx?__Action=SendCard&<%=su.URL %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", '?')});
        }
    </script>

  