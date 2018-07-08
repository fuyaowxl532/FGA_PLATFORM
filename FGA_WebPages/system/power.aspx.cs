using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_BLL.UI;
using FGA_MODEL;

namespace FGA_PLATFORM.system
{
    public partial class power : PageBase
    {
        public string editpw = "0";//只有超级管理员才可管理菜单
        protected void Page_Load(object sender, EventArgs e)
        {
            UsersModel model = base.CurrentUser;
            if (model.IsSuperUser)
                editpw = "1";
        }
    }
}