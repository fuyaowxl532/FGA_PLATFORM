/*********************************************************************************************
 * 文件名       : PowersDAL.cs
 * 文件描述     : Powers业务逻辑类 
 *********************************************************************************************/
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_MODEL;

namespace FGA_BLL
{    
    public class PowersBLL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool AddPowers(PowersModel model)
        {
            model.pcode = Common.Instance._Powers.GetMaxPowerCode(model.pcode);
            return Common.Instance._Powers.AddPowers(model);
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdatePowers(PowersModel model)
        {
            return Common.Instance._Powers.UpdatePowers(model);
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool DeletePowers(PowersModel model)
        {
            return Common.Instance._Powers.DeletePowers(model);
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static PowersModel GetPowersInfo(PowersModel model)
        {
            return Common.Instance._Powers.GetPowersInfo(model);
        }
        #endregion
        
        #region //扩展函数
        
        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public static List<PowersModel> GetPowersList(Hashtable where)
        {
            return Common.Instance._Powers.GetPowersList(where);
        }

         /// <summary>
      /// 根据上级菜单 获取所有下级菜单
      /// </summary>
      /// <param name="powers"></param>
      /// <returns></returns>
        public static List<PowersModel> GetAllLastMenu(string powers)
        {
            return Common.Instance._Powers.GetAllLastMenu(powers);
        }

        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        //public static PowersModel GetPowersListByPage()
        //{
        //    return Common.Instance._Powers.GetPowersListByPage();
        //}
        
        #endregion
    }
}
