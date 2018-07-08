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
    public partial class AssetEditHistory : System.Web.UI.Page
    {
        public static string _assetKey = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            _assetKey = Request.QueryString["id"];
        }

        [WebMethod]
        public static string Search(String assetKey)
        {
            string res = String.Empty;

            string sql = "select * from (SELECT * FROM[WMS_BarCode_V10].[dbo].[FGA_AssetLog_T] where AssetKey = '" + assetKey + "' " +
                         "union all " +
                         "select 10000 Tid,FAT.[AssetKey],FAT.[AssetName],FAT.[Category],FAT.[Brand],FAT.[IT_AssetNO],FAT.[FIN_AssetNO], " +
                         "FAT.[SerialNO],FAT.[InsuranceDate], FAT.[MacAddress],FAT.[Note],FIT.Status,FIT.PlexID,FIT.Issue_Date, " +
                         "FIT.Return_Date,FAT.LastAction,isnull(FAT.LastEditUser,FAT.Creator),GETDATE() from[FGA_AssetCard_T] FAT left join " +
                         "FGA_ITAssetInfos_T FIT ON FAT.AssetKey = FIT.AssetKey WHERE FAT.AssetKey = '" + assetKey + "' " +
                         ") AA order by AA.Tid";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<IT_AssetLogModel> luw = new List<IT_AssetLogModel>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    IT_AssetLogModel ERM = new IT_AssetLogModel(row);
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