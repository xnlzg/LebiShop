using System;
using System.Collections;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Caching;

namespace LB.Tools
{
    /// <summary>
    /// ���������
    /// </summary>
    public sealed class CacheTool
    {
        /// <summary>
        /// ����Ϊ�ܷ��࣬ӵ˽�й��캯���������Ա�ʵ����
        /// </summary>
        private CacheTool() { }

        public static readonly int DayFactor = 17280;
        public static readonly int HourFactor = 720;
        public static readonly int MinuteFactor = 12;
        public static readonly double SecondFactor = 0.2;

        private static readonly Cache _cache;

        private static int Factor = 5;//Ĭ�ϵĻ���ʱ����5����
        /// <summary>
        /// ��̬���������û���ʱ��
        /// </summary>
        /// <param name="cacheFactor"></param>
        public static void ReSetFactor(int cacheFactor)
        {
            Factor = cacheFactor;
        }
        /// <summary>
        ///  ���õ������ģʽ������̬��ʼ����������̬��ʼ��ʱ��������Ҫ��֤����Ҫ���ҵĻ����ǵ�ǰ�Ļ��棬��Ҫ�ֱ����Щ�������Ļ��棬��Щ������ʱ����
        /// </summary>
        static CacheTool()
        {

            HttpContext context = HttpContext.Current;
            if (context != null)
            {
                _cache = context.Cache;
            }
            else
            {
                _cache = HttpRuntime.Cache;
            }
        }
        public static int GetCacheItemCount()
        {
            int reval = 0;
            IDictionaryEnumerator CacheEnum = _cache.GetEnumerator();
            while (CacheEnum.MoveNext())
            {
                reval++;
            }
            return reval;

        }
        /// <summary>
        /// ������л�����Ŀ
        /// </summary>
        public static void Clear()
        {
            IDictionaryEnumerator CacheEnum = _cache.GetEnumerator();
            ArrayList al = new ArrayList();
            while (CacheEnum.MoveNext())
            {
                al.Add(CacheEnum.Key);
            }

            foreach (string key in al)
            {
                _cache.Remove(key);
            }

        }
        /// <summary>
        /// ����ģʽƥ������ջ���
        /// </summary>
        /// <param name="pattern">������ʽƥ����</param>
        public static void RemoveByPattern(string pattern)
        {
            IDictionaryEnumerator CacheEnum = _cache.GetEnumerator();
            Regex regex = new Regex(pattern, RegexOptions.IgnoreCase | RegexOptions.Singleline | RegexOptions.Compiled);
            while (CacheEnum.MoveNext())
            {
                if (regex.IsMatch(CacheEnum.Key.ToString()))
                    _cache.Remove(CacheEnum.Key.ToString());
            }
        }

        /// <summary>
        /// Removes the specified key from the cache
        /// ���ݼ�ֵ��������
        /// </summary>
        /// <param name="key"></param>
        public static void Remove(string key)
        {
            _cache.Remove(key);
        }

        /// <summary>
        /// Insert the current "obj" into the cache. 
        /// ��obj���뵽������
        /// </summary>
        /// <param name="key"></param>
        /// <param name="obj"></param>
        public static void Insert(string key, object obj)
        {
            Insert(key, obj, null, 1);
        }

        public static void Insert(string key, object obj, CacheDependency dep)
        {
            Insert(key, obj, dep, MinuteFactor * 3);
        }

        public static void Insert(string key, object obj, int seconds)
        {
            Insert(key, obj, null, seconds);
        }

        public static void Insert(string key, object obj, int seconds, CacheItemPriority priority)
        {
            Insert(key, obj, null, seconds, priority);
        }

        public static void Insert(string key, object obj, CacheDependency dep, int seconds)
        {
            Insert(key, obj, dep, seconds, CacheItemPriority.Normal);
        }

        public static void Insert(string key, object obj, CacheDependency dep, int seconds, CacheItemPriority priority)
        {
            if (obj != null)
            {
                _cache.Insert(key, obj, dep, DateTime.Now.AddSeconds(Factor * seconds), TimeSpan.Zero, priority, null);
            }

        }

        public static void MicroInsert(string key, object obj, int secondFactor)
        {
            if (obj != null)
            {
                _cache.Insert(key, obj, null, DateTime.Now.AddSeconds(Factor * secondFactor), TimeSpan.Zero);
            }
        }

        /// <summary>
        /// Insert an item into the cache for the Maximum allowed time
        /// </summary>
        /// <param name="key"></param>
        /// <param name="obj"></param>
        public static void Max(string key, object obj)
        {
            Max(key, obj, null);
        }

        public static void Max(string key, object obj, CacheDependency dep)
        {
            if (obj != null)
            {
                _cache.Insert(key, obj, dep, DateTime.MaxValue, TimeSpan.Zero, CacheItemPriority.AboveNormal, null);
            }
        }

        /// <summary>
        /// Insert an item into the cache for the Maximum allowed time
        /// �����Ի��棬��ӵ�����ʱ��
        /// </summary>
        /// <param name="key"></param>
        /// <param name="obj"></param>
        public static void Permanent(string key, object obj)
        {
            Permanent(key, obj, null);
        }

        public static void Permanent(string key, object obj, CacheDependency dep)
        {
            //if (obj != null)
            //{
                _cache.Insert(key, obj, dep, DateTime.MaxValue, TimeSpan.Zero, CacheItemPriority.NotRemovable, null);
            //}
        }

        public static object Get(string key)
        {
            return _cache[key];
        }

        /// <summary>
        /// Return int of seconds * SecondFactor
        /// </summary>
        public static int SecondFactorCalculate(int seconds)
        {
            // Insert method below takes integer seconds, so we have to round any fractional values
            return Convert.ToInt32(Math.Round((double)seconds * SecondFactor));
        }

    }
}
