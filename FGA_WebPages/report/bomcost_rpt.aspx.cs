using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace FGA_PLATFORM.report
{
    public partial class bomcost_rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }


        private void BindData()
        {
            //string month = this.DropDownList1.SelectedItem.Text;
            //string year = this.DropDownList2.SelectedItem.Text;
            //string sql = "select * from bomcost_rpt where PERIOD_NAME='{0}'";
            //sql = string.Format(sql, month + "-" + year);
            //DataSet ds = new DataSet();
            //ds=FGA_DAL.Base.SQLServerHelper.Query(sql);
            //this.rptList.DataSource = ds.Tables[0].DefaultView;
            //this.rptList.DataBind();

            string month = this.DropDownList1.SelectedItem.Text;
            string year = this.DropDownList2.SelectedItem.Text;
            string sql = "select * from bomcost_rpt where PERIOD_NAME='{0}'";
            sql = string.Format(sql, month + "-" + year);

            SqlConnection connection = new SqlConnection(FGA_NUtility.ConfigHelper.GetConfigValue("ConnectionString"));

            SqlCommand cmd = new SqlCommand(sql, connection);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            AspNetPagerAskAnswer.PageSize = 500;
            AspNetPagerAskAnswer.RecordCount = 5000;
            sda.Fill(ds, AspNetPagerAskAnswer.PageSize * (AspNetPagerAskAnswer.CurrentPageIndex - 1), AspNetPagerAskAnswer.PageSize, "bomcost_rpt");//固定不变的 
            this.rptList.DataSource = ds.Tables["bomcost_rpt"].DefaultView;
            this.rptList.DataBind();
        }
        protected void btnsearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void btnexport_Click(object sender, EventArgs e)
        {
            string filename = "bomcost_rpt"+DateTime.Now.ToString()+".xls";
            string month = this.DropDownList1.SelectedItem.Text;
            string year = this.DropDownList2.SelectedItem.Text;
            string sql = "select * from bomcost_rpt where  PERIOD_NAME='{0}'";
            sql = string.Format(sql,month+"-"+year);
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                HttpContext context = System.Web.HttpContext.Current;
                ExcelRender.SetRenderToExcel(ds.Tables[0], context, filename);
            }
        }

        protected void AspNetPagerAskAnswer_PageChanged(object sender, EventArgs e)
        {
            BindData();
        } 

    }
}