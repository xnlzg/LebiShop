using System;
using System.Collections.Generic;
using System.Text;

namespace Shop.Model
{
    
    public class LanguageContent
    {

        public LanguageContent() { }

        private string _L;
        /**
         * ��������
         */
        public string L
        {
            get { return _L; }
            set { _L = value; }
        }
        private string _C;
        /**
         * ��������
         */
        public string C
        {
            get { return _C; }
            set { _C = value; }
        }
        
    }
}
