using System;
using System.Collections.Generic;
using System.Text;

namespace Shop.Model
{
    [Serializable]
    public class BaseConfig_Supplier
    {

        public BaseConfig_Supplier() { }
        #region վ������
        /// <summary>
        /// ��վ����
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// ��վTITLE
        /// </summary>
        public string Title { get; set; }
        /// <summary>
        /// ��վ�ؼ���
        /// </summary>
        public string Keywords { get; set; }
        /// <summary>
        /// ��վ����
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// ����Э��
        /// </summary>
        public string ServiceP { get; set; }
        /// <summary>
        /// ѭ������
        /// </summary>
        public string Loop { get; set; }
        /// <summary>
        /// ��վlogo
        /// </summary>
        public string Logoimg { get; set; }
        /// <summary>
        /// �ʼ����ͷ�����
        /// </summary>
        public string SmtpAddress { get; set; }
        /// <summary>
        /// �ʼ��ʺ�
        /// </summary>
        public string MailName { get; set; }
        /// <summary>
        /// �����ʼ�����
        /// </summary>
        public string AdminMailAddress { get; set; }
        public string MailAddress { get; set; }
        public string MailDisplayName { get; set; }
        public string MailPort { get; set; }
        public string MailIsSSL { get; set; }
        /// <summary>
        /// �ʼ�����
        /// </summary>
        public string MailPassWord { get; set; }
        /// <summary>
        /// �ʼ����-��¼��Щ������Ҫ�Զ������ʼ�
        /// </summary>
        public string MailSign { get; set; }
        /// <summary>
        /// �ʼ����-��¼��Щ������Ҫ�Զ������ʼ�
        /// </summary>
        public string AdminMailSign { get; set; }
        /// <summary>
        /// QQ
        /// </summary>
        public string QQ { get; set; }
        /// <summary>
        /// �绰
        /// </summary>
        public string Phone { get; set; }
        /// <summary>
        /// ����
        /// </summary>
        public string Fax { get; set; }
        /// <summary>
        /// �ʼ�
        /// </summary>
        public string Email { get; set; }
        /// <summary>
        /// �ײ���Ȩ��Ϣ
        /// </summary>
        public string Copyright { get; set; }
        /// <summary>
        /// �ײ�HTML
        /// </summary>
        public string FootHtml { get; set; }
        /// <summary>
        /// ��վ����
        /// </summary>
        public string Domain { get; set; }
        /// <summary>
        /// �������� 1��0��
        /// </summary>
        public string CommFlag { get; set; }
        /// <summary>
        /// ��ֹ���ʱ�־ 0�ر�1����
        /// </summary>
        public string VisitTimeFlag { get; set; }
        /// <summary>
        /// ��ֹ����ʱ���
        /// </summary>
        public string VisitTime { get; set; }
        /// <summary>
        /// ��½��֤��� ��������
        /// </summary>
        public string OpenpwdFlag { get; set; }
        /// <summary>
        /// ��½��֤����???
        /// </summary>
        public string Openpwd { get; set; }
        /// <summary>
        /// �����־ 0��������1�������
        /// </summary>
        public string ClickFlag { get; set; }
        /// <summary>
        /// �����������������ֵ
        /// </summary>
        public string ClickNum1 { get; set; }
        /// <summary>
        /// ����������������ֵ
        /// </summary>
        public string ClickNum2 { get; set; }
        /// <summary>
        /// ����������־ 0��������1�������
        /// </summary>
        public string SalesFlag { get; set; }
        /// <summary>
        /// ������������������ֵ
        /// </summary>
        public string SalesNum1 { get; set; }
        /// <summary>
        /// �����������������ֵ
        /// </summary>
        public string SalesNum2 { get; set; }
        /// <summary>
        /// ���˹ؼ���
        /// </summary>
        public string Filter { get; set; }
        /// <summary>
        /// ��ʿ
        /// </summary>
        public string Tieshi { get; set; }
        /// <summary>
        /// ��Ʊ��� 0�ر�1����
        /// </summary>
        public string BillFlag { get; set; }
        /// <summary>
        /// α��̬��� 0�ر�1����
        /// </summary>
        public string UrlFlag { get; set; }
        /// <summary>
        /// ��̬��� 0�ر�1����
        /// </summary>
        public string HtmlFlag { get; set; }
        /// <summary>
        /// ά����� 0�ر�1����
        /// </summary>
        public string WeiHuFlag { get; set; }
        /// <summary>
        /// ά��˵������
        /// </summary>
        public string Wornings { get; set; }
        /// <summary>
        /// �ͷ��������
        /// </summary>
        public string ServicePanel { get; set; }
        /// <summary>
        /// ���100KEY
        /// </summary>
        public string KuaiDi100 { get; set; }
        /// <summary>
        /// ���100״̬
        /// </summary>
        public string KuaiDi100Status { get; set; }
        /// <summary>
        /// ��Ʒ���ֽ�������
        /// </summary>
        public string CommentPoint { get; set; }
        /// <summary>
        /// ʧ���ʼ��ظ�����
        /// </summary>
        public string Mail_SendTop { get; set; }
        /// <summary>
        /// �ʼ��ظ�������ȡʱ����
        /// ��λΪ����
        /// </summary>
        public string Mail_SendTime { get; set; }
        /// <summary>
        /// ���ݿⱸ��ʱ����
        /// ��λΪ����
        /// </summary>
        public string DataBase_BackUpTime { get; set; }
        /// <summary>
        /// ���ݿⱸ��·��
        /// </summary>
        public string DataBase_BackPath { get; set; }
        /// <summary>
        /// ���ݿⱸ���ļ���չ��
        /// </summary>
        public string DataBase_BackName { get; set; }

