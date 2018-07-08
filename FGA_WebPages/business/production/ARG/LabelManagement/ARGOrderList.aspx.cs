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
using FGA_MODEL.ARG;
using FGA_MODEL.index;
using FGA_NUtility;
using FGA_NUtility.Consts;
using FGA_MODEL.Args;

namespace FGA_PLATFORM.business.production.ARG.LabelManagement
{
    public partial class ARGOrderList : System.Web.UI.Page
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize_3") == string.Empty ? "1000" : ConfigHelper.GetConfigValue("PageSize_3");

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 界面查询
        /// add by it-wxl 05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string invoiceno, string itemcode, string fdate, string tdate, string CurrentPageIndex, string PageSize)
        {
            //分页查询
            SearchArgs args = new SearchArgs();
            args.CurrentIndex = int.Parse(CurrentPageIndex);
            args.PageSize = int.Parse(PageSize);
            int begin = args.StartIndex + 1;
            int end = args.StartIndex + args.PageSize;

            string res = string.Empty;
            try
            {
                string sql = "SELECT * FROM (SELECT ROW_NUMBER()OVER(ORDER BY [ShipmentDate],[InvoiceNO],[BoxNO]) Indexs,[ItemID],[InvoiceNO],[PlanNO],[CustomerNO],[CustomerName],[DestinyPort],[ItemCode],[LabelNO],[ChangedNumber],[AustriaNo] " +
                             ",[BoxNO],[BoxType],[BoxMethod],[TargetBinCode],[SOQuantity],[InboundQuantity],[InboundTime],[ShipmentDate],[LastEditUser] " +
                             ",[LastEditDate],[CreateUser],[CreateDate],[Status],[BarCode],[OutboundTime],[ReserveSign],[PlanDate],[OrderDate] " +
                             ",[OrderStatus],[SubInvoiceNO],[OutSign],[OrderNO],[IRUser],[ConvertSign] " +
                             " FROM [WMS_BarCode_V10].[dbo].[ShipmentDetail] WHERE 1=1 ";

                //查询条件
                if (!String.IsNullOrEmpty(invoiceno))
                    sql = sql + " and [InvoiceNO] like '%" + invoiceno.Trim() + "%'";
                if (!String.IsNullOrEmpty(itemcode))
                    sql = sql + " and [ItemCode] like '%" + itemcode.Trim() + "%'";


                sql = sql + ") AA where AA.indexs between " + begin + " and " + end + " ";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<ARGOrderListModel> luw = new List<ARGOrderListModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ARGOrderListModel ERM = new ARGOrderListModel(row);
                        luw.Add(ERM);
                    }

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    jssl.MaxJsonLength = Int32.MaxValue;
                    res = jssl.Serialize(luw);
                    res = res.Replace("\\/Date(", "").Replace(")\\/", "");
                }
            }
            catch (Exception e)
            {

            }
            return res;
        }
    }
}