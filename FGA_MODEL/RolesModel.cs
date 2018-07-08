/*********************************************************************************************
 * 文件名       : RolesModel.cs
 * 文件描述     : 表模型 roles 
 *********************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_NUtility;

namespace FGA_MODEL
{   
    [Serializable]
    public class RolesModel
    { 
        #region //属性
        
        /// <summary>
        /// 主键
        /// </summary>
        public Int32 rid{ get;set; }
        
        public String rgroup{ get;set; }  
        
        public String rname{ get;set; }  
        
        public int state{ get;set; }  
        #endregion
        
        #region //函数
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public RolesModel()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public RolesModel(DataRow row)
        {
            if(row.Table.Columns.Contains("rid"))
                rid = Convertor.ToInt32(row["rid"]);     
            if(row.Table.Columns.Contains("rgroup"))
                rgroup = Convertor.ToString(row["rgroup"]);     
            if(row.Table.Columns.Contains("rname"))
                rname = Convertor.ToString(row["rname"]);     
            if(row.Table.Columns.Contains("state"))
                state = Convertor.ToSByte(row["state"]);     
        }
        #endregion
    }
}
