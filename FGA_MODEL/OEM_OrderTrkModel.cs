using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class OEM_OrderTrkModel

    {
        public int RecordCnt { get; set; }
        public int Indexs { get; set; }
        public string OrderKey { get; set; }
        public string OrderNoID { get; set; }
        public string SerialNO { get; set; }
        public string OrderNO { get; set; }
        public string OrderType { get; set; }
        public string PartNO { get; set; }
        public string Customer { get; set; }
        public string Program { get; set; }
        public string AddressCode { get; set; }
        public string ContainerType { get; set; }
        public string KeyCenter { get; set; }
        public int StandardQuantity { get; set; }
        public int OrderQuantity { get; set; }
        public int BoxNum { get; set; }
        public int InBoundQty { get; set; }
        public int UnInBoundQty { get; set; }
        public int UnInBoundBox { get; set; }
        public DateTime PlanningDate { get; set; }
        public DateTime ShipmentDate { get; set; }
        public DateTime LastInBoundTime { get; set; }     
        public string Location { get; set; }
        public string OrderStatus { get; set; }
        public string DeliveryStatus { get; set; }
        public string Lastlocation { get; set; }
        public string LastInBoundUser { get; set; }
        public string Organization { get; set; }
        public string Notes { get; set; }
        public DateTime PlexCreateTime { get; set; }
        public string Operator { get; set; }
        public string TeamLeader { get; set; }
        public string Supervisor { get; set; }
        public string Manager { get; set; }
        
        public string Creater { get; set; }
        public DateTime Createdate { get; set; }
        public string LastEditUser { get; set; }
        public DateTime LastEditTime { get; set; }

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public OEM_OrderTrkModel()
        {
        
        }

          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public OEM_OrderTrkModel(DataRow row)
        {
            if (row.Table.Columns.Contains("RecordCnt"))
                RecordCnt = Convertor.ToInt32(row["RecordCnt"]);
            if (row.Table.Columns.Contains("Indexs"))
                Indexs = Convertor.ToInt32(row["Indexs"]);
            if (row.Table.Columns.Contains("SerialNO"))
                SerialNO = Convertor.ToString(row["SerialNO"]);
            if (row.Table.Columns.Contains("OrderKey"))
                OrderKey = Convertor.ToString(row["OrderKey"]);
            if (row.Table.Columns.Contains("OrderNoID"))
                OrderNoID = Convertor.ToString(row["OrderNoID"]);
            if (row.Table.Columns.Contains("OrderNO")) 
                OrderNO = Convertor.ToString(row["OrderNO"]);
            if (row.Table.Columns.Contains("OrderType"))
                OrderType = Convertor.ToString(row["OrderType"]);
            if (row.Table.Columns.Contains("PartNO"))
                PartNO = Convertor.ToString(row["PartNO"]);
            if (row.Table.Columns.Contains("Customer"))
                Customer = Convertor.ToString(row["Customer"]);
            if (row.Table.Columns.Contains("Program"))
                Program = Convertor.ToString(row["Program"]);
            if (row.Table.Columns.Contains("AddressCode"))
                AddressCode = Convertor.ToString(row["AddressCode"]);
            if (row.Table.Columns.Contains("ContainerType"))
                ContainerType = Convertor.ToString(row["ContainerType"]);
            if (row.Table.Columns.Contains("KeyCenter"))
                KeyCenter = Convertor.ToString(row["KeyCenter"]);
            if (row.Table.Columns.Contains("StandardQuantity"))
                StandardQuantity = Convertor.ToInt32(row["StandardQuantity"]);
            if (row.Table.Columns.Contains("OrderQuantity"))
                OrderQuantity = Convertor.ToInt32(row["OrderQuantity"]);
            if (row.Table.Columns.Contains("BoxNum"))
                BoxNum = Convertor.ToInt32(row["BoxNum"]);
            if (row.Table.Columns.Contains("InBoundQty"))
                InBoundQty = Convertor.ToInt32(row["InBoundQty"]);
            if (row.Table.Columns.Contains("UnInBoundQty"))
                UnInBoundQty = Convertor.ToInt32(row["UnInBoundQty"]);
            if (row.Table.Columns.Contains("UnInBoundBox"))
                UnInBoundBox = Convertor.ToInt32(row["UnInBoundBox"]);
            if (row.Table.Columns.Contains("PlanningDate"))
                PlanningDate = Convertor.ToDateTime(row["PlanningDate"]);
            if (row.Table.Columns.Contains("ShipmentDate"))
                ShipmentDate = Convertor.ToDateTime(row["ShipmentDate"]);
            if (row.Table.Columns.Contains("Location"))
                Location = Convertor.ToString(row["Location"]);
            if (row.Table.Columns.Contains("OrderStatus"))
                OrderStatus = Convertor.ToString(row["OrderStatus"]);
            if (row.Table.Columns.Contains("DeliveryStatus"))
                DeliveryStatus = Convertor.ToString(row["DeliveryStatus"]);
            if (row.Table.Columns.Contains("Lastlocation"))
                Lastlocation = Convertor.ToString(row["Lastlocation"]);
            if (row.Table.Columns.Contains("LastInBoundUser"))
                LastInBoundUser = Convertor.ToString(row["LastInBoundUser"]);
             if (row.Table.Columns.Contains("LastInBoundTime"))
                LastInBoundTime = Convertor.ToDateTime(row["LastInBoundTime"]);
            if (row.Table.Columns.Contains("Organization"))
                Organization = Convertor.ToString(row["Organization"]);
            if (row.Table.Columns.Contains("Notes"))
                Notes = Convertor.ToString(row["Notes"]);
            if (row.Table.Columns.Contains("PlexCreateTime"))
                PlexCreateTime = Convertor.ToDateTime(row["PlexCreateTime"]);
            if (row.Table.Columns.Contains("Operator"))
                Operator = Convertor.ToString(row["Operator"]);
            if (row.Table.Columns.Contains("TeamLeader"))
                TeamLeader = Convertor.ToString(row["TeamLeader"]);
            if (row.Table.Columns.Contains("Supervisor"))
                Supervisor = Convertor.ToString(row["Supervisor"]);
            if (row.Table.Columns.Contains("Manager"))
                Manager = Convertor.ToString(row["Manager"]);

            if (row.Table.Columns.Contains("Creater"))
                Creater = Convertor.ToString(row["Creater"]);
            if (row.Table.Columns.Contains("Createdate"))
                Createdate = Convertor.ToDateTime(row["Createdate"]);
            if (row.Table.Columns.Contains("LastEditUser"))
                LastEditUser = Convertor.ToString(row["LastEditUser"]);
            if (row.Table.Columns.Contains("LastEditTime"))
                LastEditTime = Convertor.ToDateTime(row["LastEditTime"]);
        }
    }

}
