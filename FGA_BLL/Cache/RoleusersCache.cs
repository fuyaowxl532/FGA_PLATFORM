using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RP.DataModel;
using System.Collections;
using RP.DataModel.Args;

namespace RP.BusinessLogic.Cache
{
    /// <summary>
    /// 角色用户关系缓存类
    /// </summary>
    public class RoleusersCache
    {
        /// <summary>
        /// 线程锁
        /// </summary>
        static readonly object _locker = new object();
        /// <summary>
        /// 全部角色用户关系数据
        /// </summary>
        private static List<UserrolesModel> _Roleusers;
        /// <summary>
        /// 读取属性：自动加载
        /// </summary>
        public static List<UserrolesModel> Roleusers
        {
            get
            {
                if (_Roleusers == null || _Roleusers.Count <= 0)
                    LoadRoleusers();
                return _Roleusers;
            }
        }
        /// <summary>
        /// 手动刷新缓存
        /// </summary>
        public static void LoadRoleusers()
        {
            try
            {
                lock (_locker)
                {
                    Hashtable where = new Hashtable();
                    where.Add(UserrolesArgs.OrderBy, string.Empty);
                    _Roleusers = UserrolesBLL.GetUserrolesList(where);
                }
            }
            catch (Exception ex)
            {
                Utility.SysLog.WriteException("缓存加载失败：角色用户关系", ex);
            }
        }
    }
}
