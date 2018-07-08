using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    [Serializable]
    public class ReasonModel
    {
        #region //属性
        
        /// <summary>
        /// 主键
        /// </summary>
        public Int32 id{ get;set; }
        
        public String reason{ get;set; }

        public String ReasonDesc { get; set; }  
        

        #endregion
        
        #region //函数
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public ReasonModel()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public ReasonModel(DataRow row)
        {
            if(row.Table.Columns.Contains("id"))
                id = Convertor.ToInt32(row["id"]);
            if (row.Table.Columns.Contains("reason"))
                reason = Convertor.ToString(row["reason"]);
            if (row.Table.Columns.Contains("ReasonDesc"))
                ReasonDesc = Convertor.ToString(row["ReasonDesc"]);         
        }
        #endregion
    }
}
