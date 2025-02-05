﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.CnzzConfig" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("CNZZ统计配置")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="r1_1"><%=Tag("状态")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="r1_1" name="r1" value="1" class="custom-control-input" shop="true" <%=model.state==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("开启")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="r1_0" name="r1" value="0" class="custom-control-input" shop="true" <%=model.state==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("关闭")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="r2_1"><%=Tag("重新开通")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="r2_1" name="r2" value="1" class="custom-control-input" shop="true">
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="r2_0" name="r2" value="0" class="custom-control-input" shop="true" checked>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script type="text/javascript">
    function SaveObj() {
        $("#EditModal").modal("hide");
        var postData = GetFormJsonData("shop");
        var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=CnzzConfig_Edit";
        RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "");$("#divid").dialog("close");});
    }
    </script>

  