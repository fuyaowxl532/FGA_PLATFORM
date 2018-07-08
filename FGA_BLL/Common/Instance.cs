
/*********************************************************************************************
 * 文件名       : Instance.cs
 * 文件描述     : 查询参数枚举，提供统一数据层DAL逻辑调用入口
 *********************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using FGA_DAL;

namespace FGA_BLL.Common
{
    /// <summary>
    /// 数据层实例
    /// </summary>
    internal class Instance
    {

        /// <summary>
        /// powers 
        /// </summary>
        internal static PowersDAL _Powers = new PowersDAL();


        /// <summary>
        /// rolepowers 
        /// </summary>
        internal static RolepowersDAL _Rolepowers = new RolepowersDAL();

        /// <summary>
        /// roles 
        /// </summary>
        internal static RolesDAL _Roles = new RolesDAL(); 

        /// <summary>
        /// userroles 
        /// </summary>
        internal static UserrolesDAL _Userroles = new UserrolesDAL();

        /// <summary>
        /// users 
        /// </summary>
        internal static UsersDAL _Users = new UsersDAL();
        /// <summary>
        /// sys_log 
        /// </summary>
        internal static Sys_LogDAL _Sys_Log = new Sys_LogDAL();

        internal static ReasonDAL _Reason = new ReasonDAL();

    }
}