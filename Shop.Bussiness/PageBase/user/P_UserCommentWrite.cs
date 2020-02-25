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

    public class P_UserCommentWrite : ShopPageUser
    {
        protected int id;
        protected Lebi_Order_Product order_product;
        protected override void LoadPage(string themecode, int siteid, string languagecode, string pcode)
        {
            LoadTheme(themecode, siteid, languagecode, pcode);
            if (CurrentUser.id == 0)
            {
                Response.Write("<script type=\"text/javascript\">alert('" + Tag("�ѹ�����Ʒ�����ջ�֮��ſ��Է�������") + "');window.location.href='"+URL("P_Login", "" + HttpUtility.UrlEncode(RequestTool.GetRequestUrlNonDomain()) + "")+"';</script>");
                Response.End();
                //Response.Redirect(URL("P_Login", "" + HttpUtility.UrlEncode(RequestTool.GetRequestUrlNonDomain()) + "," + GetUrlToken(RequestTool.GetRequestUrlNonDomain())+ ""));
            }
            path = "<a href=\"" + URL("P_Index", "") + "\" class=\"home\" title=\"" + Tag("��ҳ") + "\"><span>" + Tag("��ҳ") + "</span></a><em class=\"home\">&raquo;</em><a href=\"" + URL("P_UserCenter", "") + "\"><span>" + Tag("��Ա����") + "</span></a><em>&raquo;</em><a href=\"" + URL("P_UserComment", "1") + "\"><span>" + Tag("��Ʒ����") + "</span></a><em>&raquo;</em><a href=\"" + URL("P_UserCommentWrite", "") + "\"><span>" + Tag("��������") + "</span></a>";
            CurrentPage = B_Lebi_Theme_Page.GetModel("Code='P_UserCommentWrite'");

            id = Rint("id");
            order_product = B_Lebi_Order_Product.GetModel("id = " + id + " and IsCommented = 0 and User_id=" + CurrentUser.id + "");
            if (order_product == null)
            {
                Response.Write("<script type=\"text/javascript\">alert('" + Tag("�ѹ�����Ʒ�����ջ�֮��ſ��Է�������") + "');javascript:window.history.back();</script>");
                Response.End();
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
                        str = Tag("��������") + " - " + Tag("��Ʒ����") + " - " + Tag("��Ա����");
                    else
                        str = Lang(theme_page.SEO_Title) ;
                    break;
            }
            return ThemePageMeta(code, tag, str);
        }
    }
}