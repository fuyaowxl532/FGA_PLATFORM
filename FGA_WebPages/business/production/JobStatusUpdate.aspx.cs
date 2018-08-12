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
    public partial class JobStatusUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

            List<JobStatusModel> listmodel = new List<JobStatusModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<JobStatusModel>>(data);

            foreach (JobStatusModel pc in listmodel)
            {
                string sql = "insert into [FGA_JobNoStatusUpt]([JobNO],[JobStatus],[Creator],[CreateDate]) "+
                             "values('"+pc.JobNO+"','Production','"+ user + "',getdate())";

                sqllist.Add(sql);
            }

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
            {
                return "1";

            }

            else
                return "0";
        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData()
        {
            string res = string.Empty;
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            try
            {
                String sql = "SELECT * FROM [WMS_BarCode_V10].[dbo].[FGA_JobNoStatusUpt] where ISNULL(JobStatus,'') = 'Production' and Creator = '"+ puser + "'";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<JobStatusModel> luw = new List<JobStatusModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        JobStatusModel ERM = new JobStatusModel(row);
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

        [WebMethod]
        //更新JOBNO的状态
        public static string updateStatus()
        {
            string res = String.Empty;

            int count  = 0;
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();
            List<JobStatusModel> luw = new List<JobStatusModel>();
            string jn = "\'0\'";

            String sql = "SELECT * FROM [WMS_BarCode_V10].[dbo].[FGA_JobNoStatusUpt] where ISNULL(JobStatus,'') = 'Production' and Creator = '" + puser + "'";

            DataSet ds = new DataSet();
               
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    JobStatusModel ERM = new JobStatusModel(row);
                    //首先通过JOBNO获取JOBKEY--Job_Key_Get/10436 @Job_No
                    FGA_NUtility.POL.ExecuteDataSourceResult rkey = PlexHelper.PlexGetResult_1("10436", "Job_Key_Get", "@Job_No", ERM.JobNO);
                    if (rkey.ResultSets != null)
                    {
                        string _key = rkey.ResultSets[0].Rows[0].Columns[0].Value;
                        FGA_NUtility.POL.ExecuteDataSourceResult esr = PlexHelper.PlexGetResult_2("36211", "Job_Scheduling_Details_Update", "@Job_Key", "@Job_Status", _key, "Completed");
                        if (esr.OutputParameters[1].Value == "Success")
                        {
                            jn = jn + "," + '\'' + ERM.JobNO + '\'';
                            count++;
                        }
                    }
                }

                if (count > 0)
                {
                    string sqlupdate = "update [FGA_JobNoStatusUpt] set JobStatus ='Completed',CompletedDate = GETDATE() where JobNO in (" + jn + ") AND Creator = '" + puser + "'";
                    int fin = FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sqlupdate);

                    res = fin.ToString();
                }
            }
            else
                res = "-1";

            return res;
        }
    }
}