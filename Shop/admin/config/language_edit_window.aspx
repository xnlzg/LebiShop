﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.Language_Edit_window" validateRequest="false"%>

<table class="table">
    <tr>
        <th style="width: 20%">
            <%=Tag("名称")%>：
        </th>
        <td>
           <input type="text" id="Name" name="Name" class="input" shop="true" min="notnull" style="width: 200px;" value="<%=model.Name %>" />
        </td>
    </tr>
    <tr>
        <th style="vertical-align:top">
            <%=Tag("图标")%>：
        </th>
        <td>
            <div id="image_ImageUrl">
                <%if (model.ImageUrl != "")
                    {%>
                <img src="<%=site.WebPath + model.ImageUrl%>" />
                <%} %>
            </div>
            <input type="text" shop="true" id="ImageUrl" name="ImageUrl" class="input" style="width: 200px;" value="<%=model.ImageUrl%>" />
            <input id="file_ImageUrl" name="file_ImageUrl" type="file" class="input" onchange="uploadImage('ImageUrl')" />
            
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("币种")%>：
        </th>
        <td>
           <select id="Currency_id" name="Currency_id" shop="true">
            <option value="0"><%=Tag("请选择")%></option>
            <%=Currencylist(model.Currency_id)%>
            </select>
        </td>
    </tr>
    
    <tr>
        <th>
            <%=Tag("使用主题")%>：
        </th>
        <td>
            <select id="Theme_id" name="Theme_id" shop="true">
            <option value="0"><%=Tag("请选择")%></option>
            <%=Themeslist(model.Theme_id)%>
            </select>
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("生成路径")%>：
        </th>
        <td>
            <input type="text" id="Path" name="Path" class="input" shop="true" min="notnull" style="width: 200px;" value="<%=model.Path %>" />
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("是否启用")%>：
        </th>
        <td>
            <input type="radio" name="IsUsed" shop="true" value="1" <%=model.IsUsed==1?"checked":"" %>><%=Tag("是")%>
            <input type="radio" name="IsUsed" shop="true" value="0" <%=model.IsUsed==0?"checked":"" %> /><%=Tag("否")%>
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("是否默认")%>：
        </th>
        <td>
            <input type="radio" name="IsDefault" shop="true" value="1" <%=model.IsDefault==1?"checked":"" %>><%=Tag("是")%>
            <input type="radio" name="IsDefault" shop="true" value="0" <%=model.IsDefault==0?"checked":"" %> /><%=Tag("否")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="action">
            <div class="tools tools-m">
                <ul>
                    <li class="submit"><a href="javascript:void(0);" onclick="SaveObj();"><b></b><span><%=Tag("保存")%></span></a></li>
                </ul>
            </div>
        </td>
    </tr>
</table>
<script type="text/javascript">
    function uploadImage(id) {
        $.ajaxFileUpload
        (
	        {
	            url: WebPath + '/ajax/imageuploadone.aspx?path=config',
	            secureuri: false,
	            fileElementId: 'file_' + id,
	            dataType: 'json',
	            success: function (data, status) {
	                if (data.msg != 'OK') {
	                    MsgBox(2, data.msg, "");
	                }
	                else {
	                    var imageUrl = data.ImageUrl;
	                    if (imageUrl.length > 0) {
	                        $("#image_" + id + "").html('<img height="30" src=' + WebPath + imageUrl + '>');
	                        $("#" + id + "").val(imageUrl);
	                    }
	                }
	            },
	            error: function (data, status, e) {
	                MsgBox(2, data.msg, "");
	            }
	        }
        )
    }
    function SaveObj() {
        var postData = GetFormJsonData("shop");
        if (!CheckForm("shop", "span"))
            return false;
        var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=Language_Edit&id=<%=model.id %>";
        RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
    }
</script>

  