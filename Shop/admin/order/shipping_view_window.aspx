﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.shipping_view_window" validateRequest="false"%>

    <form action="javascript:Shipping();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("运输单据")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <div class="table-responsive">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr class="no-wrap">
                                <th>
                                    <%=Tag("商品名称")%>
                                </th>
                                <th style="width: 15%">
                                    <%=Tag("发货数量")%>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%foreach (Shop.Model.TransportProduct tp in tps){ %>
                            <tr>
                                <td>
                                    <img src="<%=Image(tp.ImageOriginal,50,50)%>" style="width: 30px" />
                                    <%=Shop.Bussiness.Language.Content(tp.Product_Name, CurrentLanguage)%>
                                </td>
                                <td>
                                    <%=tp.Count%>
                                </td>
                            </tr>
                            <%} %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="form-group">
                <label for="Transport_id"><%=Tag("配送方式")%>：</label>
                <select id="Transport_id" name="Transport_id" class="form-control" Shipping="true">
                    <%=Shop.Bussiness.EX_Area.TransportOption(torder.Transport_id) %>
                </select>
                <small><%=model.Transport_Mark %></small>
            </div>
            <div class="form-group">
                <label for="Code"><%=Tag("货运单号")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=torder.Code %>" class="form-control" Shipping="true" required>
            </div>
            <div class="form-group">
                <label><%=Tag("收货人")%>：</label>
                <%=torder.T_Name %>
            </div>
            <div class="form-group">
                <label><%=Tag("电话")%>：</label>
                <%=torder.T_Phone %>
            </div>
            <div class="form-group">
                <label><%=Tag("手机")%>：</label>
                <%=torder.T_MobilePhone %>
            </div>
            <div class="form-group">
                <label><%=Tag("Email")%>：</label>
                <%=torder.T_Email %>
            </div>
            <div class="form-group">
                <label><%=Tag("地址")%>：</label>
                <%=torder.T_Address %>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        ! function (window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function Shipping() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("Shipping");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Order_Shipping_Edit&id=<%=model.id %>&tid=<%=torder.id %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "") });
        }
    </script>

  