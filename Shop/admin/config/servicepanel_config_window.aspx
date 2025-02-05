﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.ServicePanel_Config_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("客服面板配置")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Theme"><%=Tag("面板风格")%>：</label>
                <select name="Theme" class="form-control" shop="true" onchange="document.images['Theme'].src='../../theme/system/images/CN/ServicePanel/'+options[selectedIndex].value+'_1.gif';">
                    <%int i;for(i=1;i<10;i++){%>
                    <option value="<%=i%>" <%=sp.Theme==""+i+""?"selected":"" %>><%=i%></option>
                    <%}%>
                </select>
                <small><img src="../../theme/system/images/CN/ServicePanel/<%=sp.Theme%>_1.gif" id="Theme"></small>
            </div>
            <div class="form-group">
                <label for="Status_1"><%=Tag("是否显示")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="Status_1" name="Status" value="1" class="custom-control-input" shop="true" <%=sp.Status=="1"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="Status_0" name="Status" value="0" class="custom-control-input" shop="true" <%=sp.Status=="0"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="IsFloat_1"><%=Tag("浮动位置")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsFloat_1" name="IsFloat" value="1" class="custom-control-input" shop="true" <%=sp.IsFloat=="1"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("顶部")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsFloat_0" name="IsFloat" value="0" class="custom-control-input" shop="true" <%=sp.IsFloat=="0"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("底部")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Style_1"><%=Tag("面板样式")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="Style_1" name="Style" value="1" class="custom-control-input" shop="true" <%=sp.Style=="1"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("浮动")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="Style_0" name="Style" value="0" class="custom-control-input" shop="true" <%=sp.Style=="0"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("固定")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="X"><%=Tag("坐标位置")%>：</label>
                <div class="row">
                    <div class="col-sm-6">
                        <label for="X">X：</label>
                        <input type="text" id="X" name="X" value="<%=sp.X%>" class="form-control" shop="true">
                    </div>
                    <div class="col-sm-6">
                        <label for="Y">Y：</label>
                        <input type="text" id="Y" name="Y" value="<%=sp.Y%>" class="form-control" shop="true">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=ServicePanel_Config";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
    </script>

  