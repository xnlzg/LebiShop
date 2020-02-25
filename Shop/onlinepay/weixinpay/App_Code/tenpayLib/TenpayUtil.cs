using System;
using System.Text;
using System.Web;
using Shop.Model;using DB.LebiShop;
using Shop.Bussiness;
using LB.Tools;
namespace weixinpay
{
	/// <summary>
	/// TenpayUtil ��ժҪ˵����
    /// �����ļ�
	/// </summary>
	public class TenpayUtil
	{
        public string tenpay = "1";
        public string mch_id = "";                   //�̻���
        public string key = "";  //��Կ
        public string appid = "";//appid
        public string appkey = "";
        public string tenpay_notify = ""; //֧����ɺ�Ļص�����ҳ��,*�滻��notify_url.asp����·��

		public TenpayUtil(Lebi_Order order)
		{
            Lebi_OnlinePay onlinepay = B_Lebi_OnlinePay.GetModel("id = " + order.OnlinePay_id + "");
            if (onlinepay == null)
            {
                Log.Add("����֧���ӿ� weixinpay ���ô���");
                return;
            }
            Shop.Bussiness.Site site = new Shop.Bussiness.Site();
            //B_BaseConfig bconfig = new B_BaseConfig();
            //BaseConfig SYS = bconfig.LoadConfig();
            mch_id = onlinepay.UserName;
            key = onlinepay.UserKey;
            appid = onlinepay.Appid; // SYS.platform_weixin_id;
            appkey = onlinepay.UserKey;
            tenpay_notify = "http://" + RequestTool.GetRequestDomain() + site.WebPath + "/onlinepay/weixinpay/payNotifyUrl.aspx";
		}
        public static string getNoncestr()
        {
            Random random = new Random();
            return MD5Util.GetMD5(random.Next(1000).ToString(), "utf-8");
        }


        public static string getTimestamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds).ToString();
        }
      

		/** ���ַ�������URL���� */
		public static string UrlEncode(string instr, string charset)
		{
			//return instr;
			if(instr == null || instr.Trim() == "")
				return "";
			else
			{
				string res;
				
				try
				{
					res = HttpUtility.UrlEncode(instr,Encoding.GetEncoding(charset));

				}
				catch (Exception ex)
				{
					res = HttpUtility.UrlEncode(instr,Encoding.GetEncoding("GB2312"));
				}
				
		
				return res;
			}
		}

		/** ���ַ�������URL���� */
		public static string UrlDecode(string instr, string charset)
		{
			if(instr == null || instr.Trim() == "")
				return "";
			else
			{
				string res;
				
				try
				{
					res = HttpUtility.UrlDecode(instr,Encoding.GetEncoding(charset));

				}
				catch (Exception ex)
				{
					res = HttpUtility.UrlDecode(instr,Encoding.GetEncoding("GB2312"));
				}
				
		
				return res;

			}
		}
       

		/** ȡʱ��������漴��,�滻���׵����еĺ�10λ��ˮ�� */
		public static UInt32 UnixStamp()
		{
			TimeSpan ts = DateTime.Now - TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
			return Convert.ToUInt32(ts.TotalSeconds);
		}
		/** ȡ����� */
		public static string BuildRandomStr(int length) 
		{
			Random rand = new Random();

			int num = rand.Next();

			string str = num.ToString();

			if(str.Length > length)
			{
				str = str.Substring(0,length);
			}
			else if(str.Length < length)
			{
				int n = length - str.Length;
				while(n > 0)
				{
					str.Insert(0, "0");
					n--;
				}
			}
			
			return str;
		}
       
	}
}