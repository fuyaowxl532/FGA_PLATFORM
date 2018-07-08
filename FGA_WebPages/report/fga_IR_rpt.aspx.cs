using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_NUtility;
using FGA_NUtility.Consts;
using System.Data.SqlClient;
using System.Data;

namespace FGA_PLATFORM.report
{
    public partial class fga_IR_rpt : System.Web.UI.Page
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize_3") == string.Empty ? "1000" : ConfigHelper.GetConfigValue("PageSize_3");
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string serialno, string status, string factory, string partno, string keycenter,
            string fdate, string tdate)
        {
            //按用户查看数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            string sql = "";
            string res = string.Empty;
            try
            {
                sql = "select CASE WHEN IR.ORGANIZATION = 'OT' or IR.ORGANIZATION = 'F2'  THEN 'F2' " +
                      " WHEN IR.ORGANIZATION = 'OL' or IR.ORGANIZATION = 'F1' THEN 'F1' " +
                      " WHEN IR.ORGANIZATION = 'OE' or IR.ORGANIZATION = 'F3' THEN 'F3' " +
                      " WHEN IR.ORGANIZATION = 'F4' THEN 'F4' " +
                      " END ORGANIZATION," +
                      " IR.SerialNO,IR.PartNO,IR.KEYCENTER,IR.From_LOC,IR.Quantity,IR.To_LOC,IR.Creater,IR.Createdate,IR.IRType from " +
                      " (select OIR.[SerialNO],OIR.[Part] as PartNO,PM.KEYCENTER,substring(OIR.[F_Location],0,3) as Organization,OIR.[F_Location] as From_LOC,OIR.[Quanity] as Quantity,OIR.[T_Location] as To_LOC,OIR.[Creater] , " +
                      " OIR.[Createdate],'InBound' AS IRType from OEM_IR OIR left join PartKeyCenterMapping pm on OIR.Part = PM.PARTNO WHERE FT_LOCATION LIKE 'F%I' and createdate >= cast('2017-04-24' as datetime) " +
                      " union all " +
                      " select OIR.[SerialNO],OIR.[Part] as PartNO,PM.KEYCENTER,substring(OIR.[F_Location],0,3) as Organization,OIR.[F_Location] as From_LOC,OIR.[Quanity]*-1 as Quantity,OIR.[T_Location] as To_LOC,OIR.[Creater] , " +
                      " OIR.[Createdate],'Return' AS IRType from OEM_IR OIR left join PartKeyCenterMapping pm on OIR.Part = PM.PARTNO WHERE  FT_LOCATION LIKE 'O%R'  and createdate >= cast('2017-04-24' as datetime)" +
                      " union all " +
                      " SELECT [SerialNO],[Part],'','F4' as Organization,[F_Location],[Quanity],[T_Location],UI.UserName,[Createdate],'InBound' AS IRType " +
                      " FROM[WMS_BarCode_V10].[dbo].[ARG_IR_PLEX] AI left join [Security_V10].[dbo].[UserInfo]  UI ON AI.Creater = UI.Phone where TYPE = 'InBound' " +
                      " union all " +
                      " SELECT [SerialNO],[Part],'','F4' as Organization,[F_Location],[Quanity],[T_Location],UI.UserName,[Createdate],'Return' AS IRType " +
                      " FROM[WMS_BarCode_V10].[dbo].[ARG_IR_PLEX] AI left join [Security_V10].[dbo].[UserInfo] UI ON " +
                      " AI.Creater = UI.Phone where TYPE = 'Return') IR WHERE 1=1";

                //查询条件
                if (!String.IsNullOrEmpty(serialno))
                    sql = sql + " and IR.SerialNO = '" + serialno + "'";
                if (!String.IsNullOrEmpty(partno))
                    sql = sql + " and IR.PartNO like  '" + partno + "'";
                if (!String.IsNullOrEmpty(factory))
                {
                    if (factory == "All")
                        sql = sql + " and IR.Organization in ('F1','F2','F3','F4')";
                    else
                        sql = sql + " and IR.Organization = '" + factory + "'";
                }
                if (!String.IsNullOrEmpty(keycenter))
                {
                    if (keycenter != "All")
                        sql = sql + " and IR.keycenter = '" + keycenter + "'";
                }
                if (!String.IsNullOrEmpty(fdate))
                    sql = sql + " and IR.Createdate >= cast('" + fdate + "' as datetime)";
                if (!String.IsNullOrEmpty(tdate))
                    sql = sql + " and IR.Createdate <= DATEADD(day,1,cast('" + tdate + "' as datetime)) ";


                sql = sql + " order by IR.createDate";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<PlexContainer> luw = new List<PlexContainer>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        PlexContainer ERM = new PlexContainer(row);
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

        //数据导出
        [WebMethod]
        public static string exportData(string orderno, string partno, string factory, string cst, string ordersts, string deliverysts,
            string fdate, string tdate)
        {
            string filename = "OEMRPT" + DateTime.Now.ToString() + ".xls";
            string sql = "SELECT [OrderNO],[PartNO],[Customer],[Program],[AddressCode],[BoxType],[StandardQuantity],[OrderQuantity],[OrderQuantity]/[StandardQuantity] as BoxNum,[PlanningDate] " +
                         ",[OrderStatus],[DeliveryStatus],[Organization],[Notes],[Operator],[TeamLeader],[Supervisor],[Manager],[Creater]" +
                         ",[Createdate],[ShipmentDate],[InBoundQty],[UnInBoundQty],[UnInBoundBox],[LastInBoundTime]" +
                         ",[Lastlocation],[LastInBoundUser],[OrderNoID] FROM [FGA_OEMORDERTRK_T] where 1=1";

            //查询条件
            if (!String.IsNullOrEmpty(orderno))
                sql = sql + " and [OrderNO] = '" + orderno + "'";
            if (!String.IsNullOrEmpty(partno))
                sql = sql + " and [PartNO] like  '" + partno + "'";
            if (!String.IsNullOrEmpty(factory))
            {
                if (factory == "All")
                    sql = sql + " and [Organization] in ('F1','F2','F3')";
                else
                    sql = sql + " and [Organization] = '" + factory + "'";
            }
            if (!String.IsNullOrEmpty(ordersts))
            {
                if (ordersts == "All")
                    sql = sql + " and [Orderstatus] in ('Release','In process','Closed')";
                else
                    sql = sql + " and [Orderstatus] = '" + ordersts + "'";
            }
            if (!String.IsNullOrEmpty(deliverysts))
            {
                if (deliverysts == "All")
                    sql = sql + " and [DeliveryStatus] in ('Normal','Delayed')";
                else
                    sql = sql + " and [DeliveryStatus] = '" + deliverysts + "'";
            }

            if (!String.IsNullOrEmpty(cst))
                sql = sql + " and [Customer] like '" + cst + "'";
            if (!String.IsNullOrEmpty(fdate))
                sql = sql + " and [PlanningDate] >= cast('" + fdate + "' as datetime)";
            if (!String.IsNullOrEmpty(tdate))
                sql = sql + " and [PlanningDate] <= cast('" + tdate + "' as datetime)";


            sql = sql + " order by planningDate";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                HttpContext context = System.Web.HttpContext.Current;
                ExcelRender.SetRenderToExcel(ds.Tables[0], context, filename);
            }

            return "1";
        }

    }
}