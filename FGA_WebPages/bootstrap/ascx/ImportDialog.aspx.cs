using FGA_BLL.UI;
using FGA_MODEL;
using FGA_NUtility.Consts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FGA_PLATFORM.ascx
{
    public partial class ImportDialog : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                Redirect("../404.htm");
        }


        [WebMethod]
        public static string GetAllHead(string pagename)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return "";
            string res = string.Empty;
            
            return res;
        }

        [WebMethod]
        public static string AddLog(string pagename)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return "";
            string res = "";
            
            return res;
        }


    }
}