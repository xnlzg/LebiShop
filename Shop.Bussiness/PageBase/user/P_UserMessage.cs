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

    public class P_UserMessage : ShopPageUser
    {
        protected int type;
        protected List<Lebi_Message> messages;
        protected List<Lebi_Message_Type> message_types;
        protected string PageString;
        protected string type_id;
        protected string key;
        protected string dateFrom;
        protected string dateTo;
        protected string where;
        protected override void LoadPage(string themecode, int siteid, string languagecode, string pcode)
        {
            if (CurrentUser.id == 0)
            {
                Response.Redirect(URL("P_Login", "" + HttpUtility.UrlEncode(RequestTool.GetRequestUrlNonDomain()) + "," + GetUrlToken(RequestTool.GetRequestUrlNonDomain())+ ""));
            }
            LoadTheme(themecode, siteid, languagecode, pcode);
            CurrentPage = B_Lebi_Theme_Page.GetModel("Code='P_UserMessage'");
            type = Rint_Para("0");
            path = "<a href=\"" + URL("P_Index", "") + "\" class=\"home\" title=\"" + Tag("��ҳ") + "\"><span>" + Tag("��ҳ") + "</span></a><em class=\"home\">&raquo;</em><a href=\"" + URL("P_UserCenter", "") + "\"><span>" + Tag("��Ա����") + "</span></a><em>&raquo;</em>";
            if (type == 0)
                path +="<a href=\"" + URL("P_UserMessage", "0") + "\"><span>" + Tag("�ռ���") + "</span></a>";
            else
                path +="<a href=\"" + URL("P_UserMessage", "1") + "\"><span>" + Tag("������") + "</span></a>";
            CurrentPage = B_Lebi_Theme_Page.GetModel("Code='P_UserMessage'");
            key = Rstring("key");
            type_id = Rstring("type_id");
            dateFrom = Rstring("dateFrom");
            dateTo = Rstring("dateTo");
            DateTime lbsql_dateFrom = RequestTool.RequestDate("dateFrom");
            DateTime lbsql_dateTo = RequestTool.RequestDate("dateTo");
            pageindex = RequestTool.RequestInt("page", 1);
            if (type == 0)
                where = "User_id_To=" + CurrentUser.id + "";
            if (type == 1)
                where = "User_id_From=" + CurrentUser.id + "";
            if (key != "")
                where += " and (Title like lbsql{'%" + key + "%'})";
            if (type_id != "")
                where += " and Message_Type_id = " + type_id;
            if (dateFrom != "" && dateTo != "")
                where += " and (datediff(d,Time_Add,'" + lbsql_dateFrom + "')<=0 and datediff(d,Time_Add,'" + lbsql_dateTo + "')>=0)";
            messages = B_Lebi_Message.GetList(where, "id desc", PageSize, pageindex);
            int recordCount = B_Lebi_Message.Counts(where);
            PageString = Shop.Bussiness.Pager.GetPaginationStringForWeb("?page={0}&type=" + type + "&type_id=" + type_id + "&key=" + key + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "", pageindex, PageSize, recordCount, CurrentLanguage);
            message_types = B_Lebi_Message_Type.GetList("Type_id_MessageTypeClass = 350", "id desc");

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
                        str = Tag("վ����") + " - " + Tag("��Ա����");
                    else
                        str = Lang(theme_page.SEO_Title) ;
                    break;
            }
            return ThemePageMeta(code, tag, str);
        }
    }
}