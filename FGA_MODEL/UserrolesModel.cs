/*********************************************************************************************
 * 文件名       : UserrolesModel.cs
 * 文件描述     : 表模型 userroles 
 *********************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_NUtility;

namespace FGA_MODEL
{   
    [Serializable]
    public class UserrolesModel
    { 
        #region //属性
        
        /// <summary>
        /// 主键
        /// </summary>
        public Int32 urid{ get;set; }
        
        public Int32 uid{ get;set; }  
        
        public Int32 rid{ get;set; }  
        #endregion
        
        #region //函数
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public UserrolesModel()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public UserrolesModel(DataRow row)
        {
            if(row.Table.Columns.Contains("urid"))
                urid = Convertor.ToInt32(row["urid"]);     
            if(row.Table.Columns.Contains("uid"))
                uid = Convertor.ToInt32(row["uid"]);     
            if(row.Table.Columns.Contains("rid"))
                rid = Convertor.ToInt32(row["rid"]);     
        }
        #endregion
    }
}
