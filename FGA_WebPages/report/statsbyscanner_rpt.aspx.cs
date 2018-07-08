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
    public partial class statsbyscanner_rpt : System.Web.UI.Page
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
            string month = this.DropDownList1.SelectedItem.Text;
            string year = this.DropDownList2.SelectedItem.Text;
            string sql = "select SUBSTRING (CONVERT(varchar(100),[createtime], 5),4,5) as [period_name],[SerialNO],[PartNO]," +
                         "[Location],[Quantity],[ActualQty],[ActualQty] - [Quantity] as difference,[areacode],[creater] ,[createtime] " +
                         "from statsbyscanner order by createtime desc";
            string sql_count = "select count(*) from statsbyscanner";
            sql = string.Format(sql, month + "-" + year);

            SqlConnection connection = new SqlConnection(FGA_NUtility.ConfigHelper.GetConfigValue("ConnectionString"));
            //获取数据表总行数
            SqlCommand cmd_count = new SqlCommand(sql_count, connection);

            //封装分页
            SqlCommand cmd = new SqlCommand(sql, connection);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            AspNetPagerAskAnswer.PageSize = 500;
            AspNetPagerAskAnswer.RecordCount = 5000;
            sda.Fill(ds, AspNetPagerAskAnswer.PageSize * (AspNetPagerAskAnswer.CurrentPageIndex - 1), AspNetPagerAskAnswer.PageSize, "statsbyscanner");//固定不变的 
            this.rptList.DataSource = ds.Tables["statsbyscanner"].DefaultView;
            this.rptList.DataBind();
        }
        protected void btnsearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void btnexport_Click(object sender, EventArgs e)
        {
            string filename = "statsbyscanner" + DateTime.Now.ToString() + ".xls";
            string month = this.DropDownList1.SelectedItem.Text;
            string year = this.DropDownList2.SelectedItem.Text;
            string sql = "select period_name,[SerialNO],[PartNO],[Location],[Quantity],[ActualQty],[ActualQty] - [Quantity] as difference,[creater] ,[createtime] from statsbyscanner";
            //sql = string.Format(sql,month+"-"+year);
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