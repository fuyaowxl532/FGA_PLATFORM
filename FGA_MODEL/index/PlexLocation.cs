using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_NUtility;


namespace FGA_MODEL.index
{
    public class PlexLocation
    {
        public int Indexs { get; set; }
        public string Location { get; set; }
        public int RecordCnt { get; set; }

        public PlexLocation() {
        }

        public PlexLocation(DataRow row) {

            if (row.Table.Columns.Contains("Indexs"))
                Indexs = Convertor.ToInt32(row["Indexs"]);
            if (row.Table.Columns.Contains("Location"))
                Location = Convertor.ToString(row["Location"]);
            if (row.Table.Columns.Contains("RecordCnt"))
                RecordCnt = Convertor.ToInt32(row["RecordCnt"]);
        }
    }
}
