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
    public class PartTransferctrlModel
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
        /// 从location
        /// </summary>
        public String FLOC { get; set; }
        /// <summary>
        /// 到location
        /// </summary>
        public String TLOC { get; set; }
        /// <summary>
        /// 事务类型
        /// </summary>
        public String TRANSACTIONTYPE { get; set; }
        /// <summary>
        /// 交接方式
        /// </summary>
        public String TRANSFERTYPE { get; set; }
        /// <summary>
        /// 创建人
        /// </summary>
        public String Creater { get; set; }
        /// <summary>
        /// 创建日期
        /// </summary>
        public DateTime CreateDate { get; set; }

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public PartTransferctrlModel()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public PartTransferctrlModel(DataRow row)
        {
            if (row.Table.Columns.Contains("ORGANIZATION"))
                ORGANIZATION = Convertor.ToString(row["ORGANIZATION"]);
            if (row.Table.Columns.Contains("FLOC"))
                FLOC = Convertor.ToString(row["FLOC"]);
            if (row.Table.Columns.Contains("TLOC"))
                TLOC = Convertor.ToString(row["TLOC"]);
            if (row.Table.Columns.Contains("OPERATION"))
                OPERATION = Convertor.ToString(row["OPERATION"]);
            if (row.Table.Columns.Contains("TRANSFERTYPE"))
                TRANSFERTYPE = Convertor.ToString(row["TRANSFERTYPE"]);
            if (row.Table.Columns.Contains("TRANSACTIONTYPE"))
                TRANSACTIONTYPE = Convertor.ToString(row["TRANSACTIONTYPE"]);
            if (row.Table.Columns.Contains("Creater"))
                Creater = Convertor.ToString(row["Creater"]);
            if (row.Table.Columns.Contains("CreateDate"))
                CreateDate = Convertor.ToDateTime(row["CreateDate"]);
        }
    }
}
