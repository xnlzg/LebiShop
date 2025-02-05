﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Bill_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("发票管理")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for=""><%=Tag("订单号")%>：</label>
                <%=model.Order_Code%>
            </div>
            <div class="form-group">
                <label for=""><%=Tag("会员")%>：</label>
                <%=model.User_UserName %>&nbsp;（<%=Tag("真实姓名")%>：<%=GetUser(model.User_id).RealName %>）
            </div>
            <div class="form-group">
                <label for="BillType_id"><%=Tag("类型")%>：</label>
                <select id="BillType_id" name="BillType_id" class="form-control" shop="true" onchange="changebilltype()">
                    <%=billlist(model.BillType_id)%>
                </select>
            </div>
            <div class="form-group">
                <label for="Money"><%=Tag("金额")%>：</label>
                <input type="text" id="Money" name="Money" value="<%=FormatMoney(model.Money," Number") %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
            </div>
            <div class="form-group">
                <label for="BillNo"><%=Tag("发票号码")%>：</label>
                <input type="text" id="BillNo" name="BillNo" value="<%=model.BillNo %>" class="form-control" shop="true">
            </div>
            <div class="form-group" id="t151" style="display:none;">
                <label for="Title"><%=Tag("抬头")%>：</label>
                <input type="text" id="Title" name="Title" value="<%=model.Title %>" class="form-control" shop="true">
            </div>
            <div id="t152" style="display:none;">
                <div class="form-group">
                    <label for="Company_Name"><%=Tag("单位名称")%>：</label>
                    <input type="text" id="Company_Name" name="Company_Name" value="<%=model.Company_Name %>" class="form-control" shop="true">
                </div>
                <div class="form-group">
                    <label for="Company_Code"><%=Tag("纳税人识别号")%>：</label>
                    <input type="text" id="Company_Code" name="Company_Code" value="<%=model.Company_Code %>" class="form-control" shop="true">
                </div>
                <div class="form-group">
                    <label for="Company_Address"><%=Tag("注册地址")%>：</label>
                    <input type="text" id="Company_Address" name="Company_Address" value="<%=model.Company_Address %>" class="form-control" shop="true">
                </div>
                <div class="form-group">
                    <label for="Company_Phone"><%=Tag("注册电话")%>：</label>
                    <input type="text" id="Company_Phone" name="Company_Phone" value="<%=model.Company_Phone %>" class="form-control" shop="true">
                </div>
                <div class="form-group">
                    <label for="Company_Bank"><%=Tag("开户银行")%>：</label>
                    <input type="text" id="Company_Bank" name="Company_Bank" value="<%=model.Company_Bank %>" class="form-control" shop="true">
                </div>
                <div class="form-group">
                    <label for="Company_Bank_User"><%=Tag("银行帐户")%>：</label>
                    <input type="text" id="Company_Bank_User" name="Company_Bank_User" value="<%=model.Company_Bank_User %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group kai" style="display:none;">
                <label for="Content"><%=Tag("内容")%>：</label>
                <input type="text" id="Content" name="Content" value="<%=model.Content %>" class="form-control" shop="true">
            </div>
            <div class="form-group kai" style="display:none;">
                <label for="Type_id_BillStatus"><%=Tag("状态")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Type.TypeRadio("BillStatus", "Type_id_BillStatus", model.Type_id_BillStatus, "shop=\"true\"")%>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
            <input type="hidden" shop="true" id="Order_id" name="Order_id" class="input" value="<%=model.Order_id %>" />
            <input type="hidden" shop="true" id="Order_Code" name="Order_Code" class="input" value="<%=model.Order_Code %>" />
            <input type="hidden" shop="true" id="User_id" name="User_id" class="input" value="<%=model.User_id %>" />
            <input type="hidden" shop="true" id="User_UserName" name="User_UserName" class="input" value="<%=model.User_UserName %>" />
        </div>
    </form>
    <script>
        ! function (window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_order.aspx?__Action=Bill_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function changebilltype()
        {
            var code=$('#BillType_id option:selected').attr('code');
            if(code=='151'){
                $('#t151').show();
                $('#t152').hide();
                $('.kai').each(function(){
                    $(this).show();
                });
            }
            else if(code=='152'){
                $('#t151').hide();
                $('#t152').show();
                $('.kai').each(function(){
                    $(this).show();
                });
            }else{
                $('.kai').each(function(){
                    $(this).hide();
                });
                $('#t151').hide();
                $('#t152').hide();
            }
        }
        changebilltype();
    </script>

  