﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.user.user_search_widow" validateRequest="false"%>

    <form action="javascript:SearchUser();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("会员查询")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="UserName"><%=Tag("会员帐号")%>：</label>
                <input type="text" id="UserName" name="UserName" value="<%=model.UserName %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="RealName"><%=Tag("真实姓名")%>：</label>
                <input type="text" id="RealName" name="RealName" value="<%=model.RealName %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="NickName"><%=Tag("昵称")%>：</label>
                <input type="text" id="NickName" name="NickName" value="<%=model.NickName %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="Sex_1"><%=Tag("性别")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-checkbox m-r-20">
                        <input type="checkbox" id="Sex_1" name="Sex" value="男" class="custom-control-input" shop="true" <%=model.Sex.Contains("男")?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("男")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="checkbox" id="Sex_0" name="Sex" value="女" class="custom-control-input" shop="true" <%=model.Sex.Contains("女")?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("女")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Birthday1"><%=Tag("生日")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Birthday1" name="Birthday1" value="<%=model.Birthday1 %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Birthday2" name="Birthday2" value="<%=model.Birthday2 %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group">
                <label for="Time_reg1"><%=Tag("注册日期")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Time_reg1" name="Time_reg1" value="<%=model.Time_reg1 %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Time_reg2" name="Time_reg2" value="<%=model.Time_reg2 %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group">
                <label for="Time_login1"><%=Tag("最后登录")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Time_login1" name="Time_login1" value="<%=model.Time_login1 %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Time_login2" name="Time_login2" value="<%=model.Time_login2 %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group">
                <label for="MobilePhone"><%=Tag("手机号码")%>：</label>
                <input type="text" id="MobilePhone" name="MobilePhone" value="<%=model.MobilePhone %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="Phone"><%=Tag("电话号码")%>：</label>
                <input type="text" id="Phone" name="Phone" value="<%=model.Phone %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="Email"><%=Tag("Email")%>：</label>
                <input type="text" id="Email" name="Email" value="<%=model.Email %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchUser();}">
            </div>
            <div class="form-group">
                <label for="UserLevel_id"><%=Tag("会员分组")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_User.TypeCheckbox("grade > 0", "UserLevel_id", model.UserLevel_id,"shop=\"true\"", CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Money1"><%=Tag("账户余额")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Money1" name="Money1" value="<%=model.Money1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Money2" name="Money2" value="<%=model.Money2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                </div>
            </div>
            <div class="form-group">
                <label for="Money_xiaofei1"><%=Tag("消费金额")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Money_xiaofei1" name="Money_xiaofei1" value="<%=model.Money_xiaofei1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Money_xiaofei2" name="Money_xiaofei2" value="<%=model.Money_xiaofei2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                </div>
            </div>
            <div class="form-group">
                <label for="Point1"><%=Tag("积分")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Point1" name="Point1" value="<%=model.Point1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Point2" name="Point2" value="<%=model.Point2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                </div>
            </div>
            <div class="form-group">
                <label for="Logins1"><%=Tag("登录次数")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Logins1" name="Logins1" value="<%=model.Logins1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Logins2" name="Logins2" value="<%=model.Logins2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                </div>
            </div>
            <div class="form-group">
                <label for="Language"><%=Tag("语言")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.Language.LanguageCheckbox("Language",model.Language)%>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-search"></i> <%=Tag("搜索")%></button>
        </div>
    </form>
    <script>
        $('#Birthday1').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });        $('#Birthday2').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
        $('#Time_reg1').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });        $('#Time_reg2').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
        $('#Time_login1').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });        $('#Time_login2').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
        function SearchUser()
        {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_search.aspx?__Action=UserSearch";
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: 'json',
                success: function (res) {
                    <%=callback %>(res.url);
                }
            });
        }
    </script>

  