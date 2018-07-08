using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_BLL.UI;
using System.Collections;
using FGA_MODEL.Args;
using FGA_MODEL;
using FGA_NUtility.Consts;
using FGA_NUtility.Enums;
using System.Text;
using FGA_NUtility;
using System.Web.Services;
using System.Web.Script.Serialization;
using FGA_MODEL.index;

namespace FGA_PLATFORM.system
{
    public partial class roles : PageBase
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize") == string.Empty ? "10" : ConfigHelper.GetConfigValue("PageSize");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ////记录状态
                //base.ListControlItemFill(typeof(CommonState), this.ddpStatus, true);
                ////页面的初始打开时，状态为正常
                //this.ddpStatus.SelectedValue = Convert.ToString((int)CommonState.正常);
            }
        }

        /// <summary>
        /// 信息检索
        /// </summary>
        [WebMethod]
        public static string DoUsersSearch(string name, string status, string CurrentPageIndex, string PageSize)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return "";
            string json = string.Empty;
            try
            {
                Hashtable where = new Hashtable();
                if (!string.IsNullOrEmpty(name))
                    where.Add(RolesArgs.rname, name);
                if (!string.IsNullOrEmpty(status))
                    where.Add(RolesArgs.state, Convert.ToInt32(status));
                SearchArgs args = new SearchArgs();
                args.CurrentIndex = int.Parse(CurrentPageIndex);
                args.PageSize = int.Parse(PageSize);
                var list = FGA_BLL.RolesBLL.GetRolesListByPage(where,args);

                DataReWrite dataroles = new DataReWrite();
                List<RoleReWrite> roleRelist = new List<RoleReWrite>();
                if (list != null && list.Count > 0)
                {
                    dataroles.totalRecord = args.TotalRecords;
                    foreach (RolesModel rm in list)
                    {
                        RoleReWrite ur = new RoleReWrite();
                        ur.rid = rm.rid;
                        ur.rgroup = rm.rgroup;
                        ur.rname = rm.rname;
                        ur.state = FGA_NUtility.Convertor.GetEnumName(typeof(FGA_NUtility.Enums.CommonState), rm.state);
                        roleRelist.Add(ur);
                    }
                    dataroles.rolelist = roleRelist;
                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    json = jssl.Serialize(dataroles);
                }

            }
            catch (Exception ex)
            {
                //Utility.SysLog.WriteException(GetType().Name, ex);
            }
            return json;
        }

    }
}