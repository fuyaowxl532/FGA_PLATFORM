using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class BarcodeHelperModel
    {
        public string ToolNO { get; set; }
        public string BarcodeNO { get; set; }
        public string PartNO { get; set; }
        public string BoxType { get; set; }
        public string BoxStatus { get; set; }
        public int OrderQty { get; set; }
        public int Quantity { get; set; }
        public int Div { get; set; }
        public string Location { get; set; }
        public string Shift_First_Charactor { get; set; }
        public string Customer_Part { get; set; }
        public string Customer_Part_Revision { get; set; }
        public string Def1 { get; set; }
        public string Def2 { get; set; }

        public string Creater { get; set; }
        public string Creator { get; set; }
        public DateTime Createtime { get; set; }

        //无参构造函数
        public BarcodeHelperModel() { 
        }

        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public BarcodeHelperModel(DataRow row)
        {
            if (row.Table.Columns.Contains("BarcodeNO"))
                BarcodeNO = Convertor.ToString(row["BarcodeNO"]);
            if (row.Table.Columns.Contains("PartNO"))
                PartNO = Convertor.ToString(row["PartNO"]);
            if (row.Table.Columns.Contains("BoxType"))
                BoxType = Convertor.ToString(row["BoxType"]);
            if (row.Table.Columns.Contains("BoxStatus"))
                BoxStatus = Convertor.ToString(row["BoxStatus"]);
            if (row.Table.Columns.Contains("OrderQty"))
                OrderQty = Convertor.ToInt32(row["OrderQty"]);
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToInt32(row["Quantity"]);
            if (row.Table.Columns.Contains("Location"))
                Location = Convertor.ToString(row["Location"]);
            if (row.Table.Columns.Contains("Creater"))
                Creater = Convertor.ToString(row["Creater"]);
            if (row.Table.Columns.Contains("Creator"))
                Creator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("Createdate"))
                Createtime = Convertor.ToDateTime(row["Createdate"]);

        }
    }

}
