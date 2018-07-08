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

namespace FGA_PLATFORM.business.ITAsset
{
    public partial class ITAssetDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        /// <summary>
        /// 绑定资产类别
        /// add by it-wxl 10/18/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getAssetCategory()
        {
            string res = string.Empty;
            try
            {
                string sql = "SELECT [Value] FROM [FGA_PLATFORM].[dbo].[FGA_ITAsset_Droplist_T] where valuetype = 'Category' and isnull(dr,0) = 0 order by value";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<ITAssetDroplist> luw = new List<ITAssetDroplist>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ITAssetDroplist ERM = new ITAssetDroplist(row);
                        luw.Add(ERM);
                    }

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(luw);
                }
            }
            catch (Exception e)
            {

            }
            return res;
        }

        /// <summary>
        /// 绑定资产名称
        /// add by it-wxl 10/18/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getAssetName(string category)
        {
            string res = string.Empty;
            try
            {
                string sql = "SELECT [Equipment] as value FROM [FGA_PLATFORM].[dbo].[FGA_EquipmentInfo_T] where category = '"+ category + "' and isnull(dr,0) = 0 order by [Equipment]";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<ITAssetDroplist> luw = new List<ITAssetDroplist>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ITAssetDroplist ERM = new ITAssetDroplist(row);
                        luw.Add(ERM);
                    }

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(luw);
                }
            }
            catch (Exception e)
            {

            }
            return res;
        }
    }
}