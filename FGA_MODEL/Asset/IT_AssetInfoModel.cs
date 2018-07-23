using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class IT_AssetInfoModel
    {
        public int RecordCnt { get; set; }
        public int Indexs { get; set; }
        public int IsCheck { get; set; }
        public DateTime CheckDate { get; set; }
        public string First_Name { get; set; }
        public string Last_Name { get; set; }
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
        public string AssetConfig { get; set; }
        public string SerialNO { get; set; }
        public string Creator { get; set; }
        public DateTime CreateDate { get; set; }
        public string UpdateBy { get; set; }
        public DateTime UpdateDate { get; set; }
        public DateTime LastEditDate { get; set; }
        public DateTime InBoundDate { get; set; }
        public DateTime InsuranceDate { get; set; }
        public string LastEditUser { get; set; }
        public string Active { get; set; }
        public string PlexID { get; set; }
        public string Department { get; set; }
        public string Manager { get; set; }
        public string AssetKey { get; set; }
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public IT_AssetInfoModel()
        {

        }

        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public IT_AssetInfoModel(DataRow row)
        {
            if (row.Table.Columns.Contains("RecordCnt"))
                RecordCnt = Convertor.ToInt32(row["RecordCnt"]);
            if (row.Table.Columns.Contains("Indexs"))
                Indexs = Convertor.ToInt32(row["Indexs"]);
            if (row.Table.Columns.Contains("IsCheck"))
                IsCheck = Convertor.ToInt32(row["IsCheck"]);
            if (row.Table.Columns.Contains("First_Name"))
                First_Name = Convertor.ToString(row["First_Name"]);
            if (row.Table.Columns.Contains("Last_Name"))
                Last_Name = Convertor.ToString(row["Last_Name"]);
            if (row.Table.Columns.Contains("Active"))
                Active = Convertor.ToString(row["Active"]);
            if (row.Table.Columns.Contains("PlexID"))
                PlexID = Convertor.ToString(row["PlexID"]);
            if (row.Table.Columns.Contains("Department"))
                Department = Convertor.ToString(row["Department"]);
            if (row.Table.Columns.Contains("Manager"))
                Manager = Convertor.ToString(row["Manager"]);
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
            if (row.Table.Columns.Contains("AssetConfig"))
                AssetConfig = Convertor.ToString(row["AssetConfig"]);
            if (row.Table.Columns.Contains("Creator"))
                Creator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("CreateDate"))
                CreateDate = Convertor.ToDateTime(row["CreateDate"]);
            if (row.Table.Columns.Contains("UpdateBy"))
                UpdateBy = Convertor.ToString(row["UpdateBy"]);
            if (row.Table.Columns.Contains("UpdateDate"))
                UpdateDate = Convertor.ToDateTime(row["UpdateDate"]);
            if (row.Table.Columns.Contains("LastEditDate"))
                LastEditDate = Convertor.ToDateTime(row["LastEditDate"]);
            if (row.Table.Columns.Contains("InBoundDate"))
                InBoundDate = Convertor.ToDateTime(row["InBoundDate"]);
            if (row.Table.Columns.Contains("InsuranceDate"))
                InsuranceDate = Convertor.ToDateTime(row["InsuranceDate"]);
            if (row.Table.Columns.Contains("LastEditUser"))
                LastEditUser = Convertor.ToString(row["LastEditUser"]);
            if (row.Table.Columns.Contains("AssetKey"))
                AssetKey = Convertor.ToString(row["AssetKey"]);
            if (row.Table.Columns.Contains("CheckDate"))
                CheckDate = Convertor.ToDateTime(row["CheckDate"]);
        }
    }

}
