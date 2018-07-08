/*********************************************************************************************
 * 文件名       : RolepowersDAL.cs
 * 文件描述     : Rolepowers业务逻辑类 
 *********************************************************************************************/
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_MODEL;

namespace FGA_BLL
{    
    public class RolepowersBLL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool AddRolepowers(RolepowersModel model)
        {
            return Common.Instance._Rolepowers.AddRolepowers(model);
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdateRolepowers(RolepowersModel model)
        {
            return Common.Instance._Rolepowers.UpdateRolepowers(model);
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool DeleteRolepowers(RolepowersModel model)
        {
            return Common.Instance._Rolepowers.DeleteRolepowers(model);
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static RolepowersModel GetRolepowersInfo(RolepowersModel model)
        {
            return Common.Instance._Rolepowers.GetRolepowersInfo(model);
        }
        #endregion
        
        #region //扩展函数
        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public static List<RolepowersModel> GetRolepowersList(Hashtable where)
        {
            return Common.Instance._Rolepowers.GetRolepowersList(where);
        }

        /// <summary>
        /// 设定角色模块
        /// </summary>
        /// <param name="roleId"></param>
        /// <param name="pCodes"></param>
        /// <returns></returns>
        public static bool SetRolePowers(int roleId, List<string> pCodes)
        {
            if (roleId <= 0 || pCodes == null)
                return false;
            return Common.Instance._Rolepowers.SetRolePowers(roleId, pCodes);
        }
        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        //public static RolepowersModel GetRolepowersListByPage()
        //{
        //    return Common.Instance._Rolepowers.GetRolepowersListByPage();
        //}
        #endregion
    }
}
