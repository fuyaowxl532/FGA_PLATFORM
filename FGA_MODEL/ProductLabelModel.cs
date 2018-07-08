using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class ProductLabelModel
    {
        public string ItemID { get; set; }
        public string SerialNO { get; set; }
        public string PartNO { get; set; }
        public string LabelNO { get; set; }
        public string CustName { get; set; }
        public string InvoiceNO { get; set; }
        public string BoxType { get; set; }
        public int OrderQuantity { get; set; }
        public string BoxNO { get; set; }
        public string BoxMethod { get; set; }
        public DateTime ShipmentDate { get; set; }
        public string BoxLabel { get; set; }
        public string Location { get; set; }
        public int FinishQty { get; set; }
        public int Quantity { get; set; }
        public string CrateStatus { get; set; }
        public string Creater { get; set; }
        public DateTime Createtime { get; set; }
        public string BLCreator { get; set; }
        public DateTime BLCreatetime { get; set; }
        public string Updator { get; set; }
        public DateTime UpdateDate { get; set; }

        //无参数构造函数
        public ProductLabelModel() { 

        }
        
          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public ProductLabelModel(DataRow row)
        {
            if (row.Table.Columns.Contains("ItemID"))
                ItemID = Convertor.ToString(row["ItemID"]);
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
            if (row.Table.Columns.Contains("Location"))
                Location = Convertor.ToString(row["Location"]);
            if (row.Table.Columns.Contains("BarcodeNO"))
                BoxLabel = Convertor.ToString(row["BarcodeNO"]);
            if (row.Table.Columns.Contains("BoxStatus"))
                CrateStatus = Convertor.ToString(row["BoxStatus"]);
            if (row.Table.Columns.Contains("FinishQty"))
                FinishQty = Convertor.ToInt32(row["FinishQty"]);
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToInt32(row["Quantity"]);
            if (row.Table.Columns.Contains("BoxNO"))
                BoxNO = Convertor.ToString(row["BoxNO"]);
            if (row.Table.Columns.Contains("InboundQuantity"))
            {
                string value = row["InboundQuantity"].ToString().Substring(0, row["InboundQuantity"].ToString().IndexOf("."));
                OrderQuantity = Convert.ToInt32(value);
            }
               
            if (row.Table.Columns.Contains("Creater"))
                Creater = Convertor.ToString(row["Creater"]);
            if (row.Table.Columns.Contains("Createdate"))
                Createtime = Convertor.ToDateTime(row["Createdate"]);
            if (row.Table.Columns.Contains("ShipmentDate"))
                ShipmentDate = Convertor.ToDateTime(row["ShipmentDate"]);
            if (row.Table.Columns.Contains("Creator"))
                BLCreator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("Createdate"))
                BLCreatetime = Convertor.ToDateTime(row["Createdate"]);
            if (row.Table.Columns.Contains("Updator"))
                Updator = Convertor.ToString(row["Updator"]);
            if (row.Table.Columns.Contains("UpdateDate"))
                UpdateDate = Convertor.ToDateTime(row["UpdateDate"]);

        }
    }

}
