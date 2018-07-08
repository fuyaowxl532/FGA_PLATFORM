using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Services;

using FGA_BLL.UI;
using System.Collections;
using FGA_MODEL.Args;
using FGA_MODEL;
using FGA_NUtility.Consts;
using FGA_NUtility.Enums;
using System.Text;
using FGA_NUtility;
using FGA_MODEL.index;
using System.Web.Script.Serialization;


namespace FGA_PLATFORM.business.financial
{
    public partial class bomcostdata : System.Web.UI.Page
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize") == string.Empty ? "10" : ConfigHelper.GetConfigValue("PageSize");
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {
                BindData();
            }
        }


        private void BindData()
        {
            //string sql = "select top 100 * from bomcost_rptbase";
            //DataSet ds = new DataSet();
            //ds=FGA_DAL.Base.SQLServerHelper.Query(sql);

            SqlConnection connection = new SqlConnection(FGA_NUtility.ConfigHelper.GetConfigValue("ConnectionString"));
            SqlCommand cmd = new SqlCommand("select * from bomcost_rptbase", connection);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();   
            AspNetPagerAskAnswer.PageSize = 500;
            AspNetPagerAskAnswer.RecordCount = 15000;
            sda.Fill(ds, AspNetPagerAskAnswer.PageSize * (AspNetPagerAskAnswer.CurrentPageIndex - 1), AspNetPagerAskAnswer.PageSize, "bomcost_rptbase");//固定不变的 
            this.rptList.DataSource = ds.Tables["bomcost_rptbase"].DefaultView;
            this.rptList.DataBind();
  
        }
        protected void btnsearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void btnimport_Click(object sender, EventArgs e)
        {

          
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {

        }

        protected void btndel_Click(object sender, EventArgs e)
        {

        }

        protected void btnedit_Click(object sender, EventArgs e)
        {

        }

        protected void btnrefresh_Click(object sender, EventArgs e)
        {

        }

        protected void btnexport_Click(object sender, EventArgs e)
        {
              string filename = "bomcostdata"+DateTime.Now.ToString()+".xls";
            string sql = "select * from bomcost_rptbase";
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                HttpContext context = System.Web.HttpContext.Current;
                ExcelRender.SetRenderToExcel(ds.Tables[0], context, filename);
            }

        }

        protected void btnsave_Click(object sender, EventArgs e)
        {

        }

        protected void AspNetPagerAskAnswer_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }  
    }
}