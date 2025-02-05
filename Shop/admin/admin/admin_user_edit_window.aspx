﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.admin.Administrator_Edit_window" validateRequest="false"%>

<table class="table">
    <tr>
        <th style="width: 20%;">
            <%=Tag("登录账号")%>：
        </th>
        <td>
            <input type="text" shop="true" id="UserName" name="UserName" min="notnull"
                class="input" value="<%=model.UserName %>" style="width:200px" />
        </td>
    </tr>
    <tr>
        <th >
            <%=Tag("姓名")%>：
        </th>
        <td>
            <input type="text" shop="true" id="RealName" name="RealName"
                class="input" value="<%=model.RealName %>" style="width:200px" />
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("权限组")%>：
        </th>
        <td>
            <select shop="true" id="Admin_Group_id" name="Admin_Group_id">
            <%foreach (DB.LebiShop.Lebi_Admin_Group group in groups)
              {%>
              <option value="<%=group.id %>" <%=group.id==model.Admin_Group_id?"selected":"" %> ><%=Lang(group.Name) %></option>
            <%} %>
            </select>
        </td>
    </tr>

    <tr>
        <th >
            <%=Tag("状态")%>：
        </th>
        <td>
            <%=Shop.Bussiness.EX_Type.TypeRadio("AdminStatus", "Type_id_AdminStatus", model.Type_id_AdminStatus,"shop=\"true\"")%>
        </td>
    </tr>
    <%if (model.id == 0)
      { %>
    <tr>
        <th >
            <%=Tag("密码")%>：
        </th>
        <td>
            <input type="password" shop="true" min="notnull" id="Password" name="Password"
                class="input" value="" style="width:200px" />
        </td>
    </tr>
    <%} %>
    <tr>
        <th >
            <%=Tag("管理分类")%>：
        </th>
        <td>
            <%=Pro_TypeCheckbox("Pro_Type_ids", model.Pro_Type_ids, CurrentLanguage.Code)%>
        </td>
    </tr>
    <%if (domain3admin)
      { %>
    <tr>
        <th >
            <%=Tag("管理站点")%>：
        </th>
        <td>
            <%=site.SiteCheckbox("Site_ids",model.Site_ids,CurrentLanguage.Code)%>
        </td>
    </tr>
    <%} %>
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
<script>
    function SaveObj() {
        if (!CheckForm("shop", "span"))
            return false;
        var postData = GetFormJsonData("shop");
        var url = "<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=Admin_Edit&id=<%=model.id %>";
        RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
    }
</script>

  