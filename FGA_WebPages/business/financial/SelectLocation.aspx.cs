using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_MODEL.index;
using FGA_NUtility;
using FGA_NUtility.Consts;
using FGA_MODEL.Args;

namespace FGA_PLATFORM.business.financial
{
    public partial class SelectLocation : System.Web.UI.Page
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize_1") == string.Empty ? "100" : ConfigHelper.GetConfigValue("PageSize_1");

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string queryData(string CurrentPageIndex, string PageSize, string filter) {
            //分页查询
            SearchArgs args = new SearchArgs();
            args.CurrentIndex = int.Parse(CurrentPageIndex);
            args.PageSize = int.Parse(PageSize);
            int begin = args.StartIndex + 1;
            int end = args.StartIndex + args.PageSize;

            string res = string.Empty;
            try
            {
                string sql = "select * from " +
                    "(SELECT ROW_NUMBER()OVER(ORDER BY FCI.Location) Indexs,FCI.Location FROM [WMS_BarCode_V10].[dbo].[FGA_Location_T] FCI " +
                             "WHERE (len(Location) > 5 OR Location like 'F%') AND Location NOT LIKE 'A0%' ";
                //查询条件
                if (!String.IsNullOrEmpty(filter))
                    sql = sql + " and (FCI.Location like '%" + filter + "%')";
                sql = sql + ") AA where AA.indexs between " + begin + " and " + end + " ";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<PlexLocation> luw = new List<PlexLocation>();
                    int count = ds.Tables[0].Rows.Count;
                    args.TotalRecords = count;

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        PlexLocation ERM = new PlexLocation(row);
                        ERM.RecordCnt = count;
                        luw.Add(ERM);
                    }
                    
                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(luw);
                }
            }
            catch (Exception e)
            {
            }

            return res;
        }
    }
}