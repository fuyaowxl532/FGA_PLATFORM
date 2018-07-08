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
    public class userctrlModel
    {
        /// <summary>
        /// 用户组织
        /// </summary>
        public String ORGANIZATION { get; set; }
        /// <summary>
        /// 用户账号
        /// </summary>
        public String USERNAME { get; set; }
        /// <summary>
        /// 数量
        /// </summary>
        public int QUANTITY { get; set; }
        /// <summary>
        /// 工序
        /// </summary>
        public String OPERATION { get; set; }
        /// <summary>
        /// WorkCenter
        /// </summary>
        public String WORKCENTER { get; set; }
        /// <summary>
        /// 班组
        /// </summary>
        public String SHIFT { get; set; }
        /// <summary>
        /// 控制类型
        /// </summary>
        public String UTYPE { get; set; }
        /// <summary>
        /// 事务类型
        /// </summary>
        public String TRANSACTIONTYPE { get; set; }
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
        public userctrlModel()
        {
        
        }

        /// <summary>
        /// 根据DataRow构造函数WORKCENTER
        /// </summary>
        public userctrlModel(DataRow row)
        {
            if (row.Table.Columns.Contains("ORGANIZATION"))
                ORGANIZATION = Convertor.ToString(row["ORGANIZATION"]);
            if (row.Table.Columns.Contains("USERNAME"))
                USERNAME = Convertor.ToString(row["USERNAME"]);
            if (row.Table.Columns.Contains("WORKCENTER"))
                WORKCENTER = Convertor.ToString(row["WORKCENTER"]);
            if (row.Table.Columns.Contains("QUANTITY"))
                QUANTITY = Convertor.ToInt32(row["QUANTITY"]);
            if (row.Table.Columns.Contains("OPERATION"))
                OPERATION = Convertor.ToString(row["OPERATION"]);
            if (row.Table.Columns.Contains("SHIFT"))
                SHIFT = Convertor.ToString(row["SHIFT"]);
            if (row.Table.Columns.Contains("UTYPE"))
                UTYPE = Convertor.ToString(row["UTYPE"]);
            if (row.Table.Columns.Contains("TRANSACTIONTYPE"))
                TRANSACTIONTYPE = Convertor.ToString(row["TRANSACTIONTYPE"]);
            if (row.Table.Columns.Contains("Creater"))
                Creater = Convertor.ToString(row["Creater"]);
            if (row.Table.Columns.Contains("CreateDate"))
                CreateDate = Convertor.ToDateTime(row["CreateDate"]);
        }
    }
}
