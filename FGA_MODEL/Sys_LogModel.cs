/*********************************************************************************************
 * 文件名       : Sys_LogModel.cs
 * 文件描述     : 表模型 sys_log 
 *********************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_NUtility;

namespace FGA_MODEL
{   
    [Serializable]
    public class Sys_LogModel
    { 
        #region //属性

        //zt：页面名 kt：方法名  action：类型，是常规性日志还是出错信息 result：日志详细信息  type：一级菜单 type1:二级菜单
        /// <summary>
        /// 主键
        /// </summary>
        public Int32 id{ get;set; }
        /// <summary>
        /// 页面名
        /// </summary>
        public String zt{ get;set; }  
        /// <summary>
        /// 方法名
        /// </summary>
        public String kt{ get;set; }  
        /// <summary>
        /// 类型，是常规性日志还是出错信息
        /// </summary>
        public Int32 action{ get;set; }  
        
        public string add_time{ get;set; }  
        /// <summary>
        /// 日志详细信息
        /// </summary>
        public String result{ get;set; }  
        /// <summary>
        /// 一级菜单
        /// </summary>
        public Int32 type{ get;set; }
        /// <summary>
        /// 二级菜单
        /// </summary>
        public Int32 type1 { get; set; }

        /// <summary>
        /// 操作人ID
        /// </summary>
        public Int32 uid { get; set; }

        public String fullName { get; set; }

        public String ip { get; set; }  

        #endregion
        
        #region //函数
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public Sys_LogModel()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public Sys_LogModel(DataRow row)
        {
            if(row.Table.Columns.Contains("id"))
                id = Convertor.ToInt32(row["id"]);     
            if(row.Table.Columns.Contains("zt"))
                zt = Convertor.ToString(row["zt"]);     
            if(row.Table.Columns.Contains("kt"))
                kt = Convertor.ToString(row["kt"]);     
            if(row.Table.Columns.Contains("action"))
                action = Convertor.ToInt32(row["action"]);     
            if(row.Table.Columns.Contains("add_time"))
                add_time = Convertor.ToString(row["add_time"]);     
            if(row.Table.Columns.Contains("result"))
                result = Convertor.ToString(row["result"]);     
            if(row.Table.Columns.Contains("type"))
                type = Convertor.ToInt32(row["type"]);
            if (row.Table.Columns.Contains("type1"))
                type1 = Convertor.ToInt32(row["type1"]);
            if (row.Table.Columns.Contains("uid"))
                uid = Convertor.ToInt32(row["uid"]);
            if (row.Table.Columns.Contains("fullname"))
                fullName = Convertor.ToString(row["fullname"]);
            if (row.Table.Columns.Contains("ip"))
                ip = Convertor.ToString(row["ip"]);  
        }
        #endregion
    }
}
