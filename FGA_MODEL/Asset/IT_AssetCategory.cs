using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class IT_AssetCategory
    {
        public string CategoryID { get; set; }
        public string Category { get; set; }
        public string CateModel { get; set; }
        public string Brand { get; set; }
        public string AssetConfig { get; set; }
        public string Note { get; set; }
        public DateTime AddDate { get; set; }
        public DateTime UpdateDate { get; set; }
        public string AddBy { get; set; }
        public string UpdateBy { get; set; }
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public IT_AssetCategory()
        {
        
        }

        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public IT_AssetCategory(DataRow row)
        {
            if (row.Table.Columns.Contains("CategoryID"))
                CategoryID = Convertor.ToString(row["CategoryID"]);
            if (row.Table.Columns.Contains("Category"))
                Category = Convertor.ToString(row["Category"]);
            if (row.Table.Columns.Contains("CateModel"))
                CateModel = Convertor.ToString(row["CateModel"]);
            if (row.Table.Columns.Contains("Brand"))
                Brand = Convertor.ToString(row["Brand"]);
            if (row.Table.Columns.Contains("AssetConfig"))
                AssetConfig = Convertor.ToString(row["AssetConfig"]);
            if (row.Table.Columns.Contains("Note"))
                Note = Convertor.ToString(row["Note"]);
            if (row.Table.Columns.Contains("AddDate"))
                AddDate = Convertor.ToDateTime(row["AddDate"]);
            if (row.Table.Columns.Contains("UpdateDate"))
                UpdateDate = Convertor.ToDateTime(row["UpdateDate"]);
            if (row.Table.Columns.Contains("AddBy"))
                AddBy = Convertor.ToString(row["AddBy"]);
            if (row.Table.Columns.Contains("UpdateBy"))
                UpdateBy = Convertor.ToString(row["UpdateBy"]);
        }
    }

}
