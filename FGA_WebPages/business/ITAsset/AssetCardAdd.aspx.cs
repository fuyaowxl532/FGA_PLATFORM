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
    public partial class AssetCardAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

        /// <summary>
        /// 修改界面记录
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string addAssetCard(String data)
        {
            string res = "0";
            IT_AssetInfoModel AssetVO = new IT_AssetInfoModel();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            AssetVO = jssl.Deserialize<IT_AssetInfoModel>(data);

            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            List<String> sqllist = new List<String>();

            //数据重复性检查
            string errorMsg = String.Empty;

            if (!String.IsNullOrEmpty(AssetVO.IT_AssetNO))
            {
                if (ValueRepeatCheck("IT_AssetNO", AssetVO.IT_AssetNO))
                    errorMsg = "IT_AssetNO is repeat" + '\n';
            }
            if (!String.IsNullOrEmpty(AssetVO.FIN_AssetNO))
            {
                if (ValueRepeatCheck("FIN_AssetNO", AssetVO.FIN_AssetNO))
                    errorMsg = "FIN_AssetNO is repeat" + '\n';
            }
            if (!String.IsNullOrEmpty(AssetVO.SerialNO))
            {
                if (ValueRepeatCheck("SerialNO", AssetVO.SerialNO))
                    errorMsg = "SerialNO is repeat" + '\n';
            }
            if (!String.IsNullOrEmpty(AssetVO.MacAddress))
            {
                if (ValueRepeatCheck("MacAddress", AssetVO.MacAddress))
                    errorMsg = "MAC ID is repeat" + '\n';
            }

            if (String.IsNullOrEmpty(errorMsg))
            {
                //生成日志表
                string sql1 = "select next value for FGA_AssetCardID";
                string akey = "ITA" + FGA_DAL.Base.SQLServerHelper_WMS.GetSingle(sql1).ToString();

                string sql2 = " INSERT INTO [FGA_AssetCard_T]([AssetKey],[AssetName],[Category],[Brand],[IT_AssetNO],[FIN_AssetNO],[SerialNO] " +
                              ",[CreateDate],[Creator],[InsuranceDate],[MacAddress],[Note],[Dr],[LastEditUser],[LastAction],[AssetConfig]) " +
                              "VALUES('" + akey + "','" + AssetVO.AssetName + "','" + AssetVO.Category + "','" + AssetVO.Brand + "','" + AssetVO.IT_AssetNO + "' " +
                              " ,'" + AssetVO.FIN_AssetNO + "','" + AssetVO.SerialNO + "',getdate(),'" + model.USERNAME + "','' " +
                              " ,'" + AssetVO.MacAddress + "','" + AssetVO.Note + "','0',null,'Asset Added','" + AssetVO.AssetConfig + "')";

                string sql3 = "insert into [FGA_ITAssetInfos_T]([Issue_Date],[Creator],[CreateDate],[PlexID],[Active],[Status],[AssetKey],[Note],[IsCheck]) " +
                              "values(convert(varchar(10),getdate(),120),'" + model.USERNAME + "',getdate(),'fy.it','0','Idle','" + akey + "','" + AssetVO.Note + "',0) ";

                sqllist.Add(sql2);
                sqllist.Add(sql3);

                if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
                    res = akey;
                else
                    res = "0";
            }
            else
                res = errorMsg;

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

        //Load AssetModel
        [WebMethod]
        public static string displayAssetInfos(string cateModel)
        {
            string res = String.Empty;

            string sql = "SELECT [Brand],[AssetConfig]  FROM [WMS_BarCode_V10].[dbo].[FGA_AssetCategory_T] where CateModel ='" + cateModel + "'";

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

        public static bool ValueRepeatCheck(string col, string value)
        {

            bool vc = false;

            string sql = "SELECT AssetKey FROM [WMS_BarCode_V10].[dbo].[FGA_AssetCard_T] where isnull(dr,'0') = 0 and " + col;

            sql = sql + "= '" + value + "' ";

            string data = FGA_DAL.Base.SQLServerHelper_WMS.GetSingle(sql) == null ? "" : FGA_DAL.Base.SQLServerHelper_WMS.GetSingle(sql).ToString();

            if (!String.IsNullOrEmpty(data))
                vc = true;

            return vc;
        }
    }
}

   