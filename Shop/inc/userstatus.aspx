﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.inc.userstatus" validateRequest="false"%><%LoadPage();%>

<%if (CurrentUser.id > 0 && CurrentUser.IsAnonymous==0)
  {%>
<a href="<%=URL("P_UserCenter","") %>" title="<%=Tag("会员中心")%>">
    <span class="username"><%if (CurrentUser.Face.Trim() != "")
  { %>
  <img src="<%=CurrentUser.Face %>" height="20"  />
<%} %><%if (CurrentUser.NickName != "") { Response.Write(CurrentUser.NickName); } else { Response.Write(CurrentUser.UserName); } %></span></a><a href="<%=URL("P_UserMessage","0")%>" title="<%=Tag("收件箱")%>"><span>(<%=Count_Message(0) %>)</span></a> ┊ <a href="<%=URL("P_UserAsk","")%>"><%=Tag("商品咨询")%><span>(<%=Count_ProductAsk(0) %>)</span></a> ┊ <a href="javascript:LoginOut();"><%=Tag("退出登录")%></a>
<%}
  else
  { %>
<a href="<%=URL("P_Register", "") %>"><%=Tag("免费注册")%></a> ┊ <a href="<%=URL("P_Login", "") %>"><%=Tag("登录")%></a>
<%} %>

  