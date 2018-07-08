using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class IT_AssetLogModel
    {
        public int Tid { get; set; }
        public int Indexs { get; set; }
        public string AssetName { get; set; }
        public string Category { get; set; }
        public string Brand { get; set; }
        public string IT_AssetNO { get; set; }
        public string FIN_AssetNO { get; set; }
        public DateTime Issue_Date { get; set; }
        public DateTime Return_Date { get; set; }
        public string Status { get; set; }
        public string IPAddress { get; set; }
        public string MacAddress { get; set; }
        public string Note { get; set; }
        public string SerialNO { get; set; }
        public string UpdateBy { get; set; }
        public DateTime UpdateDate { get; set; }
        public DateTime InsuranceDate { get; set; }
        public string AssetUser { get; set; }
        public string LastAction { get; set; }
        public int AssetKey { get; set; }
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public IT_AssetLogModel()
        {

        }

        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public IT_AssetLogModel(DataRow row)
        {
            if (row.Table.Columns.Contains("Tid"))
                Tid = Convertor.ToInt32(row["Tid"]);
            if (row.Table.Columns.Contains("Indexs"))
                Indexs = Convertor.ToInt32(row["Indexs"]);
            if (row.Table.Columns.Contains("LastAction"))
                LastAction = Convertor.ToString(row["LastAction"]);
            if (row.Table.Columns.Contains("AssetUser"))
                AssetUser = Convertor.ToString(row["AssetUser"]);
            if (row.Table.Columns.Contains("AssetName"))
                AssetName = Convertor.ToString(row["AssetName"]);
            if (row.Table.Columns.Contains("Category"))
                Category = Convertor.ToString(row["Category"]);
            if (row.Table.Columns.Contains("Brand"))
                Brand = Convertor.ToString(row["Brand"]);
            if (row.Table.Columns.Contains("IT_AssetNO"))
                IT_AssetNO = Convertor.ToString(row["IT_AssetNO"]);
            if (row.Table.Columns.Contains("FIN_AssetNO"))
                FIN_AssetNO = Convertor.ToString(row["FIN_AssetNO"]);
            if (row.Table.Columns.Contains("Issue_Date"))
                Issue_Date = Convertor.ToDateTime(row["Issue_Date"]);
            if (row.Table.Columns.Contains("Return_Date"))
                Return_Date = Convertor.ToDateTime(row["Return_Date"]);
            if (row.Table.Columns.Contains("Status"))
                Status = Convertor.ToString(row["Status"]);
            if (row.Table.Columns.Contains("SerialNO"))
                SerialNO = Convertor.ToString(row["SerialNO"]);
            if (row.Table.Columns.Contains("IPAddress"))
                IPAddress = Convertor.ToString(row["IPAddress"]);
            if (row.Table.Columns.Contains("MacAddress"))
                MacAddress = Convertor.ToString(row["MacAddress"]);
            if (row.Table.Columns.Contains("Note"))
                Note = Convertor.ToString(row["Note"]);
            if (row.Table.Columns.Contains("UpdateBy"))
                UpdateBy = Convertor.ToString(row["UpdateBy"]);
            if (row.Table.Columns.Contains("UpdateDate"))
                UpdateDate = Convertor.ToDateTime(row["UpdateDate"]);
            if (row.Table.Columns.Contains("InsuranceDate"))
                InsuranceDate = Convertor.ToDateTime(row["InsuranceDate"]);
            if (row.Table.Columns.Contains("AssetKey"))
                AssetKey = Convertor.ToInt32(row["AssetKey"]);
        }
    }

}
