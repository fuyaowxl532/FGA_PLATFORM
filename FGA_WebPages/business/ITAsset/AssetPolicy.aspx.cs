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
using FGA_NUtility;
using FGA_NUtility.Consts;
using FGA_MODEL.Args;

namespace FGA_PLATFORM.business.ITAsset
{
    public partial class AssetPolicy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //读取Use Policy并点击Agree
        [WebMethod]
        public static string agreePolicy()
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            String sql = "insert into [FGA_AssetUsePolicy]([PlexID],[SignatureDate])" +
                         "values('" + model.USERNAME + "', getdate()) ";

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql) > 0)
                return "1";
            else
                return "0";
        }
    }
}