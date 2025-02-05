﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.promotion.card_search" validateRequest="false"%>

    <form action="javascript:SearchCard();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("卡券查询")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="UserName"><%=Tag("会员帐号")%>：</label>
                <input type="text" id="UserName" name="UserName" value="<%=model.UserName %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="Code"><%=Tag("编号")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="IndexCode"><%=Tag("头字符")%>：</label>
                <input type="text" id="IndexCode" name="IndexCode" value="<%=model.IndexCode %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="Money"><%=Tag("面值")%>：</label>
                <input type="text" id="Money" name="Money" value="<%=model.Money %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="number1"><%=Tag("号码")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="number1" name="number1" value="<%=model.number1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="number2" name="number2" value="<%=model.number2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                </div>
            </div>
            <div class="form-group">
                <label for="Time_begin1"><%=Tag("生效时间")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Time_begin1" name="Time_begin1" value="<%=model.Time_begin1 %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Time_begin2" name="Time_begin2" value="<%=model.Time_begin2 %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group">
                <label for="Time_end1"><%=Tag("失效时间")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Time_end1" name="Time_end1" value="<%=model.Time_end1 %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Time_end2" name="Time_end2" value="<%=model.Time_end2 %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group">
                <label for="type"><%=Tag("类型")%>：</label>
                <div class="input-group">
                    <%int ct = 0;
                    int.TryParse(model.Type_id_CardType,out ct);
                    %>
                    <%=Shop.Bussiness.EX_Type.TypeRadio("CardType", "type", ct, "shop=\"true\"", CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Type_id_CardStatus"><%=Tag("状态")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Type.TypeCheckbox("CardStatus", "Type_id_CardStatus", model.Type_id_CardStatus, "shop=\"true\"", CurrentLanguage.Code)%>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-search"></i> <%=Tag("搜索")%></button>
        </div>
    </form>
    <script>
        $('#Time_begin1').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });        $('#Time_begin2').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
        $('#Time_end1').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });        $('#Time_end2').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
        function SearchCard()
        {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_search.aspx?__Action=CardSearch";
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: 'json',
                success: function (res) {
                    <%=callback %>(res.url);
                }
            });
        }
    </script>

  