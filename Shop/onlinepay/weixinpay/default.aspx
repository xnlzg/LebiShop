<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="default.aspx.cs" Inherits="weixinpay._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>΢��֧��</title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<%--    <script language="javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>--%>
    <script language="javascript" src="http://res.mail.qq.com/mmr/static/lib/js/jquery.js" type="text/javascript"></script>
    <script language="javascript" src="http://res.mail.qq.com/mmr/static/lib/js/lazyloadv3.js" type="text/javascript"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1" />
    <link rel="stylesheet" type="text/css" href="/Theme/system/wap/css/system.css" />
    <script language="javascript" type="text/javascript">
        // ��΢���������������ڲ���ʼ����ᴥ��WeixinJSBridgeReady�¼���
        //        document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {

        function onBridgeReady(){
            WeixinJSBridge.invoke(
                'getBrandWCPayRequest', {
                    "appId": "<%= appId %>", //���ں����ƣ����̻�����
                    "timeStamp": "<%= timeStamp %>", //ʱ���
                    "nonceStr": "<%= nonceStr %>", //�����
                    "package": "<%= packageValue %>", //��չ��
                    "signType": "MD5", //΢��ǩ����ʽ:1.sha1
                    "paySign": "<%= paySign %>" //΢��ǩ��  
                },
                function(res){     
                    if (res.err_msg == "get_brand_wcpay_request:ok") {
                        //alert("΢��֧���ɹ�!");
                        $('#getBrandWCPayRequest').hide();
                        window.location = "<%=returnurl %>";
                    } else if (res.err_msg == "get_brand_wcpay_request:cancel") {
                        alert("�û�ȡ��֧��!");
                    } else {
                        alert(res.err_msg);
                        alert("֧��ʧ��!");
                    }
                }
            ); 
        }
        if (typeof WeixinJSBridge == "undefined"){
            if( document.addEventListener ){
                document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
            }else if (document.attachEvent){
                document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
                document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
            }
        }else{
            onBridgeReady();
        } 
    </script>
    <style>
        .title{background-color: #f7f7f7;height:30px;padding-left:10px;line-height:30px;} 
        .title h2{font-size: 14px;}
        .des{width:100px;height:30px;line-height:30px;padding-left:10px;}
        .con{text-align:left;}
        #getBrandWCPayRequest {display:none}
    </style>
</head>
<body>
    <div class="WCPay">
         <div style="width:98%; margin: 5px auto 0 auto;">
            <table style="width:100%;">
                <tr>
                    <td colspan="2" class="title"><h2><%=shopname%></h2></td>
                </tr>
                <tr>
                    <td class="des">������ţ�</td>
                    <td class="con"><%=order.Code%></td>
                </tr>
                <tr>
                    <td class="des">������</td>
                    <td class="con"><%=order.Currency_Msige %> <%=order.Money_Order %></td>
                </tr>
                <tr>
                    <td class="des">֧����</td>
                    <td class="con"><%=order.Currency_Msige %> <%=order.Money_Pay %></td>
                </tr>


            </table>
            <%if (order.IsPaid == 0)
              { %>
            <button id="getBrandWCPayRequest" style="width:100%;height:35px;margin-top:40px;border:1px;background-color: #FFD777;">��������</button>
            <%} %>
        </div>
    </div>
</body>
</html>
