using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class SmalllotModel
    {
        public string LoadID { get; set; }
        public string SerialNO { get; set; }
        public string SerialNO_HIS { get; set; }
        public int CurrPosition   { get; set; }
        public int TotalPos { get; set; }
        public string PartNO { get; set; }
        public string Rev { get; set; }
        public int Quantity { get; set; }
        public string CustomerName { get; set; }
        public string ShipTo { get; set; }
        public string LockFlag { get; set; }
        public string LockDesc { get; set; }

        public string LastUser { get; set; }
        public DateTime LastEditTime { get; set; }

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public SmalllotModel()
        {
        
        }

          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public SmalllotModel(DataRow row)
        {
            if (row.Table.Columns.Contains("LoadID"))
                LoadID = Convertor.ToString(row["LoadID"]);
            if (row.Table.Columns.Contains("SerialNO"))
                SerialNO = Convertor.ToString(row["SerialNO"]);
            if (row.Table.Columns.Contains("SerialNO_HIS"))
                SerialNO_HIS = Convertor.ToString(row["SerialNO_HIS"]);
            if (row.Table.Columns.Contains("CurrPosition"))
                CurrPosition = Convertor.ToInt32(row["CurrPosition"]);
            if (row.Table.Columns.Contains("TotalPos"))
                TotalPos = Convertor.ToInt32(row["TotalPos"]);
            if (row.Table.Columns.Contains("PartNO"))
                PartNO = Convertor.ToString(row["PartNO"]);
            if (row.Table.Columns.Contains("Rev"))
                Rev = Convertor.ToString(row["Rev"]);
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToInt32(row["Quantity"]);
            if (row.Table.Columns.Contains("CustomerName"))
                CustomerName = Convertor.ToString(row["CustomerName"]);
            if (row.Table.Columns.Contains("ShipTo"))
                ShipTo = Convertor.ToString(row["ShipTo"]);
            if (row.Table.Columns.Contains("LockFlag"))
                LockFlag = Convertor.ToString(row["LockFlag"]);
            if (row.Table.Columns.Contains("LockDesc"))
                LockDesc = Convertor.ToString(row["LockDesc"]);
          
            if (row.Table.Columns.Contains("LastUser"))
                LastUser = Convertor.ToString(row["LastUser"]);
            if (row.Table.Columns.Contains("LastEditTime"))
                LastEditTime = Convertor.ToDateTime(row["LastEditTime"]);
        }
    }

}
