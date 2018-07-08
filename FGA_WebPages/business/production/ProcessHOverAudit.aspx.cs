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


namespace FGA_PLATFORM.business.production
{
    public partial class ProcessHOverAudit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 查询数据
        /// 按照用户配置表获取当前用户能操作的事物类型
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string batchno,string status, string floc, string tloc,string fdate,string tdate)
        {
            //按用户查看数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            if (status == "Both") {
                status = "'In Progress','Finish','Reject'";
            }
            if (status == "In Progress")
            {
                status = "'In Progress'";
            }
            if (status == "Reject")
            {
                status = "'Reject'";
            }
            if (status == "Finish")
            {
                status = "'Finish'";
            }
           
            string sql = "";
            string res = string.Empty;
            try
            {
                if (model.USERNAME != "administrator")
                {
                    sql = " SELECT a.[Organization],a.[OperationNo],a.[TransactionType],a.[SerialNO],a.[PartNO],a.[From_LOC],a.[To_LOC],a.[Quantity],a.[Creater],a.[Createdate],a.[BatchNO],a.[ContainerStatus]" +
                          " FROM [ProcessHOAudit_T]  a join userctrl b on a.operationno = b.operation " +
                          " and a.transactiontype = substring(b.[TRANSACTIONTYPE],0,7) and len(b.[TRANSACTIONTYPE]) >6 and b.[USERNAME] = '" + model.USERNAME+ "'" +
                          " where a.[ContainerStatus] in (" + status + ") ";
                }
                if (model.USERNAME == "administrator")
                {
                    sql = " SELECT [Organization],[OperationNo],[TransactionType],[SerialNO],[PartNO],[From_LOC],[To_LOC],[Quantity],[Creater],[Createdate],[BatchNO],[ContainerStatus] " +
                          " FROM [ProcessHOAudit_T] a where a.[ContainerStatus] in (" + status + ") ";
                }
                if (fdate != "")
                {
                    sql = sql + " and a.Createdate between cast('"+fdate+"' as datetime) and cast('"+tdate+"' as datetime)";
                }
                if (batchno != "")
                {
                    sql = sql + " and a.BatchNO = '" + batchno + "'";
                }
                if (floc != "") {
                    sql = sql + " and a.From_LOC like  '" + floc + "'";
                }
                if (tloc != "") {
                    sql = sql + " and a.To_LOC like  '" + tloc + "'";
                }

                sql = sql + " order by a.Createdate desc";
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
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

        /// <summary>
        /// 执行移库操作
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string confirmData(string data)
        {
            //按用户查看EDI的数据
            string plexid = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).PLEXID;
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();

            List<PlexContainer> listmodel = new List<PlexContainer>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<PlexContainer>>(data);

            foreach (PlexContainer pc in listmodel) {
                bool rt = true;
                FGA_NUtility.POL.ExecuteDataSourceResult esr = PlexHelper.PlexGetResult_4("27181", "Container_Update_Simple", "@Serial_No", "@Last_Action", "@Location", "@Update_By",
                    pc.SerialNO, "Updated at Inventory Update Form", pc.TLoc, plexid);
                rt = esr.Error;

                if (!rt) {
                    string sql = "update [ProcessHOAudit_T] set [ContainerStatus] = 'Finish',[Receiver] ='" + user + "',[ReceptionDate] = getdate()  where SERIALNO = '" + pc.SerialNO + "' AND [From_LOC] = '" + pc.Location + "' and [ContainerStatus] = 'In Progress'";
                    sqllist.Add(sql);
                }
            }

            if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
            {
                return "1";
            }
            else
                return "0";
        }

        /// <summary>
        /// 驳回数据(拒绝)
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string rejectData(string data)
        {
            //按用户查看EDI的数据
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();

            List<PlexContainer> listmodel = new List<PlexContainer>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<PlexContainer>>(data);


            foreach (PlexContainer pc in listmodel)
            {
                string sql = "update [ProcessHOAudit_T] set [ContainerStatus] = 'Reject',[Receiver] ='" + user + "',[ReceptionDate] = getdate()  where SERIALNO = '" + pc.SerialNO + "' AND [From_LOC] = '" + pc.Location + "' and [ContainerStatus] = 'In Progress'";
                sqllist.Add(sql);
            }

            if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
            {
                return "1";
            }
            else
                return "0";
        }
    }

       
}