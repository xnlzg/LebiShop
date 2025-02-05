﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.OnLinePay_Edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <ul class="nav nav-tabs customtab" role="tablist">
                <%
                List
                <DB.LebiShop.Lebi_Language_Code>
                    langs = Shop.Bussiness.Language.Languages();foreach (DB.LebiShop.Lebi_Language_Code lang in langs){
                    %>
                    <li class="nav-item"> <a class="nav-link <%if (langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" data-toggle="tab" href="#lang_<%=lang.Code %>" role="tab" aria-selected="true"><%=lang.Name %></a> </li>
                    <%
                    }
                    %>
            </ul>
            <div class="tab-content m-t-20">
                <%
                foreach (DB.LebiShop.Lebi_Language_Code lang in langs)
                {%>
                <div class="tab-pane <%if (langs.FirstOrDefault().Code == lang.Code){%>active show<%}%>" id="lang_<%=lang.Code %>" role="tabpanel">
                    <div class="form-group">
                        <label for="Name<%=lang.Code %>"><%=Tag("名称")%>：</label>
                        <input type="text" id="Name<%=lang.Code %>" name="Name<%=lang.Code %>" value="<%=Shop.Bussiness.Language.Content(model.Name,lang.Code) %>" <%if (langs.FirstOrDefault().Code == lang.Code){%>required<%}%> class="form-control" shop="true">
                    </div>
                    <div class="form-group">
                        <label for="Description<%=lang.Code %>"><%=Tag("描述")%>：</label>
                        <textarea id="Description<%=lang.Code %>" name="Description<%=lang.Code %>" class="form-control" style="height: 60px;" shop="true"><%=Shop.Bussiness.Language.Content(model.Description,lang.Code) %></textarea>
                        <div class="button-group m-t-5">
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description<%=lang.Code %>',100);"><%=Tag("展开")%></button>
                            <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Description<%=lang.Code %>',-100);"><%=Tag("收缩")%></button>
                        </div>
                    </div>
                </div>
                <%} %>
            </div>
            <h4 class="nav-tips m-t-20 m-b-10"><%=Tag("通用信息")%></h4>
            <div class="form-group">
                <label for="TypeName"><%=Tag("接口类型")%>：</label>
                <select name="TypeName" id="TypeName" autocomplete="off" class="form-control" shop="true" onChange="ChangeType();">
                    <option value="Paypal" <%=model.TypeName == "Paypal"?"selected":""%>>Paypal</option>
                    <option value="财付通即时到帐接口" <%=model.TypeName == "财付通即时到帐接口"?"selected":""%>>财付通即时到帐接口</option>
                    <option value="支付宝即时到帐" <%=model.TypeName == "支付宝即时到帐"?"selected":""%>>支付宝即时到帐</option>
                    <option value="支付宝担保交易" <%=model.TypeName == "支付宝担保交易"?"selected":""%>>支付宝担保交易</option>
                    <option value="支付宝双接口" <%=model.TypeName == "支付宝双接口"?"selected":""%>>支付宝双接口</option>
                    <option value="支付宝海外支付" <%=model.TypeName == "支付宝海外支付"?"selected":""%>>支付宝海外支付</option>
                    <option value="支付宝手机支付" <%=model.TypeName == "支付宝手机支付"?"selected":""%>>支付宝手机支付</option>
                    <option value="支付宝批量付款" <%=model.TypeName == "支付宝批量付款"?"selected":""%>>支付宝批量付款</option>
                    <option value="网银在线" <%=model.TypeName == "网银在线"?"selected":""%>>网银在线</option>
                    <option value="95epay" <%=model.TypeName == "95epay"?"selected":""%>>95epay</option>
                    <option value="快钱" <%=model.TypeName == "快钱"?"selected":""%>>快钱</option>
                    <option value="微信支付" <%=model.TypeName == "微信支付"?"selected":""%>>微信支付</option>
                    <option value="微信支付H5" <%=model.TypeName == "微信支付H5"?"selected":""%>>微信支付H5</option>
                    <option value="Molpay" <%=model.TypeName == "Molpay"?"selected":""%>>Molpay</option>
                    <option value="智付" <%=model.TypeName == "智付"?"selected":""%>>智付</option>
                    <option value="钱海支付" <%=model.TypeName == "钱海支付"?"selected":""%>>钱海支付</option>
                    <option value="银联全民付" <%=model.TypeName == "银联全民付"?"selected":""%>>银联全民付</option>
                    <option value="汇付宝" <%=model.TypeName == "汇付宝"?"selected":""%>>汇付宝</option>
                    <option value="behpardakht" <%=model.TypeName == "behpardakht"?"selected":""%>>Behpardakht</option>
                    <option value="authroize" <%=model.TypeName == "authroize"?"selected":""%>>Authroize</option>
                    <option value="INIpayWeb" <%=model.TypeName == "INIpayWeb"?"selected":""%>>INIpayWeb</option>
                    <option value="INIpayWap" <%=model.TypeName == "INIpayWap"?"selected":""%>>INIpayWap</option>
                    <option value="conekta" <%=model.TypeName == "conekta"?"selected":""%>>Conekta</option>
                    <option value="tonglianPay" <%=model.TypeName == "tonglianPay"?"selected":""%>>通联支付</option>
                </select>
            </div>
            <div class="form-group">
                <label for="parentid"><%=Tag("上级")%>：</label>
                <select name="parentid" id="parentid" autocomplete="off" class="form-control" shop="true">
                    <option value="0">顶级</option>
                    <%foreach(DB.LebiShop.Lebi_OnlinePay p in models){%>
                    <option value="<%=p.id%>" <%=p.id == model.parentid?"selected":""%>><%=Shop.Bussiness.Language.Content(p.Name, CurrentLanguage.Code)%></option>
                    <%}%>
                </select>
            </div>
            <div class="form-group">
                <label for="Code"><%=Tag("接口代码")%>：</label>
                <input type="text" id="Code" name="Code" value="<%=model.Code %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Logo"><%=Tag("图片Logo")%>：</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="image_Logo"><%if (model.Logo != ""){%><img src="<%=site.WebPath + model.Logo%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                    </div>
                    <input type="text" id="Logo" name="Logo" value="<%=model.Logo %>" class="form-control" shop="true">
                    <div class="input-group-append fileupload">
                        <span class="input-group-text"><i class="ti-upload"></i></span>
                        <input type="file" id="file_Logo" name="file_Logo" class="upload" onchange="uploadImage('Logo')">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="UserName"><%=username%>：</label>
                <input type="text" id="UserName" name="UserName" value="<%=model.UserName %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="UserKey"><%=key%>：</label>
                <input type="text" id="UserKey" name="UserKey" value="<%=model.UserKey %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Email"><%=email%>：</label>
                <input type="text" id="Email" name="Email" value="<%=model.Email %>" class="form-control" shop="true">
            </div>
            <div class="form-group" id="tr_appid">
                <label for="Appid"><%=Tag("Appid")%>：</label>
                <input type="text" id="Appid" name="Appid" value="<%=model.Appid %>" class="form-control" shop="true">
            </div>
            <div class="form-group" id="tr_terminal">
                <label for="terminal"><%=Tag("终端号")%>：</label>
                <input type="text" id="terminal" name="terminal" value="<%=model.terminal %>" class="form-control" shop="true">
            </div>
            <div class="form-group" id="tr_userrealname">
                <label for="UserRealName"><%=Tag("真实姓名")%>：</label>
                <input type="text" id="UserRealName" name="UserRealName" value="<%=model.UserRealName %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Url"><%=Tag("提交URL")%>：</label>
                <input type="text" id="Url" name="Url" value="<%=model.Url %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="FeeRate"><%=Tag("手续费")%>：</label>
                <div class="input-group">
                    <input type="text" id="FeeRate" name="FeeRate" value="<%=model.FeeRate %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'');">
                    <div class="input-group-append">
                        <span class="input-group-text">
                            <label class="custom-control custom-checkbox">
                                <input type="checkbox" id="FreeFeeRate_1" name="FreeFeeRate" value="1" class="custom-control-input" shop="true" <%=model.FreeFeeRate==1?"checked":"" %>>
                                <span class="custom-control-label"><%=Tag("免手续费")%></span>
                            </label>
                        </span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="IsUsed_1"><%=Tag("是否启用")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="IsUsed_1" name="IsUsed" value="1" class="custom-control-input" shop="true" <%=model.IsUsed==1?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="IsUsed_0" name="IsUsed" value="0" class="custom-control-input" shop="true" <%=model.IsUsed==0?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="showtype_web"><%=Tag("启用类型")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="showtype_web" name="showtype" value="web" class="custom-control-input" shop="true" <%=model.showtype.Contains("web")?"checked":"" %>>
                        <span class="custom-control-label">Web</span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="showtype_wap" name="showtype" value="wap" class="custom-control-input" shop="true" <%=model.showtype.Contains("wap")?"checked":"" %>>
                        <span class="custom-control-label">Wap</span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Currency_id"><%=Tag("货币")%>：</label>
                <select id="Currency_id" name="Currency_id" class="form-control" shop="true">
                    <%=Currency(model.Currency_id)%>
                </select>
            </div>
            <div class="form-group">
                <label for="Supplier_id"><%=Tag("供应商")%>：</label>
                <select id="Supplier_id" name="Supplier_id" class="form-control" shop="true">
                    <option value="0"><%=Tag("商城") %></option>
                    <%=Shop.Bussiness.EX_Supplier.SupplierOption(model.Supplier_id, CurrentLanguage.Code)%>
                </select>
            </div>
            <div class="form-group">
                <label for="Language_ids"><%=Tag("语言")%>：</label>
                <div class="form-control-label">
                    <%= Shop.Bussiness.Language.SiteLanguageCheckbox("Language_ids", model.Language_ids,CurrentLanguage.Code,CurrentAdmin)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Sort"><%=Tag("排序序号")%>：</label>
                <input type="text" id="Sort" name="Sort" value="<%=model.Sort %>" class="form-control" shop="true">
            </div>
            <div class="form-group">
                <label for="Remark"><%=Tag("内部备注")%>：</label>
                <textarea id="Remark" name="Remark" class="form-control" style="height: 60px;" shop="true"><%=model.Remark %></textarea>
                <div class="button-group m-t-5">
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',100);"><%=Tag("展开")%></button>
                    <button type="button" class="btn btn-default btn-xs btn-sm" onclick="javascript:resizeEditor('Remark',-100);"><%=Tag("收缩")%></button>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        ! function(window, document, $) {
            "use strict";
            $("input,select,textarea").not("[type=submit]").jqBootstrapValidation()
        }(window, document, jQuery);
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=OnlinePay_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "?")});
        }
        function uploadImage(id) {
            $.ajaxFileUpload({
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
                            $("#image_" + id + "").html('<img src="' + WebPath + imageUrl + '" height="20">');
                            $("#" + id + "").val(imageUrl);
                        }
                    }

                }
            })
        }
        function ChangeType(){
            var t=$("#TypeName").val();
            $("#tr_appid").hide();
            $("#tr_userrealname").hide();
            $("#tr_terminal").hide();
            switch (t) {
                case "Paypal":
                    $("#Code").val("paypal");
                    $("#username").html("<%=Tag("帐号") %>：");
                    $("#key").html("<%=Tag("KEY") %>：");
                    $("#email").html("<%=Tag("邮箱") %>：");
                    $("#Url").val("/onlinepay/paypal/default.aspx");
                    break;
                case "财付通即时到帐接口":
                    $("#Code").val("tenpayJSDZ");
                    $("#username").html("<%=Tag("帐号") %>：");
                    $("#key").html("<%=Tag("KEY") %>：");
                    $("#email").html("<%=Tag("邮箱") %>：");
                    $("#Url").val("/onlinepay/tenpayJSDZ/default.aspx");
                    break;
                case "支付宝即时到帐":
                    $("#Code").val("alipayJSDZ");
                    $("#username").html("合作者身份(PID)：");
                    $("#key").html("安全校验码(Key)：");
                    $("#email").html("支付宝账号：");
                    $("#Url").val("/onlinepay/alipayJSDZ/default.aspx");
                    break;
                case "支付宝担保交易":
                    $("#Code").val("alipayDBJY");
                    $("#username").html("合作者身份(PID)：");
                    $("#key").html("安全校验码(Key)：");
                    $("#email").html("支付宝账号：");
                    $("#Url").val("/onlinepay/alipayDBJY/default.aspx");
                    break;
                case "支付宝双接口":
                    $("#Code").val("alipaySJK");
                    $("#username").html("合作者身份(PID)：");
                    $("#key").html("安全校验码(Key)：");
                    $("#email").html("支付宝账号：");
                    $("#Url").val("/onlinepay/alipaySJK/default.aspx");
                    break;
                case "支付宝海外支付":
                    $("#Code").val("alipayHaiWai");
                    $("#username").html("合作者身份(PID)：");
                    $("#key").html("安全校验码(Key)：");
                    $("#email").html("支付宝账号：");
                    $("#Url").val("/onlinepay/alipayHaiWai/default.aspx");
                    break;
                case "支付宝手机支付":
                    $("#Code").val("alipayWAP");
                    $("#username").html("合作者身份(PID)：");
                    $("#key").html("安全校验码(Key)：");
                    $("#email").html("支付宝账号：");
                    $("#Url").val("/onlinepay/alipayWAP/default.aspx");
                    break;
                case "支付宝批量付款":
                    $("#Code").val("alipaybatch");
                    $("#username").html("合作者身份(PID)：");
                    $("#key").html("安全校验码(Key)：");
                    $("#email").html("支付宝账号：");
                    $("#tr_userrealname").show();
                    $("#Url").val("/onlinepay/alipaybatch/default.aspx");
                    break;
                case "网银在线":
                    $("#Code").val("wangyinzaixian");
                    $("#username").html("商户号：");
                    $("#key").html("MD5密钥：");
                    $("#email").html("<%=Tag("邮箱") %>：");
                    $("#Url").val("/onlinepay/wangyinzaixian/default.aspx");
                    break;
                case "95epay":
                    $("#Code").val("95epay");
                    $("#username").html("<%=Tag("帐号") %>：");
                    $("#key").html("<%=Tag("KEY") %>：");
                    $("#email").html("<%=Tag("邮箱") %>：");
                    $("#Url").val("/onlinepay/95epay/Payment.aspx");
                    break;
                case "快钱":
                    $("#Code").val("kuaiqian");
                    $("#username").html("<%=Tag("帐号") %>：");
                    $("#key").html("<%=Tag("KEY") %>：");
                    $("#email").html("<%=Tag("邮箱") %>：");
                    $("#Url").val("/onlinepay/kuaiqian/default.aspx");
                    break;
                case "微信支付":
                    $("#Code").val("weixinpay");
                    $("#username").html("商户号：");
                    $("#key").html("密钥：");
                    $("#email").html("商户简称：");
                    $("#tr_appid").show();
                    $("#Url").val("/onlinepay/weixinpay/default.aspx");
                    //$("#tr_appkey").show();
                    break;
                case "微信支付H5":
                    $("#Code").val("weixinpayh5");
                    $("#username").html("商户号：");
                    $("#key").html("密钥：");
                    $("#email").html("商户简称：");
                    $("#tr_appid").show();
                    $("#Url").val("/onlinepay/weixinpayh5/default.aspx");
                    //$("#tr_appkey").show();
                    break;
                case "Molpay":
                    $("#Code").val("molpay");
                    $("#username").html("Merchant ID：");
                    $("#key").html("Verify Key：");
                    $("#email").html("<%=Tag("邮箱") %>：");
                    $("#Url").val("/onlinepay/molpay/default.aspx");
                    break;
                case "智付":
                    $("#Code").val("dinpay");
                    $("#username").html("<%=Tag("帐号") %>：");
                    $("#key").html("<%=Tag("KEY") %>：");
                    $("#email").html("<%=Tag("邮箱") %>：");
                    $("#Url").val("/onlinepay/dinpay/default.aspx");
                    break;
                case "钱海支付":
                    $("#Code").val("qianhai");
                    $("#username").html("商户号：");
                    $("#key").html("MD5密钥：");
                    $("#email").html("<%=Tag("邮箱") %>：");
                    $("#tr_terminal").show();
                    $("#Url").val("/onlinepay/qianhai/default.aspx");
                    break;
                case "银联全民付":
                    $("#Code").val("yinlianqmf");
                    $("#username").html("商户号：");
                    $("#key").html("密钥路径：");
                    $("#email").html("公钥路径：");
                    $("#tr_terminal").show();
                    $("#Url").val("/onlinepay/yinlianqmf/default.aspx");
                    break;
                case "汇付宝":
                    $("#Code").val("huifubao");
                    $("#username").html("商户号：");
                    $("#key").html("密钥：");
                    $("#Url").val("/onlinepay/huifubao/default.aspx");
                    break;
                case "behpardakht":
                    $("#Code").val("behpardakht");
                    $("#username").html("UserName：");
                    $("#key").html("PassWord：");
                    $("#tr_terminal").show();
                    $("#tr_email").hide();
                    $("#Url").val("/onlinepay/behpardakht/default.aspx");
                    break;
                case "authroize":
                    $("#Code").val("authroize");
                    $("#username").html("APILoginID：");
                    $("#key").html("ApiKey：");
                    $("#email").html("ApiTransactionKey：");
                    $("#tr_terminal").hide();
                    $("#Url").val("/onlinepay/authroizeVisa/default.aspx");
                    break;
                case"INIpayWap":
                    $("#Code").val("INIpayWap");
                    $("#username").html("商户号：");
                    $("#key").html("密钥：");
                    $("#Url").val("/onlinepay/INIpayWap/default.aspx");
                    break;
                case"INIpayWeb":
                    $("#Code").val("INIpayWeb");
                    $("#username").html("商户号：");
                    $("#key").html("密钥：");
                    $("#Url").val("/onlinepay/INIpayWeb/default.aspx");
                    break;
                case "conekta":
                    $("#Code").val("conekta");
                    $("#username").html("商户号：");
                    $("#key").html("密钥：");
                    $("#Url").val("/onlinepay/conektapay/default.aspx");
                    break;
                case "tonglianPay":
                    $("#Code").val("tonglianPay");
                    $("#username").html("商户号：");
                    $("#key").html("密钥：");
                    $("#tr_appid").show();

                    //$("#Url").val("/onlinepay/tonglianPay/default.aspx");
                    break;
            }
        }
        ChangeType();
    </script>

  