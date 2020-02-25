using System;
using System.Collections.Generic;
using System.Text;

namespace Shop.Model
{

    public class PluginConfig
    {
        public string Assembly
        {
            get;
            set;
        }
        public string Name
        {
            get;
            set;
        }
        public string Company
        {
            get;
            set;
        }
        public int Version
        {
            get;
            set;
        }
        public List<eventconfig> EventConfigs
        {
            get;
            set;
        }
        public List<menuconfig> MenuConfigs
        {
            get;
            set;
        }
        public List<menurewrite> MenuRewrites
        {
            get;
            set;
        }
        public List<pageconfig> PageConfigs
        {
            get;
            set;
        }
        public List<tableconfig> TableConfigs
        {
            get;
            set;
        }
        /// <summary>
        /// �¼�����
        /// </summary>
        public class eventconfig
        {
            public string eventname
            {
                get;
                set;
            }
            public string spacename
            {
                get;
                set;
            }
            public string classname
            {
                get;
                set;
            }
            public string methodname
            {
                get;
                set;
            }
        }
        /// <summary>
        /// �˵�����
        /// </summary>
        public class menuconfig
        {
            public string name
            {
                get;
                set;
            }
            public string url
            {
                get;
                set;
            }
            public string parentcode
            {
                get;
                set;
            }
            public List<menuconfig> son
            {
                get;
                set;
            }
        }
        /// <summary>
        /// �˵���д
        /// </summary>
        public class menurewrite
        {
            public string code
            {
                get;
                set;
            }
            public string url
            {
                get;
                set;
            }
        }
        /// <summary>
        /// ҳ������
        /// </summary>
        public class pageconfig
        {
            public string skin
            {
                get;
                set;
            }
            public string wapskin
            {
                get;
                set;
            }
            public string page
            {
                get;
                set;
            }
        }
        /// <summary>
        /// ���ݱ�����
        /// </summary>
        public class tableconfig
        {
            public string name
            {
                get;
                set;
            }
            public string primarykey
            {
                get;
                set;
            }
            public string cols
            {
                get;
                set;
            }

        }
    }

}
