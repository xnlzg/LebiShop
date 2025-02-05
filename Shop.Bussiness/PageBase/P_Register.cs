using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Reflection;
using System.Globalization;
using Shop.Model;
using Shop.Tools;
using System.Linq;
using System.Collections.Specialized;

namespace Shop.Bussiness
{
    public class P_Register : ShopPage
    {
        protected string backurl;
        protected string token;
        protected bool Checkmobilephone = false;
        protected bool Checkemail = false;
        protected int parentuserid = 0;
        protected override void LoadPage(string themecode, int siteid, string languagecode, string pcode)
        {
            LoadTheme(themecode, siteid, languagecode, pcode);
            path = "<a href=\"" + URL("P_Index", "") + "\" class=\"home\" title=\"" + Tag("首页") + "\"><span>" + Tag("首页") + "</span></a><em class=\"home\">&raquo;</em><a href=\"" + URL("P_Register", "") + "\"><span>" + Tag("会员注册") + "</span></a>";

            backurl = Rstring("url");
            if (backurl == "" || backurl.ToLower().IndexOf(URL("P_Login", "").ToLower()) > -1 || backurl.ToLower().IndexOf(URL("P_Register", "").ToLower()) > -1)
                backurl = RequestTool.GetUrlReferrerNonDomain();
            token = GetUrlToken(backurl);
            if (SYS.UserRegCheckedType.Contains("mobilephone"))
                Checkmobilephone = true;
            if (SYS.UserRegCheckedType.Contains("email"))
                Checkemail = true;
            if (Shop.Bussiness.B_API.Check("plugin_agent"))
            {
                var nv = Shop.Tools.CookieTool.GetCookie("parentuser");
                if (!string.IsNullOrEmpty(nv.Get("id")))
                {
                    string parentuserid_ = nv.Get("id");
                    int pid = 0;
                    int.TryParse(parentuserid_, out pid);
                    Lebi_User puser = Shop.Bussiness.B_Lebi_User.GetModel("id=" + parentuserid_ + "");
                    if (puser != null)
                    {
                        if (SYS.IsUsedAgent == "1")
                        {
                            if (Shop.Bussiness.B_API.Check("plugin_agent"))
                            {
                                parentuserid = puser.id;
                            }
                        }
                    }
                }
            }
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
                    if (Lang(theme_page.SEO_Title) == "")
                        str = Tag("会员注册");
                    else
                        str = Lang(theme_page.SEO_Title);
                    break;
            }
            return ThemePageMeta(code, tag, str);
        }
    }
}