/*********************************************************************************************
 * 文件名       : PowersModel.cs
 * 文件描述     : 表模型 powers 
 *********************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_NUtility;

namespace FGA_MODEL
{   
    [Serializable]
    public class PowersModel
    { 
        #region //属性
        
        /// <summary>
        /// 主键
        /// </summary>
        public String pcode{ get;set; }
        
        public String pname{ get;set; }  
        
        public String pdescription{ get;set; }  
        
        public String purl{ get;set; }

        public int bz { get; set; }  

        #endregion
        
        #region //函数
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public PowersModel()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public PowersModel(DataRow row)
        {
            if(row.Table.Columns.Contains("pcode"))
                pcode = Convertor.ToString(row["pcode"]);     
            if(row.Table.Columns.Contains("pname"))
                pname = Convertor.ToString(row["pname"]);     
            if(row.Table.Columns.Contains("pdescription"))
                pdescription = Convertor.ToString(row["pdescription"]);     
            if(row.Table.Columns.Contains("purl"))
                purl = Convertor.ToString(row["purl"]);
            if (row.Table.Columns.Contains("bz"))
                bz = Convertor.ToInt32(row["bz"]);     
        }
        #endregion
    }
}
