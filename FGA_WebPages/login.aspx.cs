using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_NUtility.Consts;
using FGA_NUtility.Enums;
namespace FGA_PLATFORM
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }
        protected void btnsub_Click(object sender, EventArgs e)
        {
            try
            {
                string uid = account.Value.Trim();
                string psd = pwd.Value.Trim();
                UsersModel model = FGA_BLL.UsersBLL.UserLogin(uid, psd);
                if (model == null)
                    lblMsg.InnerText = "Username or password is wrong!";
                else
                {

                    Session[SysConst.S_LOGIN_USER] = model;
                    Response.Redirect("index.aspx", false);
                }
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException(this.GetType().Name, ex);
                lblMsg.InnerText = "Login failure!";
            }
        }
    }
}