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
    public partial class EDI_LoadDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        ///查询release数据
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData()
        {
            //按用户查看EDI的数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string ET = "";
            string sql = "";

            if (model.USERNAME == "Honda_front")
                ET = "Front";
            if (model.USERNAME == "Honda_rear")
                ET = "Rear";
            if (model.USERNAME == "Honda_side")
                ET = "Side";



            string res = string.Empty;
            try
            {
                if (model.USERNAME != "administrator")
                {
                    sql = "select FLT.[Quantity],FLT.[Creator],FLT.[Createdate],FLT.[LoadStatus],FLT.[LoadID] " +
                             ",FLT.[CustomerAddress],FLT.[ShipDate],SM.[SerialNO] from FGA_EDI_LOAD_T  FLT LEFT JOIN " +
                             "(SELECT BB.* FROM (SELECT AA.lOADID, AA.SerialNO, AA.CNT, ROW_NUMBER() over(PARTITION by AA.Loadid order by AA.CNT) RANKA " +
                             "FROM (SELECT[LoadID],[SerialNO], COUNT(*) CNT  FROM[FGA_SmallLot_T] WHERE LOCKFLAG = 'N' GROUP BY[LoadID],[SerialNO]) AA) BB WHERE bb.RANKA = 1) SM" +
                             " ON FLT.LOADID = SM.LOADID WHERE FLT.PartType = '"+ET+"' order by FLT.LoadID desc";
                }

                if (model.USERNAME == "administrator" || model.USERNAME == "Shipping")
                {
                    sql = "select  FLT.[Quantity],FLT.[Creator],FLT.[Createdate],FLT.[LoadStatus],FLT.[LoadID] " +
                             ",FLT.[CustomerAddress],FLT.[ShipDate],SM.[SerialNO] from FGA_EDI_LOAD_T   FLT LEFT JOIN " +
                             "(SELECT BB.* FROM (SELECT AA.lOADID, AA.SerialNO, AA.CNT, ROW_NUMBER() over(PARTITION by AA.Loadid order by AA.CNT) RANKA " +
                             "FROM (SELECT[LoadID],[SerialNO], COUNT(*) CNT  FROM[FGA_SmallLot_T] WHERE LOCKFLAG = 'N' GROUP BY[LoadID],[SerialNO]) AA) BB WHERE bb.RANKA = 1) SM" +
                             " ON FLT.LOADID = SM.LOADID WHERE 1=1  order by FLT.LoadID desc";
                }

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<EDILoadModel> luw = new List<EDILoadModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        EDILoadModel ERM = new EDILoadModel(row);
                        luw.Add(ERM);
                    }

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
        /// 查询release详情
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchDetail(string data)
        {
            string res = string.Empty;
            try
            {
                string sql = "SELECT [customer_name],[Customer_Address_Code],[Customer_Part_No],[Customer_Part_Revision],[part_no] " +
                             " ,[part_name],[Ship_Date],[Lot_No],[BATCH_NO],[Standard_Quantity],[Quantity],[JOB_SEQUENCE] FROM " +
                             "[FGA_PLATFORM].[dbo].[FGA_LoadDetail_T] where loadid = '"+data+"'";
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<EDIReleaseModel> luw = new List<EDIReleaseModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        EDIReleaseModel ERM = new EDIReleaseModel(row);
                        luw.Add(ERM);
                    }

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
        /// 查询release详情
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string reWork(string data)
        {
            int count = 0;
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            List<string> sqllist = new List<string>();

            List<EDILoadModel> listmodel = new List<EDILoadModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<EDILoadModel>>(data);

            //rework后,开启release数据权限。将[FGA_EDI_LOAD_T]表状态设置为"Cancelled"状态
            foreach(EDILoadModel vo in listmodel)
            {
                string sql1 = " update FGA_EDI_LOAD_T set Slstatus = '1',LoadStatus = 'Cancelled',updateby = '" + model + "', " +
                              " updatedate = getdate() where LoadID = '"+vo.LoadID+"'";
                sqllist.Add(sql1);

                string sql2 = "update [FGA_EDI_862_T] set rstatus = '0' where EDI_RowID IN (SELECT EDI_RowID FROM FGA_LoadPart_T WHERE LoadID ='"+ vo.LoadID + "')";
                sqllist.Add(sql2);

                count = FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist);
            }

            return count.ToString();
        }
    }
}