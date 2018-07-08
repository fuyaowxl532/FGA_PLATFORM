using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_BLL.UI;
using FGA_MODEL;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.system
{
    public partial class maintenance : PageBase
    {
        //加载
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// 刷新缓存
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            try
            {
                if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                    return;
                //角色
                FGA_BLL.Cache.RolesCache.InitCache();
                //权限
                FGA_BLL.Cache.PowersCache.InitCache();
                //用户
                FGA_BLL.Cache.UsersCache.InitCache();
                //角色权限对应
                FGA_BLL.Cache.RolepowersCache.InitCache();
                //用户角色对应
                FGA_BLL.Cache.UserrolesCache.InitCache();
                //ShowBottomMessage("缓存刷新成功！");
               // ShowTopMessage("缓存刷新成功！","40px","100%");
                AutoCloseMessage("btnRefresh", "缓存刷新成功！", "right");

            }
            catch (Exception ex)
            {
               // ShowTopMessage("缓存刷新成功！", "40px", "100%");
                AutoCloseMessage("btnRefresh", "缓存刷新失败！", "right");

                //ShowBottomMessage("敏感信息保存失败！");
                FGA_NUtility.SysLog.WriteError(this.GetType().Name, ex);
            }
        }
    }
}