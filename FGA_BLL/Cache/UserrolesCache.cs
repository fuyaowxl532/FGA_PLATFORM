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
    public class UserrolesCache
    {
        /// <summary>
        /// 键
        /// </summary>
        static readonly string KEY = "_user_role_cache_";
        /// <summary>
        /// 读取属性：自动加载
        /// </summary>
        public static List<UserrolesModel> Userroles
        {
            get
            {
                List<UserrolesModel> list = HttpContext.Current.Cache.Get(KEY) as List<UserrolesModel>;
                if (list == null)
                    InitCache();
                list = HttpContext.Current.Cache.Get(KEY) as List<UserrolesModel>;
                if (list == null || list.Count <= 0)
                    list = new List<UserrolesModel>();
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
                where.Add(UserrolesArgs.OrderBy, " urid asc ");
                List<UserrolesModel> list = UserrolesBLL.GetUserrolesList(where);
                if (list != null)
                    HttpContext.Current.Cache.Insert(KEY, list);
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException("缓存异常 " + KEY, ex);
            }
        }

        ///// <summary>
        ///// 根据loginid输出名称
        ///// </summary>
        ///// <param name="DCode"></param>
        //public static string GetNameByLoginID(object loginid)
        //{
        //    var user = Users.Find(r => r.loginid == loginid.ToString());
        //    return user == null ? string.Empty : user.fullname;
        //}
        /// <summary>
        /// 根据用户uid来输出角色名称
        /// </summary>
        /// <param name="DCode"></param>
        public static string GetRoleNameByUid(object uid)
        {
            var userrole = Userroles.Find(r => r.uid ==FGA_NUtility.Convertor.ToInt32(uid));
            if (userrole == null)
            {
                return string.Empty;
            }
            RolesModel tmp = new RolesModel();
            tmp.rid = userrole.rid;
            var role = FGA_BLL.RolesBLL.GetRolesInfo(tmp);
            return role == null ? string.Empty : role.rname;
        }

        /// <summary>
        /// 根据用户ID 获取角色ID
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static int GetRoleIDByUid(object uid)
        {
            var userrole = Userroles.Find(r => r.uid ==FGA_NUtility.Convertor.ToInt32(uid));
            //if (userrole == null)
            //{
            //    return string.Empty;
            //}
            //RolesModel tmp = new RolesModel();
            //tmp.rid = userrole.rid;
            //var role = FGA_BLL.RolesBLL.GetRolesInfo(tmp);
            return userrole == null ? 0 : userrole.rid;
        }
    }
}
