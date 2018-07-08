using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class LoadPartList
    {
        public string LoadID { get; set; }
        public string CustomerPart { get; set; }
        public string PartNO { get; set; }
        public int Quantity  { get; set; }
        public int JobSequence { get; set; }
          /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public LoadPartList(DataRow row)
        {
            if (row.Table.Columns.Contains("LoadID"))
                LoadID = Convertor.ToString(row["LoadID"]);
            if (row.Table.Columns.Contains("CustomerPart"))
                CustomerPart = Convertor.ToString(row["CustomerPart"]);
            if (row.Table.Columns.Contains("PartNO"))
                PartNO = Convertor.ToString(row["PartNO"]);
            if (row.Table.Columns.Contains("Quantity"))
                Quantity = Convertor.ToInt32(row["Quantity"]);
            if (row.Table.Columns.Contains("JobSequence"))
                JobSequence = Convertor.ToInt32(row["JobSequence"]);

        }
    }

}
