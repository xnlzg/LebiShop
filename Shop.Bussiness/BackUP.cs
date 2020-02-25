using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Linq;
using Shop.Model;using DB.LebiShop;
using LB.Tools;
using LB.DataAccess;
using System.Web.Script.Serialization;
using System.IO;

namespace Shop.Bussiness
{
    public class BackUP
    {
        /// <summary>
        /// ������ݱ���
        /// </summary>
        public static bool Add()
        {

            try
            {

                string backpath = ShopCache.GetBaseConfig().DataBase_BackPath;
                string backname = ShopCache.GetBaseConfig().DataBase_BackName;
                if (backpath.IndexOf("/") == 0)
                {
                    backpath = System.Web.HttpRuntime.AppDomainAppPath + "/" + backpath;
                }
                if (!Directory.Exists(backpath))
                {
                    Directory.CreateDirectory(backpath);
                }
                if (!backname.Contains("."))
                {
                    backname = "." + backname;
                }
                backname = System.DateTime.Now.ToString("yyyyMMddhhmmss") + backname;
                backpath = backpath + "/" + backname;
                Regex r = new Regex(@"//*/", RegexOptions.Singleline);//Ŀ�ģ���ֹ���ơ�///����////����//////�������
                backpath = r.Replace(backpath, "/");
                string sql = "exec p_backupdb @bkfname='" + backpath + "'";
                Common.ExecuteSql(sql);
                Log.Add("�������ݿ�");//��Ӳ�����¼
                
                return true;
            }
            catch (Exception ex)
            {
                Log.Add("�������ݿ��쳣��", ex.Message);//��Ӳ�����¼
                return false;
            }
        }

    }

}

