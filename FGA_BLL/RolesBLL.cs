/*********************************************************************************************
 * 文件名       : RolesDAL.cs
 * 文件描述     : Roles业务逻辑类 
 *********************************************************************************************/
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_MODEL;
using FGA_MODEL.Args;

namespace FGA_BLL
{    
    public class RolesBLL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool AddRoles(RolesModel model)
        {
            return Common.Instance._Roles.AddRoles(model);
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdateRoles(RolesModel model)
        {
            return Common.Instance._Roles.UpdateRoles(model);
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool DeleteRoles(RolesModel model)
        {
            return Common.Instance._Roles.DeleteRoles(model);
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static RolesModel GetRolesInfo(RolesModel model)
        {
            return Common.Instance._Roles.GetRolesInfo(model);
        }
        #endregion
        
        #region //扩展函数
        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public static List<RolesModel> GetRolesList(Hashtable where)
        {
            return Common.Instance._Roles.GetRolesList(where);
        }

        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        public static List<RolesModel> GetRolesListByPage(Hashtable where, SearchArgs args)
        {
            return Common.Instance._Roles.GetRolesListByPage(where, args);
        }

        public static RolesModel GetRolesModel(string strRoleName)
        {
            return Common.Instance._Roles.GetRolesModel(strRoleName);
        }
        #endregion
    }
}
