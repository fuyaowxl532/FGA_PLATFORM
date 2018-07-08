using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL.Financial
{
    public class CycleInventory_H
    {
        public int RecordCnt { get; set; }
        public int Indexs { get; set; }
        public string CycleNO { get; set; }
        public string Location { get; set; }
        public int CycleID { get; set; }
        public string CycleStatus { get; set; }
        public string StartBy { get; set; }
        public string CompleteBy { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime CompleteDate { get; set; }

        public CycleInventory_H()
        {
        }

        public CycleInventory_H(DataRow row)
        {
            if (row.Table.Columns.Contains("RecordCnt"))
                RecordCnt = Convertor.ToInt32(row["RecordCnt"]);
            if (row.Table.Columns.Contains("Indexs"))
                Indexs = Convertor.ToInt32(row["Indexs"]);
            if (row.Table.Columns.Contains("CycleNO"))
                CycleNO = Convertor.ToString(row["CycleNO"]);
            if (row.Table.Columns.Contains("Location"))
                Location = Convertor.ToString(row["Location"]);
            if (row.Table.Columns.Contains("CycleID"))
                CycleID = Convertor.ToInt32(row["CycleID"]);
            if (row.Table.Columns.Contains("CycleStatus"))
                CycleStatus = Convertor.ToString(row["CycleStatus"]);
            if (row.Table.Columns.Contains("StartBy"))
                StartBy = Convertor.ToString(row["StartBy"]);
            if (row.Table.Columns.Contains("CompleteBy"))
                CompleteBy = Convertor.ToString(row["CompleteBy"]);
            if (row.Table.Columns.Contains("StartDate"))
                StartDate = Convertor.ToDateTime(row["StartDate"]);
            if (row.Table.Columns.Contains("CompleteDate"))
                CompleteDate = Convertor.ToDateTime(row["CompleteDate"]);
        }
    }
}
