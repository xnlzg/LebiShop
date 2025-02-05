﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.promotion.card_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <%if (card_ids == ""){ %>
            <div class="form-group">
                <label for=""><%=Tag("范围")%>：</label>
                <%=su.Description == "" ? Tag("全部") : su.Description%>
            </div>
            <%}else{ %>
            <div class="form-group" id="showuser">
                <label for=""><%=Tag("编号")%>：</label>
                <div class="input-control">
                    <div class="row" id="proBox" style="overflow:hidden">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <a class="btn btn-danger btn-xs btn-sm" href="javascript:void(0);" onclick="delitem();"><i class="ti-close"></i> <%=Tag("删除")%></a>
                                    <a class="btn btn-danger btn-xs btn-sm" href="javascript:void(0);" onclick="remove();"><i class="ti-trash"></i> <%=Tag("清空")%></a>
                                </div>
                                <div class="card-body b-t">
                                    <div class="multi-list" id="Card_idsList"><ul></ul></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%foreach (DB.LebiShop.Lebi_Card u in models){ %>
                    <script>
                        var temp = '<li ondblclick="delitem();" title="<%=Tag("双击删除") %>" class="iName"><input type="hidden" name="card_ids" id="card_ids" value="<%=u.id %>" shop="true" /><input type="hidden" name="card_codes" id="card_codes" value="<%=u.Code %>" shop="true" /><span><%=u.Code %></span></li>';
                        $('#Card_idsList ul').append(temp);
                        $('#Card_idsList ul li').selectedElement({ css: 'on' });
                        $("#User_Name_To").attr("min", "");
                    </script>
                    <%}%>
                </div>
            </div>
            <%} %>
            <div class="form-group">
                <label for=""><%=Tag("数量")%>：</label>
                <%=count%>
            </div>
            <div class="form-group">
                <label for="Type_id_MoneyType"><%=Tag("状态")%>：</label>
                <select id="CardStatus" name="CardStatus" class="form-control" shop="true">
                    <option value="0"><%=Tag("请选择") %></option>
                    <%=Shop.Bussiness.EX_Type.TypeOption("CardStatus",0) %>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("提交")%></button>
        </div>
    </form>
    <script>
        function delitem() {
            $("#Card_idsList ul li[selectedElement]").remove();
            if ($("#Card_idsList ul li").length == 0)
            {
                $("#User_Name_To").show();
                $("#User_Name_To").attr("min","notnull");
                $("#proBox").hide();
            }
        }
        function remove() {
            $("#Card_idsList ul li").remove();
            $("#User_Name_To").show();
            $("#User_Name_To").attr("min","notnull");
            $("#proBox").hide();
        }
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_sale.aspx?__Action=Cards_Edit&<%=su.URL %>";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", '?')});
        }
    </script>

  