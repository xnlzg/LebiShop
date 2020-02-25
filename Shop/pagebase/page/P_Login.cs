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
    public class P_Login : ShopPage
    {
        protected string backurl;
        protected string token;
        protected bool LoginError = false;
        protected override void LoadPage(string themecode, int siteid, string languagecode, string pcode)
        {
            if (EX_User.LoginStatus())
            {
                Response.Redirect("/user");
                return;
            }
            LoadTheme(themecode, siteid, languagecode, pcode);
            path = "<a href=\"" + URL("P_Index", "") + "\" class=\"home\" title=\"" + Tag("��ҳ") + "\"><span>" + Tag("��ҳ") + "</span></a><em class=\"home\">&raquo;</em><a href=\"" + URL("P_Login", "") + "\"><span>" + Tag("��Ա��¼") + "</span></a>";
            backurl = Rstring("url");
            token = Rstring("token");
            if (backurl == "" || backurl.ToLower().IndexOf(URL("P_Login", "").ToLower()) > -1 || backurl.ToLower().IndexOf(URL("P_Register", "").ToLower()) > -1 || backurl.ToLower().IndexOf(URL("P_FindPassword", "").ToLower()) > -1)
            {
                backurl = RequestTool.GetUrlReferrerNonDomain();
                token = GetUrlToken(RequestTool.GetUrlReferrerNonDomain());
            }
            try
            {
                if ((string)HttpContext.Current.Session["loginerror"] == "true")
                    LoginError = true;
            }
            catch
            {
                LoginError = false;
            }
            //if (IsWechat())
            //{
            //    Response.Redirect(WebPath + "/platform/redirect_weixin.aspx?backurl=" + backurl);
            //    return;
            //}
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
                        str = Tag("��Ա��½");
                    else
                        str = Lang(theme_page.SEO_Title) ;
                    break;
            }
            return ThemePageMeta(code, tag, str);
        }
    }
}