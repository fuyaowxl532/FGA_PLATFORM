/*********************************************************************************************
 * 文件名       : UserrolesDAL.cs
 * 文件描述     : Userroles业务逻辑类 
 *********************************************************************************************/
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_MODEL;

namespace FGA_BLL
{
    public class UserrolesBLL
    {
        #region //增删改查基本操作

        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool AddUserroles(UserrolesModel model)
        {
            return Common.Instance._Userroles.AddUserroles(model);
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdateUserroles(UserrolesModel model)
        {
            return Common.Instance._Userroles.UpdateUserroles(model);
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool DeleteUserroles(UserrolesModel model)
        {
            return Common.Instance._Userroles.DeleteUserroles(model);
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static UserrolesModel GetUserrolesInfo(UserrolesModel model)
        {
            return Common.Instance._Userroles.GetUserrolesInfo(model);
        }
        #endregion

        #region //扩展函数

        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public static List<UserrolesModel> GetUserrolesList(Hashtable where)
        {
            return Common.Instance._Userroles.GetUserrolesList(where);
        }
        ///// <summary>
        ///// 获取分页
        ///// </summary>
        ///// <returns></returns>
        //public static UserrolesModel GetUserrolesListByPage()
        //{
        //    return Common.Instance._Userroles.GetUserrolesListByPage();
        //}

        /// <summary>
        /// 根据uid来获得uid对应的userroles对象
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static UserrolesModel GetUserRolesModelInfo(string uid)
        {
            return Common.Instance._Userroles.GetUserRolesModelInfo(uid);
        }

        /// <summary>
        /// 根据uid来更新rid
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdateUserroles(string uid, string rid)
        {
            return Common.Instance._Userroles.UpdateUserroles(uid, rid);
        }


        /// <summary>
        ///  删除uid对应的记录
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="rid"></param>
        /// <returns></returns>
        public static bool DeleteUserroles(string uid)
        {
            return Common.Instance._Userroles.DeleteUserroles(uid);
        }

        #endregion
    }
}
