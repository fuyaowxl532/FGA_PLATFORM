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
    public partial class ProcessHOver_rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 页面初始化读取workcenter
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string batchno,string status, string floc, string tloc,string fdate,string tdate)
        {
            //按用户查看数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            if (status == "Both")
            {
                status = "'In Progress','Finish'";
            }
            if (status == "In Progress")
            {
                status = "'In Progress'";
            }
            if (status == "Finish")
            {
                status = "'Finish'";
            }

            string sql = "";
            string sql_d = "";
            string sqlquery = "";
            string res = string.Empty;
            try
            {
                if (model.USERNAME != "administrator")
                {
                    sql = " SELECT a.[Organization],a.[OperationNo],a.[TransactionType],a.[SerialNO],a.[PartNO],a.[From_LOC],a.[To_LOC],a.[Quantity],a.[Creater],a.[Createdate],a.[BatchNO],a.[ContainerStatus]" +
                          " FROM [ProcessHOAudit_T]  a where a.[ContainerStatus] in (" + status + ") AND a.[Organization]+a.[OperationNo] IN (SELECT ORGANIZATION + OPERATION FROM UserCtrl U WHERE U.USERNAME = '" + model.USERNAME + "')";
                }
                if (model.USERNAME == "administrator")
                {
                    sql = " SELECT [Organization],[OperationNo],[TransactionType],[SerialNO],[PartNO],[From_LOC],[To_LOC],[Quantity],[Creater],[Createdate],[BatchNO],[ContainerStatus] " +
                          " FROM [ProcessHOAudit_T] a where a.[ContainerStatus] in (" + status + ") ";
                }
                if (fdate != "")
                {
                    sql = sql + " and a.Createdate between cast('" + fdate + "' as datetime) and cast('" + tdate + "' as datetime)";
                }
                if (batchno != "")
                {
                    sql = sql + " and a.BatchNO = '" + batchno + "'";
                }
                if (floc != "")
                {
                    sql = sql + " and a.From_LOC like  '" + floc + "'";
                }
                if (tloc != "")
                {
                    sql = sql + " and a.To_LOC like  '" + tloc + "'";
                }


                //直接交接的数据
                if(model.USERNAME != "administrator")
                {
                    sql_d = " SELECT p.[Organization],p.[Operation],p.[TransactionType],p.SERIALNO,p.PARTNO,p.FROM_LOC,p.TO_LOC,p.QUANTITY,p.CREATER,p.CREATEDATE," +
                            " p.BATCHNO,'Finish' FROM PROCESSHANDOVER_T p  WHERE p.[ContainerStatus] in (" + status + ") AND p.[Organization]+p.[Operation] IN (SELECT ORGANIZATION + OPERATION FROM UserCtrl U WHERE U.USERNAME = '" + model.USERNAME + "')";
                }
                if(model.USERNAME == "administrator")
                {
                    sql_d = " SELECT p.[Organization],p.[Operation],p.[TransactionType],p.SERIALNO,p.PARTNO,p.FROM_LOC,p.TO_LOC,p.QUANTITY,p.CREATER,p.CREATEDATE," +
                            " p.BATCHNO,'Finish' FROM PROCESSHANDOVER_T p WHERE p.[ContainerStatus] in (" + status + ")";
                }

                if (fdate != "")
                {
                    sql_d = sql_d + " and p.Createdate between cast('" + fdate + "' as datetime) and cast('" + tdate + "' as datetime)";
                }
                if (batchno != "")
                {
                    sql_d = sql_d + " and p.BatchNO = '" + batchno + "'";
                }
                if (floc != "")
                {
                    sql_d = sql_d + " and p.From_LOC like  '" + floc + "'";
                }
                if (tloc != "")
                {
                    sql_d = sql_d + " and p.To_LOC like  '" + tloc + "'";
                }

                sqlquery = " select aa. [Organization],aa.[OperationNo],aa.[TransactionType],aa.[SerialNO],aa.[PartNO],aa.[From_LOC],aa.[To_LOC],aa.[Quantity],aa.[Creater],aa.[Createdate],aa.[BatchNO],aa.[ContainerStatus] from " +

                           " (" + sql + " union all " + sql_d + ") aa  order by aa.[Creater] desc";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sqlquery);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<PlexContainer> luw = new List<PlexContainer>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        PlexContainer ERM = new PlexContainer(row);
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
    }
       
}