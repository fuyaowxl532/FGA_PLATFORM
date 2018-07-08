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

namespace FGA_PLATFORM.business.production
{
    public partial class ProductBoxLabel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// 界面查询
        /// add by it-wxl 05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string itemcode)
        {


            string res = string.Empty;
            try
            {
                string sql = "SELECT DISTINCT [ItemID],[InvoiceNO],[PlanNO],[ItemCode] " +
                             " ,[LabelNO],[BoxType],[SOQuantity],[InboundQuantity] " +
                             " ,[CreateUser],[CreateDate] FROM [WMS_BarCode_V10].[dbo].[ShipmentDetail] where 1=1";

                //查询条件

                if (!String.IsNullOrEmpty(itemcode))
                    sql = sql + " and [ItemCode] like  '" + itemcode + "'";

                sql = sql + " order by createdate";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<ProductLabelModel> luw = new List<ProductLabelModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ProductLabelModel ERM = new ProductLabelModel(row);
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
        /// 返回条码号
        /// add by it-wxl 05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getBarcodeNO()
        {
            string res = string.Empty;
            try
            {
                string sql1 = "select next value for arg_partid_seq";
                string sql2 = "select next value for arg_partid_seq";

                DataSet ds_seq1 = new DataSet();
                ds_seq1 = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql1);

                DataSet ds_seq2 = new DataSet();
                ds_seq2 = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql2);

                if (ds_seq1 != null && ds_seq2 != null)
                {
                    res = ds_seq1.Tables[0].Rows[0][0].ToString() + "&" + ds_seq2.Tables[0].Rows[0][0].ToString();
                }
               
            }
            catch (Exception e)
            {

            }
            return res;
        }

        /// <summary>
        /// 将打印的条码信息存入数据库
        /// add by it-wxl 05/09/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SaveData(string data)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            List<BarcodeHelperModel> listmodel = new List<BarcodeHelperModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            List<string> sqllist = new List<string>();
            listmodel = jssl.Deserialize<List<BarcodeHelperModel>>(data);
            string sql = "";

            if (listmodel.Count > 0)
            {
                foreach (BarcodeHelperModel lm in listmodel)
                {
                    sql = "insert into [LabelARGItemInfo](BarcodeNO,PartNO,Creater,CreateDate) " +
                          "values('" + lm.BarcodeNO + "','" + lm.PartNO + "','" + model.USERNAME + "',getdate())";

                    sqllist.Add(sql);
                }
            }

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
                return "1";
            else
                return "0";
        }

    }
}