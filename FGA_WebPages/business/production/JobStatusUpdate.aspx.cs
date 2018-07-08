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
            if (!IsPostBack)
            {
                BindData();
            }
        }

        [WebMethod]
        //更新JOBNO的状态
        public static string vaildate(string jobno)
        {

            try
            {
                JobStatusModel jsm = new JobStatusModel();
                List<string> sqllist = new List<string>();

                string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

                string sql = "SELECT Q.JOB_NO,Q.JOB_KEY,Q.PART_NO,Q.NAME,Q.Part_Group,Q.Due_Date,Q.Job_Status FROM OPENQUERY(PLEXODBC, " +
                              " 'SELECT PJ.JOB_NO,PJ.JOB_KEY,PP.PART_NO,PP.NAME,ppg.Part_Group,pj.Due_Date,pjs.Job_Status " +
                              " FROM Part_V_Job PJ,PART_V_PART PP,Part_v_Job_Status  pjs,Part_v_Part_Group ppg " +
                              " WHERE PJ.PART_KEY=PP.PART_KEY " +
                              " and pj.Job_Status_Key=pjs.Job_Status_Key" +
                              " and pp.Part_Group_Key=ppg.Part_Group_Key" +
                              " AND PJ.JOB_NO=''S1400''')  AS Q";
                string updatesql = null;

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    updatesql = "update [JobNoStatusUpt] set jobkey ='{0}' ,partno ='{1}' ,partname ='{2}'," +
                                "partgroup ='{3}',JobStatus = '{4}' where JobNO = '{5}' ";

                    updatesql = string.Format(updatesql, ds.Tables[0].Rows[0][1].ToString(),ds.Tables[0].Rows[0][2].ToString(),
                        ds.Tables[0].Rows[0][3].ToString(),ds.Tables[0].Rows[0][4].ToString(),ds.Tables[0].Rows[0][6].ToString(), jobno);
                }

                sqllist.Add(updatesql);

                if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
                {
                    return "1";
                }
                else
                    return "0";
            }
            catch
            { return "0"; }
        }

        [WebMethod]
        //更新JOBNO的状态
        public static string updateStatus(string data)
        {
            string jobnos = null;
            int count  = 0;

            try
            {
                string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
                List<string> sqllist = new List<string>();

                JobStatusModel model = new JobStatusModel();
                List<JobStatusModel> listmodel = new List<JobStatusModel>();
                JavaScriptSerializer jssl = new JavaScriptSerializer();
                listmodel = jssl.Deserialize<List<JobStatusModel>>(data);

                foreach (JobStatusModel m in listmodel)
                {
                    //首先通过JOBNO获取JOBKEY--Job_Key_Get/10436 @Job_No
                    FGA_NUtility.POL.ExecuteDataSourceResult rkey = PlexHelper.PlexGetResult_1("10436", "Job_Key_Get", "@Job_No", m.JobNO);
                    if (rkey.ResultSets != null)
                    {
                        string _key = rkey.ResultSets[0].Rows[0].Columns[0].Value;
                        FGA_NUtility.POL.ExecuteDataSourceResult esr = PlexHelper.PlexGetResult_2("36211", "Job_Scheduling_Details_Update", "@Job_Key", "@Job_Status", _key, "Completed");
                        if (esr.OutputParameters[1].Value == "Success")
                        {
                            string sql = "update JobNoStatusUpt set jobkey = '" + _key + "',Jobstatus = 'Completed',Note = 'Y' where jobno = '"+m.JobNO+"'";
                            sqllist.Add(sql);
                            count++;
                        }
                        else
                            jobnos = jobnos + m.JobNO;
                    }
                }

                FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist);
               
                return "1";
            }
            catch
            { return "0"; }
        }

        private void BindData()
        {
            string sql = null;

            if (cbCompleted.Checked)
            {
                sql = "select [JobNO],[JobKey],[PartNO],[PartName],[PartGroup],[DueDate],[JobStatus],[Note],[Creater],[CreateDate]" +
                      "from [JobNoStatusUpt] order by createdate desc";
            }
            else
            {
                sql = "select [JobNO],[JobKey],[PartNO],[PartName],[PartGroup],[DueDate],[JobStatus],[Note],[Creater],[CreateDate]" +
                     "from [JobNoStatusUpt] where Note is null order by createdate desc";
            }
            //string sql = "select [JobNO],[JobKey],[PartNO],[PartName],[PartGroup],[DueDate],[JobStatus],[Note],[Creater],[CreateDate]"+
            //             "from [JobNoStatusUpt] order by createdate desc";
            //string sql_count = "select count(*) from JobNoStatusUpt";

            //SqlConnection connection = new SqlConnection(FGA_NUtility.ConfigHelper.GetConfigValue("ConnectionString"));
            ////获取数据表总行数
            //SqlCommand cmd_count = new SqlCommand(sql_count, connection);

            ////封装分页
            //SqlCommand cmd = new SqlCommand(sql, connection);
            //SqlDataAdapter sda = new SqlDataAdapter(cmd);
            //DataSet ds = new DataSet();
            //AspNetPagerAskAnswer.PageSize = 500;
            //AspNetPagerAskAnswer.RecordCount = 5000;
            //sda.Fill(ds, AspNetPagerAskAnswer.PageSize * (AspNetPagerAskAnswer.CurrentPageIndex - 1), AspNetPagerAskAnswer.PageSize, "JobNoStatusUpt");//固定不变的 
            //this.rptList.DataSource = ds.Tables["JobNoStatusUpt"].DefaultView;
            //this.rptList.DataBind();

            
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
            this.rptList.DataSource = ds.Tables[0].DefaultView;
            this.rptList.DataBind();
        }

        //查询
        protected void btnquery_Click(object sender, EventArgs e)
        {
            BindData();
        }

    }
}