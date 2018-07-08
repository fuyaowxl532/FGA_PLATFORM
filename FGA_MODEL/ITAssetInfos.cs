using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class ITAssetInfos
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Equipment { get; set; }
        public string CateGory   { get; set; }
        public string AccountingAssetNO { get; set; }
        public string ITSerialNO { get; set; }
        public string EquipmentSerialNO { get; set; }
        public DateTime IssueDate { get; set; }
        public DateTime ReturnDate { get; set; }
        public string Department { get; set; }
        public string DepartmentManager { get; set; }
        public string Status { get; set; }
        public string IPAddress { get; set; }
        public string MacAddress { get; set; }
        public string Brand { get; set; }
        public string Note { get; set; }
        public string PlexID    { get; set; }
        public string Email      { get; set; }
        public string Creator { get; set; }
        public DateTime Createdate { get; set; }
        public string Updator { get; set; }
        public DateTime UpdateDate { get; set; }

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public ITAssetInfos()
        {
        
        }

        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public ITAssetInfos(DataRow row)
        {
            if (row.Table.Columns.Contains("FirstName"))
                FirstName = Convertor.ToString(row["FirstName"]);
            if (row.Table.Columns.Contains("LastName"))
                LastName = Convertor.ToString(row["LastName"]);
            if (row.Table.Columns.Contains("EQTName"))
                Equipment = Convertor.ToString(row["EQTName"]);
            if (row.Table.Columns.Contains("CateGory"))
                CateGory = Convertor.ToString(row["CateGory"]);
            if (row.Table.Columns.Contains("ACTAssetNO"))
                AccountingAssetNO = Convertor.ToString(row["ACTAssetNO"]);
            if (row.Table.Columns.Contains("ITSerialNO"))
                ITSerialNO = Convertor.ToString(row["ITSerialNO"]);
            if (row.Table.Columns.Contains("EQTSerialNO"))
                EquipmentSerialNO = Convertor.ToString(row["EQTSerialNO"]);
            if (row.Table.Columns.Contains("IssueDate"))
                IssueDate = Convertor.ToDateTime(row["IssueDate"]);
            if (row.Table.Columns.Contains("ReturnDate"))
                ReturnDate = Convertor.ToDateTime(row["ReturnDate"]);
            if (row.Table.Columns.Contains("Department"))
                Department = Convertor.ToString(row["Department"]);
            if (row.Table.Columns.Contains("DepartmentManager"))
                DepartmentManager = Convertor.ToString(row["DepartmentManager"]);
            if (row.Table.Columns.Contains("Status"))
                Status = Convertor.ToString(row["Status"]);
            if (row.Table.Columns.Contains("IPAddress"))
                IPAddress = Convertor.ToString(row["IPAddress"]);
            if (row.Table.Columns.Contains("MacAddress"))
                MacAddress = Convertor.ToString(row["MacAddress"]);
            if (row.Table.Columns.Contains("Brand"))
                Brand = Convertor.ToString(row["Brand"]);
            if (row.Table.Columns.Contains("Note"))
                Note = Convertor.ToString(row["Note"]);
            if (row.Table.Columns.Contains("PlexID"))
                PlexID = Convertor.ToString(row["PlexID"]);
            if (row.Table.Columns.Contains("Email"))
                Email = Convertor.ToString(row["Email"]);

            if (row.Table.Columns.Contains("Creator"))
                Creator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("Createdate"))
                Createdate = Convertor.ToDateTime(row["Createdate"]);
            if (row.Table.Columns.Contains("Updator"))
                Updator = Convertor.ToString(row["Updator"]);
            if (row.Table.Columns.Contains("UpdateDate"))
                UpdateDate = Convertor.ToDateTime(row["UpdateDate"]);
        }
    }

}
