using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL.Financial
{
    public class CycleInventory_Detail
    {
        public int RecordCnt { get; set; }
        public int Indexs { get; set; }
        public string CycleNO { get; set; }
        public string CycleStatus { get; set; }
        public int CycleRowID { get; set; }
        public string SerialNO { get; set; }
        public string PartNO { get; set; }
        public string OperationCode { get; set; }
        public string PartName { get; set; }
        public string Location { get; set; }
        public string TargetLocation { get; set; }
        public decimal Quantity { get; set; }
        public decimal ActualQty { get; set; }
      
        public string Creator { get; set; }
        public string Dr { get; set; }
        public DateTime Createtime { get; set; }

        public CycleInventory_Detail() {

        }

        public CycleInventory_Detail(DataRow row) {

            if (row.Table.Columns.Contains("RecordCnt"))
                RecordCnt = Convertor.ToInt32(row["RecordCnt"]);
            if (row.Table.Columns.Contains("Indexs"))
                Indexs = Convertor.ToInt32(row["Indexs"]);
            if (row.Table.Columns.Contains("CycleNO"))
                CycleNO = Convertor.ToString(row["CycleNO"]);
            if (row.Table.Columns.Contains("CycleStatus"))
                CycleStatus = Convertor.ToString(row["CycleStatus"]);
            if (row.Table.Columns.Contains("CycleRowID"))
                CycleRowID = Convertor.ToInt32(row["CycleRowID"]);
            if (row.Table.Columns.Contains("SerialNO"))
                SerialNO = Convertor.ToString(row["SerialNO"]);
            if (row.Table.Columns.Contains("PartNO"))
                PartNO = Convertor.ToString(row["PartNO"]);
            if (row.Table.Columns.Contains("PartName"))
                PartName = Convertor.ToString(row["PartName"]);
            if (row.Table.Columns.Contains("OperationCode"))
                OperationCode = Convertor.ToString(row["OperationCode"]);
            if (row.Table.Columns.Contains("Location"))
                Location = Convertor.ToString(row["Location"]);
            if (row.Table.Columns.Contains("TargetLocation"))
                TargetLocation = Convertor.ToString(row["TargetLocation"]);
            if (row.Table.Columns.Contains("Dr"))
                Dr = Convertor.ToString(row["Dr"]);
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToDecimal(row["Quantity"]);
            if (row.Table.Columns.Contains("ActualQty"))
                ActualQty = Convertor.ToDecimal(row["ActualQty"]);
            if (row.Table.Columns.Contains("Creator"))
                Creator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("Createtime"))
                Createtime = Convertor.ToDateTime(row["Createtime"]);
        }

    }
}
