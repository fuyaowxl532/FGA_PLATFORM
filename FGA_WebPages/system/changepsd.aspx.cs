using FGA_BLL.UI;
using FGA_MODEL;
using FGA_NUtility.Consts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FGA_PLATFORM.system
{
    public partial class changepsd : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// 提交处理
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OnBtnSubClick(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return;
            try
            {
                string oldpsd = this.txtcurrent.Text.Trim();
                string newpsd = this.txtnew.Text.Trim();
                string newpsd2 = this.txtnew2.Text.Trim();

                
                //三次md5加密
                for (int i = 0; i < 3; i++)
                {
                    oldpsd =FGA_NUtility.Encrypt.MD5EnCode(oldpsd);
                }

                if (!oldpsd.Equals(base.CurrentUser.PASSWORD))
                {
                    AutoCloseMessage("txtcurrent", "Current password is wrong!", "bottom left");
                    return;
                }
                if (newpsd.Length < 6)
                {
                    AutoCloseMessage("txtnew", "The length of new password must be greater than six!", "bottom left");
                    return;
                }
                if (!newpsd.Equals(newpsd2))
                {
                    AutoCloseMessage("txtnew2", "The passwords you entered do not match!", "bottom left");
                    return;
                }
                
                for (int i = 0; i < 3; i++)
                {
                    newpsd =FGA_NUtility.Encrypt.MD5EnCode(newpsd);
                }
                base.CurrentUser.PASSWORD = newpsd;

                bool res = FGA_BLL.UsersBLL.UpdateUsers(base.CurrentUser);
                if (res)
                {
                    AutoCloseMessage("btnSub", "Update Successfully!", "bottom left");

                    
                }
                else
                {
                    
                }

                
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException(this.GetType().Name, ex);
                AutoCloseMessage("btnSub", "Update Successfully!", "bottom left");
            }
        }
    }
}