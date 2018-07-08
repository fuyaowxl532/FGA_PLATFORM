/*********************************************************************************************
 * 文件名       : UsersDAL.cs
 * 文件描述     : Users业务逻辑类 
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
    public class UsersBLL
    {
        #region //增删改查基本操作

        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool AddUsers(UsersModel model)
        {
            return Common.Instance._Users.AddUsers(model);
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdateUsers(UsersModel model)
        {
            return Common.Instance._Users.UpdateUsers(model);
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool DeleteUsers(UsersModel model)
        {
            return Common.Instance._Users.DeleteUsers(model);
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static UsersModel GetUsersInfo(UsersModel model)
        {
            UsersModel uModel = Common.Instance._Users.GetUsersInfo(model);

            return uModel;
        }
        #endregion

        #region //扩展函数

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="loginid"></param>
        /// <param name="psd"></param>
        /// <returns></returns>
        public static UsersModel UserLogin(string loginid, string psd)
        {
           
            //三次md5加密
            for (int i = 0; i < 3; i++)
            {
                psd =FGA_NUtility.Encrypt.MD5EnCode(psd);
            }
            UsersModel model = Common.Instance._Users.UserLogin(loginid, psd);
            return model;
        }
        

        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public static List<UsersModel> GetUsersList(Hashtable where)
        {
            return Common.Instance._Users.GetUsersList(where);
        }
        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        public static List<UsersModel> GetUsersListByPage(Hashtable where, SearchArgs args)
        {
            return Common.Instance._Users.GetUsersListByPage(where, args);
        }

        /// <summary>
        /// 根据loginid来获取uid
        /// </summary>
        /// <param name="loginid"></param>
        /// <returns></returns>
        public static UsersModel GetModelByLoginId(string loginid)
        {
            return Common.Instance._Users.GetModelByLoginId(loginid);
        }
        
        #endregion
         
    }
}
