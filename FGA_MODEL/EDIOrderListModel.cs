using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class EDIOrderListModel
    {
        public string Customer_Name { get; set; }
        public string Customer_Address_Code { get; set; }
        public string Customer_Part_NO { get; set; }
        public string Customer_Part_Revision  { get; set; }
        public string Part_NO { get; set; }
        public string Part_Name { get; set; }
        public DateTime Due_Date { get; set; }
        public DateTime Ship_Date { get; set; }
        public string Order_NO { get; set; }
        public string Lot_NO { get; set; }
        public string Batch_NO { get; set; }
        public string MasterID { get; set; }
        public int EDI_Key { get; set; }
        public string EDI_Action { get; set; }
        public string EDI_Status { get; set; }
        public string Docname { get; set; }
        public int Standard_Quantity { get; set; }
        public int Quantity { get; set; }
        public int Job_Sequence { get; set; }
        public int EDI_RowID { get; set; }
        public int rstatus { get; set; }
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public EDIOrderListModel()
        {
        
        }

          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public EDIOrderListModel(DataRow row)
        {
            if (row.Table.Columns.Contains("Customer_Name"))
                Customer_Name = Convertor.ToString(row["Customer_Name"]);
            if (row.Table.Columns.Contains("Customer_Address_Code"))
                Customer_Address_Code = Convertor.ToString(row["Customer_Address_Code"]);
            if (row.Table.Columns.Contains("Customer_Part_NO"))
                Customer_Part_NO = Convertor.ToString(row["Customer_Part_NO"]);
            if (row.Table.Columns.Contains("Customer_Part_Revision"))
                Customer_Part_Revision = Convertor.ToString(row["Customer_Part_Revision"]);
            if (row.Table.Columns.Contains("Part_NO"))
                Part_NO = Convertor.ToString(row["Part_NO"]);
            if (row.Table.Columns.Contains("Part_Name"))
                Part_Name = Convertor.ToString(row["Part_Name"]);
            if (row.Table.Columns.Contains("Order_NO"))
                Order_NO = Convertor.ToString(row["Order_NO"]);
            if (row.Table.Columns.Contains("Lot_NO"))
                Lot_NO = Convertor.ToString(row["Lot_NO"]);
            if (row.Table.Columns.Contains("Batch_NO"))
                Batch_NO = Convertor.ToString(row["Batch_NO"]);
            if (row.Table.Columns.Contains("MasterID"))
                MasterID = Convertor.ToString(row["MasterID"]);
            if (row.Table.Columns.Contains("EDI_Action"))
                EDI_Action = Convertor.ToString(row["EDI_Action"]);
            if (row.Table.Columns.Contains("EDI_Status"))
                EDI_Status = Convertor.ToString(row["EDI_Status"]);
            if (row.Table.Columns.Contains("Docname"))
                Docname = Convertor.ToString(row["Docname"]);
            if (row.Table.Columns.Contains("Due_Date"))
                Due_Date = Convertor.ToDateTime(row["Due_Date"]);
            if (row.Table.Columns.Contains("Ship_Date"))
                Ship_Date = Convertor.ToDateTime(row["Ship_Date"]);
            if (row.Table.Columns.Contains("EDI_Key"))
                EDI_Key = Convertor.ToInt32(row["EDI_Key"]);
            if (row.Table.Columns.Contains("Standard_Quantity"))
                Standard_Quantity = Convertor.ToInt32(row["Standard_Quantity"]); 
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToInt32(row["Quantity"]);
            if (row.Table.Columns.Contains("Job_Sequence"))
                Job_Sequence = Convertor.ToInt32(row["Job_Sequence"]);
            if (row.Table.Columns.Contains("EDI_RowID"))
                EDI_RowID = Convertor.ToInt32(row["EDI_RowID"]);
            if (row.Table.Columns.Contains("rstatus"))
                rstatus = Convertor.ToInt32(row["rstatus"]);

        }
    }

}
