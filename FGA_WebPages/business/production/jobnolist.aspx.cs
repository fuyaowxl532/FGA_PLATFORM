using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_BLL.UI;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.business.production
{
    public partial class jobnolist : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return;
            
            if (!IsPostBack)
            {
                string sql = "select * from argplanlist";
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                rptList.DataSource = ds;
                rptList.DataBind();
            }
        }
    }
}