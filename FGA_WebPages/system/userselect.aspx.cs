using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FGA_PLATFORM.system
{
    public partial class userselect : System.Web.UI.Page
    {
        /// <summary>
        /// 是否多选，默认0否
        /// </summary>
        protected string MutiCheck = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            bool isMuti = !string.IsNullOrEmpty(Request.QueryString["muti"]);
            MutiCheck = isMuti.ToString().ToLower();
        }
    }
}