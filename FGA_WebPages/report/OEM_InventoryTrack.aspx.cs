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
    public partial class OEM_InventoryTrack : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string orderno, string partno, string factory, string cst,string ordersts,string deliverysts,
            string fdate, string tdate)
        {
            //按用户查看数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            string sql = "";
            string res = string.Empty;
            try
            {
                sql = "SELECT [OrderNO],[PartNO],[Customer],[Program],[AddressCode],[BoxType],[StandardQuantity],[OrderQuantity],[OrderQuantity]/[StandardQuantity] as BoxNum,[PlanningDate] " +
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
                    List<OEM_OrderTrkModel> luw = new List<OEM_OrderTrkModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        OEM_OrderTrkModel ERM = new OEM_OrderTrkModel(row);
                        luw.Add(ERM);
                    }

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(luw);
                    res = res.Replace("\\/Date(", "").Replace(")\\/", "");
                }
            }
            catch (Exception e)
            {

            }
            return res;
        }

        /// <summary>
        /// 锚点查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string querySerialno()
        {
            //按用户查看数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            string sql = "";
            string res = string.Empty;
            try
            {
                sql = "SELECT FOT.OrderNO,OI.[SerialNO],OI.[Part] AS PartNO,OI.[T_Location] AS Location" +
                      ",OI.[Creater] AS LastInBoundUser,OI.[Createdate] AS LastInBoundTime" +
                      ",OI.[OrderNoID],OI.Quanity FROM fga_oemordertrk_t FOT left join [OEM_IR] OI" +
                      " on OI.ordernoid = FOT.ordernoid and OI.[FT_Location] LIKE 'F%I'";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<OEM_OrderTrkModel> luw = new List<OEM_OrderTrkModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        OEM_OrderTrkModel ERM = new OEM_OrderTrkModel(row);
                        luw.Add(ERM);
                    }

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
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