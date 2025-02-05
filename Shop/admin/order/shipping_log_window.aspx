﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.shipping_log_window" validateRequest="false"%>

    <form novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("物流跟踪")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <%if (log.message == "ok"){ %>
            <div class="form-group">
                <div class="table-responsive">
                    <table class="table table-hover no-wrap">
                        <thead>
                            <tr class="no-wrap">
                                <th>
                                    <%=Tag("状态")%>：
                                </th>
                                <th>
                                    <%=Shop.Bussiness.EX_Type.TypeName(torder.Type_id_TransportOrderStatus)%>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%foreach (Shop.Model.KuaiDi100.KuaiDi100data d in log.data){ %>
                            <tr>
                                <td><%=d.time%></td>
                                <td><%=d.context%></td>
                            </tr>
                            <%} %>
                        </tbody>
                    </table>
                </div>
            </div>
            <%}else{ %>
            <div class="form-group">
                <label><%=Tag("状态")%>：</label>
                <div class="input-group">
                    <iframe name="kuaidi100" src="<%=torder.HtmlLog %>" width="100%" height="400" marginwidth="0" marginheight="0" frameborder="0"></iframe>
                </div>
            </div>
            <%}%>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
        </div>
    </form>

  