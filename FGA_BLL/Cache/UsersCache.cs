using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FGA_MODEL;
using System.Collections;
using FGA_MODEL.Args;
using FGA_NUtility.Enums;
using System.Web;

namespace FGA_BLL.Cache
{
    /// <summary>
    /// 角色缓存类
    /// </summary>
    public class UsersCache
    {
        /// <summary>
        /// 键
        /// </summary>
        static readonly string KEY = "_user_cache_";
        /// <summary>
        /// 读取属性：自动加载
        /// </summary>
        public static List<UsersModel> Users
        {
            get
            {
                List<UsersModel> list = HttpContext.Current.Cache.Get(KEY) as List<UsersModel>;
                if (list == null)
                    InitCache();
                list = HttpContext.Current.Cache.Get(KEY) as List<UsersModel>;
                if (list == null || list.Count <= 0)
                    list = new List<UsersModel>();
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
                HttpContext.Current.Cache.Remove(KEY);

                Hashtable where = new Hashtable();
                where.Add(UsersArgs.STATUS, (int)CommonState.normal);
                where.Add(UsersArgs.OrderBy, "loginid asc");
                List<UsersModel> list = UsersBLL.GetUsersList(where);
                if (list != null)
                    HttpContext.Current.Cache.Insert(KEY, list);
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException("缓存异常 " + KEY, ex);
            }
        }
        /// <summary>
        /// 根据loginid输出名称
        /// </summary>
        /// <param name="DCode"></param>
        public static string GetNameByLoginID(object loginid)
        {
            var user = Users.Find(r => r.USERNAME == loginid.ToString());
            return user == null ? string.Empty : user.USERNAME;
        }
        /// <summary>
        /// 根据编码输出名称
        /// </summary>
        /// <param name="DCode"></param>
        public static string GetNameByUid(object uid)
        {
            var user = Users.Find(r => r.USERID ==FGA_NUtility.Convertor.ToInt32(uid));
            return user == null ? string.Empty : user.USERNAME;
        }
    }
}
