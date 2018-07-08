//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using RP.DataModel;
//using System.Collections;
//using RP.DataModel.Args;
//namespace RP.BusinessLogic.Cache
//{
//    public class SiteCatchCache
//    {
//        /// <summary>
//        /// 线程锁
//        /// </summary>
//        static readonly object _locker = new object();
//        /// <summary>
//        /// 全部部门数据
//        /// </summary>
//        private static List<Fllb_XxflModel> _sites;

//        /// <summary>
//        /// 读取属性：自动加载
//        /// </summary>
//        public static List<Fllb_XxflModel> Sites
//        {
//            get
//            {
//                if (_sites == null || _sites.Count <= 0)
//                    LoadSiteCatching();
//                return _sites;
//            }
//        }

//        /// <summary>
//        /// 手动刷新缓存
//        /// </summary>
//        public static void LoadSiteCatching()
//        {
//            try
//            {
//                lock (_locker)
//                {
//                    Hashtable where = new Hashtable();
//                    where.Add(Fllb_XxflArgs.LBFL, "8");
//                    where.Add(Fllb_XxflArgs.OrderBy, " id asc ");
//                    _sites = Fllb_XxflBLL.GetFllb_XxflList(where);
//                }
//            }
//            catch (Exception ex)
//            {
//                Utility.SysLog.WriteException("缓存加载失败：网站版块", ex);
//            }
//        }
//    }
//}
