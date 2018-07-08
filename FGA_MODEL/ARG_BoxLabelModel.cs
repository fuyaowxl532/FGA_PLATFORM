using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class ARG_BoxLabelModel
    {
        public string PartNO { get; set; }
        public decimal BoxHeight { get; set; }
        public decimal GasketThick { get; set; }
        public string CornerType { get; set; }
        public string BaseNO { get; set; }
        public string EdgeType { get; set; }
        public string Component_Part { get; set; }
        public string Component_Type { get; set; }
        public string Creator { get; set; }
        public DateTime Createtime { get; set; }

        //无参构造函数
        public ARG_BoxLabelModel() { 
        }

        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public ARG_BoxLabelModel(DataRow row)
        {
            if (row.Table.Columns.Contains("PartNO"))
                PartNO = Convertor.ToString(row["PartNO"]);
            if (row.Table.Columns.Contains("BoxHeight"))
                BoxHeight = Convertor.ToDecimal(row["BoxHeight"]);
            if (row.Table.Columns.Contains("GasketThick"))
                GasketThick = Convertor.ToDecimal(row["GasketThick"]);
            if (row.Table.Columns.Contains("CornerType"))
                CornerType = Convertor.ToString(row["CornerType"]);
            if (row.Table.Columns.Contains("BaseNO"))
                BaseNO = Convertor.ToString(row["BaseNO"]);
            if (row.Table.Columns.Contains("EdgeType"))
                EdgeType = Convertor.ToString(row["EdgeType"]);
            if (row.Table.Columns.Contains("Component_Part"))
                Component_Part = Convertor.ToString(row["Component_Part"]);
            if (row.Table.Columns.Contains("Component_Type"))
                Component_Type = Convertor.ToString(row["Component_Type"]);
            if (row.Table.Columns.Contains("Creator"))
                Creator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("Createdate"))
                Createtime = Convertor.ToDateTime(row["Createdate"]);

        }
    }

}
