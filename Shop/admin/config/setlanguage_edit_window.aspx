﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.config.SetLanguage_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("设置语言")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Language_ids"><%=Tag("显示语言")%>：</label>
                <div class="input-group">
                    <%= Shop.Bussiness.Language.SiteLanguageCheckbox("Language_ids", "", CurrentLanguage.Code,CurrentAdmin)%>
                </div>
            </div>
            <div class="form-group">
                <label for="DataType_1"><%=Tag("数据来源")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="DataType_1" name="DataType" value="1" class="custom-control-input" shop="true" <%if (ids == ""){%>checked<%}%>>
                        <span class="custom-control-label"><%=Tag("全部")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="DataType_0" name="DataType" value="0" class="custom-control-input" shop="true" <%if (ids != ""){%>checked<%}%>>
                        <span class="custom-control-label"><%=Tag("选择")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="UpdateType_1"><%=Tag("更新类型")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="UpdateType_1" name="UpdateType" value="1" class="custom-control-input" shop="true" checked>
                        <span class="custom-control-label"><%=Tag("追加")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="UpdateType_0" name="UpdateType" value="0" class="custom-control-input" shop="true">
                        <span class="custom-control-label"><%=Tag("覆盖")%></span>
                    </label>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <input type="hidden" name="table" id="table" value="<%=table %>" shop="true" />
            <input type="hidden" name="ids" id="ids" value="<%=ids %>" shop="true" />
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        function SaveObj() {
            var DataType=$("input[name='DataType']:checked").val();
            var ids = $("#ids").val();
            if (DataType == 0){
                if (ids == ""){
                    MsgBox(2, "<%=Tag("没有选择任何数据")%>", "");
                    return;
                }
            }
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=SetLanguage_Update";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  