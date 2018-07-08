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
    public class HandOverHead
    {
        /// <summary>
        /// 用户组织
        /// </summary>
        public String ORGANIZATION { get; set; }
        /// <summary>
        /// 工序
        /// </summary>
        public String OPERATION { get; set; }
        /// <summary>
        /// WorkCenter
        /// </summary>
        public String WORKCENTER { get; set; }
        /// <summary>
        /// 批次号
        /// </summary>
        public String BATCHNO { get; set; }

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public HandOverHead()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public HandOverHead(DataRow row)
        {
            if (row.Table.Columns.Contains("ORGANIZATION"))
                ORGANIZATION = Convertor.ToString(row["ORGANIZATION"]);
            if (row.Table.Columns.Contains("BATCHNO"))
                BATCHNO = Convertor.ToString(row["BATCHNO"]);
            if (row.Table.Columns.Contains("OPERATION"))
                OPERATION = Convertor.ToString(row["OPERATION"]);
            if (row.Table.Columns.Contains("WorkCenter"))
                WORKCENTER = Convertor.ToString(row["WorkCenter"]);
        }
    }
}
