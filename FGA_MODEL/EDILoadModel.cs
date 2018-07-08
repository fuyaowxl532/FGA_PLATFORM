using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class EDILoadModel
    {
        public string LoadID { get; set; }
        public string CustomerAddress{ get; set; }
        public DateTime ShipDate { get; set; }
        public DateTime DueDate { get; set; }
        public string LoadStatus { get; set; }
        public int Quantity { get; set; }
        public string Creator { get; set; }
        public string SerialNO { get; set; }
        public DateTime CreateDate { get; set; }

         /// <summary>
        /// 默认构造函数
        /// </summary>
        public EDILoadModel()
        {
        
        }

          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public EDILoadModel(DataRow row)
        {
            if (row.Table.Columns.Contains("LoadID"))
                LoadID = Convertor.ToString(row["LoadID"]);
            if (row.Table.Columns.Contains("CustomerAddress"))
                CustomerAddress = Convertor.ToString(row["CustomerAddress"]);
            if (row.Table.Columns.Contains("LoadStatus"))
                LoadStatus = Convertor.ToString(row["LoadStatus"]);
            if (row.Table.Columns.Contains("SerialNO"))
                SerialNO = Convertor.ToString(row["SerialNO"]);
            if (row.Table.Columns.Contains("Creator"))
                Creator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("ShipDate"))
                ShipDate = Convertor.ToDateTime(row["ShipDate"]);
            if (row.Table.Columns.Contains("DueDate"))
                DueDate = Convertor.ToDateTime(row["DueDate"]);
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToInt32(row["Quantity"]);
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToInt32(row["Quantity"]);
            if (row.Table.Columns.Contains("CreateDate"))
                CreateDate = Convertor.ToDateTime(row["CreateDate"]);
        }
    }

}
