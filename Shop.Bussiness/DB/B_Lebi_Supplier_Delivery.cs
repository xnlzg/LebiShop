﻿using System;
using System.Data;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Shop.Model;
using Shop.SQLDataAccess;
namespace Shop.Bussiness
{
	/// <summary>
	/// 业务逻辑类B_Lebi_Supplier_Delivery 的摘要说明。
	/// </summary>
	public partial class B_Lebi_Supplier_Delivery
	{
		public B_Lebi_Supplier_Delivery()
		{}
		#region  成员方法

		/// <summary>
		/// 返回单个字符串
		/// </summary>
		public static string GetValue(string col,string where)
		{
			return D_Lebi_Supplier_Delivery.Instance.GetValue(col,where);
		}


		/// <summary>
		/// 返回记录条数
		/// </summary>
		public static int Counts(string where)
		{
			return D_Lebi_Supplier_Delivery.Instance.Counts(where);
		}
		public static int Counts(SQLPara para)
		{
			return D_Lebi_Supplier_Delivery.Instance.Counts(para);
		}

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public static int Add(Lebi_Supplier_Delivery model)
		{
			return D_Lebi_Supplier_Delivery.Instance.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public static void Update(Lebi_Supplier_Delivery model)
		{
			D_Lebi_Supplier_Delivery.Instance.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public static void Delete(int id)
		{
			
			D_Lebi_Supplier_Delivery.Instance.Delete(id);
		}
		/// <summary>
		/// 删除多条数据  by where条件
		/// </summary>
		public static void Delete(string where)
		{
			
			D_Lebi_Supplier_Delivery.Instance.Delete(where);
		}
		/// <summary>
		/// 删除多条数据
		/// </summary>
		public static void Delete(SQLPara para)
		{
			
			D_Lebi_Supplier_Delivery.Instance.Delete(para);
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public static Lebi_Supplier_Delivery GetModel(int id)
		{
			
			return D_Lebi_Supplier_Delivery.Instance.GetModel(id);
		}
		/// <summary>
		/// 得到一个对象实体 by where条件
		/// </summary>
		public static Lebi_Supplier_Delivery GetModel(string where)
		{
			
			return D_Lebi_Supplier_Delivery.Instance.GetModel(where);
		}
		public static Lebi_Supplier_Delivery GetModel(SQLPara para)
		{
			
			return D_Lebi_Supplier_Delivery.Instance.GetModel(para);
		}


		/// <summary>
		/// 得到最大ID
		/// </summary>
		public static int GetMaxId()
		{
			return D_Lebi_Supplier_Delivery.Instance.GetMaxID("");
		}
		public static int GetMaxId(SQLPara para)
		{
			return D_Lebi_Supplier_Delivery.Instance.GetMaxID(para);
		}
		public static int GetMaxId(string strWhere)
		{
			return D_Lebi_Supplier_Delivery.Instance.GetMaxID(strWhere);
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public static List<Lebi_Supplier_Delivery> GetList(string strWhere,string strFieldOrder)
		{
			return D_Lebi_Supplier_Delivery.Instance.GetList(strWhere,strFieldOrder);
		}
		public static List<Lebi_Supplier_Delivery> GetList(SQLPara para)
		{
			return D_Lebi_Supplier_Delivery.Instance.GetList(para);
		}
		public static List<Lebi_Supplier_Delivery> GetList(string strWhere, string strFieldOrder, int PageSize, int page)
		{
			return D_Lebi_Supplier_Delivery.Instance.GetList(strWhere,strFieldOrder,PageSize,page);
		}
		public static List<Lebi_Supplier_Delivery> GetList(SQLPara para, int PageSize, int page)
		{
			return D_Lebi_Supplier_Delivery.Instance.GetList(para,PageSize,page);
		}

		/// <summary>
		/// 绑定表单数据
		/// </summary>
		public static Lebi_Supplier_Delivery BindForm(Lebi_Supplier_Delivery model)
		{
			
			return D_Lebi_Supplier_Delivery.Instance.BindForm(model);
		}
		/// <summary>
		/// 安全方式绑定表单数据
		/// </summary>
		public static Lebi_Supplier_Delivery SafeBindForm(Lebi_Supplier_Delivery model)
		{
			
			return D_Lebi_Supplier_Delivery.Instance.SafeBindForm(model);
		}

		#endregion  成员方法
	}
}

