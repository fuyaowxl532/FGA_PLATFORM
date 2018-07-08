using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class PlexUserModel
    {
        public string PlexID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PlexUserID { get; set; }
        public string Department { get; set; }
       

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public PlexUserModel()
        {
        
        }

        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public PlexUserModel(DataRow row)
        {
            if (row.Table.Columns.Contains("PlexID"))
                PlexID = Convertor.ToString(row["PlexID"]);
            if (row.Table.Columns.Contains("FirstName"))
                FirstName = Convertor.ToString(row["FirstName"]);
            if (row.Table.Columns.Contains("LastName"))
                LastName = Convertor.ToString(row["LastName"]);
            if (row.Table.Columns.Contains("PlexUserID"))
                PlexUserID = Convertor.ToString(row["PlexUserID"]);
            if (row.Table.Columns.Contains("Department"))
                Department = Convertor.ToString(row["Department"]);
        }
    }

}
