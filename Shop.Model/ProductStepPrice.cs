using System;
using System.Collections.Generic;
using System.Text;

namespace Shop.Model
{

    public class ProductStepPrice
    {

        public ProductStepPrice() { }

        /// <summary>
        /// ��������
        /// </summary>
        public int Count { get; set; }
        /// <summary>
        /// ����۸�
        /// </summary>
        public decimal Price { get; set; }

    }
    public class ProductUserLevelPrice
    {

        public ProductUserLevelPrice() { }

        /// <summary>
        /// ��������
        /// </summary>
        public int UserLevel_id { get; set; }
        /// <summary>
        /// ����۸�
        /// </summary>
        public decimal Price { get; set; }

    }
    public class ProductUserLevelCount
    {

        public ProductUserLevelCount() { }

        /// <summary>
        /// ��������
        /// </summary>
        public int UserLevel_id { get; set; }
        /// <summary>
        /// ����
        /// </summary>
        public int Count { get; set; }

    }
}
