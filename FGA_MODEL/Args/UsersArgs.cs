/*********************************************************************************************
 * 文件名       : UsersArgs.cs
 * 文件描述     : users 查询参数枚举
 *********************************************************************************************/
using System;
using System.Text;

namespace FGA_MODEL.Args
{   
    /// <summary>
    /// 查询参数枚举: 使用时请结合实际条件增减
    /// </summary>
    public enum UsersArgs
    { 
        USERNAME,
        STATUS,
        OrderBy
    }
}
