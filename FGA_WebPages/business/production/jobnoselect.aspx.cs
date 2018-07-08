using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.business.production
{
    public partial class jobnoselect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// 派工将分配的车号和对应jobno以及本厂编号录入
        /// </summary>
        /// <param name="cars">1,2,3</param>
        /// <param name="jobnoandcodeitem">jobno,itemcode</param>
        /// <returns></returns>
        [WebMethod]
        public static string SaveData(string cars, string jobnoandcodeitem, string workcenter)
        {
            string res = string.Empty;
            try
            {
                UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
                string[] cararry = cars.Split(',');
                string jobno = jobnoandcodeitem.Split(',')[0];
                string itemcode = jobnoandcodeitem.Split(',')[1];
                List<string> sqllist = new List<string>();
                string sql=string.Empty;
                foreach (var item in cararry)
                {
                    sql = "delete  from argbendingplan where WorkCenter='{0}' and CarNO='{1}'";
                    sql = string.Format(sql, workcenter,item);//重新分配已经分配过的认为重新分配，此细节问题后期确定后再修改
                    sqllist.Add(sql);
                    sql = "insert into argbendingplan (WorkCenter,CarNO,JobNO,ItemCode,CreateUser,CreateDate) values ('{0}','{1}','{2}','{3}','{4}',('{5}'))";
                    sql = string.Format(sql,workcenter,item,jobno,itemcode,model.USERNAME,DateTime.Now);
                    sqllist.Add(sql);
                }
                if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
                {
                    res = "success";
                }
                else 
                {
                    res = "fail";
                }

            }
            catch
            { }
            return res;
        }
    }
}