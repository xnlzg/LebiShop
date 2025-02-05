﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.agent.areaagent_user_edit_window" validateRequest="false"%>

<table class="table">
    <tr>
        <th style="width: 20%">
            <%=Tag("会员帐号")%>：
        </th>
        <td style="text-align: left;">
            <input type="text" id="User_UserName" name="User_UserName" value="<%=model.User_UserName %>" class="input" shop="true" min="notnull" />
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("地区")%>：
        </th>
        <td>
            <%=Shop.Bussiness.EX_Area.GetAreaName(model.Area_id) %>
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("过期时间")%>：
        </th>
        <td>
            <input type="text" id="Time_end" name="Time_end" value="<%=model.Time_end.ToString("yyyy-MM-dd") %>" class="calendar" shop="true" min="notnull" />
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("状态")%>：
        </th>
        <td>
             <input type="radio" name="IsFailure" value="0" shop="true" <%=model.IsFailure==0?"checked":"" %> /><%=Tag("正常")%>
             <input type="radio" name="IsFailure" value="1" shop="true" <%=model.IsFailure==1?"checked":"" %> /><%=Tag("失效")%>
        </td>
    </tr>
    <tr>
        <th style="vertical-align:top">
            <%=Tag("内部备注")%>：<br>
            <em>≤ <span id="remLen">255</span></em>
        </th>
        <td>
            <textarea name="Remark" id="Remark" shop="true" rows="3" cols="60" class="input" onKeyDown="checkMaxInput(this.form)" onKeyUp="checkMaxInput(this.form)" style="height: 55px;width: 100%;"><%=model.Remark%></textarea>
            <div class="tools clear">
                <ul>
                    <li class="plus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Remark',100);"><b></b><span><%=Tag("展开")%></span></a></li>
                    <li class="minus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('Remark',-100)"><b></b><span><%=Tag("收缩")%></span></a></li>
                </ul>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="action">
        <div class="tools tools-m clear">
            <ul>
                <li class="submit"><a href="javascript:void(0);" onclick="SaveObj();"><b></b><span><%=Tag("保存")%></span></a></li>
            </ul>
        </div>
        </td>
    </tr>
</table>
<script type="text/javascript">
    function SaveObj() {
        var postData = GetFormJsonData("shop");
        if (!CheckForm("shop", "span"))
            return false;
        var Area_id=$("#Area_id").val();
        var PArea_id=$("#Area_id").prev().val();
        var url = "<%=site.AdminPath %>/ajax/ajax_agent.aspx?__Action=AreaAgentUser_Edit&id=<%=model.id %>";
        RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        //RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
    }
</script>

  