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
	/// 数据访问类D_Lebi_Supplier_UserGroup。
	/// </summary>
	public partial class D_Lebi_Supplier_UserGroup
	{
		static D_Lebi_Supplier_UserGroup _Instance;
		public static D_Lebi_Supplier_UserGroup Instance
		{
		   get
		   {
		        if (_Instance == null)
		        {
		            _Instance = new D_Lebi_Supplier_UserGroup("Lebi_Supplier_UserGroup");
		        }
		        return _Instance;
		    }
		    set
		    {
		        _Instance = value;
		    }
		}
		string TableName = "Lebi_Supplier_UserGroup";
		public D_Lebi_Supplier_UserGroup(string tablename)
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
		           LB.DataAccess.DB.Instance.SetMemchche(cachekey, val, "Lebi_Supplier_UserGroup", 0 , cachestr , seconds);
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
		       LB.DataAccess.DB.Instance.SetMemchche(cachekey, val, "Lebi_Supplier_UserGroup", 0 , cachestr , seconds);
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
		       LB.DataAccess.DB.Instance.SetMemchche(cachekey, val, "Lebi_Supplier_UserGroup" , 0 , cachestr , seconds);
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
		       LB.DataAccess.DB.Instance.SetMemchche(cachekey, val, "Lebi_Supplier_UserGroup", 0 , cachestr,seconds);
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
		public int Add(Lebi_Supplier_UserGroup model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into "+ TableName + " (");
			strSql.Append(LB.DataAccess.DB.BaseUtilsInstance.ColName("Description")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("IsShow")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Limit_Codes")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Limit_ids")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Menu_ids")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Menu_ids_index")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Name")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Sort")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Supplier_id")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Time_Add")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("Time_Edit")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("User_id_Add")+","+LB.DataAccess.DB.BaseUtilsInstance.ColName("User_id_Edit")+")");
			strSql.Append(" values (");
			strSql.Append("@Description,@IsShow,@Limit_Codes,@Limit_ids,@Menu_ids,@Menu_ids_index,@Name,@Sort,@Supplier_id,@Time_Add,@Time_Edit,@User_id_Add,@User_id_Edit);select @@identity;");
			SqlParameter[] parameters = {
					new SqlParameter("@Description", model.Description),
					new SqlParameter("@IsShow", model.IsShow),
					new SqlParameter("@Limit_Codes", model.Limit_Codes),
					new SqlParameter("@Limit_ids", model.Limit_ids),
					new SqlParameter("@Menu_ids", model.Menu_ids),
					new SqlParameter("@Menu_ids_index", model.Menu_ids_index),
					new SqlParameter("@Name", model.Name),
					new SqlParameter("@Sort", model.Sort),
					new SqlParameter("@Supplier_id", model.Supplier_id),
					new SqlParameter("@Time_Add", model.Time_Add),
					new SqlParameter("@Time_Edit", model.Time_Edit),
					new SqlParameter("@User_id_Add", model.User_id_Add),
					new SqlParameter("@User_id_Edit", model.User_id_Edit)};

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
		public void Update(Lebi_Supplier_UserGroup model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update "+ TableName + " set ");
			List<string> cols = new List<string>();
			if((","+model.UpdateCols+",").IndexOf(",Description,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Description")+"= @Description");
			if((","+model.UpdateCols+",").IndexOf(",IsShow,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("IsShow")+"= @IsShow");
			if((","+model.UpdateCols+",").IndexOf(",Limit_Codes,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Limit_Codes")+"= @Limit_Codes");
			if((","+model.UpdateCols+",").IndexOf(",Limit_ids,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Limit_ids")+"= @Limit_ids");
			if((","+model.UpdateCols+",").IndexOf(",Menu_ids,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Menu_ids")+"= @Menu_ids");
			if((","+model.UpdateCols+",").IndexOf(",Menu_ids_index,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Menu_ids_index")+"= @Menu_ids_index");
			if((","+model.UpdateCols+",").IndexOf(",Name,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Name")+"= @Name");
			if((","+model.UpdateCols+",").IndexOf(",Sort,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Sort")+"= @Sort");
			if((","+model.UpdateCols+",").IndexOf(",Supplier_id,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Supplier_id")+"= @Supplier_id");
			if((","+model.UpdateCols+",").IndexOf(",Time_Add,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Time_Add")+"= @Time_Add");
			if((","+model.UpdateCols+",").IndexOf(",Time_Edit,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("Time_Edit")+"= @Time_Edit");
			if((","+model.UpdateCols+",").IndexOf(",User_id_Add,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("User_id_Add")+"= @User_id_Add");
			if((","+model.UpdateCols+",").IndexOf(",User_id_Edit,")>-1 || model.UpdateCols=="")
			   cols.Add(LB.DataAccess.DB.BaseUtilsInstance.ColName("User_id_Edit")+"= @User_id_Edit");
			strSql.Append(string.Join(",", cols));
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", model.id),
					new SqlParameter("@Description", model.Description),
					new SqlParameter("@IsShow", model.IsShow),
					new SqlParameter("@Limit_Codes", model.Limit_Codes),
					new SqlParameter("@Limit_ids", model.Limit_ids),
					new SqlParameter("@Menu_ids", model.Menu_ids),
					new SqlParameter("@Menu_ids_index", model.Menu_ids_index),
					new SqlParameter("@Name", model.Name),
					new SqlParameter("@Sort", model.Sort),
					new SqlParameter("@Supplier_id", model.Supplier_id),
					new SqlParameter("@Time_Add", model.Time_Add),
					new SqlParameter("@Time_Edit", model.Time_Edit),
					new SqlParameter("@User_id_Add", model.User_id_Add),
					new SqlParameter("@User_id_Edit", model.User_id_Edit)};
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
		public Lebi_Supplier_UserGroup GetModel(int id, int seconds=0)
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
		           return obj as Lebi_Supplier_UserGroup;
		   }
		   Lebi_Supplier_UserGroup model = null;
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReaderOne(strTableName, strFieldShow,  strWhere, null))
		   {
		       if(dataReader==null)
		           return null;
		       while (dataReader.Read())
		       {
		           model = ReaderBind(dataReader);
		           if (cachekey != "")
		               LB.DataAccess.DB.Instance.SetMemchche(cachekey, model, "Lebi_Supplier_UserGroup",id , cachestr , seconds);
		           return model;
		       }
		   }
		   return null;
		}
		/// <summary>
		/// 得到一个对象实体 by where条件
		/// </summary>
		public Lebi_Supplier_UserGroup GetModel(string strWhere, int seconds=0)
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
		           return obj as Lebi_Supplier_UserGroup;
		   }
		   Lebi_Supplier_UserGroup model = null;
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReaderOne(strTableName, strFieldShow, strWhere, null))
		   {
		       if(dataReader==null)
		           return null;
		       while (dataReader.Read())
		       {
		           model = ReaderBind(dataReader);
		           if (cachekey != "")
		               LB.DataAccess.DB.Instance.SetMemchche(cachekey, model, "Lebi_Supplier_UserGroup",model.id , cachestr , seconds);
		           return model;
		       }
		   }
		   return null;
		}
		/// <summary>
		/// 得到一个对象实体 by SQLpara
		/// </summary>
		public Lebi_Supplier_UserGroup GetModel(SQLPara para, int seconds=0)
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
		           return obj as Lebi_Supplier_UserGroup;
		   }
		   Lebi_Supplier_UserGroup model = null;
		   using (IDataReader dataReader = LB.DataAccess.DB.Instance.TextExecuteReaderOne(strTableName, strFieldShow, strWhere, para.Para))
		   {
		       if(dataReader==null)
		           return null;
		       while (dataReader.Read())
		       {
		           model = ReaderBind(dataReader);
		           if (cachekey != "")
		               LB.DataAccess.DB.Instance.SetMemchche(cachekey, model, "Lebi_Supplier_UserGroup",model.id , cachestr , seconds);
		           return model;
		       }
		   }
		   return null;
		}

		/// <summary>
		/// 获得数据列表-带分页
		/// </summary>
		public List<Lebi_Supplier_UserGroup> GetList(string strWhere, string strFieldOrder, int PageSize, int page, int seconds=0)
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
		           return obj as List<Lebi_Supplier_UserGroup>;
		   }
		   List<Lebi_Supplier_UserGroup> list = new List<Lebi_Supplier_UserGroup>();
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
		         LB.DataAccess.DB.Instance.SetMemchche(cachekey, list, "Lebi_Supplier_UserGroup", 0 , cachestr , seconds);
		   return list;
		}
		public List<Lebi_Supplier_UserGroup> GetList(SQLPara para, int PageSize, int page, int seconds=0)
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
		           return obj as List<Lebi_Supplier_UserGroup>;
		   }
		   List<Lebi_Supplier_UserGroup> list = new List<Lebi_Supplier_UserGroup>();
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
		         LB.DataAccess.DB.Instance.SetMemchche(cachekey, list, "Lebi_Supplier_UserGroup", 0 , cachestr , seconds);
		   return list;
		}

		/// <summary>
		/// 获得数据列表-不带分页
		/// </summary>
		public List<Lebi_Supplier_UserGroup> GetList(string strWhere,string strFieldOrder, int seconds=0)
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
		           return obj as List<Lebi_Supplier_UserGroup>;
		   }
		   List<Lebi_Supplier_UserGroup> list = new List<Lebi_Supplier_UserGroup>();
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
		         LB.DataAccess.DB.Instance.SetMemchche(cachekey, list, "Lebi_Supplier_UserGroup", 0 , cachestr , seconds);
		   return list;
		}
		public List<Lebi_Supplier_UserGroup> GetList(SQLPara para, int seconds=0)
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
		           return obj as List<Lebi_Supplier_UserGroup>;
		   }
		   List<Lebi_Supplier_UserGroup> list = new List<Lebi_Supplier_UserGroup>();
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
		         LB.DataAccess.DB.Instance.SetMemchche(cachekey, list, "Lebi_Supplier_UserGroup", 0 , cachestr , seconds);
		   return list;
		}


		/// <summary>
		/// 绑定对象表单
		/// </summary>
		public Lebi_Supplier_UserGroup BindForm(Lebi_Supplier_UserGroup model)
		{
			if (HttpContext.Current.Request["Description"] != null)
				model.Description=LB.Tools.RequestTool.RequestString("Description");
			if (HttpContext.Current.Request["IsShow"] != null)
				model.IsShow=LB.Tools.RequestTool.RequestInt("IsShow",0);
			if (HttpContext.Current.Request["Limit_Codes"] != null)
				model.Limit_Codes=LB.Tools.RequestTool.RequestString("Limit_Codes");
			if (HttpContext.Current.Request["Limit_ids"] != null)
				model.Limit_ids=LB.Tools.RequestTool.RequestString("Limit_ids");
			if (HttpContext.Current.Request["Menu_ids"] != null)
				model.Menu_ids=LB.Tools.RequestTool.RequestString("Menu_ids");
			if (HttpContext.Current.Request["Menu_ids_index"] != null)
				model.Menu_ids_index=LB.Tools.RequestTool.RequestString("Menu_ids_index");
			if (HttpContext.Current.Request["Name"] != null)
				model.Name=LB.Tools.RequestTool.RequestString("Name");
			if (HttpContext.Current.Request["Sort"] != null)
				model.Sort=LB.Tools.RequestTool.RequestInt("Sort",0);
			if (HttpContext.Current.Request["Supplier_id"] != null)
				model.Supplier_id=LB.Tools.RequestTool.RequestInt("Supplier_id",0);
			if (HttpContext.Current.Request["Time_Add"] != null)
				model.Time_Add=LB.Tools.RequestTool.RequestTime("Time_Add", System.DateTime.Now);
			if (HttpContext.Current.Request["Time_Edit"] != null)
				model.Time_Edit=LB.Tools.RequestTool.RequestTime("Time_Edit", System.DateTime.Now);
			if (HttpContext.Current.Request["User_id_Add"] != null)
				model.User_id_Add=LB.Tools.RequestTool.RequestInt("User_id_Add",0);
			if (HttpContext.Current.Request["User_id_Edit"] != null)
				model.User_id_Edit=LB.Tools.RequestTool.RequestInt("User_id_Edit",0);
				return model;
		}
		/// <summary>
		/// 安全方式绑定对象表单
		/// </summary>
		public Lebi_Supplier_UserGroup SafeBindForm(Lebi_Supplier_UserGroup model)
		{
			if (HttpContext.Current.Request["Description"] != null)
				model.Description=LB.Tools.RequestTool.RequestSafeString("Description");
			if (HttpContext.Current.Request["IsShow"] != null)
				model.IsShow=LB.Tools.RequestTool.RequestInt("IsShow",0);
			if (HttpContext.Current.Request["Limit_Codes"] != null)
				model.Limit_Codes=LB.Tools.RequestTool.RequestSafeString("Limit_Codes");
			if (HttpContext.Current.Request["Limit_ids"] != null)
				model.Limit_ids=LB.Tools.RequestTool.RequestSafeString("Limit_ids");
			if (HttpContext.Current.Request["Menu_ids"] != null)
				model.Menu_ids=LB.Tools.RequestTool.RequestSafeString("Menu_ids");
			if (HttpContext.Current.Request["Menu_ids_index"] != null)
				model.Menu_ids_index=LB.Tools.RequestTool.RequestSafeString("Menu_ids_index");
			if (HttpContext.Current.Request["Name"] != null)
				model.Name=LB.Tools.RequestTool.RequestSafeString("Name");
			if (HttpContext.Current.Request["Sort"] != null)
				model.Sort=LB.Tools.RequestTool.RequestInt("Sort",0);
			if (HttpContext.Current.Request["Supplier_id"] != null)
				model.Supplier_id=LB.Tools.RequestTool.RequestInt("Supplier_id",0);
			if (HttpContext.Current.Request["Time_Add"] != null)
				model.Time_Add=LB.Tools.RequestTool.RequestTime("Time_Add", System.DateTime.Now);
			if (HttpContext.Current.Request["Time_Edit"] != null)
				model.Time_Edit=LB.Tools.RequestTool.RequestTime("Time_Edit", System.DateTime.Now);
			if (HttpContext.Current.Request["User_id_Add"] != null)
				model.User_id_Add=LB.Tools.RequestTool.RequestInt("User_id_Add",0);
			if (HttpContext.Current.Request["User_id_Edit"] != null)
				model.User_id_Edit=LB.Tools.RequestTool.RequestInt("User_id_Edit",0);
				return model;
		}


		/// <summary>
		/// 对象实体绑定数据
		/// </summary>
		public Lebi_Supplier_UserGroup ReaderBind(IDataReader dataReader)
		{
			Lebi_Supplier_UserGroup model=new Lebi_Supplier_UserGroup();
			object ojb; 
			ojb = dataReader["id"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.id= Convert.ToInt32(ojb);
			}
			model.Description=dataReader["Description"].ToString();
			ojb = dataReader["IsShow"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.IsShow= Convert.ToInt32(ojb);
			}
			model.Limit_Codes=dataReader["Limit_Codes"].ToString();
			model.Limit_ids=dataReader["Limit_ids"].ToString();
			model.Menu_ids=dataReader["Menu_ids"].ToString();
			model.Menu_ids_index=dataReader["Menu_ids_index"].ToString();
			model.Name=dataReader["Name"].ToString();
			ojb = dataReader["Sort"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.Sort= Convert.ToInt32(ojb);
			}
			ojb = dataReader["Supplier_id"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.Supplier_id= Convert.ToInt32(ojb);
			}
			ojb = dataReader["Time_Add"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.Time_Add=(DateTime)ojb;
			}
			ojb = dataReader["Time_Edit"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.Time_Edit=(DateTime)ojb;
			}
			ojb = dataReader["User_id_Add"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.User_id_Add= Convert.ToInt32(ojb);
			}
			ojb = dataReader["User_id_Edit"];
			if(ojb != null && ojb != DBNull.Value)
			{
				model.User_id_Edit= Convert.ToInt32(ojb);
			}
			return model;
		}

		#endregion  成员方法
	}
}

