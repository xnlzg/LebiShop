﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.order.Order_QuickPay_window" validateRequest="false"%>

<table class="table">
    <tr>
        <td>
            <textarea id="quickpayurl" shop="true" name="quickpayurl" class="textarea" style="height: 60px;width: 100%;"><%=QuickPayURL%></textarea>
            <div class="tools clear">
                <ul>
                    <li class="plus"><a href="javascript:void(0);" onclick="javascript: resizeEditor('quickpayurl', 100);"><b></b><span><%=Tag("展开")%></span></a></li>
                    <li class="minus"><a href="javascript:void(0);" onclick="javascript: resizeEditor('quickpayurl', -100)"><b></b><span><%=Tag("收缩")%></span></a></li>
                </ul>
            </div>
        </td>
    </tr>
</table>

  