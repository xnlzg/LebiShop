using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Reflection;
using System.Globalization;
using Shop.Model;using DB.LebiShop;
using LB.Tools;
using System.Linq;
using System.Collections.Specialized;
using Shop.Bussiness;
namespace Shop
{
    public class P_Index : ShopPage
    {
        protected override void LoadPage(string themecode, int siteid, string languagecode, string pcode)
        {

            #region 单点登录 xnlzg 测试用户kingdge登录 (http://localhost:23712/?sign=tNneZFTdxyHM7BHwHKENhNWEerWb1Jhr)

            //var signTemp = EX_Admin.DesEncrypt("kingdge≌123456");
            var sign = Rstring("sign");
            if (!string.IsNullOrWhiteSpace(sign))
            {
                //解密
                var nameAndPass = EX_Admin.DesDecrypt(sign).Split('≌');
                var userName = nameAndPass[0];
                var password = nameAndPass[1];
                //判断用户是否存在,不存在创建新帐号
                int count = B_Lebi_User.Counts("UserName=lbsql{'" + userName + "'}");
                if (count == 0)
                {
                    Lebi_UserLevel defaultlevel = B_Lebi_UserLevel.GetModel("Grade>0 order by Grade asc");
                    Lebi_User model = new Lebi_User();
                    B_Lebi_User.SafeBindForm(model);
                    model.NickName = model.UserName;
                    model.Password = EX_User.MD5(password);
                    model.UserLevel_id = defaultlevel.id;
                    model.Time_Reg = DateTime.Now;
                    model.Time_This = DateTime.Now;
                    model.Time_Last = DateTime.Now;
                    model.Count_Login = 1;
                    model.IP_This = RequestTool.GetClientIP();
                    model.IP_Last = RequestTool.GetClientIP(); 
                    model.User_id_parent = 0;
                    if (CurrentSite != null)
                        model.Site_id = CurrentSite.id;
                    if (CurrentLanguage != null)
                        model.Language = CurrentLanguage.Code;
                    model.Area_id = RequestTool.RequestInt("Area_id", 0);
                    int DefaultUserEndDays = 0;
                    int.TryParse(SYS.DefaultUserEndDays, out DefaultUserEndDays);
                    model.Time_End = System.DateTime.Now.AddDays(DefaultUserEndDays);
                    Lebi_User user = EX_User.UserReg(model, password);
                }
                //登录
                if (EX_User.UserLogin(userName, password))
                {
                    CurrentUser = EX_User.CurrentUser();
                    if (ShopCache.GetBaseConfig().IsOpenUserEnd == "1")
                    {
                        if (CurrentUser.Time_End < System.DateTime.Now)
                        {
                            Response.Write("{\"msg\":\"" + Tag("账号已过期") + "\"}");
                            CookieTool.DeleteCookie("User");
                            return;
                        }
                    } 
                    if (SYS.Verifycode_UserLogin == "1")
                    {
                        HttpContext.Current.Session["loginerror"] = "false";
                    } 
                } 

            }


            #endregion

            LoadTheme(themecode, siteid, languagecode, pcode);

        }
        public override string ThemePageMeta(string code, string tag)
        {
            string str = "";
            Lebi_Theme_Page theme_page = B_Lebi_Theme_Page.GetModel("Code='" + code + "'");
            if (theme_page == null)
                return "";
            switch (tag.ToLower())
            {
                case "description":
                    if (Lang(theme_page.SEO_Description) == "")
                        str = Lang(SYS.Description);
                    else
                        str = Lang(theme_page.SEO_Description);
                    break;
                case "keywords":
                    if (Lang(theme_page.SEO_Keywords) == "")
                        str = Lang(SYS.Keywords);
                    else
                        str = Lang(theme_page.SEO_Keywords);
                    break;
                default:
                    if (Lang(theme_page.SEO_Title) != "")
                        str = Lang(theme_page.SEO_Title);
                    else
                        str = Lang(SYS.Title);
                    break;
            }
            return ThemePageMeta(code, tag, str,"P_Index");
        }
    }
}