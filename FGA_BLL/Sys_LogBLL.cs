using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_MODEL;
using FGA_MODEL.Args;

namespace FGA_BLL
{
   public class Sys_LogBLL
    {
        #region //增删改查基本操作

        /// <summary>
        ///  zt：页面名 kt：方法名  action：类型，是常规性日志还是出错信息 result：日志详细信息  type：一级菜单 type1:二级菜单
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public static bool AddSys_Log(Sys_LogModel model)
        {
            return Common.Instance._Sys_Log.AddSys_Log(model);
        }
        /// <summary>
        /// 改  zt：页面名 kt：方法名  action：类型，是常规性日志还是出错信息 result：日志详细信息  type：模块
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public static bool UpdateSys_Log(Sys_LogModel model)
        {
            return Common.Instance._Sys_Log.UpdateSys_Log(model);
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static bool DeleteSys_Log(Sys_LogModel model)
        {
            return Common.Instance._Sys_Log.DeleteSys_Log(model);
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static Sys_LogModel GetSys_LogInfo(Sys_LogModel model)
        {
            return Common.Instance._Sys_Log.GetSys_LogInfo(model);
        }

        /// <summary>
       /// 自己输入查询条件
       /// </summary>
       /// <param name="where"></param>
       /// <returns></returns>
        public static List<Sys_LogModel> GetUsersListByPage(Hashtable where, SearchArgs args)
        {
            return Common.Instance._Sys_Log.GetUsersListByPage(where, args);
        }

       /// <summary>
        /// 根据where条件查询所有数据
       /// </summary>
       /// <param name="where"></param>
       /// <returns></returns>
        public static List<Sys_LogModel> GetUsersListByWhere(string where)
        {
            return Common.Instance._Sys_Log.GetUsersListByWhere(where);
        }

        #endregion
    }
}
