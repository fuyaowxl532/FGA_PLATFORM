/*********************************************************************************************
 * 文件名       : RolepowersModel.cs
 * 文件描述     : 表模型 rolepowers 
 *********************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_NUtility;

namespace FGA_MODEL
{   
    [Serializable]
    public class RolepowersModel
    { 
        #region //属性
        
        /// <summary>
        /// 主键
        /// </summary>
        public Int32 rpid{ get;set; }
        
        public Int32 roleid{ get;set; }  
        
        public String pcode{ get;set; }  
        #endregion
        
        #region //函数
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public RolepowersModel()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public RolepowersModel(DataRow row)
        {
            if(row.Table.Columns.Contains("rpid"))
                rpid = Convertor.ToInt32(row["rpid"]);     
            if(row.Table.Columns.Contains("roleid"))
                roleid = Convertor.ToInt32(row["roleid"]);     
            if(row.Table.Columns.Contains("pcode"))
                pcode = Convertor.ToString(row["pcode"]);     
        }
        #endregion
    }
}
