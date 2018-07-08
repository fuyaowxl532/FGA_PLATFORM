using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL.ARG
{
    public class ARGOrderListModel
    {
        public int Indexs { get; set; }
        public string OrderKey { get; set; }
        public string SerialNO { get; set; }
        public string OrderNO { get; set; }
        public string PartNO { get; set; }
        public string LabelNO { get; set; }
        public string CustomerNO { get; set; }
        public string CustName { get; set; }
        public string InvoiceNO { get; set; }
        public string SubInvNO { get; set; }
        public string BoxType { get; set; }
        public string BoxNO { get; set; }
        public string BoxMethod { get; set; }
        public string Barcode { get; set; }
        public DateTime OrderDate { get; set; }
        public DateTime ShipmentDate { get; set; }
        public string OrderStatus { get; set; }
        public string OrderType { get; set; }
        public string InBoundUser { get; set; }
        public DateTime IntBoundDate { get; set; }
        public DateTime OutBoundDate { get; set; }
        public string LastEditUser { get; set; }
        public DateTime LastEditDate { get; set; }
        public string InvCheck { get; set; }
        public string ConvertSign { get; set; }
        public string Location { get; set; }
        public int InBoundQTY { get; set; }
        public int Quantity { get; set; }
        public string PO { get; set; }
        public string Status { get; set; }
        public string Creator { get; set; }
        public DateTime CreateDate { get; set; }

        public ARGOrderListModel() {
        }

        public ARGOrderListModel(DataRow row)
        {
            if (row.Table.Columns.Contains("Indexs"))
                Indexs = Convertor.ToInt32(row["Indexs"]);
            if (row.Table.Columns.Contains("ItemID"))
                OrderKey = Convertor.ToString(row["ItemID"]);
            if (row.Table.Columns.Contains("PlanNO"))
                SerialNO = Convertor.ToString(row["PlanNO"]);
            if (row.Table.Columns.Contains("ItemCode"))
                PartNO = Convertor.ToString(row["ItemCode"]);
            if (row.Table.Columns.Contains("InvoiceNO"))
                InvoiceNO = Convertor.ToString(row["InvoiceNO"]);
            if (row.Table.Columns.Contains("LabelNO"))
                LabelNO = Convertor.ToString(row["LabelNO"]);
            if (row.Table.Columns.Contains("CustomerName"))
                CustName = Convertor.ToString(row["CustomerName"]);
            if (row.Table.Columns.Contains("BoxType"))
                BoxType = Convertor.ToString(row["BoxType"]);
            if (row.Table.Columns.Contains("BoxMethod"))
                BoxMethod = Convertor.ToString(row["BoxMethod"]);
            if (row.Table.Columns.Contains("TargetBinCode"))
                Location = Convertor.ToString(row["TargetBinCode"]);
            if (row.Table.Columns.Contains("BarcodeNO"))
                Barcode = Convertor.ToString(row["BarcodeNO"]);
            if (row.Table.Columns.Contains("SOQuantity"))
                Quantity = Convertor.ToInt32(row["SOQuantity"]);
            if (row.Table.Columns.Contains("BoxNO"))
                BoxNO = Convertor.ToString(row["BoxNO"]);
            if (row.Table.Columns.Contains("InboundQuantity"))
            {
                string value = row["InboundQuantity"].ToString().Substring(0, row["InboundQuantity"].ToString().IndexOf("."));
                InBoundQTY = Convert.ToInt32(value);
            }

            if (row.Table.Columns.Contains("IRUser"))
                InBoundUser = Convertor.ToString(row["IRUser"]);
            if (row.Table.Columns.Contains("InboundTime"))
                IntBoundDate = Convertor.ToDateTime(row["InboundTime"]);
            if (row.Table.Columns.Contains("OutboundTime"))
                OutBoundDate = Convertor.ToDateTime(row["OutboundTime"]);
            if (row.Table.Columns.Contains("LastEditUser"))
                LastEditUser = Convertor.ToString(row["LastEditUser"]);
            if (row.Table.Columns.Contains("LastEditDate"))
                LastEditDate = Convertor.ToDateTime(row["LastEditDate"]);
            if (row.Table.Columns.Contains("CreateUser"))
                Creator = Convertor.ToString(row["CreateUser"]);
            if (row.Table.Columns.Contains("CreateDate"))
                CreateDate = Convertor.ToDateTime(row["CreateDate"]);
          
        }
    }
}
