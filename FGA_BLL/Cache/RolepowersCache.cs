using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FGA_MODEL;
using System.Collections;
using FGA_MODEL.Args;
using System.Web;

namespace FGA_BLL.Cache
{
    /// <summary>
    /// 角色模块关系缓存类
    /// </summary>
    public class RolepowersCache
    {
        /// <summary>
        /// 键
        /// </summary>
        static readonly string KEY = "_rowpower_cache_";
        /// <summary>
        /// 读取属性：自动加载
        /// </summary>
        public static List<RolepowersModel> Rolepowers
        {
            get
            {
                List<RolepowersModel> list = HttpContext.Current.Cache.Get(KEY) as List<RolepowersModel>;
                if (list == null)
                    InitCache();
                list = HttpContext.Current.Cache.Get(KEY) as List<RolepowersModel>;
                if (list == null || list.Count <= 0)
                    list = new List<RolepowersModel>();
                return list;
            }
        }

        /// <summary>
        /// 手动刷新缓存
        /// </summary>
        public static void InitCache()
        {
            try
            {
                Hashtable where = new Hashtable();
                where.Add(RolepowersArgs.OrderBy, "roleid asc,pcode asc");
                List<RolepowersModel> list = RolepowersBLL.GetRolepowersList(where);
                if (list != null)
                    HttpContext.Current.Cache.Insert(KEY, list);
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException("缓存异常 " + KEY, ex);
            }
        }
    }
}
