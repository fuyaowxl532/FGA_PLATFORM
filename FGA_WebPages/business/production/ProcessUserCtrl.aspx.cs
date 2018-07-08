using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_MODEL.index;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.business.production
{
    public partial class ProcessUserCtrl : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        ///获取当前用户
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getUser()
        {
            string res = string.Empty;

            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            res = model.USERNAME;

            return res;
        }

        /// <summary>
        /// 查询数据
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData()
        {
            string res = string.Empty;
            try
            {
                UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
                string sql = "SELECT [ORGANIZATION],[OPERATION],[CREATER],[CREATEDATE],[TRANSACTIONTYPE]" +
                             ",[UserName] FROM [FGA_PLATFORM].[dbo].[UserCtrl] where  UTYPE = '01'";
                sql = string.Format(sql, model.USERNAME);
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<userctrlModel> luw = new List<userctrlModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                        luw.Add(new userctrlModel(row));

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(luw);
                    res = res.Replace("\\/Date(", "").Replace(")\\/", "");
                }
            }
            catch (Exception e)
            {

            }
            return res;
        }

        /// <summary>
        /// 保存数据
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string saveData(string data)
        {
            //按用户查看EDI的数据
            string plexid = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).PLEXID;
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();

            List<userctrlModel> listmodel = new List<userctrlModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<userctrlModel>>(data);


            foreach (userctrlModel pc in listmodel)
            {
                string sql = "insert into [UserCtrl]([ORGANIZATION],[OPERATION],[USERNAME],[TRANSACTIONTYPE] ,[CREATER]" +
                             " ,[CREATEDATE],[UTYPE]) values('"+pc.ORGANIZATION+"','"+pc.OPERATION+"','"+pc.USERNAME+"','"+pc.TRANSACTIONTYPE+"' " +
                             ",'"+pc.Creater+"','"+pc.CreateDate+"','01')";

                //sqllist.Add(sql);

            }

            if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
            {
                return "1";
            }
            else
            {
                return "0";
            }
        }
    }

       
}