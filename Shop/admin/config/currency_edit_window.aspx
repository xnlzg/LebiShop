﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Config.Currency_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Code"><%=Tag("代码")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Name"><%=Tag("名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="Msige"><%=Tag("货币符号")%>：</label>
                <input type="text" id="Msige" name="Msige" value="<%=model.Msige %>" class="form-control" shop="true" required>
            </div>
            <div class="form-group">
                <label for="ExchangeRate"><%=Tag("汇率")%>：</label>
                <input type="text" id="ExchangeRate" name="ExchangeRate" value="<%=model.ExchangeRate %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <div class="form-group">
                <label for="DecimalLength_0"><%=Tag("小数")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="DecimalLength_0" name="DecimalLength" value="0" class="custom-control-input" shop="true" <%=model.DecimalLength==0?"checked":"" %>>
                        <span class="custom-control-label">0</span>
                    </label>
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="DecimalLength_1" name="DecimalLength" value="1" class="custom-control-input" shop="true" <%=model.DecimalLength==1?"checked":"" %>>
                        <span class="custom-control-label">1</span>
                    </label>
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="DecimalLength_2" name="DecimalLength" value="2" class="custom-control-input" shop="true" <%=model.DecimalLength==2?"checked":"" %>>
                        <span class="custom-control-label">2</span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="DecimalLength_3" name="DecimalLength" value="3" class="custom-control-input" shop="true" <%=model.DecimalLength==3?"checked":"" %>>
                        <span class="custom-control-label">3</span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="IsDefault_1"><%=Tag("是否默认")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsDefault_1" name="IsDefault" value="1" class="custom-control-input" shop="true" <%=model.IsDefault==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsDefault_0" name="IsDefault" value="0" class="custom-control-input" shop="true" <%=model.IsDefault==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Name" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true">
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
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=Currency_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  