        public int ImageBigWidth { get; set; }
        public int ImageBigHeight { get; set; }
        public int ImageMediumWidth { get; set; }
        public int ImageMediumHeight { get; set; }
        public int ImageSmallWidth { get; set; }
        public int ImageSmallHeight { get; set; }
        /// <summary>
        /// �ϴ�����
        /// </summary>
        public string UpLoadLimit { get; set; }
        /// <summary>
        /// �ϴ�·��
        /// </summary>
        public string UpLoadPath { get; set; }
        /// <summary>
        /// �ϴ��ļ���������
        /// </summary>
        public string UpLoadSaveName { get; set; }
        /// <summary>
        /// �ϴ��ļ�ǰ׺
        /// </summary>
        public string UpLoadRName { get; set; }
        /// <summary>
        /// �ϴ��ļ�ģʽ
        /// </summary>
        public string UpLoadMode { get; set; }
        /// <summary>
        /// ��ֹIP
        /// </summary>
        public string IPLock { get; set; }
        /// <summary>
        /// ������Ͷ������
        /// </summary>
        public string TakeMoneyLimit { get; set; }
        /// <summary>
        /// ����������
        /// </summary>
        public string WithdrawalFeeRate { get; set; }
        /// <summary>
        /// �Զ��ջ�����
        /// </summary>
        public string OrderReceivedDays { get; set; }
        /// <summary>
        /// �����Զ��������
        /// </summary>
        public string OrderCompleteDays { get; set; }
        /// <summary>
        /// api����
        /// </summary>
        public string APIPassWord { get; set; }
        /// <summary>
        /// lebiAPI��ַ
        /// </summary>
        public string LebiAPI { get; set; }
        /// <summary>
        /// ���ﳵ��ʾҳ 0�ر�1����
        /// </summary>
        public string IsBasketAction { get; set; }
        /// ��Ʒ���ǰ׺
        /// </summary>
        public string ProductNumberPrefix { get; set; }
        /// ��Ʒ��ų���
        /// </summary>
        public string ProductNumberLength { get; set; }
        /// ���¼����ʱ��
        /// </summary>
        public string NewEventTimes { get; set; }
        /// ���¼�������Ƶ
        /// </summary>
        public string NewEventPlayAudio { get; set; }
        /// HTTP����
        /// </summary>
        public string HTTPServer { get; set; }
        /// ����˰��
        /// </summary>
        public string TaxRate { get; set; }
        #endregion
        #region �ʼ�ģ��
        /// <summary>
        /// �ʼ�ģ��
        /// �����嵥-����
        /// </summary>
        public string EmailTPL_changgouqingdan_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��
        /// �����嵥
        /// </summary>
        public string EmailTPL_changgouqingdan { get; set; }
        /// <summary>
        /// �ʼ�ģ��
        /// �»�Աע��
        /// </summary>
        public string EmailTPL_newuser { get; set; }
        /// <summary>
        /// �ʼ�ģ��
        /// �һ�����
        /// </summary>
        public string EmailTPL_getpwd { get; set; }
        /// <summary>
        /// �ʼ�ģ��
        /// �����ύ
        /// </summary>
        public string EmailTPL_ordersubmit { get; set; }
        /// <summary>
        /// �ʼ�ģ��
        /// ��������
        /// </summary>
        public string EmailTPL_ordershipping { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����
        /// �»�Աע��
        /// </summary>
        public string EmailTPL_newuser_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����
        /// �һ�����
        /// </summary>
        public string EmailTPL_getpwd_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����
        /// �����ύ
        /// </summary>
        public string EmailTPL_ordersubmit_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����
        /// ��������
        /// </summary>
        public string EmailTPL_ordershipping_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա
        /// �»�Աע��
        /// </summary>
        public string EmailTPL_Admin_newuser { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա
        /// �����ύ
        /// </summary>
        public string EmailTPL_Admin_ordersubmit { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա
        /// ��������
        /// </summary>
        public string EmailTPL_Admin_ordercomment { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա
        /// ���Է���
        /// </summary>
        public string EmailTPL_Admin_inquiry { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա
        /// ��Ʒ����
        /// </summary>
        public string EmailTPL_Admin_comment { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա
        /// ��Ʒ��ѯ
        /// </summary>
        public string EmailTPL_Admin_ask { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա
        /// վ����
        /// </summary>
        public string EmailTPL_Admin_message { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա-����
        /// �»�Աע��
        /// </summary>
        public string EmailTPL_Admin_newuser_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա-����
        /// �����ύ
        /// </summary>
        public string EmailTPL_Admin_ordersubmit_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա-����
        /// ��������
        /// </summary>
        public string EmailTPL_Admin_ordercomment_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա-����
        /// ���Է���
        /// </summary>
        public string EmailTPL_Admin_inquiry_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա-����
        /// ��Ʒ����
        /// </summary>
        public string EmailTPL_Admin_comment_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա-����
        /// ��Ʒ��ѯ
        /// </summary>
        public string EmailTPL_Admin_ask_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-����Ա-����
        /// վ����
        /// </summary>
        public string EmailTPL_Admin_message_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-�ʼ���֤��
        /// </summary>
        public string EmailTPL_checkcode { get; set; }
        /// <summary>
        /// �ʼ�ģ��-�ʼ���֤��-����
        /// </summary>
        public string EmailTPL_checkcode_title { get; set; }
        /// <summary>
        /// �ʼ�ģ��-�ʼ���������
        /// </summary>
        public string EmailTPL_sendfriend { get; set; }
        /// <summary>
        /// �ʼ�ģ��-�ʼ���������-����
        /// </summary>
        public string EmailTPL_sendfriend_title { get; set; }

        /// <summary>
        /// �ʼ�ģ��-Ԥ����Ʒ����
        /// </summary>
        public string EmailTPL_reserveok { get; set; }
        /// <summary>
        /// �ʼ�ģ��-Ԥ����Ʒ����-����
        /// </summary>
        public string EmailTPL_reserveok_title { get; set; }

        #endregion

        #region ��Ȩ
        public string LicenseUserName { get; set; }
        public string LicensePWD { get; set; }
        public string LicenseString { get; set; }
        public string LicensePackage { get; set; }
        public string LicenseMD5 { get; set; }
        public string InstallCode { get; set; }
        public string SpreadCode { get; set; }
        /// <summary>
        /// ��������
        /// </summary>
        public string LicenseDomain { get; set; }
        public string Version { get; set; }
        public string Version_Son { get; set; }
        #endregion;

        #region ������ƽ̨
        public string platform_login { get; set; }
        public string platform_qq_id { get; set; }
        public string platform_qq_key { get; set; }
        public string platform_qq_image { get; set; }
        public string platform_weibo_id { get; set; }
        public string platform_weibo_key { get; set; }
        public string platform_weibo_image { get; set; }
        public string platform_taobao_key { get; set; }
        public string platform_taobao_secret { get; set; }
        public string platform_taobao_image { get; set; }
        public string platform_facebook_id { get; set; }
        public string platform_facebook_secret { get; set; }
        public string platform_facebook_image { get; set; }
        public string platform_twitter_key { get; set; }
        public string platform_twitter_secret { get; set; }
        public string platform_twitter_image { get; set; }
        public string platform_weixin_number { get; set; }
        public string platform_weixin_id { get; set; }
        public string platform_weixin_secret { get; set; }
        public string platform_weixin_image { get; set; }
        public string platform_weixin_image_qrcode { get; set; }
        public string platform_weixin_custemtoken { get; set; }
        public string platform_weixin_subscribe_automsg { get; set; }
        /// <summary>
        /// �Ա�Ӧ����Ȩ��Ϣ
        /// </summary>
        public string platform_taobao_sessionkey { get; set; }
        /// <summary>
        /// �Ա����̻�����Ϣ
        /// </summary>
        public string platform_taobao_shopnick { get; set; }
        #endregion

        #region ����
        /// <summary>
        /// ��ע�Ṻ����
        /// </summary>
        public string IsAnonymousUser { get; set; }
        /// <summary>
        /// �Ƿ������ֶһ��ʽ�
        /// </summary>
        public string IsPointToMoney { get; set; }
        /// <summary>
        /// �����ջ���ַ
        /// </summary>
        public string TopAreaid { get; set; }
        /// <summary>
        /// ������Զ�ȷ��
        /// </summary>
        public string IsOpenPaidOrderConfirm { get; set; }
        /// <summary>
        /// 0����Զ��¼�
        /// </summary>
        public string IsNullStockDown { get; set; }
        /// <summary>
        /// �����������
        /// </summary>
        public string IsNullStockSale { get; set; }
        /// <summary>
        /// ������ʱ��
        /// </summary>
        public string ProductStockFreezeTime { get; set; }
        /// <summary>
        /// ��̨����
        /// </summary>
        public string AdminLanguages { get; set; }
        public string PluginUsed { get; set; }
        public string IsClosetuihuo { get; set; }
        /// <summary>
        /// ��Ӧ�������տ�
        /// </summary>
        public string IsSupplierCash { get; set; }
        /// <summary>
        /// ��Ա��Ч�����ÿ���
        /// </summary>
        public string IsOpenUserEnd { get; set; }
        /// <summary>
        /// Ĭ���˺���Ч��
        /// </summary>
        public string DefaultUserEndDays { get; set; }
        /// <summary>
        /// ��Աע����֤����
        /// </summary>
        public string UserRegCheckedType { get; set; }
        /// <summary>
        /// ǰ̨�Ƿ�����չ�ֽ��
        /// </summary>
        public string IsMutiCurrencyShow { get; set; }

        /// <summary>
        /// ����վ���ύAJAX����
        /// </summary>
        public string IsAllowOutSideAjax { get; set; }
        /// <summary>
        /// ����IP
        /// </summary>
        public string SafeIPs { get; set; }
        /// <summary>
        /// վ����ƷȨ������0��ѡ��Ȩ�ޱ�ʾ�ܾ�1��ѡ��Ȩ�ޱ�ʾ����
        /// </summary>
        public string ProductLimitType { get; set; }
        #endregion

        #region ���
        public bool IsMutiSite { get; set; }
        #endregion
        #region �ƹ�/Ӷ���������
        /// <summary>
        /// Ӷ�𶳽�ʱ��/��
        /// </summary>
        public string CommissionMoneyDays { get; set; }
        /// <summary>
        /// ������ں󣬿���������
        /// </summary>
        public string AgentEndDays { get; set; }
        /// <summary>
        /// ������Ʒ�����ΪӶ��ı���
        /// </summary>
        public string OrderProductCommission { get; set; }
        /// <summary>
        /// һ����ԱӶ�����
        /// </summary>
        public string Angent1_Commission { get; set; }
        /// <summary>
        /// ������ԱӶ�����
        /// </summary>
        public string Angent2_Commission { get; set; }
        /// <summary>
        /// ��ԱӶ�����
        /// </summary>
        public string Angent_Commission { get; set; }
        /// <summary>
        /// ��ԱӶ�����-�ż�
        /// </summary>
        public string Angent_Commission_require { get; set; }
        /// <summary>
        /// �ƹ������
        /// </summary>
        public string IsUsedAgent { get; set; }
        /// <summary>
        /// ����������
        /// </summary>
        public string IsUsedAgent_Area { get; set; }
        /// <summary>
        /// ��Ʒ������
        /// </summary>
        public string IsUsedAgent_Product { get; set; }
        #endregion
        #region �ֻ�����
        /// <summary>
        /// ģ��-���û�ע��
        /// </summary>
        public string SMSTPL_newuser { get; set; }
        /// <summary>
        /// ģ��-�����ύ
        /// </summary>
        public string SMSTPL_ordersubmit { get; set; }
        /// <summary>
        /// ģ��-�����ύ-����ȷ��
        /// </summary>
        public string SMSTPL_orderpickup { get; set; }
        /// <summary>
        /// ģ��-��������
        /// </summary>
        public string SMSTPL_ordershipping { get; set; }
        /// <summary>
        /// ģ��-�������
        /// </summary>
        public string SMSTPL_account { get; set; }
        /// <summary>
        /// ģ��-�������
        /// </summary>
        public string SMSTPL_balance { get; set; }
        /// <summary>
        /// ģ��-�һ�����
        /// </summary>
        public string SMSTPL_getpwd { get; set; }
        /// <summary>
        /// ģ��-��ȡ������
        /// </summary>
        public string SMSTPL_getnewpwd { get; set; }
        /// <summary>
        /// ģ��-��Ʒ����
        /// </summary>
        public string SMSTPL_comment { get; set; }
        /// <summary>
        /// ģ��-��Ʒ��ѯ
        /// </summary>
        public string SMSTPL_ask { get; set; }
        /// <summary>
        /// ģ��-վ����
        /// </summary>
        public string SMSTPL_message { get; set; }
        /// <summary>
        /// ģ��-Ԥ����Ʒ����
        /// </summary>
        public string SMSTPL_reserveok { get; set; }
        /// <summary>
        /// ģ��-�ֻ���֤��
        /// </summary>
        public string SMSTPL_checkcode { get; set; }
        /// <summary>
        /// ģ��-����Ա-���û�ע��
        /// </summary>
        public string SMSTPL_Admin_newuser { get; set; }
        /// <summary>
        /// ģ��-����Ա-�����ύ
        /// </summary>
        public string SMSTPL_Admin_ordersubmit { get; set; }
        /// <summary>
        /// ģ��-����Ա-��������
        /// </summary>
        public string SMSTPL_Admin_orderpaid { get; set; }
        /// <summary>
        /// ģ��-����Ա-�����ջ�
        /// </summary>
        public string SMSTPL_Admin_orderrecive { get; set; }
        /// <summary>
        /// ģ��-����Ա-��������
        /// </summary>
        public string SMSTPL_Admin_ordercomment { get; set; }
        /// <summary>
        /// ģ��-����Ա-���Է���
        /// </summary>
        public string SMSTPL_Admin_inquiry { get; set; }
        /// <summary>
        /// ģ��-����Ա-��Ʒ����
        /// </summary>
        public string SMSTPL_Admin_comment { get; set; }
        /// <summary>
        /// ģ��-����Ա-��Ʒ��ѯ
        /// </summary>
        public string SMSTPL_Admin_ask { get; set; }
        /// <summary>
        /// ģ��-����Ա-վ����
        /// </summary>
        public string SMSTPL_Admin_message { get; set; }
        /// <summary>
        /// �����ʺ�
        /// </summary>
        public string SMS_user { get; set; }
        /// <summary>
        /// ��������
        /// </summary>
        public string SMS_password { get; set; }
        /// <summary>
        /// ���ź�׺
        /// </summary>
        public string SMS_lastmsg { get; set; }
        /// <summary>
        /// ����ƽ̨
        /// </summary>
        public string SMS_server { get; set; }
        /// <summary>
        /// ״̬
        /// </summary>
        public string SMS_state { get; set; }
        /// <summary>
        /// ����ͨ��
        /// </summary>
        public string SMS_apitype { get; set; }
        /// <summary>
        /// ��������
        /// </summary>
        public string SMS_sendmode { get; set; }
        /// <summary>
        /// �����ֻ�
        /// </summary>
        public string SMS_reciveno { get; set; }
        /// <summary>
        /// �˿ں�
        /// </summary>
        public string SMS_serverport { get; set; }
        /// <summary>
        /// ����ַ�
        /// </summary>
        public string SMS_maxlen { get; set; }
        /// <summary>
        /// ͨ�ýӿڵ�ַ
        /// </summary>
        public string SMS_httpapi { get; set; }
        /// <summary>
        /// �Ƿ�����ͬһ�ֻ��Ŷ��ע��
        /// </summary>
        public string IsMobilePhoneMutiReg { get; set; }
        #endregion
        #region ��˰
        /// <summary>
        /// ��˰-��͹����ܶ�
        /// </summary>
        public string Refund_MinMoney { get; set; }
        /// <summary>
        /// ��˰-�����Ѻ�����
        /// </summary>
        public string Refund_StepR { get; set; }
        /// <summary>
        /// ��˰-��ֵ˰��
        /// </summary>
        public string Refund_VAT { get; set; }
        #endregion
        #region ���¼�
        /// <summary>
        /// ����-δȷ��
        /// </summary>
        public string NewEvent_Order_IsVerified { get; set; }
        /// <summary>
        /// ����-��֧��
        /// </summary>
        public string NewEvent_Order_IsPaid { get; set; }
        /// <summary>
        /// ����-δ����
        /// </summary>
        public string NewEvent_Order_IsShipped { get; set; }
        #endregion
        #region ��֤�뿪��
        /// <summary>
        /// ��Աע��
        /// </summary>
        public string Verifycode_UserRegister { get; set; }
        /// <summary>
        /// ��Ա��¼
        /// </summary>
        public string Verifycode_UserLogin { get; set; }
        /// <summary>
        /// ��������
        /// </summary>
        public string Verifycode_ForgetPassword { get; set; }
        /// <summary>
        /// �̼�ע��
        /// </summary>
        public string Verifycode_SupplierRegister { get; set; }
        /// <summary>
        /// �̼ҵ�¼
        /// </summary>
        public string Verifycode_SupplierLogin { get; set; }
        /// <summary>
        /// �����¼
        /// </summary>
        public string Verifycode_AdminLogin { get; set; }
        #endregion
    }
}