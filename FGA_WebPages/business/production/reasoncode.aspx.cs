using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_BLL.UI;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.business.production
{
    public partial class reasoncode : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return;
            this.pno.Value = HttpContext.Current.Request.QueryString["pno"].ToString();
            if (!IsPostBack)
            {
                rptList.DataSource = FGA_BLL.ReasonBLL.GetReasonList(null);
                rptList.DataBind();
            }
        }

        protected void OnBtnSaveClick(object sender, EventArgs e)
        {
            //string sql = "update sequencerecord set Reason='{0}',ReasonDesc='{1}' where PartNO='{2}'";
            string sql = "insert into sequencerecord (WorkCenter,Reason,ReasonDesc,PartNO) values ('wct','{0}','{1}','{2}') ";
            sql = string.Format(sql, this.ddlreason.SelectedValue, this.ddlreason.SelectedItem.Text, Request.QueryString["pno"].ToString());

            if (FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql) > 0)
                base.DoYmpromptBack(SysConst.ST_OK);
        }
        [WebMethod]
        public static string UpdateSqrd(string Reason, string ReasonDesc, string pno, string workcenter)
        {
            string res = string.Empty;
            try
            {
                //string sql = "update sequencerecord set Reason='{0}',ReasonDesc='{1}' where PartNO='{2}'";
                string sql = "insert into sequencerecord (WorkCenter,Reason,ReasonDesc,PartNO) values ('{3}','{0}','{1}','{2}') ";
                sql = string.Format(sql, Reason, ReasonDesc, pno, workcenter);

                if (FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql) > 0)
                    res = "1";
                else
                    res = "0";
            }
            catch
            {
                res = "0";
            }
            return res;
        }
    }
}