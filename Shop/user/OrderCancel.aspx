﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.P_UserOrderCancel" validateRequest="false"%>


<%@ Import Namespace="Shop.Bussiness" %>
<%@ Import Namespace="Shop.Model" %>
<%@ Import Namespace="DB.LebiShop" %>
<%@ Import Namespace="System.Collections.Generic" %>
<% LoadPage("wangdayu523@163.com_37",1,"CN","P_UserOrderCancel"); %>


    

<div class="window">
    <div class="dl-table clearfix">
    <dl>
        <dt>取消原因：</dt>
        <dd><select id="Content" name="Content" onchange="SelectOption();" shop="true">
        <option value="option1">现在不想购买</option> 
        <option value="option2">商品价格较贵</option> 
        <option value="option3">价格波动</option> 
        <option value="option4">商品缺货</option> 
        <option value="option5">重复下单</option> 
        <option value="option6">添加或删除商品</option> 
        <option value="option7">收货人信息有误</option> 
        <option value="option8">发票信息有误</option> 
        <option value="option9">无法支付订单</option> 
        <option value="option10">其他原因</option> 
        </select></dd>
    </dl>
    <dl id="DIVRemark" style="display:none">
        <dt>补充说明：</dt>
        <dd><textarea class="textarea" style="width: 100%; height: 50px;" id="Remark" name="Remark" min="notnull" shop="true">现在不想购买</textarea>
        <span id="Formsay"></span></dd>
    </dl>
    <dl class="dl-btn">
        <dt></dt>
        <dd><a href="javascript:void(0)" onclick="submit();" class="btn btn-12"><s></s>提交</a></dd>
    </dl>
    </div>
</div>
<script type="text/javascript" >
    function SelectOption() {
        var Content = $("#Content").val();
        if (Content == "option10") {
            $("#DIVRemark").show();
            $("#Remark").html("");
        } else {
            $("#DIVRemark").hide();
            switch (Content) {
                case "option1":
                    $("#Remark").html("现在不想购买");
                    break;
                case "option2":
                    $("#Remark").html("商品价格较贵");
                    break;
                case "option3":
                    $("#Remark").html("价格波动");
                    break;
                case "option4":
                    $("#Remark").html("商品缺货");
                    break;
                case "option5":
                    $("#Remark").html("重复下单");
                    break;
                case "option6":
                    $("#Remark").html("添加或删除商品");
                    break;
                case "option7":
                    $("#Remark").html("收货人信息有误");
                    break;
                case "option8":
                    $("#Remark").html("发票信息有误");
                    break;
                case "option9":
                    $("#Remark").html("无法支付订单");
                    break;
            }
        }
    }
    function submit() {
        if (!CheckForm("shop", "span"))
            return false;
        var postData = GetFormJsonData("shop");
        var url = path + "/ajax/Ajax_order.aspx?__Action=OrderCancal&id=<%=order.id %>";
        RequestAjax(url, postData, function () { MsgBox(1, "操作成功", "?") });
    }
</script>

<div style="width:100%;text-align:center;font-size:12px;color:#999">Powered by <a style="font-size:12px;color:#00497f" href="http://www.lebi.cn/support/license/?url=" target="_blank" title="LebiShop多语言网店系统">LebiShop</a> V<%=SYS.Version%>.<%=SYS.Version_Son%></div>