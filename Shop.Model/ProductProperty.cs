using System;
using System.Collections.Generic;
using System.Text;
using DB.LebiShop;
namespace Shop.Model
{
    
    public class ProductProperty
    {

        public ProductProperty() { }

        private Lebi_ProPerty _Pproperty;
        /**
         * ��������
         */
        public Lebi_ProPerty Pproperty
        {
            get { return _Pproperty; }
            set { _Pproperty = value; }
        }

        private Lebi_ProPerty _property;
        /**
         * ����
         */
        public Lebi_ProPerty property
        {
            get { return _property; }
            set { _property = value; }
        }

        private Lebi_Product _product;
        /**
         * ��Ʒ
         */
        public Lebi_Product product
        {
            get { return _product; }
            set { _product = value; }
        }
    }
}
