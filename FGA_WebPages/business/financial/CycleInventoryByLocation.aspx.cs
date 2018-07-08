using System;
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
using System.Data.SqlClient;
using System.Data;
using FGA_MODEL.Args;

namespace FGA_PLATFORM.business.financial
{
    public partial class CycleInventoryByLocation : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData_H(string cycleno, string location,string status, string fdate, string tdate)
        {
            //按用户查看数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            string sql = "";
            string res = string.Empty;
            try
            {
                sql = "SELECT fch.[CycleNO],fch.[CycleStatus],fch.[StartBy],fch.[CompleteBy],fch.[StartDate],fch.[CompleteDate],fch.[Location] " +
                      "FROM [WMS_BarCode_V10].[dbo].[FGA_CycleInventory_H] fch WHERE isnull(Dr,0) = 0 and exists (select 1 from [FGA_CycleInventory_Detail] fcd " +
                      "where fch.[CycleNO] = fcd.[CycleNO] and isnull(fcd.Dr,0) = 0) ";

                //查询条件
                if(!model.USERNAME.Equals("administrator") && !model.USERNAME.Equals("fy.aricciardi"))
                    sql = sql + " and [StartBy] = '" + model.USERNAME + "'";

                if (!String.IsNullOrEmpty(cycleno))
                    sql = sql + " and fch.[CycleNO] like '%" + cycleno.Trim() + "%'";
                if (!String.IsNullOrEmpty(status))
                {
                    if (status != "All")
                        sql = sql + " and fch.[CycleStatus] = '" + status.Trim() + "'";
                }
                if (!String.IsNullOrEmpty(location))
                    sql = sql + " and fch.[Location] like  '%" + location.Trim() + "%'";
                if (!String.IsNullOrEmpty(fdate))
                    sql = sql + " and fch.[StartDate] >= cast('" + fdate + "' as datetime)";
                if (!String.IsNullOrEmpty(tdate))
                    sql = sql + " and fch.[StartDate] <= cast('" + tdate + "' as datetime)";

                sql = sql + " order by fch.[CycleNO] desc";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<CycleInventory_H> luw = new List<CycleInventory_H>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        CycleInventory_H ERM = new CycleInventory_H(row);
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
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchDetail(string data) {

            string res = String.Empty;
            try
            {
                string sql = "SELECT * " +
                             "FROM [WMS_BarCode_V10].[dbo].[FGA_CycleInventory_Detail] where [CycleNO] = '"+data+"' and isnull(dr,'0') = '0' order by CycleRowID desc";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<CycleInventory_Detail> luw = new List<CycleInventory_Detail>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        CycleInventory_Detail ERM = new CycleInventory_Detail(row);
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