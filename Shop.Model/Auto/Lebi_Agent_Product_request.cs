﻿using System;
namespace Shop.Model
{
	[Serializable]
	public class Lebi_Agent_Product_request
	{
		#region Model
		private int _id=0;
		private int _user_id=0;
		private string _user_username="";
		private int _product_id_old=0;
		private int _product_id=0;
		private int _type_id_agentproductrequeststatus=0;
		private DateTime _time_add=DateTime.Now;
		private DateTime _time_manage=DateTime.Now;
		private int _admin_id=0;
		private string _admin_username="";
		private string _remark="";
		private Lebi_Agent_Product_request _model;
		/// <summary>
		/// 
		/// </summary>
		public int id
		{
			set{ _id=value;}
			get{return _id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int User_id
		{
			set{ _user_id=value;}
			get{return _user_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string User_UserName
		{
			set{ _user_username=value;}
			get{return _user_username;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int Product_id_old
		{
			set{ _product_id_old=value;}
			get{return _product_id_old;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int Product_id
		{
			set{ _product_id=value;}
			get{return _product_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int Type_id_AgentProductRequestStatus
		{
			set{ _type_id_agentproductrequeststatus=value;}
			get{return _type_id_agentproductrequeststatus;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime Time_add
		{
			set{ _time_add=value;}
			get{return _time_add;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime Time_manage
		{
			set{ _time_manage=value;}
			get{return _time_manage;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int Admin_id
		{
			set{ _admin_id=value;}
			get{return _admin_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Admin_UserName
		{
			set{ _admin_username=value;}
			get{return _admin_username;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Remark
		{
			set{ _remark=value;}
			get{return _remark;}
		}
		#endregion

	}
}

