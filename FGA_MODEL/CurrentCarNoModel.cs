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
    public class CurrentCarNoModel
    {
        
        /// <summary>
        /// 用户账号
        /// </summary>
        public String WORKCENTER { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public String CURRENTCARNO  { get; set; }
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public CurrentCarNoModel()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public CurrentCarNoModel(DataRow row)
        {

            if (row.Table.Columns.Contains("WORKCENTER"))
                WORKCENTER = Convertor.ToString(row["WORKCENTER"]);
            if (row.Table.Columns.Contains("CURRENTCARNO"))
                CURRENTCARNO = Convertor.ToString(row["CURRENTCARNO"]);
        }
    }
}
