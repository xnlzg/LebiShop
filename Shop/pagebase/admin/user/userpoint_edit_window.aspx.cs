﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Shop.Bussiness;
using Shop.Model;using DB.LebiShop;
using LB.Tools;

namespace Shop.Admin.user
{
    public partial class UserPoint_Edit_window : AdminAjaxBase
    {
        protected Lebi_User_Point model;
        protected List<Lebi_User> users;
        protected string User_Name;
        protected string user_ids;
        protected string Point;
        protected int id;
        protected int user_id;
        protected SearchUser su;
        protected string mode = "scope";
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestTool.RequestInt("id", 0);
            if (id == 0)
            {
                if (!EX_Admin.Power("user_point_add", "添加会员积分"))
                {
                    WindowNoPower();
                }
            }
            else
            {
                if (!EX_Admin.Power("user_point_edit", "编辑会员积分"))
                {
                    WindowNoPower();
                }
            }
            int user_id = RequestTool.RequestInt("user_id", 0);
            model = B_Lebi_User_Point.GetModel(id);
            if (model == null)
            {
                model = new Lebi_User_Point();
                model.Type_id_PointStatus = 171;
                Point = "";
            }
            else
            {
                //user_id = model.User_id;
                Point = model.Point.ToString();
                mode = "user";
            }
            Lebi_User user = B_Lebi_User.GetModel(user_id);
            if (user == null)
            {
                User_Name = RequestTool.RequestString("User_Name");
                user = B_Lebi_User.GetModel("UserName=lbsql{'" + User_Name + "'}");
            }
            if (user != null)
            {
                mode = "user";
                User_Name = user.UserName;
            }
            user_ids = RequestTool.RequestString("ids");
            if (user_ids != "")
            {
                users = B_Lebi_User.GetList("id in (lbsql{" + user_ids + "})", "id desc");
                mode = "users";
            }
            su = new SearchUser(CurrentAdmin, CurrentLanguage.Code);

        }
    }
}