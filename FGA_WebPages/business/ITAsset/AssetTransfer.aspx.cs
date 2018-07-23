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
    public partial class AssetTransfer : System.Web.UI.Page
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize_1") == string.Empty ? "100" : ConfigHelper.GetConfigValue("PageSize_1");
        public static string _assetKey = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            _assetKey = Request.QueryString["id"];
        }

        /// <summary>
        /// 界面查询
        /// add by it-wxl 05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string CurrentPageIndex, string PageSize, string filter)
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
                string sql = "select  [FirstName],[LastName],[PlexID],[Department] from " +
                    "(SELECT ROW_NUMBER()OVER(ORDER BY FCI.FirstName) Indexs,FCI.* FROM [FGA_PlexUser_T] FCI  WHERE 1=1";

                //查询条件
                if (!String.IsNullOrEmpty(filter))
                    sql = sql + " and FCI.FirstName like '%" + filter + "%'";


                sql = sql + ") AA where AA.indexs between " + begin + " and " + end + " ";

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
                    res = res.Replace("\\/Date(", "").Replace(")\\/", "");
                }
            }
            catch (Exception e)
            {

            }
            return res;
        }

        /// <summary>
        /// 资产转移
        /// add by it-wxl 20180523
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string DoTransfer(string assetKeys, string plexid)
        {
            string res = string.Empty;
            string akeys = "\'0\'";

            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            List<String> sqllist = new List<String>();
            List<IT_AssetInfoModel> listmodel = new List<IT_AssetInfoModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<IT_AssetInfoModel>>(assetKeys);
            foreach (IT_AssetInfoModel vo in listmodel)
            {
                akeys = akeys + "," + "\'" + vo.AssetKey + "\'";
            }

            try
            {
                //生成日志表
                string sql1 = "insert into [FGA_AssetLog_T]([AssetKey],[AssetName],[Category],[Brand],[IT_AssetNO],[FIN_AssetNO],[SerialNO],[InsuranceDate]," +
                              " [MacAddress],[Note],[Status],[AssetUser],[Issue_Date],[Return_Date],[LastAction],[UpdateBy],[UpdateDate])" +
                              " select FAT.[AssetKey],FAT.[AssetName],FAT.[Category],FAT.[Brand],FAT.[IT_AssetNO],FAT.[FIN_AssetNO],FAT.[SerialNO],FAT.[InsuranceDate]," +
                              " FAT.[MacAddress],FAT.[Note],FIT.Status,FIT.PlexID,FIT.Issue_Date,FIT.Return_Date,FAT.LastAction,'" + model.USERNAME + "',GETDATE() from [FGA_AssetCard_T] FAT left join FGA_ITAssetInfos_T FIT ON FAT.AssetKey = FIT.AssetKey" +
                              " WHERE FAT.AssetKey IN (" + akeys + ")";

                string sql2 = "update [FGA_ITAssetInfos_T] set [Issue_Date] = convert(varchar(10),getdate(),120),[PlexID] = '" + plexid + "',Return_Date =null ,,IsCheck = 0,CheckDate = null,Status = 'InUse' ,UpdateDate =GETDATE() ," +
                              "UpdateBy ='" + model.USERNAME + "'  where AssetKey in (" + akeys + ") ";

                string sql3 = "update [WMS_BarCode_V10].[dbo].[FGA_AssetCard_T] set LastAction = 'Asset Transfer' where [AssetKey] in (" + akeys + ")";

                sqllist.Add(sql1);
                sqllist.Add(sql2);
                sqllist.Add(sql3);

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