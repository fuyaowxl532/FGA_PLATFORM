using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class InterPlantTransferModel
    {
        public string TransferNO { get; set; }
        public string Factory { get; set; }
        public string Transtatus { get; set; }
        public string SerialNO { get; set; }
        public string PartNO { get; set; }
        public string F_Location { get; set; }
        public string T_Location { get; set; }
        public decimal Quantity { get; set; }
        public string Creator { get; set; }
        public DateTime CreateDate { get; set; }
        public string Receiver { get; set; }
        public DateTime ReceptionDate { get; set; }

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public InterPlantTransferModel()
        {
        
        }

          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public InterPlantTransferModel(DataRow row)
        {
            if (row.Table.Columns.Contains("TransferNO"))
                TransferNO = Convertor.ToString(row["TransferNO"]);
            if (row.Table.Columns.Contains("Factory"))
                Factory = Convertor.ToString(row["Factory"]);
            if (row.Table.Columns.Contains("Transtatus"))
                Transtatus = Convertor.ToString(row["Transtatus"]);
            if (row.Table.Columns.Contains("F_Location"))
                F_Location = Convertor.ToString(row["F_Location"]);
            if (row.Table.Columns.Contains("T_Location"))
                T_Location = Convertor.ToString(row["T_Location"]);
            if (row.Table.Columns.Contains("PartNO"))
                PartNO = Convertor.ToString(row["PartNO"]);
            if (row.Table.Columns.Contains("SerialNO"))
                SerialNO = Convertor.ToString(row["SerialNO"]);
            if (row.Table.Columns.Contains("Creator"))
                Creator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToDecimal(row["Quantity"]);
            if (row.Table.Columns.Contains("CreateDate"))
                CreateDate = Convertor.ToDateTime(row["CreateDate"]);
            if (row.Table.Columns.Contains("Receiver"))
                Receiver = Convertor.ToString(row["Receiver"]);
            if (row.Table.Columns.Contains("ReceptionDate"))
                ReceptionDate = Convertor.ToDateTime(row["ReceptionDate"]);
        }
    }

}
