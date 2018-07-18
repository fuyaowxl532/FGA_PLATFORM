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
using FGA_MODEL.Args;


namespace FGA_PLATFORM.business.production
{
    public partial class OEM_OrderTracking : System.Web.UI.Page
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize_2") == string.Empty ? "500" : ConfigHelper.GetConfigValue("PageSize_2");
        protected string role = "";
        protected string pusername = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            pusername = model.USERNAME;
            string sql = "SELECT rid FROM userroles where uid = (select userid from userinfo where username ='"+model.USERNAME+"')";
            DataSet dst = new DataSet();
            dst = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
            if (dst != null && dst.Tables.Count > 0 && dst.Tables[0].Rows.Count > 0)
            {
                for (int i=0;i < dst.Tables[0].Rows.Count;i++) {
                    if(Convert.ToInt32(dst.Tables[0].Rows[i][0]) ==25)
                        role = "Sales";
                    if (Convert.ToInt32(dst.Tables[0].Rows[i][0]) == 26)
                        role = "Planner";
                }
            }
        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string creator,string orderno,string ordertype, string partno, string factory, string status,string cst, string fdate, string tdate, string CurrentPageIndex, string PageSize)
        {
            //按用户查看数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            //List<string> power = model.Powers;

            //分页查询
            SearchArgs args = new SearchArgs();
            args.CurrentIndex = int.Parse(CurrentPageIndex);
            args.PageSize = int.Parse(PageSize);
            int begin = args.StartIndex + 1;
            int end = args.StartIndex + args.PageSize;

            string sql = "";
            string res = string.Empty;
            try
            {
                //获取记录总数
                string sql_total = "select count(*) Indexs from [FGA_OEMORDERTRK_T] fot where 1=1";

                //查询条件
                if (!String.IsNullOrEmpty(orderno))
                    sql_total = sql_total + " and [OrderNO] like '%" + orderno + "%'";

                if (!String.IsNullOrEmpty(ordertype))
                {
                    if (ordertype != "All")
                        sql_total = sql_total + " and [OrderType] = '" + ordertype + "'";
                }

                if (!String.IsNullOrEmpty(partno))
                    sql_total = sql_total + " and [PartNO] like  '%" + partno + "%'";

                if (!String.IsNullOrEmpty(factory) && status != "All")
                    sql_total = sql_total + " and [Organization] = '" + factory + "'";

                if (!String.IsNullOrEmpty(cst))
                    sql_total = sql_total + " and [Customer] like '%" + cst + "%'";

                if (!String.IsNullOrEmpty(status) && status != "All")
                        sql_total = sql_total + " and [OrderStatus] = '" + status + "'";

                if (!String.IsNullOrEmpty(creator))
                {
                    if (creator != "All")
                        sql_total = sql_total + " and [Creater] = '" + creator + "'";
                }

                if (!String.IsNullOrEmpty(fdate))
                    sql_total = sql_total + " and [ShipmentDate] >= cast('" + fdate + "' as datetime)";
                if (!String.IsNullOrEmpty(tdate))
                    sql_total = sql_total + " and [ShipmentDate] <= cast('" + tdate + "' as datetime)";


                DataSet dst = new DataSet();
                dst = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql_total);

                if (dst != null && dst.Tables.Count > 0 && dst.Tables[0].Rows.Count > 0)
                {
                    args.TotalRecords = Convert.ToInt32(dst.Tables[0].Rows[0][0]);
                }
                else
                {
                    args.TotalRecords = 0;
                }

                sql = "SELECT * FROM (SELECT ROW_NUMBER()OVER(ORDER BY [PlanningDate]) Indexs,[Orderkey],[OrderNO],[PartNO],[Customer],[Program],[BoxType] as [ContainerType],[StandardQuantity],[OrderQuantity],[PlanningDate] " +
                      ",[ShipmentDate],[InBoundQty],[UnInBoundQty],[UnInBoundBox],[OrderStatus],[DeliveryStatus],[Organization],[Notes],[LastEditUser],[LastEditTime],[Creater],[Createdate],[OrderNoID] FROM [FGA_OEMORDERTRK_T] where 1=1 ";

                //查询条件
                if (!String.IsNullOrEmpty(orderno))
                    sql = sql + " and [OrderNO] like '%" + orderno + "%'";
                //if (!String.IsNullOrEmpty(ordertype))
                //{
                //    if (sql != "All")
                //        sql = sql + " and [OrderType] = '" + ordertype + "'";
                //}
                if (!String.IsNullOrEmpty(partno))
                    sql = sql + " and [PartNO] like  '%" + partno + "%'";

                if (!String.IsNullOrEmpty(factory) && status != "All")
                    sql_total = sql_total + " and [Organization] = '" + factory + "'";

                if (!String.IsNullOrEmpty(cst))
                    sql = sql + " and [Customer] like '%" + cst + "%'";
                if (!String.IsNullOrEmpty(status))
                {
                    if (status != "All")
                        sql = sql + " and [OrderStatus] = '" + status + "'";
                }
                if (!String.IsNullOrEmpty(creator))
                {
                    if (creator != "All")
                        sql = sql + " and [Creater] = '" + creator + "'";
                }
                if (!String.IsNullOrEmpty(fdate))
                    sql = sql + " and [ShipmentDate] >= cast('" + fdate + "' as datetime)";

                if (!String.IsNullOrEmpty(tdate))
                    sql = sql + " and [ShipmentDate] <= cast('" + tdate + "' as datetime)";

                sql = sql + ") AA where AA.indexs between " + begin + " and " + end + " ";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<OEM_OrderTrkModel> luw = new List<OEM_OrderTrkModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        OEM_OrderTrkModel ERM = new OEM_OrderTrkModel(row);
                        ERM.RecordCnt = args.TotalRecords;
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
        /// 执行更新操作操作
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string saveData(string data)
        {
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();

            List<OEM_OrderTrkModel> listmodel = new List<OEM_OrderTrkModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<OEM_OrderTrkModel>>(data);

            foreach (OEM_OrderTrkModel pc in listmodel)
            {
                string sql = "update FGA_OEMORDERTRK_T set planningdate = '"+pc.PlanningDate+"',shipmentdate ='"+pc.ShipmentDate+"' where ordernoid = '"+pc.OrderNoID+"'";
                sqllist.Add(sql);
            }

            int count = FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist);
            if (count > 0)
                return "1";
            else
                return "0";
        }

        /// <summary>
        /// 执行更新操作操作
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string OnAction(string opt, string orderkeys, string pstatus)
        {
            string res = String.Empty;
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            string sql = "";

            if (opt.Equals("Pstatus"))
            {
                sql = "update [FGA_OEMORDERTRK_T] set [OrderStatus] = '" + pstatus + "',[LastEditUser] = '" + user + "', " +
                "[LastEditTime] = getdate() where OrderKey in (" + orderkeys + ") and [OrderStatus] <> '"+ pstatus + "' ";
            }
            if (opt.Equals("Pshippingdate"))
            {
                sql = "update [FGA_OEMORDERTRK_T] set [ShipmentDate] = '" + pstatus + "',[PlanningDate] = DateAdd(hour,-8,'" + pstatus + "'),[LastEditUser] = '" + user + "', " +
                "[LastEditTime] = getdate() where OrderKey in (" + orderkeys + ") ";
            }
            if (opt.Equals("Porderqty"))
            {
                sql = "update [FGA_OEMORDERTRK_T] set [OrderQuantity] = " + pstatus + ",[LastEditUser] = '" + user + "', " +
                "[LastEditTime] = getdate() where OrderKey in (" + orderkeys + ") ";
            }

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql) > 0)
                res = "1";
            else
                res = "0";

            return res;
        }
        /// <summary>
        /// 删除数据
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string DeleteRecords(string orderkeys)
        {
            string res = String.Empty;
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
          
            string   sql = "delete from [FGA_OEMORDERTRK_T] where OrderKey in (" + orderkeys + ") ";
          
            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql) > 0)
                res = "1";
            else
                res = "0";

            return res;
        }
        /// <summary>
        /// 导入保存数据
        /// add by it-wxl
        /// add date 12/20/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string saveDataImport(string data)
        {
            //按用户查看EDI的数据
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();
            List<string> sqllist1 = new List<string>();

            List<OEM_OrderTrkModel> listmodel = new List<OEM_OrderTrkModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<OEM_OrderTrkModel>>(data);

            foreach (OEM_OrderTrkModel pc in listmodel)
            {
                if (!String.IsNullOrEmpty(pc.PartNO))
                {
                    string sql = "insert into [FGA_OEMORDERTRK_T_tmp]([OrderNO],[PartNO],[BoxType],[StandardQuantity],[OrderQuantity],[Creater],[Createdate] " +
                             ",[ShipmentDate],[Customer],[OrderStatus],[DeliveryStatus],[Program],[OrderKey]) " +
                             "values('" + pc.OrderNO + "','" + pc.PartNO + "','" + pc.ContainerType + "'," + pc.StandardQuantity + "," + pc.OrderQuantity + "," +
                             "'" + user + "',getdate(),'" + pc.ShipmentDate + "','" + pc.Customer + "','OrderGeneration','Normal','" + pc.Program + "',NEXT VALUE FOR OEM_OrderKey_seq) ";
                    
                    sqllist.Add(sql);
                }
            }

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
            {
                string insertsql = "insert into [FGA_OEMORDERTRK_T] " +
                                   "select [OrderNO],[PartNO],cfv.[ContainerType],[StandardQuantity],[OrderQuantity],DateAdd(hour,-8, ShipmentDate),PG.Factory, " +
                                   " [Notes],[PlexCreateTime],[Operator],[TeamLeader],[Supervisor],[Manager],[Creater],[Createdate],[ShipmentDate] " +
                                   " ,[Location],0,[OrderQuantity],[OrderQuantity]/[StandardQuantity],[LastInBoundTime],[Lastlocation],[LastInBoundUser] " +
                                   " ,[OrderNoID],[Customer],[OrderStatus],[DeliveryStatus],[KeyCenter],[Program],[AddressCode],[OrderKey],[LastEditUser] " +
                                   " ,[LastEditTime] from FGA_OEMORDERTRK_T_tmp fott left join " +
                                   " (select distinct PVP.Part_No, PFT.Factory from [part_v_part] PVP left join[PartGroup_Factory_t] pft " +
                                   " on pvp.Part_Group_Key = pft.Part_Group_Key " +
                                   " where pft.Factory<> 'All') PG on  fott.PartNO COLLATE DATABASE_DEFAULT = PG.Part_No " +
                                   " left join ContainerType_FromPlex_v cfv on  fott.PartNO COLLATE DATABASE_DEFAULT = cfv.Part_No where fott.creater ='" + user + "'";

                string delsql = "delete from FGA_OEMORDERTRK_T_tmp where creater = '" + user + "'";

                sqllist1.Add(insertsql);
                sqllist1.Add(delsql);

                if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist1) > 0)
                {
                    return "1";
                }
                else
                    return "0";
            }
            else
            {
                return "0";
            }
        }

    }
}