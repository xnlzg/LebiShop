﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.agent.product_add_window" validateRequest="false"%>

<table class="table">
    <tr>
        <th style="width: 20%">
            <%=Tag("操作")%>：
        </th>
        <td style="text-align: left;">
             <a href="javascript:void(0);" onclick="SearchWindow();"><%=Tag("高级搜索")%></a>
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("搜索结果")%>：
        </th>
        <td>
            <%=sp.Description%>
        </td>
    </tr>
    <tr>
        <th>
            <%=Tag("商品数量")%>：
        </th>
        <td>
            <%=ProductCount%>
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
        var url = "<%=site.AdminPath %>/ajax/ajax_agent.aspx?__Action=Product_Add&<%=sp.URL %>";
        RequestAjax(url,'',function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
    }
    function SearchWindow() {
            var title_ = "<%=Tag("商品查询")%>";
            var url_ = "<%=site.AdminPath %>/product/product_search_window.aspx?callback=Product_Add&<%=sp.URL %>";
            var width_ = 700;
            var height_ = 505;
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_,'prodiv');
        }
</script>

  