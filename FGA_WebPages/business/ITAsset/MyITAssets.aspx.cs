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
    public partial class MyITAssets : System.Web.UI.Page
    {
        protected string ReadPolicy = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string sql = "SELECT FPT.FirstName+' '+FPT.LastName UserName,FAP.[SignatureDate] " +
                         "FROM [FGA_AssetUsePolicy] FAP LEFT JOIN[FGA_PlexUser_T] FPT ON FAP.PLEXID = FPT.PLEXID where FAP.PLEXID = '"+ model.USERNAME+ "'";
            DataSet dst = new DataSet();
            dst = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (dst != null && dst.Tables.Count > 0 && dst.Tables[0].Rows.Count > 0)
                ReadPolicy = dst.Tables[0].Rows[0][0].ToString() + "&" + dst.Tables[0].Rows[0][1].ToString();
            else
                ReadPolicy = "No";
        }

        //获取当前用户名及部门
        [WebMethod]
        public static string getUserInfo() {
            string res = String.Empty;
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            String dept = "Non";

            String sql = "SELECT PlexID,Department FROM [WMS_BarCode_V10].[dbo].[FGA_PlexUser_T] where PlexID ='"+ model.USERNAME+ "'";
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                dept = ds.Tables[0].Rows[0][1] == null ? "Non" : ds.Tables[0].Rows[0][1].ToString();

            return "UName@"+ model.USERNAME +"Dept&"+dept;
        }

        //读取Use Policy并点击Agree
        [WebMethod]
        public static string agreePolicy()
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            String sql = "insert into [FGA_AssetUsePolicy]([PlexID],[SignatureDate])" +
                         "values('"+ model.USERNAME+ "', getdate()) ";

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql) > 0)
                return "1";
            else
                return "0";
        }

        //点击Agree获取签名
        [WebMethod]
        public static string getSign()
        {
            string signInfo = String.Empty;

            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string sql = "SELECT FPT.FirstName+' '+FPT.LastName UserName,FAP.[SignatureDate] " +
                         "FROM [FGA_AssetUsePolicy] FAP LEFT JOIN[FGA_PlexUser_T] FPT ON FAP.PLEXID = FPT.PLEXID where FAP.PLEXID = '" + model.USERNAME + "'";
            DataSet dst = new DataSet();
            dst = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (dst != null && dst.Tables.Count > 0 && dst.Tables[0].Rows.Count > 0)
                signInfo = dst.Tables[0].Rows[0][0].ToString() + "&" + dst.Tables[0].Rows[0][1].ToString();
            else
                signInfo = "No";

            return signInfo;
        }

        /// <summary>
        /// 界面查询
        /// add by it-wxl 06/14/2018
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData()
        {
            string res = string.Empty;
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            try
            {
                string sql = "SELECT ROW_NUMBER()OVER(ORDER BY BB.Last_Name,BB.First_Name DESC) Indexs,BB.*  " +
                             "FROM(SELECT FIA.*, FAT.IT_AssetNO, FAT.FIN_AssetNO, FAT.AssetName, FAT.Brand, FAT.Category, FAT.MacAddress, " +
                             "FPT.FirstName AS First_Name, FPT.LastName AS Last_Name, FPT.Department, FPT.Manager  " +
                             "FROM FGA_ITAssetInfos_T FIA LEFT JOIN FGA_AssetCard_T FAT ON FIA.AssetKey = FAT.AssetKey  " +
                             "LEFT JOIN FGA_PlexUser_T FPT ON FIA.PlexID = FPT.PlexID) BB where 1 = 1 and isnull(BB.active,'0') = '0' and BB.PlexID = '" + model.USERNAME + "'";

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
            }
            catch (Exception e)
            {

            }
            return res;
        }

        //确认资产
        [WebMethod]
        public static string checkassetInfo(String assetKey)
        {
            String sql = "update [FGA_ITAssetInfos_T] set IsCheck = 1,CheckDate = getdate() where AssetKey = '"+ assetKey + "'  ";
            int count  = FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql);


            return count.ToString();
        }
    }
}