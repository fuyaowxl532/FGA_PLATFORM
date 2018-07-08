using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class ContainerViewObject
    {
        public int Indexs { get; set; }
        public int Recordcnt { get; set; }
        public string Barcode { get; set; }
        public string TypeNO { get; set; }
        public string CustomerPartNO { get; set; }
        public string ContainerType { get; set; }
        public string CustomerCode { get; set; }
        public string Program { get; set; }
        public string PartSerialNO { get; set; }
        public string ReceiptNO { get; set; }
        public string Status { get; set; }
        public string Active { get; set; }
        public string LastEditUser { get; set; }
        public DateTime LastUpdateDate { get; set; }
        public DateTime CreateDate { get; set; }
        public string Creator { get; set; }
        public string TranscationID { get; set; }
        public string TranscationUser { get; set; }
        public DateTime TranscationTime { get; set; }
        public string SerialNO { get; set; }
        public int dr { get; set; }


        /// <summary>
        /// 默认构造函数
        /// </summary>
        public ContainerViewObject()
        {
        
        }

          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public ContainerViewObject(DataRow row)
        {
            if (row.Table.Columns.Contains("Indexs"))
                Indexs = Convertor.ToInt32(row["Indexs"]);
            if (row.Table.Columns.Contains("Recordcnt"))
                Recordcnt = Convertor.ToInt32(row["Recordcnt"]);
            if (row.Table.Columns.Contains("TranscationID"))
                TranscationID = Convertor.ToString(row["TranscationID"]);
            if (row.Table.Columns.Contains("TranscationUser"))
                TranscationUser = Convertor.ToString(row["TranscationUser"]);
            if (row.Table.Columns.Contains("SerialNO"))
                SerialNO = Convertor.ToString(row["SerialNO"]);
            if (row.Table.Columns.Contains("dr"))
                dr = Convertor.ToInt32(row["dr"]);
            if (row.Table.Columns.Contains("TranscationTime"))
                TranscationTime = Convertor.ToDateTime(row["TranscationTime"]);

            if (row.Table.Columns.Contains("Barcode"))
                Barcode = Convertor.ToString(row["Barcode"]);
            if (row.Table.Columns.Contains("Status"))
                Status = Convertor.ToString(row["Status"]);
            if (row.Table.Columns.Contains("Active"))
                Active = Convertor.ToString(row["Active"]);
            if (row.Table.Columns.Contains("TypeNO"))
                TypeNO = Convertor.ToString(row["TypeNO"]);
            if (row.Table.Columns.Contains("CustomerPartNO"))
                CustomerPartNO = Convertor.ToString(row["CustomerPartNO"]);
            if (row.Table.Columns.Contains("ContainerType"))
                ContainerType = Convertor.ToString(row["ContainerType"]);
            if (row.Table.Columns.Contains("CustomerCode"))
                CustomerCode = Convertor.ToString(row["CustomerCode"]);
            if (row.Table.Columns.Contains("Program"))
                Program = Convertor.ToString(row["Program"]);
            if (row.Table.Columns.Contains("PartSerialNO"))
                PartSerialNO = Convertor.ToString(row["PartSerialNO"]);
            if (row.Table.Columns.Contains("ReceiptNO"))
                ReceiptNO = Convertor.ToString(row["ReceiptNO"]);
            if (row.Table.Columns.Contains("LastEditUser"))
                LastEditUser = Convertor.ToString(row["LastEditUser"]);
            if (row.Table.Columns.Contains("LastUpdateDate"))
                LastUpdateDate = Convertor.ToDateTime(row["LastUpdateDate"]);
            if (row.Table.Columns.Contains("Creator"))
                Creator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("CreateDate"))
                CreateDate = Convertor.ToDateTime(row["CreateDate"]);
        }
    }

}
