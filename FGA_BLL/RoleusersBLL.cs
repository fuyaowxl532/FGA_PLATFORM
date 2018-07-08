/*********************************************************************************************
 * 文件名       : RoleusersDAL.cs
 * 文件描述     : Roleusers业务逻辑类 
 * 历史记录     :
 * [2013-02-27 10:46:10 / xlb] create by CodeSmith 5.3
 *********************************************************************************************/
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using RP.DataModel;

namespace RP.BusinessLogic
{    
    public class RoleusersBLL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool AddRoleusers(RoleusersModel model)
        {
            return Common.Instance._Roleusers.AddRoleusers(model);
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdateRoleusers(RoleusersModel model)
        {
            return Common.Instance._Roleusers.UpdateRoleusers(model);
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool DeleteRoleusers(RoleusersModel model)
        {
            return Common.Instance._Roleusers.DeleteRoleusers(model);
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static RoleusersModel GetRoleusersInfo(RoleusersModel model)
        {
            return Common.Instance._Roleusers.GetRoleusersInfo(model);
        }
        #endregion
        
        #region //扩展函数
         /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public static List<RoleusersModel> GetRoleusersList(Hashtable where)
        {
            List<RoleusersModel> list = Common.Instance._Roleusers.GetRoleusersList(where);
            list = list == null ? new List<RoleusersModel>() : list;
            return list;
        }
        /*
         
        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        public static RoleusersModel GetRoleusersListByPage()
        {
            return Common.Instance._Roleusers.GetRoleusersListByPage();
        }
        */
        #endregion
    }
}
