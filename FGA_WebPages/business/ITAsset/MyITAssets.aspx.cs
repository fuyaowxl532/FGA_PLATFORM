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
        protected void Page_Load(object sender, EventArgs e)
        {

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
    }
}