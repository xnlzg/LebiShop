﻿using System;
using System.Data;
using System.Data.Common;
using System.Text;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.OleDb;

using System.Text.RegularExpressions;
using System.Web;
using LB.DataAccess;
namespace DB.LebiShop
{
	/// <summary>
	/// 数据访问类D_Lebi_Product_Stock_Log。
	/// </summary>
	public partial class D_Lebi_Product_Stock_Log
	{
		static D_Lebi_Product_Stock_Log _Instance;
		public static D_Lebi_Product_Stock_Log Instance
		{
		   get
		   {
		        if (_Instance == null)
		        {
		            _Instance = new D_Lebi_Product_Stock_Log("Lebi_Product_Stock_Log");
		        }
		        return _Instance;
		    }
		    set
		    {
		        _Instance = value;
		    }
		}
		string TableName = "Lebi_Product_Stock_Log";
		public D_Lebi_Product_Stock_Log(string tablename)
		{
		    TableName = tablename;
		}

		#region  成员方法
		/// <summary>
		/// 根据字段名，where条件获取一个值,返回字符串
		/// </summary>
		public string GetValue(string colName,string strWhere,int seconds=0)
		{
		   string val = "";
		   try
		   {
		       StringBuilder strSql=new StringBuilder();
		       strSql.Append("select " + colName + " from "+ TableName + "");
		       if(strWhere.Trim()!="")
		       {
		           strSql.Append(" where "+strWhere);
		       }
		       string cachestr = "";
		       string cachekey = "";
		       if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		       {
		           cachestr = strSql.ToString() + "|" + seconds;
		           cachekey = LB.Tools.Utils.MD5(cachestr);
		           var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		           if (obj != null)
		               return obj.ToString();
		       }
		       val = Convert.ToString(LB.DataAccess.DB.Instance.TextExecute(strSql.ToString()));
		       if (cachekey != "")
		           LB.DataAccess.DB.Instance.SetMemchche(cachekey, val, "Lebi_Product_Stock_Log", 0 , cachestr , seconds);
		   }
		   catch
		   {
		       val = "";
		   }
		   return val;
		}
		public string GetValue(string colName,SQLPara para, int seconds=0)
		{
		   StringBuilder strSql=new StringBuilder();
		   strSql.Append("select  "+colName+" from "+ TableName + "");
		   if(para.Where!="")
		       strSql.Append(" where "+para.Where);
		   string cachestr = "";
		   string cachekey = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = strSql.ToString() + "|" + para.ValueString + "|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return obj.ToString();
		   }
		   string val = "";
		   val = Convert.ToString( LB.DataAccess.DB.Instance.TextExecute(strSql.ToString(), para.Para)); 
		   if (cachekey != "")
		       LB.DataAccess.DB.Instance.SetMemchche(cachekey, val, "Lebi_Product_Stock_Log", 0 , cachestr , seconds);
		   return val;
		}

