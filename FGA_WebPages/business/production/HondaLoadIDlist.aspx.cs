using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_BLL.UI;
using FGA_MODEL;
using FGA_MODEL.index;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.business.production
{
    public partial class HondaLoadIDlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return;

            if (!IsPostBack)
            {
                UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

                //按用户查看EDI的数据
                string ET = "";
                string sql = "";

                if (model.USERNAME == "Honda_front")
                    ET = "Front";
                if (model.USERNAME == "Honda_rear")
                    ET = "Rear";
                if (model.USERNAME == "Honda_side")
                    ET = "Side";
             


                sql = "select [Quantity],[Creater],[Createdate],[LoadStatus],[LoadID] " +
                             ",[CustomerName],[CustomerAddress],[ShipDate],[BatchNO] from FGA_EDI_LOAD_T  WHERE PartType = '"+ET+"' and slstatus = '0' order by LoadID desc";

                if (model.USERNAME == "administrator")
                {
                    sql = "select [Quantity],[Creater],[Createdate],[LoadStatus],[LoadID] " +
                            ",[CustomerName],[CustomerAddress],[ShipDate],[BatchNO] from FGA_EDI_LOAD_T  order by LoadID desc";
                }
                
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                rptList.DataSource = ds;
                rptList.DataBind();
            }
        }
    }
}