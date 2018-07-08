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
using System.Data;

namespace FGA_PLATFORM.business.ITAsset
{
    public partial class AssetCardDetailView : System.Web.UI.Page
    {
        public static string _assetKey = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            _assetKey = Request.QueryString["id"];
        }

        //Load Category
        [WebMethod]
        public static string LoadCategory()
        {
            string res = String.Empty;

            string sql = "SELECT distinct [Category] FROM [WMS_BarCode_V10].[dbo].[FGA_AssetCategory_T] order by Category";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<IT_AssetCategory> luw = new List<IT_AssetCategory>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    IT_AssetCategory ERM = new IT_AssetCategory(row);
                    luw.Add(ERM);
                }

                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(luw);
                res = res.Replace("\\/Date(", "").Replace(")\\/", "");
            }

            return res;
        }

        //Load AssetModel
        [WebMethod]
        public static string LoadAssetModel()
        {
            string res = String.Empty;

            string sql = "SELECT distinct [CateModel] FROM [WMS_BarCode_V10].[dbo].[FGA_AssetCategory_T] ";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<IT_AssetCategory> luw = new List<IT_AssetCategory>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    IT_AssetCategory ERM = new IT_AssetCategory(row);
                    luw.Add(ERM);
                }

                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(luw);
                res = res.Replace("\\/Date(", "").Replace(")\\/", "");
            }

            return res;
        }

        [WebMethod]
        public static string Search(String assetKey)
        {
            string res = String.Empty;

            string sql = "SELECT * FROM [WMS_BarCode_V10].[dbo].[FGA_AssetCard_T] where AssetKey = '" + assetKey + "'";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<IT_AssetInfoModel> luw = new List<IT_AssetInfoModel>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    IT_AssetInfoModel ERM = new IT_AssetInfoModel(row);
                    luw.Add(ERM);
                }

                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(luw);
                res = res.Replace("\\/Date(", "").Replace(")\\/", "");
            }

            return res;
        }

        /// <summary>
        /// 修改界面记录
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string UpdateAssetCard(String assetKey, String data)
        {
            string res = String.Empty;
            IT_AssetInfoModel AssetVO = new IT_AssetInfoModel();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            AssetVO = jssl.Deserialize<IT_AssetInfoModel>(data);

            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            List<String> sqllist = new List<String>();

            //生成日志表
            string sql1 = "insert into [FGA_AssetLog_T]([AssetKey],[AssetName],[Category],[Brand],[IT_AssetNO],[FIN_AssetNO],[SerialNO],[InsuranceDate]," +
                          " [MacAddress],[Note],[Status],[AssetUser],[Issue_Date],[Return_Date],[LastAction],[UpdateBy],[UpdateDate])" +
                          " select FAT.[AssetKey],FAT.[AssetName],FAT.[Category],FAT.[Brand],FAT.[IT_AssetNO],FAT.[FIN_AssetNO],FAT.[SerialNO],FAT.[InsuranceDate]," +
                          " FAT.[MacAddress],FAT.[Note],FIT.Status,FIT.PlexID,FIT.Issue_Date,FIT.Return_Date,'Asset Transfer','" + model.USERNAME + "',GETDATE() from[FGA_AssetCard_T] FAT left join FGA_ITAssetInfos_T FIT ON FAT.AssetKey = FIT.AssetKey" +
                          " WHERE FAT.AssetKey IN (" + assetKey + ")";


            string sql2 = " update [FGA_AssetCard_T] set [AssetName] = '" + AssetVO.AssetName + "',[Category]= '" + AssetVO.Category + "',[Brand] = '" + AssetVO.Brand + "', " +
                         " [IT_AssetNO] = '" + AssetVO.IT_AssetNO + "',[FIN_AssetNO] = '" + AssetVO.FIN_AssetNO + "',[SerialNO] = '" + AssetVO.SerialNO + "'," +
                         " [MacAddress] = '" + AssetVO.MacAddress + "' where [AssetKey] = '" + assetKey + "' ";

            sqllist.Add(sql1);
            sqllist.Add(sql2);

            if (FGA_DAL.Base.SQLServerHelper_FGA.ExecuteSqlTran(sqllist) > 0)
                res = "1";
            else
                res = "0";


            return res;
        }

        //Load AssetModel
        [WebMethod]
        public static string changeModelList(string category)
        {
            string res = String.Empty;

            string sql = "SELECT distinct [CateModel] FROM [WMS_BarCode_V10].[dbo].[FGA_AssetCategory_T] where Category = '" + category + "'";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<IT_AssetCategory> luw = new List<IT_AssetCategory>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    IT_AssetCategory ERM = new IT_AssetCategory(row);
                    luw.Add(ERM);
                }

                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(luw);
                res = res.Replace("\\/Date(", "").Replace(")\\/", "");
            }

            return res;
        }
    }
}