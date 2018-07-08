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
using FGA_MODEL.index;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.business.production
{
    public partial class arg_bendinghome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// 点击本厂编号记录成品信息
        /// </summary>
        /// <param name="pno">benchangbianhao</param>
        /// <returns></returns>
        [WebMethod]
        public static string AddToSqrd(string pno,string workcenter)
        {
            try
            {
                string sql = "insert into sequencerecord (WorkCenter,PartNO) values ('{1}','{0}')";
                sql = string.Format(sql, pno, workcenter);
                if (FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql) > 0)
                    return "1";
                else
                    return "0";
            }
            catch
            {
                return "0";
            }
        }
        /// <summary>
        /// 页面初始化读取workcenter
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string InitWkct()
        {
            string res = string.Empty;
            try
            {
                UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
                string sql = "SELECT [ORGANIZATION],[USERCODE],[WORKCENTER],[OPERATION] " +
                             ",[SHIFT],[UTYPE] FROM [FGA_PLATFORM].[dbo].[UserCtrl]where USERCODE='{0}' AND UTYPE = '02' order by convert(int,substring(WORKCENTER,6,2))";
                sql = string.Format(sql, model.USERNAME);
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<userctrlModel> luw = new List<userctrlModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                        luw.Add(new userctrlModel(row));

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(luw);
                }


            }
            catch (Exception e)
            {
 

            }
            return res;
        }
        /// <summary>
        /// chushihua30gexiaochexinxi
        /// </summary>
        /// workcenter:dangqian workcenter
        /// <returns></returns>
        [WebMethod]
        public static string InitBendingData(string workcenter)
        {
            string res = string.Empty;
            try
            {
                arg_bendingModel abdmodel = new arg_bendingModel();
                planmodel plan = null;
                List<planmodel> planlist = new List<planmodel>();

                #region qu dangqian xiaochehao
                UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
                string sql = "select CurrentCarNO from currentcar where workcenter='{0}' ";
                sql = string.Format(sql, workcenter);
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    abdmodel.curcarno = ds.Tables[0].Rows[0][0].ToString();
                }
                else
                {
                    abdmodel.curcarno = "1";
                }
                #endregion

                #region fengzhunag 30 ge xiaoche jihua paidan xinxi

                sql = "select CarNO,JobNO,ItemCode from argbendingplan where workcenter='{0}'";
                sql = string.Format(sql, workcenter);
                ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                bool hasdata=false;
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    hasdata=true;
                }
                for (int i = 1; i <= 30; i++)
                {
                    plan = new planmodel();
                    plan.carno = i.ToString();
                    if (hasdata)
                    {
                        DataRow[] dr = ds.Tables[0].Select("CarNO='" + i.ToString() + "'");
                        if (dr.Count() > 0)
                        {
                            plan.jobno = dr[0]["JobNO"].ToString();
                            plan.codeitem = dr[0]["ItemCode"].ToString();
                        }
                        else
                        {
                            plan.jobno = "";
                            plan.codeitem = "";
                        }
                    }
                    else
                    {
                        plan.jobno = "";
                        plan.codeitem = "";
                    }
                    planlist.Add(plan);
                }
                abdmodel.planlist = planlist;

                #endregion

                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(abdmodel);


            }
            catch (Exception e)
            {


            }
            return res;
        }

        [WebMethod]
        public static string UpdateCurcar(string carno, string workcenter)
        {
            string res = string.Empty;
            try
            {
                if (int.Parse(carno) >= 31)
                    carno = "1";
                List<string> sqllist = new List<string>();
                string sql = string.Empty;
                sql = "delete from currentcar where WorkCenter='{0}'";
                sql = string.Format(sql,workcenter);
                sqllist.Add(sql);
                sql = "insert into currentcar (WorkCenter,CurrentCarNO) values ('{0}','{1}')";
                sql = string.Format(sql,workcenter,carno);
                sqllist.Add(sql);
                if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist)>0)
                {
                    res = "success";
                }
                else
                {
                    res = "fail";
                }
            }
            catch
            {
 
            }
            return res;

        }

    }
}