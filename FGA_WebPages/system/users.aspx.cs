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
using FGA_MODEL.index;
using System.Web.Script.Serialization;

namespace FGA_PLATFORM.system
{
    public partial class users : PageBase
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
        /// 用户信息检索
        /// </summary>
        [WebMethod]
        public static string DoUsersSearch(string strLoginId, string strName, string status, string CurrentPageIndex, string PageSize)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return "";
            string json=string.Empty;
            try
            {
                Hashtable where = new Hashtable();
                if (!string.IsNullOrEmpty(strLoginId))
                    where.Add(UsersArgs.USERNAME, strLoginId);
                if (!string.IsNullOrEmpty(status))
                    where.Add(UsersArgs.STATUS, Convert.ToInt32(status));
                where.Add(UsersArgs.OrderBy, "createdate desc");
                SearchArgs args = new SearchArgs();
                args.CurrentIndex = int.Parse(CurrentPageIndex);
                args.PageSize = int.Parse(PageSize);
                var list = FGA_BLL.UsersBLL.GetUsersListByPage(where, args);
                DataReWrite datausers = new DataReWrite();
                List<UserReWrite> userRelist = new List<UserReWrite>();
                if (list != null && list.Count > 0)
                {
                    
                    datausers.totalRecord = args.TotalRecords;
                    foreach (UsersModel um in list)
                    {
                        UserReWrite ur = new UserReWrite();
                        ur.USERID = um.USERID;
                        ur.USERNAME = um.USERNAME;
                        ur.rolename = ConvertToRoleName(um.USERID);
                        ur.CREATEDATE = FGA_NUtility.Convertor.ToDateString(um.CREATEDATE, false);
                        ur.STATUS = FGA_NUtility.Convertor.GetEnumName(typeof(FGA_NUtility.Enums.CommonState), um.STATUS);
                        userRelist.Add(ur);
                    }
                    datausers.userlist = userRelist;
                    JavaScriptSerializer jssl= new JavaScriptSerializer();
                    json = jssl.Serialize(datausers);
                }
            }
            catch (Exception ex)
            {
                //Utility.SysLog.WriteException(GetType().Name, ex);
            }
            return json;
        }


        public static string ConvertToRoleName(object e)
        {
            string uid = "";
            try
            {
                uid = e.ToString().Trim();
                UserrolesModel tmp = new UserrolesModel();
                string rid = FGA_BLL.UserrolesBLL.GetUserRolesModelInfo(uid).rid.ToString();
                RolesModel tmp2 = new RolesModel();
                tmp2.rid = Convert.ToInt32(rid);
                tmp2 = FGA_BLL.RolesBLL.GetRolesInfo(tmp2);
                string name = string.Empty;
                name = tmp2.rname;
                if (tmp2.state != 1)
                {
                    name += "<span style='color:red'>(已" + Enum.GetName(typeof(CommonState), tmp2.state) + ")</span>";
                }
                return name;
            }
            catch
            {
                return "未知";
            }
        }

    }
}