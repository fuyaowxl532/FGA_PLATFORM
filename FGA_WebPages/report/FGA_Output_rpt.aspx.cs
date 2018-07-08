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
    public partial class FGA_Output_rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 根据当前用户获取workcenter
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getWorkCenter()
        {
            //按用户查看数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            string sql = "";
            string res = string.Empty;
            try
            {
                sql = "SELECT [WorkCenter] FROM [UserWorkCenter_t] where UserName = '" + model.USERNAME + "' and Ptype = 'output'";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<userctrlModel> luw = new List<userctrlModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        userctrlModel ERM = new userctrlModel(row);
                        luw.Add(ERM);
                    }

                    //同步workcenter当班的产量
                    List<userctrlModel> nwt = getOutPut(luw);

                    //获取workcenter对应的产量
                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(nwt);
                }
            }
            catch (Exception e)
            {

            }

            return res;
        }

        /// <summary>
        /// 根据workcenter同步当班产量
        /// 1st:
        /// 2nd:15:00:00--22:59:59
        /// 3rd:23:00:00--06:59:59
        /// </summary>
        /// <returns></returns>
        public static List<userctrlModel> getOutPut(List<userctrlModel> nm)
        {
            if(nm.Count !=0)
            {
                //获取当前时间
                //当前时间在07:00:00--14:59:59获取当天第一班
                //当前时间在15:00:00--22:59:59获取当天第二班
                //当前时间在23:00:00--23:59:59获取当天第三班
                //当前时间在00:00:00--06:59:59获取当天第三班
                string shift = "";
                List<string> sqllist = new List<string>();

                DateTime dt = DateTime.Now;
                string dts = "";

                if (dt.Hour >= 7 && dt.Hour < 15)
                { 
                    shift = "1st";
                    dts = dt.Date.ToString();
                }
                 if (dt.Hour >= 15 && dt.Hour < 23)
                { 
                    shift = "2nd";
                    dts = dt.Date.ToString();
                }
                 if (dt.Hour < 7 && dt.Hour == 23)
                {
                    shift = "3rd";
                    dts = dt.AddDays(-1).Date.ToString();
                }

                foreach (userctrlModel vo in nm) 
                {
                    string sql = " select WCKey FROM [PlexWorkCenter_t] where WorkCenter = '"+vo.WORKCENTER+"' ";
                    string wkey = "";
                    DataSet ds = new DataSet();
                    ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        wkey = ds.Tables[0].Rows[0][0].ToString();

                        //获取指定日期的产量
                        FGA_NUtility.POL.ExecuteDataSourceResult rst = PlexHelper.PlexGetResult_3("9330", "Daily_Production_Get_New",
                       "@Workcenter_Code", "@Start_Date", "@End_Date", wkey, dts, dts);

                        if (rst.ResultSets != null)
                        {
                            int count = rst.ResultSets[0].Rows.Length;
                            for (int i = 0; i < count; i++)
                            {
                                string _shift = rst.ResultSets[0].Rows[i].Columns[1].Value;
                                string _partno = rst.ResultSets[0].Rows[i].Columns[2].Value;
                                string _quantity = rst.ResultSets[0].Rows[i].Columns[4].Value;
                                string _reportdate = rst.ResultSets[0].Rows[i].Columns[10].Value;
                                string _scrapqty = rst.ResultSets[0].Rows[i].Columns[29].Value;
                                string _operationcode = rst.ResultSets[0].Rows[i].Columns[32].Value;

                                string insert_sql = "insert into [Plex_Daily_Production]([WorkCenter],[ShiftGroup],[PartNO],[Quantity],[Report_Date],[Scrap_Quantity],[OperationCode],[CreateDate])" +
                                                    "values('" + vo.WORKCENTER + "','" + _shift + "','" + _partno + "'," + _quantity + ",'" + _reportdate + "'," + _scrapqty + ",'" + _operationcode + "',getdate())";

                                sqllist.Add(insert_sql);
                            }
                        }
                    }
                }

                //产量插入数据库
                FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist);

                //获取各workcenter对应的产量
                string sql_o = "select WorkCenter,sum(Quantity) Quantity from [Plex_Daily_Production] where " +
                               "report_date = '" + dts + "' and ShiftGroup ='"+shift+"' group by WorkCenter";
                DataSet dso = new DataSet();
                dso = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql_o);
                if (dso != null && dso.Tables.Count > 0 && dso.Tables[0].Rows.Count > 0)
                {
                    //定义hashtable
                    Dictionary<string, int> dic = new Dictionary<string, int>();

                    foreach (DataRow row in dso.Tables[0].Rows)
                    {
                        dic.Add(row[0].ToString(),
                            Convert.ToInt32(row[1]));
                    }

                    //赋值workcenter的产量
                    for (int i = 0; i < nm.Count; i++)
                    {
                        if (dic.ContainsKey(nm[i].WORKCENTER))
                            nm[i].QUANTITY = dic[nm[i].WORKCENTER];
                        else
                            nm[i].QUANTITY = 0;
                    }
                }
            }
            return nm;
        }

        /// <summary>
        /// 当前workcenter周产量
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getWeekData()
        {
            string res = string.Empty;

            DateTime dt = DateTime.Now;
            DateTime sw = dt.AddDays(1 - Convert.ToInt32(dt.DayOfWeek.ToString("d")));

           

            /// 获取本周各班组的产量信息
            string sql_w = "select ShiftGroup SHIFT,sum(Quantity) Quantity from [Plex_Daily_Production] where " +
                           "report_date between '" + sw.Date.ToString() + "' and '" + dt.Date.ToString() + "' group by ShiftGroup";
            DataSet dsw = new DataSet();
            dsw = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql_w);
            if (dsw != null && dsw.Tables.Count > 0 && dsw.Tables[0].Rows.Count > 0)
            {

                List<userctrlModel> luw = new List<userctrlModel>();
                foreach (DataRow row in dsw.Tables[0].Rows)
                {
                    userctrlModel ERM = new userctrlModel(row);
                    luw.Add(ERM);
                }

                //获取workcenter对应的产量
                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(luw);
            }

            return res;
        }
    }
}