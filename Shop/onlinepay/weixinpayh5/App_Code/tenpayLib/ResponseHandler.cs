using System.Collections;
using System.Collections.Specialized;
using System.Web;
using System.Xml;
using System.Text;

namespace weixinpayh5
{
    /** 
    '============================================================================
    'api˵����
    'getKey()/setKey(),��ȡ/������Կ
    'getParameter()/setParameter(),��ȡ/���ò���ֵ
    'getAllParameters(),��ȡ���в���
    'isTenpaySign(),�Ƿ���ȷ��ǩ��,true:�� false:��
    'isWXsign(),�Ƿ���ȷ��ǩ��,true:�� false:��
    ' * isWXsignfeedback�ж�΢��άȨǩ��
    ' *getDebugInfo(),��ȡdebug��Ϣ
    '============================================================================
    */

    public class ResponseHandler
    {
        // ��Կ 
        private string key;
        // ����ǩ���Ĳ����б�
        private static string SignField = "appid,appkey,timestamp,openid,noncestr,issubscribe";
        // ΢�ŷ��������뷽ʽ
        private string charset = "gb2312";

        //����ǩ���Ĳ����б�
        protected HttpContext httpContext;
        //protected Hashtable parameters;
        private Hashtable xmlMap;

        //��ȡҳ���ύ��get��post����
        public ResponseHandler(HttpContext httpContext)
        {
            //parameters = new Hashtable();
            xmlMap = new Hashtable();

            this.httpContext = httpContext;
            //NameValueCollection collection;
            //post data
            //if (this.httpContext.Request.HttpMethod == "POST")
            //{
            //    collection = this.httpContext.Request.Form;
            //    foreach (string k in collection)
            //    {
            //        string v = collection[k];
            //        setParameter(k, v);
            //    }
            //}
            //query string
            //collection = this.httpContext.Request.QueryString;
            //foreach (string k in collection)
            //{
            //    string v = collection[k];
            //    setParameter(k, v);
            //}
            if (this.httpContext.Request.InputStream.Length > 0)
            {
                var xmlDoc = new XmlDocument();
                xmlDoc.Load(this.httpContext.Request.InputStream);
                XmlNode root = xmlDoc.SelectSingleNode("xml");
                XmlNodeList xnl = root.ChildNodes;

                foreach (XmlNode xnf in xnl)
                {
                    xmlMap.Add(xnf.Name, xnf.InnerText);
                }
            }
        }

        #region ����=======================================
        /// <summary>
        /// ��ʼ������
        /// </summary>
        public virtual void init()
        {
        }

        /// <summary>
        /// ��ȡ��Կ
        /// </summary>
        /// <returns></returns>
        public string getKey()
        {
            return key;
        }

        /// <summary>
        /// ������Կ
        /// </summary>
        /// <param name="key"></param>
        public void setKey(string key)
        {
            this.key = key;
        }

        /// <summary>
        /// ��ȡ����ֵ
        /// </summary>
        /// <param name="parameter"></param>
        /// <returns></returns>
        public string getParameter(string parameter)
        {
            var s = (string)xmlMap[parameter];
            return (null == s) ? "" : s;
        }

        /// <summary>
        /// ���ò���ֵ
        /// </summary>
        /// <param name="parameter"></param>
        /// <param name="parameterValue"></param>
        public void setParameter(string parameter, string parameterValue)
        {
            //if (parameter != null && parameter != "")
            //{
            //    if (parameters.Contains(parameter))
            //    {
            //        parameters.Remove(parameter);
            //    }

            //    parameters.Add(parameter, parameterValue);
            //}
        }
        #endregion

        #region ��������===================================
        /// <summary>
        /// �ж�΢��ǩ��
        /// </summary>
        /// <returns></returns>
        public virtual bool isWXsign(out string error)
        {
            StringBuilder sb = new StringBuilder();
            Hashtable signMap = new Hashtable();
            foreach (string k in xmlMap.Keys)
            {
                if (k != "sign")
                {
                    signMap.Add(k.ToLower(), xmlMap[k]);
                }
            }

            ArrayList akeys = new ArrayList(signMap.Keys);
            akeys.Sort();

            foreach (string k in akeys)
            {
                string v = (string)signMap[k];
                sb.Append(k + "=" + v + "&");
            }
            sb.Append("key=" + this.key);

            string sign = MD5Util.GetMD5(sb.ToString(), charset).ToString().ToUpper();
            error = "sign = " + sign + "\r\n xmlMap[sign]=" + xmlMap["sign"].ToString();
            return sign.Equals(xmlMap["sign"]);

        }

        /// <summary>
        /// �ж�΢��άȨǩ��
        /// </summary>
        /// <returns></returns>
        public virtual bool isWXsignfeedback()
        {
            return true;
            //StringBuilder sb = new StringBuilder();
            //Hashtable signMap = new Hashtable();

            //foreach (string k in xmlMap.Keys)
            //{
            //    if (SignField.IndexOf(k.ToLower()) != -1)
            //    {
            //        signMap.Add(k.ToLower(), xmlMap[k]);
            //    }
            //}
            //signMap.Add("appkey", this.appkey);


            //ArrayList akeys = new ArrayList(signMap.Keys);
            //akeys.Sort();

            //foreach (string k in akeys)
            //{
            //    string v = (string)signMap[k];
            //    if (sb.Length == 0)
            //    {
            //        sb.Append(k + "=" + v);
            //    }
            //    else
            //    {
            //        sb.Append("&" + k + "=" + v);
            //    }
            //}

            //string sign = SHA1Util.getSha1(sb.ToString()).ToString().ToLower();

            //this.setDebugInfo(sb.ToString() + " => SHA1 sign:" + sign);

            //return sign.Equals(xmlMap["AppSignature"]);

        }

        /// <summary>
        /// ��ȡ���뷽ʽ
        /// </summary>
        /// <returns></returns>
        protected virtual string getCharset()
        {
            return httpContext.Request.ContentEncoding.BodyName;
        }
        #endregion
    }
}