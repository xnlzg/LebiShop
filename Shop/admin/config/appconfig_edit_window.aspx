﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.storeConfig.appconfig_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("推送配置")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="APPPush_state_1"><%=Tag("状态")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="APPPush_state_1" name="APPPush_state" value="1" class="custom-control-input" shop="true" <%=model.APPPush_state=="1"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("开启")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="APPPush_state_0" name="APPPush_state" value="0" class="custom-control-input" shop="true" <%=model.APPPush_state=="0"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("关闭")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="checkbox_ordershipping"><%=Tag("发给会员")%>：</label>
                <div class="form-control-label">
                    <%string ms = model.APPPush_sendmode;
                    if (ms == null)
                    ms = "";
                    %>
                    <div class="input-group">
                        <label class="custom-control custom-checkbox m-r-20">
                            <input type="checkbox" id="checkbox_ordershipping" name="APPPush_sendmode" value="ordershipping" class="custom-control-input" shop="true" <%=ms.Contains("ordershipping")?"checked":"" %>>
                            <span class="custom-control-label"><%=Tag("订单发货")%></span>
                        </label>
                        <label class="custom-control custom-checkbox m-r-20">
                            <input type="checkbox" id="checkbox_balance" name="APPPush_sendmode" value="balance" class="custom-control-input" shop="true" <%=ms.Contains("balance")?"checked":"" %>>
                            <span class="custom-control-label"><%=Tag("余额提醒")%></span>
                        </label>
                        <label class="custom-control custom-checkbox m-r-20">
                            <input type="checkbox" id="checkbox_comment" name="APPPush_sendmode" value="comment" shop="true" <%=ms.Contains("comment")?"checked":"" %>>
                            <span class="custom-control-label"><%=Tag("商品评论")%></span>
                        </label>
                        <label class="custom-control custom-checkbox m-r-20">
                            <input type="checkbox" id="checkbox_ask" name="APPPush_sendmode" value="ask" class="custom-control-input" shop="true" <%=ms.Contains("ask")?"checked":"" %>>
                            <span class="custom-control-label"><%=Tag("商品咨询")%></span>
                        </label>
                        <label class="custom-control custom-checkbox m-r-20">
                            <input type="checkbox" id="checkbox_message" name="APPPush_sendmode" value="message" class="custom-control-input" shop="true" <%=ms.Contains("message")?"checked":"" %>>
                            <span class="custom-control-label"><%=Tag("站内信")%></span>
                        </label>
                        <label class="custom-control custom-checkbox">
                            <input type="checkbox" id="checkbox_reserveok" name="APPPush_sendmode" value="reserveok" class="custom-control-input" shop="true" <%=ms.Contains("reserveok")?"checked":"" %>>
                            <span class="custom-control-label"><%=Tag("预定到货提醒")%></span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="app_share_qq"><%=Tag("分享")%>：</label>
                <div class="form-control-label">
                    <%string share = model.app_share;
                    if (share == null)
                    share = "";
                    %>
                    <div class="input-group">
                        <label class="custom-control custom-checkbox m-r-20">
                            <input type="checkbox" id="app_share_qq" name="app_share" value="qq" class="custom-control-input" shop="true" <%=share.Contains("qq")?"checked":"" %>>
                            <span class="custom-control-label"><%=Tag("QQ")%></span>
                        </label>
                        <label class="custom-control custom-checkbox m-r-20">
                            <input type="checkbox" id="app_share_wechat" name="app_share" value="wechat" class="custom-control-input" shop="true" <%=share.Contains("wechat")?"checked":"" %>>
                            <span class="custom-control-label"><%=Tag("微信")%></span>
                        </label>
                        <label class="custom-control custom-checkbox">
                            <input type="checkbox" id="app_share_dingtalk" name="app_share" value="dingtalk" class="custom-control-input" shop="true" <%=share.Contains("dingtalk")?"checked":"" %>>
                            <span class="custom-control-label"><%=Tag("钉钉")%></span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="app_share_qq_key"><%=Tag("QQ")%>：</label>
                <div class="row">
                    <div class="col-sm-6">
                        <label for="app_share_qq_key">Appid：</label>
                        <div class="input-group">
                            <input type="text" id="app_share_qq_key" name="app_share_qq_key" value="<%=model.app_share_qq_key%>" class="form-control" shop="true">
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <label for="app_share_qq_secret">Appkey：</label>
                        <div class="input-group">
                            <input type="text" id="app_share_qq_secret" name="app_share_qq_secret" value="<%=model.app_share_qq_secret%>" class="form-control" shop="true">
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="app_share_wechat_key"><%=Tag("微信")%>：</label>
                <div class="row">
                    <div class="col-sm-6">
                        <label for="app_share_wechat_key">Appid：</label>
                        <div class="input-group">
                            <input type="text" id="app_share_wechat_key" name="app_share_wechat_key" value="<%=model.app_share_wechat_key%>" class="form-control" shop="true">
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <label for="app_share_wechat_secret">Appkey：</label>
                        <div class="input-group">
                            <input type="text" id="app_share_wechat_secret" name="app_share_wechat_secret" value="<%=model.app_share_wechat_secret%>" class="form-control" shop="true">
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="app_share_dingtalk_key"><%=Tag("钉钉")%>：</label>
                <div class="row">
                    <div class="col-sm-6">
                        <label for="app_share_dingtalk_key">Appid：</label>
                        <div class="input-group">
                            <input type="text" id="app_share_dingtalk_key" name="app_share_dingtalk_key" value="<%=model.app_share_dingtalk_key%>" class="form-control" shop="true">
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <label for="app_share_dingtalk_secret">Appkey：</label>
                        <div class="input-group">
                            <input type="text" id="app_share_dingtalk_secret" name="app_share_dingtalk_secret" value="<%=model.app_share_dingtalk_secret%>" class="form-control" shop="true">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        function SaveObj() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=APPPush_Edit";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "");});
        }
    </script>

  