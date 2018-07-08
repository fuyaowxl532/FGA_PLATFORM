using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class PlexContainer
    {
        public int Indexs { get; set; }
        public int Recordcnt { get; set; }
        public string rn { get; set; }
        public string Organization { get; set; }
        public string SerialNO { get; set; }
        public string PartNO   { get; set; }
        public string KeyCenter { get; set; }
        public string PartKey { get; set; }
        public string BatchNO { get; set; }
        public string OperationCode { get; set; }
        public string TransactionType { get; set; }
        public string TransferType { get; set; }
        public string OperationNo { get; set; }
        public string ContainerStatus { get; set; }
        public string ContainerType { get; set; }
        public DateTime ShipmentDate { get; set; }
        public string Location { get; set; }
        public string TLoc { get; set; }
        public string IRType { get; set; }
        public decimal Quantity    { get; set; }
        public decimal MaterialQty { get; set; }
        public int Active      { get; set; }

        public string Creater { get; set; }
        public DateTime Createdate { get; set; }

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public PlexContainer()
        {
        
        }

          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public PlexContainer(DataRow row)
        {
            if (row.Table.Columns.Contains("Indexs"))
                Indexs = Convertor.ToInt32(row["Indexs"]);
            if (row.Table.Columns.Contains("Recordcnt"))
                Recordcnt = Convertor.ToInt32(row["Recordcnt"]);
            if (row.Table.Columns.Contains("rn"))
                rn = Convertor.ToString(row["rn"]);
            if (row.Table.Columns.Contains("Organization"))
                Organization = Convertor.ToString(row["Organization"]);
            if (row.Table.Columns.Contains("TransactionType"))
                TransactionType = Convertor.ToString(row["TransactionType"]);
            if (row.Table.Columns.Contains("TransferType"))
                TransferType = Convertor.ToString(row["TransferType"]);
            if (row.Table.Columns.Contains("SerialNO"))
                SerialNO = Convertor.ToString(row["SerialNO"]);
            if (row.Table.Columns.Contains("PartNO"))
                PartNO = Convertor.ToString(row["PartNO"]);
            if (row.Table.Columns.Contains("KeyCenter"))
                KeyCenter = Convertor.ToString(row["KeyCenter"]);
            if (row.Table.Columns.Contains("PartKey"))
                PartKey = Convertor.ToString(row["PartKey"]);
            if (row.Table.Columns.Contains("BatchNO"))
                BatchNO = Convertor.ToString(row["BatchNO"]);
            if (row.Table.Columns.Contains("OperationCode"))
                OperationCode = Convertor.ToString(row["OperationCode"]);
            if (row.Table.Columns.Contains("OperationNo"))
                OperationNo = Convertor.ToString(row["OperationNo"]);
            if (row.Table.Columns.Contains("ContainerStatus"))
                ContainerStatus = Convertor.ToString(row["ContainerStatus"]);
            if (row.Table.Columns.Contains("ContainerType"))
                ContainerType = Convertor.ToString(row["ContainerType"]);
            if (row.Table.Columns.Contains("ShipmentDate"))
                ShipmentDate = Convertor.ToDateTime(row["ShipmentDate"]);
            if (row.Table.Columns.Contains("From_LOC"))
                Location = Convertor.ToString(row["From_LOC"]);
            if (row.Table.Columns.Contains("IRType"))
                IRType = Convertor.ToString(row["IRType"]);
            if (row.Table.Columns.Contains("To_LOC"))
                TLoc = Convertor.ToString(row["To_LOC"]);
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToDecimal(row["Quantity"]);
            if (row.Table.Columns.Contains("MaterialQty"))
                MaterialQty = Convertor.ToDecimal(row["MaterialQty"]);
            if (row.Table.Columns.Contains("Active"))
                Active = Convertor.ToInt32(row["Active"]);

            if (row.Table.Columns.Contains("Creater"))
                Creater = Convertor.ToString(row["Creater"]);
            if (row.Table.Columns.Contains("Createdate"))
                Createdate = Convertor.ToDateTime(row["Createdate"]);
        }
    }

}
