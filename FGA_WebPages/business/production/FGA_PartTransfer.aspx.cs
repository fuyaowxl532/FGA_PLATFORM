using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_MODEL.Financial;
using FGA_NUtility;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.business.production
{
    public partial class FGA_PartTransfer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string createShipperNO()
        {

            string res = String.Empty;
            int count = 0;

            //string sql = "select serial_no,tracking_no FROM MZ_ADDDATE_plex_v where Tracking_No not like '18%' and " +
            //                  " Tracking_No not like '17%' and Tracking_No not like '16%' ";

            //DataSet ds = new DataSet();

            //ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            //if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            //{
            //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            //    {
            //        string sn = ds.Tables[0].Rows[i][0].ToString();
            //        string tn = ds.Tables[0].Rows[i][1].ToString();

            //        FGA_NUtility.POL.ExecuteDataSourceResult da_rst = null;

            //        da_rst = PlexHelper.PlexGetResult_4("27181", "Container_Update_Simple", "@Serial_No", "@Last_Action", "@Tracking_No", "@Update_By",
            //        sn, "Updated at Container Form", tn, "2786442");

            //        count++;

            //    }

            //    res = count.ToString();
            //}
            //2018-05-11 10:25:05.120
            string sql = "select Part+CAST(Quanity AS VARCHAR(50)) as pq from OEM_IR where Createdate >'2018-05-11' and Createdate <'2018-05-12' and F_Location like 'F%'";
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++) {

                    string ui = ds.Tables[0].Rows[i][0].ToString();

                    string update_sql = "update FGA_OEMORDERTRK_T set InBoundQty = InBoundQty+StandardQuantity,UnInBoundQty = UnInBoundQty - StandardQuantity,UnInBoundBox = UnInBoundBox-1 " +
                                      " where OrderKey = (select top 1 OrderKey from FGA_OEMORDERTRK_T where PartNO+cast(StandardQuantity as VARCHAR(50)) = '" + ui + "' and UnInBoundBox > 0 " +
                                      " and orderstatus not in ('OrderClose','OrderCancel') order by PlanningDate)";

                    //FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(update_sql);

                    count++;

                }

                res = count.ToString();
            }

            return res;
        }
    }
}