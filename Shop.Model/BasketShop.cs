using System;
using System.Collections.Generic;
using System.Text;
using DB.LebiShop;
namespace Shop.Model
{
    /// <summary>
    /// ���ﳵ��������
    /// </summary>
    public class BasketShop
    {
        /// <summary>
        /// �̻���Ϣ����ֵʱ��ʾ��Ӫ
        /// </summary>
        public Lebi_Supplier Shop
        {
            get;
            set;
        }
        /// <summary>
        /// ��Ʒ����
        /// </summary>
        public int Count
        {
            get;
            set;
        }
        /// <summary>
        /// ���ﳵ����
        /// </summary>
        public int ProPerty134
        {
            get;
            set;
        }
        /// <summary>
        /// ����
        /// </summary>
        public decimal Weight
        {
            get;
            set;
        }
        /// <summary>
        /// ���
        /// </summary>
        public decimal Volume
        {
            get;
            set;
        }
        /// <summary>
        /// �˷�
        /// </summary>
        public decimal Money_Transport
        {
            get;
            set;
        }
        /// <summary>
        /// �����˷�
        /// </summary>
        public int Money_Transport_One
        {
            get;
            set;
        }
        /// <summary>
        /// �Ƿ񶨶��˷�
        /// </summary>
        public bool IsTransportPriceOne
        {
            get;
            set;
        }
        /// <summary>
        /// ��Ʒ���
        /// </summary>
        public decimal Money_Product
        {
            get;
            set;
        }
        /// <summary>
        /// δ�������ǰ����Ʒ�ܽ��
        /// </summary>
        public decimal Money_Product_begin
        {
            get;
            set;
        }
        /// <summary>
        /// ���Լ۸����ӳ����ޣ��ܺͽ��
        /// </summary>
        public decimal Money_Property
        {
            get;
            set;
        }
        /// <summary>
        /// �Żݽ��
        /// </summary>
        public decimal Money_Cut
        {
            get;
            set;
        }
        /// <summary>
        /// �������
        /// </summary>
        public decimal Money_Give
        {
            get;
            set;
        }
        /// <summary>
        /// �г���
        /// </summary>
        public decimal Money_Market
        {
            set;
            get;
        }
        /// <summary>
        /// ˰��
        /// </summary>
        public decimal Money_Tax
        {
            set;
            get;
        }
        /// <summary>
        ///  = 0;//��û�������
        /// </summary>
        public decimal Point
        {
            set;
            get;
        }
        /// <summary>
        /// = 0;//��Ʒ��û�������
        /// </summary>
        public decimal Point_Product
        {
            set;
            get;
        }
        /// <summary>
        ///  = 0;//���ͻ���
        /// </summary>
        public decimal Point_Free
        {
            set;
            get;
        }
        /// <summary>
        ///  ���ֹ���ʱ�������
        /// </summary>
        public decimal Point_Buy
        {
            set;
            get;
        }
        /// <summary>
        /// ; //��Ʒ
        /// </summary>
        public List<Lebi_User_Product> FreeProducts
        {
            set;
            get;
        }
        /// <summary>
        /// ;//���������Ĵ����
        /// </summary>
        public List<Lebi_Promotion_Type> PromotionTypes
        {
            set;
            get;
        }
        /// <summary>
        /// ��Ʒ
        /// </summary>
        public List<Lebi_User_Product> Products 
        {
            get;
            set;
        }

    }


}
