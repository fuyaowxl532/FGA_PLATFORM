using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_BLL.UI;
using FGA_NUtility;
using FGA_BLL;
using FGA_NUtility.Consts;
using FGA_NUtility.Enums;
namespace FGA_PLATFORM.system
{
    public partial class ARGBoxLabelItem : PageBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        /// <summary>
        /// 保存员工信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OnBtnSaveClick(object sender, EventArgs e)
        {
            if (Session[SysConst.S_LOGIN_USER] == null)
                return;
        }

        //判断用户名是否重复
        private bool CheckLoginIdExist(string strLoginId)
        {
                return true;
        }

        protected void OnPasswordReset(object sender, EventArgs e)
        {
           
        }
    }
}