		/// <summary>
		/// 计算记录条数
		/// </summary>
		public int Counts(string strWhere, int seconds=0)
		{
		   if (strWhere.IndexOf("lbsql{") > 0)
		   {
		       SQLPara para = new SQLPara(strWhere, "", "");
		       return Counts(para, seconds);
		   }
		   StringBuilder strSql=new StringBuilder();
		   strSql.Append("select count(1) from "+ TableName + "");
		   if(strWhere.Trim()!="")
		       strSql.Append(" where "+strWhere);
		   string cachestr = "";
		   string cachekey = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = strSql.ToString() + "|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return Convert.ToInt32(obj);
		   }
		   int val = 0;
		   val= Convert.ToInt32( LB.DataAccess.DB.Instance.TextExecute(strSql.ToString())); 
		   if (cachekey != "")
		       LB.DataAccess.DB.Instance.SetMemchche(cachekey, val, "Lebi_Product_Stock_Log" , 0 , cachestr , seconds);
		   return val;
		}
		public int Counts(SQLPara para, int seconds=0)
		{
		   StringBuilder strSql=new StringBuilder();
		   strSql.Append("select count(1) from "+ TableName + "");
		   if(para.Where!="")
		       strSql.Append(" where "+para.Where);
		   string cachestr = "";
		   string cachekey = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = strSql.ToString() + "|" + para.ValueString + "|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return Convert.ToInt32(obj);
		   }
		   int val = 0;
		   val = Convert.ToInt32( LB.DataAccess.DB.Instance.TextExecute(strSql.ToString(), para.Para)); 
		   if (cachekey != "")
		       LB.DataAccess.DB.Instance.SetMemchche(cachekey, val, "Lebi_Product_Stock_Log", 0 , cachestr,seconds);
		   return val;
		}


		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxID(string strWhere)
		{
		   if (strWhere.IndexOf("lbsql{") > 0)
		   {
		       SQLPara para = new SQLPara(strWhere, "", "");
		       return GetMaxID(para);
		   }
		   StringBuilder strSql = new StringBuilder();
		   strSql.Append("select max(id) from "+ TableName + "");
		   if(strWhere.Trim()!="")
		       strSql.Append(" where "+strWhere);
		   return Convert.ToInt32(LB.DataAccess.DB.Instance.TextExecute(strSql.ToString()));
		}
		public int GetMaxID(SQLPara para)
		{
		   StringBuilder strSql=new StringBuilder();
		   strSql.Append("select count(1) "+ TableName + "");
		   if(para.Where!="")
		       strSql.Append(" where "+para.Where);
		  return Convert.ToInt32( LB.DataAccess.DB.Instance.TextExecute(strSql.ToString(), para.Para)); 
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(Lebi_Product_Stock_Log model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into "+ TableName + " (");
			strSql.Append(LB.DataAccess.DB.BaseUtilsInstance.ColName("Count")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Order_Code")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Order_id")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Product_id")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Remark")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Time_Add")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Type_id_Stock")+")");
			strSql.Append(" values (");
			strSql.Append("@Count,@Order_Code,@Order_id,@Product_id,@Remark,@Time_Add,@Type_id_Stock);select @@identity;");
			SqlParameter[] parameters = {
					new SqlParameter("@Count", model.Count),
					new SqlParameter("@Order_Code", model.Order_Code),
					new SqlParameter("@Order_id", model.Order_id),
					new SqlParameter("@Product_id", model.Product_id),
					new SqlParameter("@Remark", model.Remark),
					new SqlParameter("@Time_Add", model.Time_Add),
					new SqlParameter("@Type_id_Stock", model.Type_id_Stock)};

			object obj = LB.DataAccess.DB.Instance.TextExecute(strSql.ToString(),parameters);
			if (obj == null)
			{
				return 1;
			}
			else
			{
				return Convert.ToInt32(obj);
			}
		}
		/// <summary>
		/// 更新一条数据
		/// </summary>
		public void Update(Lebi_Product_Stock_Log model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update "+ TableName + " set ");
			List<string> cols = new List<string>();
			if((","+model.UpdateCols+",").IndexOf(",Count,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Count")+"= @Count");
			if((","+model.UpdateCols+",").IndexOf(",Order_Code,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Order_Code")+"= @Order_Code");
			if((","+model.UpdateCols+",").IndexOf(",Order_id,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Order_id")+"= @Order_id");
			if((","+model.UpdateCols+",").IndexOf(",Product_id,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Product_id")+"= @Product_id");
			if((","+model.UpdateCols+",").IndexOf(",Remark,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Remark")+"= @Remark");
			if((","+model.UpdateCols+",").IndexOf(",Time_Add,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Time_Add")+"= @Time_Add");
			if((","+model.UpdateCols+",").IndexOf(",Type_id_Stock,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Type_id_Stock")+"= @Type_id_Stock");
			strSql.Append(string.Join(",", cols));
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", model.id),
					new SqlParameter("@Count", model.Count),
					new SqlParameter("@Order_Code", model.Order_Code),
					new SqlParameter("@Order_id", model.Order_id),
					new SqlParameter("@Product_id", model.Product_id),
					new SqlParameter("@Remark", model.Remark),
					new SqlParameter("@Time_Add", model.Time_Add),
					new SqlParameter("@Type_id_Stock", model.Type_id_Stock)};
			LB.DataAccess.DB.Instance.TextExecuteNonQuery(strSql.ToString().Replace(", where id=@id", " where id=@id"),parameters);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public void Delete(int id)
		{
		   StringBuilder strSql=new StringBuilder();
		   strSql.Append("delete from "+ TableName + " ");
		   strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", id)};

		LB.DataAccess.DB.Instance.TextExecuteNonQuery(strSql.ToString(),parameters);
		}
		/// <summary>
		/// 删除多条数据  by where条件
		/// </summary>
		public void Delete(string strWhere)
		{
		   if (strWhere.IndexOf("lbsql{") > 0)
		   {
		       SQLPara para = new SQLPara(strWhere, "", "");
		       Delete(para);
		       return;
		   }
		   StringBuilder strSql=new StringBuilder();
		   strSql.Append("delete from "+ TableName + " ");
		   strSql.Append(" where "+ strWhere +"");
		   LB.DataAccess.DB.Instance.TextExecuteNonQuery(strSql.ToString());
		}
		public void Delete(SQLPara para)
		{
		   StringBuilder strSql=new StringBuilder();
		   strSql.Append("delete from "+ TableName + " ");
		   if (para.Where != "")
		   strSql.Append(" where "+ para.Where +"");
		   LB.DataAccess.DB.Instance.TextExecuteNonQuery(strSql.ToString(),para.Para);
		}


		/// <summary>
		/// 得到一个对象实体 by id
		/// </summary>
		public Lebi_Product_Stock_Log GetModel(int id, int seconds=0)
		{
		   string strTableName = TableName;
		   string strFieldShow = "*";
		   string strWhere = "id="+id;
		   string cachestr = "";
		   string cachekey = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = "select * "+ TableName + " where id="+id+"|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return obj as Lebi_Product_Stock_Log;
		   }
		   Lebi_Product_Stock_Log model = null;
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReaderOne(strTableName, strFieldShow,  strWhere, null))
		   {
		       if(dataReader==null)
		           return null;
		       while (dataReader.Read())
		       {
		           model = ReaderBind(dataReader);
		           if (cachekey != "")
		               LB.DataAccess.DB.Instance.SetMemchche(cachekey, model, "Lebi_Product_Stock_Log",id , cachestr , seconds);
		           return model;
		       }
		   }
		   return null;
		}
		/// <summary>
		/// 得到一个对象实体 by where条件
		/// </summary>
		public Lebi_Product_Stock_Log GetModel(string strWhere, int seconds=0)
		{
		   if (strWhere.IndexOf("lbsql{") > 0)
		   {
		       SQLPara para = new SQLPara(strWhere, "", "");
		           return GetModel(para, seconds);
		   }
		   string strTableName =TableName;
		   string strFieldShow = "*";
		   string cachekey = "";
		   string cachestr = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = "select * "+ TableName + " where "+strWhere+"|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return obj as Lebi_Product_Stock_Log;
		   }
		   Lebi_Product_Stock_Log model = null;
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReaderOne(strTableName, strFieldShow, strWhere, null))
		   {
		       if(dataReader==null)
		           return null;
		       while (dataReader.Read())
		       {
		           model = ReaderBind(dataReader);
		           if (cachekey != "")
		               LB.DataAccess.DB.Instance.SetMemchche(cachekey, model, "Lebi_Product_Stock_Log",model.id , cachestr , seconds);
		           return model;
		       }
		   }
		   return null;
		}
		/// <summary>
		/// 得到一个对象实体 by SQLpara
		/// </summary>
		public Lebi_Product_Stock_Log GetModel(SQLPara para, int seconds=0)
		{
		   string strTableName = TableName;
		   string strFieldShow = "*";
		   string strWhere = para.Where;
		   string cachestr = "";
		   string cachekey = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = "select * "+ TableName + " where "+para.Where+"|"+para.ValueString+"|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return obj as Lebi_Product_Stock_Log;
		   }
		   Lebi_Product_Stock_Log model = null;
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReaderOne(strTableName, strFieldShow, strWhere, para.Para))
		   {
		       if(dataReader==null)
		           return null;
		       while (dataReader.Read())
		       {
		           model = ReaderBind(dataReader);
		           if (cachekey != "")
		               LB.DataAccess.DB.Instance.SetMemchche(cachekey, model, "Lebi_Product_Stock_Log",model.id , cachestr , seconds);
		           return model;
		       }
		   }
		   return null;
		}

		/// <summary>
		/// 获得数据列表-带分页
		/// </summary>
		public List<Lebi_Product_Stock_Log> GetList(string strWhere, string strFieldOrder, int PageSize, int page, int seconds=0)
		{
		   if (strWhere.IndexOf("lbsql{") > 0)
		   {
		       SQLPara para = new SQLPara(strWhere, strFieldOrder, "");
		       return GetList(para,PageSize,page,seconds);
		   }
		   string strTableName = TableName;
		   string strFieldKey = "id";
		   string strFieldShow = "*";
		   string cachestr = "";
		   string cachekey = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = strTableName + "|" + strFieldOrder + "|" + strWhere + "|" + PageSize + "|" + page + "|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return obj as List<Lebi_Product_Stock_Log>;
		   }
		   List<Lebi_Product_Stock_Log> list = new List<Lebi_Product_Stock_Log>();
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReader(strTableName, strFieldKey, strFieldShow, strFieldOrder, strWhere, PageSize, page))
		   {
		       if(dataReader!=null)
		       {
		           while (dataReader.Read())
		           {
		               list.Add(ReaderBind(dataReader));
		           }
		       }
		   }
		   if (cachekey != "" && list.Count > 0)
		         LB.DataAccess.DB.Instance.SetMemchche(cachekey, list, "Lebi_Product_Stock_Log", 0 , cachestr , seconds);
		   return list;
		}
		public List<Lebi_Product_Stock_Log> GetList(SQLPara para, int PageSize, int page, int seconds=0)
		{
		   string strTableName = TableName;
		   string strFieldKey = "id";
		   string strFieldShow = "*";
		   string strFieldOrder = para.Order;
		   string strWhere = para.Where;
		   string cachestr = "";
		   string cachekey = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = strTableName + "|" + strFieldOrder + "|" + strWhere + "|" + PageSize + "|" + page + "|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return obj as List<Lebi_Product_Stock_Log>;
		   }
		   List<Lebi_Product_Stock_Log> list = new List<Lebi_Product_Stock_Log>();
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReader(strTableName, strFieldKey, strFieldShow, strFieldOrder, strWhere, PageSize, page,para.Para))
		   {
		       if(dataReader!=null)
		       {
		           while (dataReader.Read())
		           {
		               list.Add(ReaderBind(dataReader));
		           }
		       }
		   }
		   if (cachekey != "" && list.Count > 0)
		         LB.DataAccess.DB.Instance.SetMemchche(cachekey, list, "Lebi_Product_Stock_Log", 0 , cachestr , seconds);
		   return list;
		}

		/// <summary>
		/// 获得数据列表-不带分页
		/// </summary>
		public List<Lebi_Product_Stock_Log> GetList(string strWhere,string strFieldOrder, int seconds=0)
		{
		   if (strWhere.IndexOf("lbsql{") > 0)
		   {
		       SQLPara para = new SQLPara(strWhere, strFieldOrder, "");
		       return GetList(para, seconds);
		   }
		   StringBuilder strSql=new StringBuilder();
		   strSql.Append("select * from "+ TableName + " ");
		   if(strWhere.Trim()!="")
		   {
		       strSql.Append(" where "+strWhere);
		   }
		   if(strFieldOrder.Trim()!="")
		   {
		       strSql.Append(" order by "+strFieldOrder);
		   }
		   string cachestr = "";
		   string cachekey = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = strSql.ToString() + "|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return obj as List<Lebi_Product_Stock_Log>;
		   }
		   List<Lebi_Product_Stock_Log> list = new List<Lebi_Product_Stock_Log>();
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReader(strSql.ToString()))
		   {
		       if(dataReader!=null)
		       {
		           while (dataReader.Read())
		           {
		               list.Add(ReaderBind(dataReader));
		           }
		       }
		   }
		   if (cachekey != "" && list.Count > 0)
		         LB.DataAccess.DB.Instance.SetMemchche(cachekey, list, "Lebi_Product_Stock_Log", 0 , cachestr , seconds);
		   return list;
		}
		public List<Lebi_Product_Stock_Log> GetList(SQLPara para, int seconds=0)
		{
		   string strTableName = TableName;
		   StringBuilder strSql=new StringBuilder();
		   strSql.Append("select " + para.ShowField + " from " + strTableName + "");
		   if (para != null)
		       strSql.Append(" where " + para.Where + "");
		   if (para.Order != "")
		       strSql.Append(" order by " + para.Order + "");
		   string cachestr = "";
		   string cachekey = "";
		   if (BaseUtils.BaseUtilsInstance.MemcacheInstance != null && seconds > 0)
		   {
		       cachestr = strSql.ToString() + "|" + para.ValueString + "|" + seconds;
		       cachekey = LB.Tools.Utils.MD5(cachestr);
		       var obj = LB.DataAccess.DB.Instance.GetMemchche(cachekey);
		       if (obj != null)
		           return obj as List<Lebi_Product_Stock_Log>;
		   }
		   List<Lebi_Product_Stock_Log> list = new List<Lebi_Product_Stock_Log>();
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReader(strSql.ToString(), para.Para))
		   {
		       if(dataReader!=null)
		       {
		           while (dataReader.Read())
		           {
		               list.Add(ReaderBind(dataReader));
		           }
		       }
		   }
		   if (cachekey != "" && list.Count > 0)
		         LB.DataAccess.DB.Instance.SetMemchche(cachekey, list, "Lebi_Product_Stock_Log", 0 , cachestr , seconds);
		   return list;
		}


		/// <summary>
		/// 绑定对象表单
		/// </summary>
		public Lebi_Product_Stock_Log BindForm(Lebi_Product_Stock_Log model)
		{
			if (HttpContext.Current.Request["Count"] != null)
				model.Count=LB.Tools.RequestTool.RequestDecimal("Count",0);
			if (HttpContext.Current.Request["Order_Code"] != null)
				model.Order_Code=LB.Tools.RequestTool.RequestString("Order_Code");
			if (HttpContext.Current.Request["Order_id"] != null)
				model.Order_id=LB.Tools.RequestTool.RequestInt("Order_id",0);
			if (HttpContext.Current.Request["Product_id"] != null)
				model.Product_id=LB.Tools.RequestTool.RequestInt("Product_id",0);
			if (HttpContext.Current.Request["Remark"] != null)
				model.Remark=LB.Tools.RequestTool.RequestString("Remark");
			if (HttpContext.Current.Request["Time_Add"] != null)
				model.Time_Add=LB.Tools.RequestTool.RequestTime("Time_Add", System.DateTime.Now);
			if (HttpContext.Current.Request["Type_id_Stock"] != null)
				model.Type_id_Stock=LB.Tools.RequestTool.RequestInt("Type_id_Stock",0);
				return model;
		}
		/// <summary>
		/// 安全方式绑定对象表单
		/// </summary>
		public Lebi_Product_Stock_Log SafeBindForm(Lebi_Product_Stock_Log model)
		{
			if (HttpContext.Current.Request["Count"] != null)
				model.Count=LB.Tools.RequestTool.RequestDecimal("Count",0);
			if (HttpContext.Current.Request["Order_Code"] != null)
				model.Order_Code=LB.Tools.RequestTool.RequestSafeString("Order_Code");
			if (HttpContext.Current.Request["Order_id"] != null)
				model.Order_id=LB.Tools.RequestTool.RequestInt("Order_id",0);
			if (HttpContext.Current.Request["Product_id"] != null)
				model.Product_id=LB.Tools.RequestTool.RequestInt("Product_id",0);
			if (HttpContext.Current.Request["Remark"] != null)
				model.Remark=LB.Tools.RequestTool.RequestSafeString("Remark");
			if (HttpContext.Current.Request["Time_Add"] != null)
				model.Time_Add=LB.Tools.RequestTool.RequestTime("Time_Add", System.DateTime.Now);
			if (HttpContext.Current.Request["Type_id_Stock"] != null)
				model.Type_id_Stock=LB.Tools.RequestTool.RequestInt("Type_id_Stock",0);
				return model;
		}


		/// <summary>
		/// 对象实体绑定数据
		/// </summary>
		public Lebi_Product_Stock_Log ReaderBind(IDataReader dataReader)
		{
			Lebi_Product_Stock_Log model=new Lebi_Product_Stock_Log();
			object ojb; 
			ojb = dataReader["id"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.id= Convert.ToInt32(ojb);
			}
			ojb = dataReader["Count"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.Count=(decimal)ojb;
			}
			model.Order_Code=dataReader["Order_Code"].ToString();
			ojb = dataReader["Order_id"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.Order_id= Convert.ToInt32(ojb);
			}
			ojb = dataReader["Product_id"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.Product_id= Convert.ToInt32(ojb);
			}
			model.Remark=dataReader["Remark"].ToString();
			ojb = dataReader["Time_Add"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.Time_Add=(DateTime)ojb;
			}
			ojb = dataReader["Type_id_Stock"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.Type_id_Stock= Convert.ToInt32(ojb);
			}
			return model;
		}

		#endregion  成员方法
	}
}

