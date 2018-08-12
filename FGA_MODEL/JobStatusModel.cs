using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_NUtility;

namespace FGA_MODEL
{
    public class JobStatusModel
    {
        public string JobNO { get; set; }
        public string JobStatus { get; set; }
        public string Creator { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime CompletedDate { get; set; }

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public JobStatusModel()
        {

        }

        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public JobStatusModel(DataRow row)
        {
            if (row.Table.Columns.Contains("JobNO"))
                JobNO = Convertor.ToString(row["JobNO"]);
            if (row.Table.Columns.Contains("JobStatus"))
                JobStatus = Convertor.ToString(row["JobStatus"]);
            if (row.Table.Columns.Contains("Creator"))
                Creator = Convertor.ToString(row["Creator"]);
            if (row.Table.Columns.Contains("CreateDate"))
                CreateDate = Convertor.ToDateTime(row["CreateDate"]);
            if (row.Table.Columns.Contains("CompletedDate"))
                CompletedDate = Convertor.ToDateTime(row["CompletedDate"]);
        }
    }

}
