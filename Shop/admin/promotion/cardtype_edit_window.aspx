﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Config.CardType_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <ul class="nav nav-tabs customtab" role="tablist">
                <%
                List<DB.LebiShop.Lebi_Language_Code> langs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in langs){
                %>
                <li class="nav-item"> <a class="nav-link <%if (langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                <%
                }
                %>
            </ul>
            <div class="tab-content m-t-20">
                <%
                foreach (DB.LebiShop.Lebi_Language_Code lang in langs)
                {%>
                <div class="tab-pane <%if (langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                    <div class="form-group">
                        <label for="Name<%=lang.Code %>"><%=Tag("名称")%>：</label>
                        <input type="text" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name,lang.Code) %>" <%if (langs.FirstOrDefault().Code == lang.Code){%>required<%}%> class="form-control" shop="true">
                    </div>
                </div>
                <%} %>
            </div>
            <h4 class="nav-tips m-t-20 m-b-10"><%=Tag("通用信息")%></h4>
            <div class="form-group">
                <label for="Type_id_CardType"><%=Tag("类型")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Type.TypeRadio("CardType", "Type_id_CardType", model.Type_id_CardType, "shop=\"true\" onclick=\"ChangeType();\"")%>
                </div>
            </div>
            <div class="form-group">
                <label for="Money"><%=Tag("面值")%>：</label>
                <input type="text" id="Money" name="Money" value="<%=model.Money %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <div class="form-group" id="tr_Money_Buy">
                <label for="Money_Buy"><%=Tag("最低消费")%>：</label>
                <input type="text" id="Money_Buy" name="Money_Buy" value="<%=model.Money_Buy %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" required>
            </div>
            <div class="form-group" id="tr_IsCanOtherUse">
                <label for="IsCanOtherUse_0"><%=Tag("单独使用")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsCanOtherUse_0" name="IsCanOtherUse" value="0" class="custom-control-input" shop="true" <%=model.IsCanOtherUse==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsCanOtherUse_1" name="IsCanOtherUse" value="1" class="custom-control-input" shop="true" <%=model.IsCanOtherUse==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group" id="tr_Pro_Type_ids">
                <label for="Pro_Type_ids"><%=Tag("限制分类")%>：</label>
                <div class="input-group">
                    <%=protypes(model.Pro_Type_ids)%>
                </div>
            </div>
            <div class="form-group">
                <label for="NO_Start"><%=Tag("号码段")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="NO_Start" name="NO_Start" value="<%=model.NO_Start %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="NO_End" name="NO_End" value="<%=model.NO_End %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                </div>
            </div>
            <div class="form-group">
                <label for="Time_Begin"><%=Tag("有效期")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Time_Begin" name="Time_Begin" value="<%=FormatDate(model.Time_Begin) %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Time_End" name="Time_End" value="<%=FormatDate(model.Time_End) %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group">
                <label for="Pro_Type_ids"><%=Tag("申请链接")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.ThemeUrl.GetURL("P_UserCardGet",model.id.ToString(),"",CurrentLanguage.Code)%>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        $('#Time_Begin').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_sale.aspx?__Action=CardType_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function ChangeType()
        {
            var t=$("input[name='Type_id_CardType']:checked").val();
            if(t==311)
            {
                $("#tr_Money_Buy").hide();
                $("#tr_IsCanOtherUse").hide();
                $("#tr_Pro_Type_ids").hide();
            }else{
                $("#tr_Money_Buy").show();
                $("#tr_IsCanOtherUse").show();
                $("#tr_Pro_Type_ids").show();
            }
        }
        ChangeType();
    </script>

  