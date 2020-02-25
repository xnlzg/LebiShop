using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Text.RegularExpressions;
using System.Linq;
using Shop.Model;using DB.LebiShop;
using LB.Tools;
using LB.DataAccess;
using System.Web.Script.Serialization;
using System.Collections.Specialized;

namespace Shop.Bussiness
{
    public class Promotion
    {
        /// <summary>
        /// ���»״̬
        /// </summary>
        public void UpdateStatus()
        {
            bool flag = false;
            //ȡ���ﱸ�У������еĴ���
            List<Lebi_Promotion> models = B_Lebi_Promotion.GetList("Type_id_PromotionStatus in (240,241)", "");
            foreach (Lebi_Promotion model in models)
            {
                if (model.Type_id_PromotionStatus == 240)
                {
                    if (model.Time_Start <= System.DateTime.Now && model.Time_End >= System.DateTime.Now)
                    {
                        model.Type_id_PromotionStatus = 241;
                        flag = true;
                    }
                }
                if (model.Type_id_PromotionStatus == 241)
                {
                    if (model.Time_End <= System.DateTime.Now)
                    {
                        model.Type_id_PromotionStatus = 242;//����
                        flag = true;
                    }
                }
                B_Lebi_Promotion.Update(model);
            }
            if (flag)
                ShopCache.SetCurrentPromotionType();
        }

        /// <summary>
        /// ��ǰ����
        ///  ���ʱ�䣬������޹�״̬
        /// </summary>
        /// <returns></returns>
        public static List<Lebi_Promotion_Type> CurrentPromotionType()
        {
            //return ShopCache.GetCurrentPromotionType();
            List<Lebi_Promotion_Type> models = B_Lebi_Promotion_Type.GetList("Type_id_PromotionStatus=241", "");
            List<Lebi_Promotion_Type> res = new List<Lebi_Promotion_Type>();
            foreach (Lebi_Promotion_Type model in models)
            {
                if (model.Time_End < System.DateTime.Now)
                {
                    model.Type_id_PromotionStatus = 242;
                    B_Lebi_Promotion_Type.Update(model);
                    continue;
                }
                res.Add(model);
            }
            return res;
        }
        /// <summary>
        /// ���ش�������
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static List<Lebi_Promotion> GetPromotion(int id)
        {
            List<Lebi_Promotion> models = B_Lebi_Promotion.GetList("Promotion_Type_id=" + id + "", "Sort desc");
            return models;
        }


    }


}

