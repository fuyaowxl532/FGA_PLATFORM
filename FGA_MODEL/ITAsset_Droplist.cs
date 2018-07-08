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
    public class ITAssetDroplist
    {
        
        /// <summary>
        /// 用户账号
        /// </summary>
        public String valuetype { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public String value  { get; set; }
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public ITAssetDroplist()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public ITAssetDroplist(DataRow row)
        {

            if (row.Table.Columns.Contains("valuetype"))
                valuetype = Convertor.ToString(row["valuetype"]);
            if (row.Table.Columns.Contains("value"))
                value = Convertor.ToString(row["value"]);
        }
    }
}
