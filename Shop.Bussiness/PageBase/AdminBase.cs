using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Reflection;
using System.Globalization;
using Shop.Model;using DB.LebiShop;
using LB.Tools;
using LB.DataAccess;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Linq;
using System.Collections.Specialized;
namespace Shop.Bussiness
{
    public class AdminBase : PageBase
    {
        protected Lebi_Administrator CurrentAdmin;
        protected Lebi_Admin_Group CurrentAdminGroup;
        protected Lebi_Language_Code CurrentAdminLanguage;
        protected List<Lebi_Language_Code> langs;
        protected Site site;
        protected Lebi_Language_Code CurrentLanguage;
        protected Lebi_Currency DefaultCurrency;
        protected BaseConfig config;
        protected bool IsEditStock=true; //�Ƿ�༭���
        protected bool domain3admin = false;//�Ƿ���Ҫ��̨��վ�����
        protected int page = RequestTool.RequestInt("page", 1);
        protected int PageSize = 20;
        public AdminBase()
        {
            if (("," + SYS.PluginUsed + ",").Contains(",Lebi.ERP,"))
            {
                IsEditStock = false;
            }
            config = ShopCache.GetBaseConfig();
            site = new Site();
            CurrentLanguage = Language.AdminCurrentLanguage();
            CurrentAdminLanguage = Language.AdminCurrentLanguage();
            DefaultCurrency = Language.DefaultCurrency();
            //page = RequestTool.RequestInt("page", 1);
            langs = Language.AdminLanguages();
            if (CurrentAdminGroup == null)
                CurrentAdminGroup = new Lebi_Admin_Group();
            
            if (site.SiteCount > 1)
            {
                //if (Shop.LebiAPI.Service.Instanse.Check("domain3admin"))
                //{
                domain3admin = true;
                //}
            }
           
        }
        /// <summary>
        /// ������ҳ��
        /// </summary>
        public void CheckPagePower()
        {
            if (Session["admin_power_url"] != null)
            {
                string requestpage = RequestTool.GetRequestUrlNoParas().ToLower();
                List<Lebi_Admin_Power> purls = (List<Lebi_Admin_Power>)Session["admin_power_url"];
                if (purls != null)
                {
                    foreach (Lebi_Admin_Power p in purls)
                    {
                        if (requestpage.Contains(p.Url.ToLower()))
                        {
                            PageNoPower();
                            return;
                        }
                    }
                }
            }
        }
        /// <summary>
        /// �����ֱ�ǩ
        /// </summary>
        /// <param name="TagName"></param>
        /// <returns></returns>
        public string Tag(string TagName)
        {
            //return TagName;
            return Bussiness.Language.Tag(TagName, CurrentLanguage.Code);
        }
        public string Lang(string jsonstr)
        {
            return Bussiness.Language.Content(jsonstr, CurrentLanguage.Code);
        }
        public string Lang(string jsonstr, string lang)
        {
            return Bussiness.Language.Content(jsonstr, lang);
        }
        public void PageError()
        {
            Response.Write(Tag("��������"));
            Response.End();
        }
        public void PageNoPower()
        {
            if (RequestTool.GetConfigKey("DemoSite").Trim() != "1")
            {
                Response.Write(Tag("Ȩ�޲���"));
                Response.End();
            }
        }
        public string PageErrorMsg()
        {
            return Tag("��������");
        }
        public string PageNoPowerMsg()
        {
            if (RequestTool.GetConfigKey("DemoSite").Trim() == "1")
            {
                return "";
            }
            return Tag("Ȩ�޲���");
        }
        public string PageNoEditMsg()
        {
            return "�˹����漰��վ��ȫ��Ҫ�ֶ�����������վ�ļ�web.config����&lt;appSettings&gt;&lt;/appSettings&gt;��ǩ�����&lt;add key=\"OnlineFileEdit\" value=\"1\" /&gt;";
        }
        public void NewPageNoPower()
        {
            PageNoPower();
        }
        public void WindowNoPower()
        {
            PageNoPower();
        }
        public void AjaxNoPower()
        {
            Response.Write("{\"msg\":\"" + Tag("Ȩ�޲���") + "\"}");
            Response.End();
        }
        /// <summary>
        /// ������ʽ��ΪĬ�ϻ���
        /// </summary>
        /// <param name="money"></param>
        /// <returns></returns>
        public string FormatMoney(decimal money)
        {
            return Language.FormatMoney(money, DefaultCurrency);
        }
        /// <summary>
        /// ������ʽ��Ϊָ������
        /// </summary>
        /// <param name="money"></param>
        /// <returns></returns>
        public string FormatMoney(decimal money, string CurrencyCode)
        {
            return Language.FormatMoney(money, CurrencyCode);
        }
        /// <summary>
        /// վ������
        /// </summary>
        /// <param name="siteid"></param>
        /// <returns></returns>
        public string SiteName(int siteid)
        {
            Lebi_Site model = B_Lebi_Site.GetModel(siteid);
            if (model == null)
                model = ShopCache.GetMainSite();
            return model.SubName;
        }
        /// <summary>
        /// վ������
        /// </summary>
        /// <param name="siteid"></param>
        /// <returns></returns>
        public string SiteName(int siteid, int DT_id, string LanuageCode)
        {
            if (DT_id == 0)
            {
                Lebi_Site model = B_Lebi_Site.GetModel(siteid);
                if (model == null)
                    model = ShopCache.GetMainSite();
                return model.SubName;
            }
            else
            {
                Lebi_DT model = B_Lebi_DT.GetModel(DT_id);
                if (model == null)
                    model = new Lebi_DT();
                return Shop.Bussiness.Language.Content(model.Site_Name,LanuageCode);
            }
        }
        /// <summary>
        /// ��������
        /// </summary>
        /// <param name="siteid"></param>
        /// <returns></returns>
        public string LanguageName(string langids)
        {
            if (langids.Trim(',') == "")
                return "";
            string res = "";
            try
            {
                List<Lebi_Site> sites = Shop.Bussiness.Site.Instance.Sites();
                foreach (Lebi_Site site in sites)
                {
                    List<Lebi_Language> langs = B_Lebi_Language.GetList("Site_id=" + site.id + " and id in (" + langids + ")", "");
                    if (langs.Count > 0)
                    {
                        if (sites.Count > 1)
                        {
                            if (res == "")
                                res = site.SubName + "��";
                            else
                                res += "|" + site.SubName + "��";
                        }
                        foreach (Lebi_Language lang in langs)
                        {
                            res += lang.Code + " ";
                        }
                    }
                }
                return res;
            }
            catch
            {
                return "";
            }
            
        }
        /// <summary>
        /// �û�����
        /// </summary>
        /// <param name="siteid"></param>
        /// <returns></returns>
        public string UserName(int id)
        {
            Lebi_User model = B_Lebi_User.GetModel(id);
            if (model == null)
                model = new Lebi_User();
            return "[" + model.UserName + "]" + model.RealName;
        }
        /// <summary>
        /// ����Ա�û�����
        /// </summary>
        /// <param name="siteid"></param>
        /// <returns></returns>
        public string AdminName(int id)
        {
            Lebi_Administrator model = B_Lebi_Administrator.GetModel(id);
            if (model == null)
                return "";
            Lebi_Admin_Group group = B_Lebi_Admin_Group.GetModel(model.Admin_Group_id);
            if (group == null)
                return model.RealName;
            return "[" + Lang(group.Name) + "]" + model.RealName;
        }
        /// <summary>
        /// �����������
        /// </summary>
        /// <param name="content"></param>
        /// <returns></returns>
        public string OrderByName(string OrderBy, string content)
        {
            OrderBy = OrderBy.Trim();
            content = content.Trim();
            if (OrderBy == content && content.Contains("Desc"))
            {
                content = content.Replace("Desc", "Asc");
            }
            else
            {
                content = content.Replace("Asc", "Desc");
            }
            return "?OrderBy=" + content + "";
        }
        public string OrderByName(string OrderBy, string content, string type)
        {
            string str = "both";
            OrderBy = OrderBy.Trim();
            content = content.Trim();
            if (OrderBy == content)
            {
                str = "desc";
            }
            else if (OrderBy == content.Replace("Desc", "Asc"))
            {
                str = "asc";
            }
            return str;
        }
    }
}
