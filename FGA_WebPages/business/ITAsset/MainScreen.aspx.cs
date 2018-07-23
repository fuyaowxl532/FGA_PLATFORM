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
using FGA_NUtility;
using FGA_NUtility.Consts;
using FGA_MODEL.Args;

namespace FGA_PLATFORM.business.ITAsset
{
    public partial class MainScreen : System.Web.UI.Page
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize_2") == string.Empty ? "500" : ConfigHelper.GetConfigValue("PageSize_2");

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 界面查询
        /// add by it-wxl 05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string sn, string fn, string ln, string department, string itno, string finno, string status, string fd, string td,
            string ITInv, string CurrentPageIndex, string PageSize)
        {
            //分页查询
            SearchArgs args = new SearchArgs();
            args.CurrentIndex = int.Parse(CurrentPageIndex);
            args.PageSize = int.Parse(PageSize);
            int begin = args.StartIndex + 1;
            int end = args.StartIndex + args.PageSize;

            string res = string.Empty;
            try
            {
                //获取记录总数
                string sql_total = "select count(*) Indexs from [FGA_ITAssetInfos_T] where 1=1 and isnull(active,'0') ='0' ";
                //查询条件
                if ("0".Equals(ITInv))
                    sql_total = sql_total + " and [PlexID] <> 'FY.IFGA'";

                DataSet dst = new DataSet();
                dst = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql_total);

                if (dst != null && dst.Tables.Count > 0 && dst.Tables[0].Rows.Count > 0)
                    args.TotalRecords = Convert.ToInt32(dst.Tables[0].Rows[0][0]);
                else
                    return res;

                string sql = "SELECT * FROM " +
                             "(SELECT ROW_NUMBER()OVER(ORDER BY BB.Last_Name,BB.First_Name DESC) Indexs,BB.* " +
                             "FROM (SELECT FIA.*, FAT.IT_AssetNO, FAT.SerialNO,FAT.FIN_AssetNO, FAT.AssetName,FAT.Brand,FAT.Category," +
                             "FAT.MacAddress, FPT.FirstName AS First_Name, FPT.LastName AS Last_Name, FPT.Department,FPT.Manager " +
                             "FROM FGA_ITAssetInfos_T FIA LEFT JOIN FGA_AssetCard_T FAT ON FIA.AssetKey = FAT.AssetKey " +
                             "LEFT JOIN FGA_PlexUser_T FPT ON FIA.PlexID = FPT.PlexID) BB where 1=1 and isnull(BB.active,'0') ='0'";

                //查询条件
                if ("0".Equals(ITInv))
                    sql = sql + " and BB.PlexID <> 'FY.IFGA'";

                if (!String.IsNullOrEmpty(fn))
                    sql = sql + " and upper(BB.First_Name) like '%" + fn.ToUpper() + "%'";
                if (!String.IsNullOrEmpty(ln))
                    sql = sql + " and upper(BB.Last_Name) like '%" + ln.ToUpper() + "%'";
                if (!"All".Equals(department) && !"null".Equals(department))
                    sql = sql + " and BB.Department = '" + department + "'";
                if (!"All".Equals(status) && !"null".Equals(status))
                    sql = sql + " and BB.Status = '" + status + "'";
                if (!String.IsNullOrEmpty(sn))
                    sql = sql + " and BB.SerialNO like '%" + sn + "%'";
                if (!String.IsNullOrEmpty(itno))
                    sql = sql + " and BB.IT_AssetNO like '%" + itno + "%'";
                if (!String.IsNullOrEmpty(finno))
                    sql = sql + " and BB.FIN_AssetNO like '%" + finno + "%'";
                if (!String.IsNullOrEmpty(fd))
                    sql = sql + " and BB.Issue_Date >= '" + fd + "'";
                if (!String.IsNullOrEmpty(td))
                    sql = sql + " and BB.Issue_Date <= '" + td + "'";

                sql = sql + ") AA where AA.indexs between " + begin + " and " + end + " ";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<IT_AssetInfoModel> luw = new List<IT_AssetInfoModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        IT_AssetInfoModel ERM = new IT_AssetInfoModel(row);
                        ERM.RecordCnt = args.TotalRecords;
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
        /// 获取部门List
        /// add by it-wxl 20180611
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getDepartment()
        {
            string res = string.Empty;
            string sql = "SELECT distinct [Department_Code] as Department FROM FGA_PlexDepartment_T order by [Department_Code]";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<PlexUserModel> luw = new List<PlexUserModel>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    PlexUserModel ERM = new PlexUserModel(row);
                    luw.Add(ERM);
                }

                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(luw);
            }

            return res;
        }

        /// <summary>
        /// 业务操作类
        /// add by it-wxl 20180313
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string doAction(string assetkeys, string ptype)
        {
            string res = string.Empty;
            string akeys = "\'0\'";
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            List<String> sqllist = new List<String>();

            List<IT_AssetInfoModel> listmodel = new List<IT_AssetInfoModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<IT_AssetInfoModel>>(assetkeys);
            foreach (IT_AssetInfoModel vo in listmodel)
            {
                akeys = akeys + "," + "\'" + vo.AssetKey + "\'";
            }

            try
            {
                //Return
                //IT-WXL 20180403
                if (ptype.Equals("Return"))
                {
                    //生成日志表
                    string sql1 = "insert into [FGA_AssetLog_T]([AssetKey],[AssetName],[Category],[Brand],[IT_AssetNO],[FIN_AssetNO],[SerialNO],[InsuranceDate]," +
                                  " [MacAddress],[Note],[Status],[AssetUser],[Issue_Date],[Return_Date],[LastAction],[UpdateBy],[UpdateDate])" +
                                  " select FAT.[AssetKey],FAT.[AssetName],FAT.[Category],FAT.[Brand],FAT.[IT_AssetNO],FAT.[FIN_AssetNO],FAT.[SerialNO],FAT.[InsuranceDate]," +
                                  " FAT.[MacAddress],FAT.[Note],FIT.Status,FIT.PlexID,FIT.Issue_Date,FIT.Return_Date,FAT.LastAction,'" + model.USERNAME + "',GETDATE() from [FGA_AssetCard_T] FAT left join FGA_ITAssetInfos_T FIT ON FAT.AssetKey = FIT.AssetKey" +
                                  " WHERE FAT.AssetKey IN (" + akeys + ")";

                    string sql2 = "update [FGA_ITAssetInfos_T] set PlexID = 'FY.IT',IsCheck = 0,CheckDate = null,Return_Date =GETDATE() ,Status = 'Idle' ,UpdateDate =GETDATE() ,UpdateBy ='" + model.USERNAME + "' " +
                                  "where AssetKey in (" + akeys + ")";

                    string sql3 = "update [WMS_BarCode_V10].[dbo].[FGA_AssetCard_T] set LastAction = 'Asset Return' where [AssetKey] in (" + akeys + ")";

                    sqllist.Add(sql1);
                    sqllist.Add(sql2);
                    sqllist.Add(sql3);
                }

                //Damage
                //IT-WXL 20180403
                if (ptype.Equals("Damage"))
                {
                    string sql1 = "insert into [FGA_AssetLog_T]([AssetKey],[AssetName],[Category],[Brand],[IT_AssetNO],[FIN_AssetNO],[SerialNO],[InsuranceDate]," +
                                  " [MacAddress],[Note],[Status],[AssetUser],[Issue_Date],[Return_Date],[LastAction],[UpdateBy],[UpdateDate])" +
                                  " select FAT.[AssetKey],FAT.[AssetName],FAT.[Category],FAT.[Brand],FAT.[IT_AssetNO],FAT.[FIN_AssetNO],FAT.[SerialNO],FAT.[InsuranceDate]," +
                                  " FAT.[MacAddress],FAT.[Note],FIT.Status,FIT.PlexID,FIT.Issue_Date,FIT.Return_Date,FAT.LastAction,'" + model.USERNAME + "',GETDATE() from[FGA_AssetCard_T] FAT left join FGA_ITAssetInfos_T FIT ON FAT.AssetKey = FIT.AssetKey" +
                                  " WHERE FAT.AssetKey IN (" + akeys + ")";

                    string sql2 = "update [FGA_ITAssetInfos_T] set Status = 'Damage',UpdateDate =GETDATE() ,UpdateBy ='" + model.USERNAME + "' " +
                                  "where AssetKey in (" + akeys + ") ";

                    string sql3 = "update [WMS_BarCode_V10].[dbo].[FGA_AssetCard_T] set LastAction = 'Update asset status(Damage)' where [AssetKey] in (" + akeys + ")";

                    sqllist.Add(sql1);
                    sqllist.Add(sql2);
                    sqllist.Add(sql3);
                }

                //Scrapped
                //IT-WXL 20180403
                if (ptype.Equals("Scrapped"))
                {
                    string sql1 = "insert into [FGA_AssetLog_T]([AssetKey],[AssetName],[Category],[Brand],[IT_AssetNO],[FIN_AssetNO],[SerialNO],[InsuranceDate]," +
                                 " [MacAddress],[Note],[Status],[AssetUser],[Issue_Date],[Return_Date],[LastAction],[UpdateBy],[UpdateDate])" +
                                 " select FAT.[AssetKey],FAT.[AssetName],FAT.[Category],FAT.[Brand],FAT.[IT_AssetNO],FAT.[FIN_AssetNO],FAT.[SerialNO],FAT.[InsuranceDate]," +
                                 " FAT.[MacAddress],FAT.[Note],FIT.Status,FIT.PlexID,FIT.Issue_Date,FIT.Return_Date,FAT.LastAction,'" + model.USERNAME + "',GETDATE() from[FGA_AssetCard_T] FAT left join FGA_ITAssetInfos_T FIT ON FAT.AssetKey = FIT.AssetKey" +
                                 " WHERE FAT.AssetKey IN (" + akeys + ")";

                    string sql2 = "update [FGA_ITAssetInfos_T] set Status = 'Scrapped' ,UpdateDate =GETDATE() ,UpdateBy ='" + model.USERNAME + "' " +
                                  "where AssetKey in (" + akeys + ") ";

                    string sql3 = "update [WMS_BarCode_V10].[dbo].[FGA_AssetCard_T] set LastAction = 'Update asset status(Scrapped)' where [AssetKey] in (" + akeys + ")";

                    sqllist.Add(sql1);
                    sqllist.Add(sql2);
                    sqllist.Add(sql3);
                }

                //Missing
                //IT-WXL 20180403
                if (ptype.Equals("Missing"))
                {
                    string sql1 = "insert into [FGA_AssetLog_T]([AssetKey],[AssetName],[Category],[Brand],[IT_AssetNO],[FIN_AssetNO],[SerialNO],[InsuranceDate]," +
                                 " [MacAddress],[Note],[Status],[AssetUser],[Issue_Date],[Return_Date],[LastAction],[UpdateBy],[UpdateDate])" +
                                 " select FAT.[AssetKey],FAT.[AssetName],FAT.[Category],FAT.[Brand],FAT.[IT_AssetNO],FAT.[FIN_AssetNO],FAT.[SerialNO],FAT.[InsuranceDate]," +
                                 " FAT.[MacAddress],FAT.[Note],FIT.Status,FIT.PlexID,FIT.Issue_Date,FIT.Return_Date,FAT.LastAction,'" + model.USERNAME + "',GETDATE() from[FGA_AssetCard_T] FAT left join FGA_ITAssetInfos_T FIT ON FAT.AssetKey = FIT.AssetKey" +
                                 " WHERE FAT.AssetKey IN (" + akeys + ")";

                    string sql2 = "update [FGA_ITAssetInfos_T] set Status = 'Missing' ,UpdateDate =GETDATE() ,UpdateBy ='" + model.USERNAME + "' " +
                                  "where AssetKey in (" + akeys + ") ";


                    string sql3 = "update [WMS_BarCode_V10].[dbo].[FGA_AssetCard_T] set LastAction = 'Update asset status(Missing)' where [AssetKey] in (" + akeys + ")";

                    sqllist.Add(sql1);
                    sqllist.Add(sql2);
                    sqllist.Add(sql3);
                }

                if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
                    res = "1";
                else
                    res = "0";

            }
            catch (Exception e)
            {
                res = "0";
            }
            return res;
        }

    }
}