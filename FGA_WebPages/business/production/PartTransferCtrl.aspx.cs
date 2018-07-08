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
    public partial class PartTransferCtrl : System.Web.UI.Page
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
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData()
        {
            string res = string.Empty;
            try
            {
                UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
                string sql = "SELECT [ORGANIZATION],[OPERATION],[TRANSACTIONTYPE],[FLOC] " +
                             " ,[TLOC],[TRANSFERTYPE],[CREATER],[CREATEDATE] FROM [FGA_PLATFORM].[dbo].[FGA_PARTTRANSFER_T] order by organization,operation";
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<PartTransferctrlModel> luw = new List<PartTransferctrlModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                        luw.Add(new PartTransferctrlModel(row));

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

            List<PartTransferctrlModel> listmodel = new List<PartTransferctrlModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<PartTransferctrlModel>>(data);


            foreach (PartTransferctrlModel pc in listmodel)
            {
                string sql = " insert into [FGA_PARTTRANSFER_T]([ORGANIZATION],[OPERATION],[TRANSACTIONTYPE],[FLOC],[TLOC],[TRANSFERTYPE],[CREATER],[CREATEDATE]) " +
                             " values('"+pc.ORGANIZATION+"','"+pc.OPERATION+"','"+pc.TRANSACTIONTYPE+"','"+pc.FLOC+"','"+pc.TLOC+"','"+pc.TRANSFERTYPE+"','"+pc.Creater+"','"+pc.CreateDate+"')";

                sqllist.Add(sql);

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