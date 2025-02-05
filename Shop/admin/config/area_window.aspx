﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.Area_window" validateRequest="false"%>

    <form action="javascript:SelectAreaOK();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <table class="table table-hover no-wrap">
                <thead>
                    <tr>
                        <th style="width: 40px" class="selectAll">
                            <a href="javascript:void(0);" onclick="$('input[name=\'areaid\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));"><%=Tag("全选")%></a>
                        </th>
                        <th>
                            <%=Tag("地区名称")%>
                        </th>
                        <th>
                            <%=Tag("下级地区")%>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <%foreach (DB.LebiShop.Lebi_Area model in models)
                    {%>
                    <tr class="list">
                        <td style="text-align:center">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="checkbox<%=model.id %>" name="areaid" value="<%=model.id %>" class="custom-control-input" ShopKeyID="true">
                                <span class="custom-control-label"></span>
                            </label>
                        </td>
                        <td>
                            <%=model.Name %><input type="hidden" id="areaid_<%=model.id %>" name="areaid_<%=model.id %>" value="<%=model.Name %>">
                        </td>
                        <td>
                            <%
                            if (SonArea(model.id) > 0) {
                            Response.Write("<a href=\"javascript:SelectArea(" + model.id + ",'" + notid + "')\">"+ Tag("查看") +"</a>");
                            }
                            %>
                        </td>
                    </tr>
                    <%} %>
                </tbody>
            </table>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("提交")%></button>
        </div>
    </form>
    <script>
        function SelectAreaOK() {
            $("#EditsubModal").modal("hide");
            var chkArr = $("input[name='areaid']");
            var param = "";
            var temp = "";
            var ids = GetChkCheckedValues("areaid");
            for (var i = 0; i < chkArr.length; i++) {
                if (chkArr[i].checked) {
                    if ($('#areaid_' + chkArr[i].value + '').val() != "") {
                        temp = '<li ondblclick="delitem();" title="<%=Tag("双击删除") %>" class="iName"><input type="hidden" name="Area_ids" id="Area_ids" value="' + chkArr[i].value + '" shop="true" /><span>' + $('#areaid_' + chkArr[i].value + '').val() + '</span></li>';
                        $('#Area_idsList ul').append(temp);
                    }
                }
            }
            $('#Area_idsList ul li').selectedElement({ css: 'on' });
            $("#areadiv").dialog('close');
        }
    </script>

  