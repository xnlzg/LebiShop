﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Shop.Bussiness;
using Shop.Model;using DB.LebiShop;
using LB.Tools;

namespace Shop.Admin.product
{
    public partial class Brand : AdminPageBase
    {
        protected string lang;
        protected string key;
        protected string type;
        protected int status;
        protected List<Lebi_Brand> models;
        protected string PageString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!EX_Admin.Power("brand_list", "品牌列表"))
            {
                PageReturnMsg = PageNoPowerMsg();
            }
            
            PageSize = RequestTool.getpageSize(25);
            lang = RequestTool.RequestString("lang");
            key = RequestTool.RequestString("key");
            type = RequestTool.RequestString("type");
            status = RequestTool.RequestInt("status", 0);
            string where = "1=1";
            if (status > 0)
                where += " and Type_id_BrandStatus = " + status + "";
            if (key != "")
                where += " and Name like lbsql{'%" + key + "%'}";
            if (type !="")
                where += " and Pro_Type_id like lbsql{'%" + type + "%'}";
            models = B_Lebi_Brand.GetList(where, "Sort desc", PageSize, page);
            int recordCount = B_Lebi_Brand.Counts(where);

            PageString = Pager.GetPaginationString("?page={0}&type=" + type + "&status=" + status + "&key=" + key, page, PageSize, recordCount);
            
        }
    }
}