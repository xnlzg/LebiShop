﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.inc.product_comment" validateRequest="false"%><%LoadPage();%>

<div class="comments_top">
    <div class="comments_section_1">
        <strong><%=Tag("商品满意度")%><em><%=model.Star_Comment%></em><%=Tag("分")%></strong> <span><%=Tag("共")%>
            <%=model.Count_Comment%>
            <%=Tag("人评分")%></span>
    </div>
    <div class="comments_section_2">
        <h4>
            <%=Tag("商品满意度")%></h4>
        <ul>
            <li><em class="comments_bg stars_s_5"></em><span style="background: #e85864; width: px">
            </span>
                <%=Star5Percent%>%</li>
            <li><em class="comments_bg stars_s_4"></em><span style="background: #e85864; width: px">
            </span>
                <%=Star4Percent%>%</li>
            <li><em class="comments_bg stars_s_3"></em><span style="background: #e85864; width: px">
            </span>
                <%=Star3Percent%>%</li>
            <li><em class="comments_bg stars_s_2"></em><span style="background: #e85864; width: px">
            </span>
                <%=Star2Percent%>%</li>
            <li><em class="comments_bg stars_s_1"></em><span style="background: #e85864; width: px">
            </span>
                <%=Star1Percent%>%</li>
        </ul>
    </div>
    <div class="comments_section_3">
        <h4>
            <strong><%=Tag("该商品怎么样？")%></strong></h4>
        <ul>
            <li><%=Tag("发表评价最高可获得")%><span class="red"><%=SYS.CommentPoint %></span><%=Tag("积分")%></li>
            <%
            DB.LebiShop.Lebi_Order_Product order_product = DB.LebiShop.B_Lebi_Order_Product.GetModel("IsCommented = 0 and User_id=" + CurrentUser.id + " and Product_id = "+ id +" and id in(select id from [Lebi_Order_Product] where Order_id in(select id from [Lebi_Order] where User_id=" + CurrentUser.id + " and IsReceived = 1))");
            if (order_product != null){
            %>
            <li><a href="<%=URL("P_UserCommentWrite",order_product.id) %>" target="_blank" class="btn btn-11"><s></s><%=Tag("发表评价")%></a></li>
            <%
            }
            %>
        </ul>
    </div>
    <div class="clear">
    </div>
</div>
<div class="comments_info">
    <%foreach (DB.LebiShop.Lebi_Comment m in models)
      {%>
    <dl class="comments_list">
        <dd>
            <div class="c_author">
                <h3 class="c_title">
                    <%=m.User_UserName %></h3>
                <span class="c_stars comments_bg stars_m_<%=m.Star %>"></span><span class="c_date">
                    <%=m.Time_Add %></span>
            </div>
            <div class="c_content">
                <div class="c_text">
                    <%=m.Content.Replace("\r\n", "<br/>")%>
                </div>
                <ul class="piclist<%=model.id %>">
                    <%
                        string[] images = m.ImagesSmall.Split('@');
                        string[] bigs = m.Images.Split('@');
                        for (int i = 0; i < images.Count();i++)
                        {
                            if (images[i] == "")
                                continue;
                    %>
                    <li class="imagespreviewlist">
                        <span class="image"><a href="<%=WebPath+bigs[i] %>" data-lightbox="image<%=model.id %>"><img src="<%=WebPath+images[i] %>" /></a></span>
                    </li>
                        <%} %>
                </ul>
            </div>
            <%
                List<DB.LebiShop.Lebi_Comment> modelr = DB.LebiShop.B_Lebi_Comment.GetList("Parentid = " + m.id + "", "id desc", PageSize, pageindex);
                foreach (DB.LebiShop.Lebi_Comment modelreply in modelr)
                {
            %>
            <ul class="c_list c_customer">
                <li><strong>
                    <%=Tag("客服回复")%>：</strong><%=modelreply.Content.Replace("\r\n", "<br/>")%><em><%=modelreply.Time_Add%></em></li></ul>
            <%} %>
            <div class="comments_bg arrow">
            </div>
        </dd>
    </dl>
    <%} %>
</div>
<div class="bottom clearfix"><%=PageString%></div>

  