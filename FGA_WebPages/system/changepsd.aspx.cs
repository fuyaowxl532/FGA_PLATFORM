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
                    //base.ShowAlert("提示", "当前密码输入有误!");
                    //ShowTopMessage("提示:当前密码输入有误!", "40px", "100%");
                    AutoCloseMessage("txtcurrent", "当前密码输入有误！", "bottom left");
                    return;
                }
                if (newpsd.Length < 6)
                {
                    //base.ShowAlert("提示", "密码长度至少6位!");
                    //ShowTopMessage("提示:密码长度至少6位!", "40px", "100%");
                    AutoCloseMessage("txtnew", "密码长度至少6位！", "bottom left");
                    return;
                }
                if (!newpsd.Equals(newpsd2))
                {
                    //base.ShowAlert("提示", "新密码两次输入不一致!");
                    //ShowTopMessage("提示:新密码两次输入不一致!", "40px", "100%");
                    AutoCloseMessage("txtnew2", "新密码两次输入不一致！", "bottom left");
                    return;
                }

                //三次md5加密
                for (int i = 0; i < 3; i++)
                {
                    newpsd =FGA_NUtility.Encrypt.MD5EnCode(newpsd);
                }
                base.CurrentUser.PASSWORD = newpsd;

                bool res = FGA_BLL.UsersBLL.UpdateUsers(base.CurrentUser);
                if (res)
                {
                    //base.ShowAlert("提示", "密码修改成功，将于下次登录生效!");
                     //ShowTopMessage("提示:密码修改成功，将于下次登录生效!", "40px", "100%");
                    AutoCloseMessage("btnSub", "密码修改成功！", "bottom left");

                    
                }
                else
                {
                    
                }

                
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException(this.GetType().Name, ex);
                //ShowTopMessage("提示:密码修改失败!", "40px", "100%");
                AutoCloseMessage("btnSub", "密码修改成功！", "bottom left");

                //base.ShowAlert("提示", "密码修改失败!");
            }
        }
    }
}