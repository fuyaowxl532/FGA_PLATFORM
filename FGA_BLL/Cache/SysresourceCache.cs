//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using RP.DataModel;
//using System.Collections;
//using RP.DataModel.Args;
//using System.Web.UI.WebControls;

//namespace RP.BusinessLogic.Cache
//{
//    /// <summary>
//    /// 资源配置缓存类
//    /// </summary>
//    public class SysresourceCache
//    {
//        /// <summary>
//        /// 线程锁
//        /// </summary>
//        static readonly object _locker = new object();
//        /// <summary>
//        /// 全部资源配置数据
//        /// </summary>
//        private static List<SysresourceModel> _Sysresource;
//        /// <summary>
//        /// 读取属性：自动加载
//        /// </summary>
//        public static List<SysresourceModel> Sysresource
//        {
//            get
//            {
//                if (_Sysresource == null || _Sysresource.Count <= 0)
//                    LoadSysresource();
//                return _Sysresource;
//            }
//        }
//        /// <summary>
//        /// 手动刷新缓存
//        /// </summary>
//        public static void LoadSysresource()
//        {
//            try
//            {
//                lock (_locker)
//                {
//                    Hashtable where = new Hashtable();
//                    where.Add(SysresourceArgs.OrderBy, "RType asc,RKey asc");
//                    _Sysresource = SysresourceBLL.GetSysresourceList(where);
//                }
//            }
//            catch (Exception ex)
//            {
//                Utility.SysLog.WriteException("缓存加载失败：资源配置", ex);
//            }
//        }
//        /// <summary>
//        /// 根据键获取配置值
//        /// </summary>
//        /// <param name="key"></param>
//        /// <returns></returns>
//        public static string GetResourceByKey(string key) 
//        {
//            SysresourceModel resource = Sysresource.Find(r => r.RKey == key);
//            if(resource!=null)
//                return resource.RValue;
//            return string.Empty;
//        }


//        #region //对键值对配置(如区域、服务商类型，格式"1=AAA,2=BBB,3=CCC")的快捷操作
//        /// <summary>
//        /// 根据键值对的值获取名称
//        /// </summary>
//        /// <param name="key">资源名称</param>
//        /// <param name="id">id值</param>
//        /// <returns></returns>
//        public static string GetNameByID(string key,object obj)
//        {
//            int id = Utility.Convertor.ToInt32(obj);
//            if (id <= 0)
//                return string.Empty;
//            string configStr = GetResourceByKey(key);
//            string[] ary1 = configStr.Split(',');
//            if (ary1.Length >= 0)
//            {
//                foreach (string item in ary1)
//                {
//                    string[] ary2 = item.Split('=');
//                    if (ary2[0] == id.ToString())
//                        return ary2[1];
//                }
//            }
//            return string.Empty;
//        }
//        /// <summary>
//        /// 用资源配置中的键值对填充下拉列表控件
//        /// </summary>
//        /// <param name="key">资源名称</param>
//        /// <param name="emptyText">第一个默认下拉项文本(-不限-，-全部-等)，为空时没有默认项</param>
//        public static void FillSelect(DropDownList select, string key,string emptyText) 
//        {
//            select.Items.Clear();
//            if (!string.IsNullOrEmpty(emptyText))
//                select.Items.Add(new ListItem(emptyText,string.Empty));
//            string configStr = GetResourceByKey(key);
//            string[] ary1 = configStr.Split(',');
//            if (ary1.Length >= 0)
//            {
//                foreach (string item in ary1)
//                {
//                    string[] ary2 = item.Split('=');
//                    select.Items.Add(new ListItem(ary2[1],ary2[0]));
//                }
//            }
//        }

//        ///// <summary>
//        ///// 根据编码获取区域配置名称
//        ///// </summary>
//        ///// <param name="areaid"></param>
//        ///// <returns></returns>
//        //public static string GetAreaNameByID(object areaid) 
//        //{
//        //    int id = Utility.Convertor.ToInt32(areaid);
//        //    if (id <= 0)
//        //        return string.Empty;
//        //    string areaConfig = GetResourceByKey("CityArea");
//        //    string[] ary1 = areaConfig.Split(',');
//        //    if (ary1.Length >= 0)
//        //    {
//        //        foreach (string item in ary1)
//        //        {
//        //            string[] ary2 = item.Split('=');
//        //            if (ary2[0] == areaid.ToString())
//        //                return ary2[1];
//        //        }
//        //    }
//        //    return string.Empty;
//        //}
//        ///// <summary>
//        ///// 根据编码获取服务商分类名称
//        ///// </summary>
//        ///// <param name="areaid"></param>
//        ///// <returns></returns>
//        //public static string GetSupplierTypeNameByID(object suppliertype)
//        //{
//        //    int id = Utility.Convertor.ToInt32(suppliertype);
//        //    if (id <= 0)
//        //        return string.Empty;
//        //    string areaConfig = GetResourceByKey("SupplierType");
//        //    string[] ary1 = areaConfig.Split(',');
//        //    if (ary1.Length >= 0)
//        //    {
//        //        foreach (string item in ary1)
//        //        {
//        //            string[] ary2 = item.Split('=');
//        //            if (ary2[0] == suppliertype.ToString())
//        //                return ary2[1];
//        //        }
//        //    }
//        //    return string.Empty;
//        //}
//        #endregion
//    }
//}
