/*********************************************************************************************
 * 文件名       : RolesCache.cs
 * 文件描述     : RolesCache类 
 *********************************************************************************************/


using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FGA_MODEL;
using System.Collections;
using FGA_MODEL.Args;
using FGA_NUtility.Enums;
using FGA_NUtility.Consts;
using System.Web;

namespace FGA_BLL.Cache
{
    /// <summary>
    /// 角色缓存类
    /// </summary>
    public class RolesCache
    {
        /// <summary>
        /// 键
        /// </summary>
        static readonly string KEY = "_roles_cache_";
        /// <summary>
        /// 读取属性：自动加载
        /// </summary>
        public static List<RolesModel> Roles
        {
            get
            {
                List<RolesModel> list = HttpContext.Current.Cache.Get(KEY) as List<RolesModel>;
                if (list == null)
                    InitCache();
                list = HttpContext.Current.Cache.Get(KEY) as List<RolesModel>;
                if (list == null || list.Count <= 0)
                    list = new List<RolesModel>();
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
                where.Add(RolesArgs.state, (int)CommonState.normal);
                where.Add(RolesArgs.OrderBy, "rid asc");
                List<RolesModel> list = RolesBLL.GetRolesList(where);
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
