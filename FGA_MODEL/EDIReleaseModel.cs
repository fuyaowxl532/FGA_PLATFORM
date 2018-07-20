using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class EDIReleaseModel
    {
        public string customer_name { get; set; }
        public string Customer_Address_Code { get; set; }
        public string Customer_Part_No { get; set; }
        public string Customer_Part_Revision  { get; set; }
        public string part_no { get; set; }
        public string part_name { get; set; }
        public DateTime Due_Date { get; set; }
        public DateTime Ship_Date { get; set; }
        public string ORDER_NO  { get; set; }
        public string Lot_No { get; set; }
        public string BATCH_NO { get; set; }
        public string MasterID { get; set; }
        public int EDI_Key { get; set; }
        public string EDI_Action { get; set; }
        public string EDI_Status { get; set; }
        public string Docname { get; set; }
        public int Standard_Quantity { get; set; }
        public int Quantity { get; set; }
        public int JOB_SEQUENCE { get; set; }
        public int EDI_RowID { get; set; }

         /// <summary>
        /// 默认构造函数
        /// </summary>
        public EDIReleaseModel()
        {
        
        }

          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public EDIReleaseModel(DataRow row)
        {
            if (row.Table.Columns.Contains("customer_name"))
                customer_name = Convertor.ToString(row["customer_name"]);
            if (row.Table.Columns.Contains("Customer_Address_Code"))
                Customer_Address_Code = Convertor.ToString(row["Customer_Address_Code"]);
            if (row.Table.Columns.Contains("Customer_Part_No"))
                Customer_Part_No = Convertor.ToString(row["Customer_Part_No"]);
            if (row.Table.Columns.Contains("Customer_Part_Revision"))
                Customer_Part_Revision = Convertor.ToString(row["Customer_Part_Revision"]);
            if (row.Table.Columns.Contains("part_no"))
                part_no = Convertor.ToString(row["part_no"]);
            if (row.Table.Columns.Contains("part_name"))
                part_name = Convertor.ToString(row["part_name"]);
            if (row.Table.Columns.Contains("ORDER_NO"))
                ORDER_NO = Convertor.ToString(row["ORDER_NO"]);
            if (row.Table.Columns.Contains("Lot_No"))
                Lot_No = Convertor.ToString(row["Lot_No"]);
            if (row.Table.Columns.Contains("BATCH_NO"))
                BATCH_NO = Convertor.ToString(row["BATCH_NO"]);
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
            if (row.Table.Columns.Contains("JOB_SEQUENCE"))
                JOB_SEQUENCE = Convertor.ToInt32(row["JOB_SEQUENCE"]);
            if (row.Table.Columns.Contains("EDI_RowID"))
                EDI_RowID = Convertor.ToInt32(row["EDI_RowID"]);

        }
    }

}
