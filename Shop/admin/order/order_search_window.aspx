﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.order_search_widow" validateRequest="false"%>

    <form action="javascript:SearchOrder();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("订单查询")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Code"><%=Tag("订单号码")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchOrder();}">
            </div>
            <div class="form-group">
                <label for="UserName"><%=Tag("会员帐号")%>：</label>
                <input type="text" id="UserName" name="UserName" value="<%=model.UserName %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchOrder();}">
            </div>
            <div class="form-group">
                <label for="T_Name"><%=Tag("收货人")%>：</label>
                <input type="text" id="T_Name" name="T_Name" value="<%=model.T_Name %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchOrder();}">
            </div>
            <div class="form-group">
                <label for="T_Address"><%=Tag("收货地址")%>：</label>
                <input type="text" id="T_Address" name="T_Address" value="<%=model.T_Address %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchOrder();}">
            </div>
            <div class="form-group">
                <label for="T_MobilePhone"><%=Tag("收货电话")%>：</label>
                <input type="text" id="T_MobilePhone" name="T_MobilePhone" value="<%=model.T_MobilePhone %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchOrder();}">
            </div>
            <div class="form-group">
                <label for="T_Email"><%=Tag("收货EMAIL")%>：</label>
                <input type="text" id="T_Email" name="T_Email" value="<%=model.T_Email %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchOrder();}">
            </div>
            <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
            <div class="form-group">
                <label for="Supplier_id"><%=Tag("商家")%>：</label>
                <select id="Supplier_id" name="Supplier_id" class="form-control" shop="true">
                    <option value="0">
                        <%=Tag("全部")%>
                    </option>
                    <%=Shop.Bussiness.EX_Supplier.SupplierOption(model.Supplier_id, CurrentLanguage.Code)%>
                </select>
            </div>
            <div class="form-group">
                <label for="IsSupplierCash_1"><%=Tag("商家收款")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-checkbox m-r-20">
                        <input type="checkbox" id="IsSupplierCash_1" name="IsSupplierCash" value="1" class="custom-control-input" shop="true" <%=model.IsSupplierCash.Contains("1")?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="checkbox" id="IsSupplierCash_0" name="IsSupplierCash" value="0" class="custom-control-input" shop="true" <%=model.IsSupplierCash.Contains("0")?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <%} %>
            <div class="form-group">
                <label for="Time_Add1"><%=Tag("下单时间")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Time_Add1" name="Time_Add1" value="<%=model.Time_Add1 %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Time_Add2" name="Time_Add2" value="<%=model.Time_Add2 %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group">
                <label for="Money_Order1"><%=Tag("金额")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Money_Order1" name="Money_Order1" value="<%=model.Money_Order1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Money_Order2" name="Money_Order2" value="<%=model.Money_Order2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="IsVerified_1"><%=Tag("已确认")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="IsVerified_1" name="IsVerified" value="1" class="custom-control-input" shop="true" <%=model.IsVerified.Contains("1")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="IsVerified_0" name="IsVerified" value="0" class="custom-control-input" shop="true" <%=model.IsVerified.Contains("0")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
               </div>
               <div class="col-sm-6">
                    <div class="form-group">
                        <label for="IsPaid_1"><%=Tag("已付款")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="IsPaid_1" name="IsPaid" value="1" class="custom-control-input" shop="true" <%=model.IsPaid.Contains("1")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="IsPaid_0" name="IsPaid" value="0" class="custom-control-input" shop="true" <%=model.IsPaid.Contains("0")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
               </div>
               <div class="col-sm-6">
                    <div class="form-group">
                        <label for="IsShipped_1"><%=Tag("已发货")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="IsShipped_1" name="IsShipped" value="1" class="custom-control-input" shop="true" <%=model.IsShipped.Contains("1")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="IsShipped_0" name="IsShipped" value="0" class="custom-control-input" shop="true" <%=model.IsShipped.Contains("0")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="IsShipped_All_1"><%=Tag("已全部发货")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="IsShipped_All_1" name="IsShipped_All" value="1" class="custom-control-input" shop="true" <%=model.IsShipped_All.Contains("1")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="IsShipped_All_0" name="IsShipped_All" value="0" class="custom-control-input" shop="true" <%=model.IsShipped_All.Contains("0")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
               </div>
               <div class="col-sm-6">
                    <div class="form-group">
                        <label for="IsReceived_1"><%=Tag("已收货")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="IsReceived_1" name="IsReceived" value="1" class="custom-control-input" shop="true" <%=model.IsReceived.Contains("1")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="IsReceived_0" name="IsReceived" value="0" class="custom-control-input" shop="true" <%=model.IsReceived.Contains("0")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
               </div>
               <div class="col-sm-6">
                    <div class="form-group">
                        <label for="IsReceived_All_1"><%=Tag("已全部收货")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="IsReceived_All_1" name="IsReceived_All" value="1" class="custom-control-input" shop="true" <%=model.IsReceived_All.Contains("1")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="IsReceived_All_0" name="IsReceived_All" value="0" class="custom-control-input" shop="true" <%=model.IsReceived_All.Contains("0")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="IsCompleted_1"><%=Tag("已完结")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="IsCompleted_1" name="IsCompleted" value="1" class="custom-control-input" shop="true" <%=model.IsCompleted.Contains("1")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="IsCompleted_0" name="IsCompleted" value="0" class="custom-control-input" shop="true" <%=model.IsCompleted.Contains("0")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
               </div>
               <div class="col-sm-6">
                    <div class="form-group">
                        <label for="IsInvalid_1"><%=Tag("无效")%>：</label>
                        <div class="input-group">
                            <label class="custom-control custom-checkbox m-r-20">
                                <input type="checkbox" id="IsInvalid_1" name="IsInvalid" value="1" class="custom-control-input" shop="true" <%=model.IsInvalid.Contains("1")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("是")%></span>
                            </label>
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="IsInvalid_0" name="IsInvalid" value="0" class="custom-control-input" shop="true" <%=model.IsInvalid.Contains("0")?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("否")%></span>
                            </label>
                        </div>
                    </div>
               </div>
           </div>
            <div class="form-group">
                <label for="Product_Number"><%=Tag("商品编号")%>：</label>
                <input type="text" id="Product_Number" name="Product_Number" value="<%=model.Product_Number %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchOrder();}">
            </div>
            <div class="form-group">
                <label for="Remark_User"><%=Tag("用户留言")%>：</label>
                <input type="text" id="Remark_User" name="Remark_User" value="<%=model.Remark_User %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchOrder();}">
            </div>
            <div class="form-group">
                <label for="Remark_Admin"><%=Tag("客服备注")%>：</label>
                <input type="text" id="Remark_Admin" name="Remark_Admin" value="<%=model.Remark_Admin %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchOrder();}">
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-search"></i> <%=Tag("搜索")%></button>
            <input name="Product_id" value="<%=model.Product_id %>" shop="true" type="hidden" class="input" />
        </div>
    </form>
    <script>
        $('#Time_Add1').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: { format: 'YYYY-MM-DD' }
        });        $('#Time_Add2').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: { format: 'YYYY-MM-DD' }
        });
        function SearchOrder() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_search.aspx?__Action=OrderSearch";
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: 'json',
                success: function (res) {
                    <%=callback %> (res.url);
                }
            });
        }
    </script>

  