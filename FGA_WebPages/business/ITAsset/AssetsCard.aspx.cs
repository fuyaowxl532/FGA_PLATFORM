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

    public partial class AssetsCard : System.Web.UI.Page
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
        public static string SearchData(string itsn, string finsn, string assetkey, string sn, string status, string CurrentPageIndex, string PageSize)
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
                string sql_total = "select count(*) Indexs from [FGA_AssetCard_T] where isnull(Dr,'0') = '0' ";
                DataSet dst = new DataSet();
                dst = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql_total);

                if (dst != null && dst.Tables.Count > 0 && dst.Tables[0].Rows.Count > 0)
                {
                    args.TotalRecords = Convert.ToInt32(dst.Tables[0].Rows[0][0]);
                }
                else
                {
                    return res;
                }

                string sql = "select * from " +
                    "(SELECT ROW_NUMBER()OVER(ORDER BY FCI.AssetKey DESC) Indexs,FCI.*,FIT.Status FROM [WMS_BarCode_V10].[dbo].[FGA_AssetCard_T] FCI " +
                    "left join FGA_ITAssetInfos_T FIT ON FCI.AssetKey = FIT.AssetKey WHERE 1=1 ";

                if (!String.IsNullOrEmpty(itsn))
                    sql = sql + " and FCI.[IT_AssetNO] like '%" + itsn + "%'";
                if (!String.IsNullOrEmpty(finsn))
                    sql = sql + " and FCI.[FIN_AssetNO] like '%" + finsn + "%'";
                if (!String.IsNullOrEmpty(assetkey))
                    sql = sql + " and FCI.[AssetKey] like '%" + assetkey + "%'";
                if (!String.IsNullOrEmpty(sn))
                    sql = sql + " and FCI.[SerialNO] like '%" + sn + "%'";

                sql = sql + ") AA where AA.indexs between " + begin + " and " + end + " ";

                if (!String.IsNullOrEmpty(status))
                {
                    if (!"All".Equals(status))
                        sql = sql + " and AA.status = '" + status + "'";
                }

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
    }
}