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
    public partial class ARGPackPartialBox : System.Web.UI.Page
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
        public static string SearchData(string bncode, string pncode, string location, string fdate, string tdate)
        {


            string res = string.Empty;
            try
            {
                string sql = "SELECT [BarcodeNO],[PartNO],[BoxType],[OrderQty],[Quantity] " +
                             ",[Creator],[CreateDate],[BoxStatus],[Location] " +
                             " FROM [WMS_BarCode_V10].[dbo].[ARGPartialBox_T] where isnull(dr,0) = 0 and len(barcodeno) > 7";

                //查询条件
                if (!String.IsNullOrEmpty(bncode))
                    sql = sql + " and [BarcodeNO] like '%" + bncode + "%' ";
                if (!String.IsNullOrEmpty(pncode))
                    sql = sql + " and [PartNO] like  '%" + pncode + "%' ";
                if (!String.IsNullOrEmpty(location))
                {
                    if (location == "All")
                        sql = sql + " and [location] = [location]";
                    else
                        sql = sql + " and [location] like  '%" + location + "%' ";
                }
                if (!String.IsNullOrEmpty(fdate))
                    sql = sql + " and [createdate] >= cast('" + fdate + "' as datetime)";
                if (!String.IsNullOrEmpty(tdate))
                    sql = sql + " and [createdate] <= cast('" + tdate + "' as datetime)";


                sql = sql + " order by location";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<BarcodeHelperModel> luw = new List<BarcodeHelperModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        BarcodeHelperModel ERM = new BarcodeHelperModel(row);
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
        /// 执行移库操作
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string deleteData(string data)
        {
            //按用户查看EDI的数据
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();

            List<BarcodeHelperModel> listmodel = new List<BarcodeHelperModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<BarcodeHelperModel>>(data);

            foreach (BarcodeHelperModel bhm in listmodel)
            {
                string sql = "update [WMS_BarCode_V10].[dbo].[ARGPackingWIP_t] set BPstatus = '2', UpdateBy = '" + user + "',  " +
                             "UpdateDate = getdate() where BarcodeNO = '" + bhm.BarcodeNO.Trim() + "' ";

                sqllist.Add(sql);
            }

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
            {
                return "1";
            }
            else
                return "0";
        }

        /// <summary>
        /// 按照条码号获取单片Part
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getBarcodeInfo(string data)
        {
            string res = string.Empty;
            try
            {
                string sql = "SELECT BarcodeNO FROM [WMS_BarCode_V10].[dbo].[ARGBoxLabel_T] where BarcodeNO = '"+ data + "'";

                DataSet ds_seq = new DataSet();
                ds_seq = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
                {
                    res = ds_seq.Tables[0].Rows[0][0].ToString();
                }
            }
            catch (Exception e)
            {

            }
            return res;

        }

        /// <summary>
        /// 半箱入库
        /// add by it-wxl   05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SaveScanRecord(string data, string location,string fqty)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            List<BarcodeHelperModel> listmodel = new List<BarcodeHelperModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            List<string> sqllist = new List<string>();
            listmodel = jssl.Deserialize<List<BarcodeHelperModel>>(data);

            if (listmodel.Count > 0)
            {
                foreach (BarcodeHelperModel lm in listmodel)
                {
                    string sql1 = "update [ARGPartialBox_T] set dr = 1 where BarcodeNO = '" + lm.BarcodeNO + "'";

                    string sql2 = "insert into ARGPartialBox_T(BarcodeNO,PartNO,BoxType,BoxStatus,Location,OrderQty,Quantity,Creator,CreateDate,dr) " +
                                  "select '"+lm.BarcodeNO+"',sd.itemcode,sd.boxtype,'Partial','"+location+"',sd.inboundquantity,"+ fqty + ",'"+model.USERNAME+"'," +
                                  "getdate(),0 from shipmentdetail sd where sd.itemid = (select itemid from argboxlabel_t where barcodeno = '"+lm.BarcodeNO+"')";

                    sqllist.Add(sql1);
                    sqllist.Add(sql2);
                }
            }

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
                return "1";
            else
                return "0";

        }

        /// <summary>
        /// 半箱出库
        /// add by it-wxl   05/08/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string outOfArea(string data)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            List<BarcodeHelperModel> listmodel = new List<BarcodeHelperModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            List<string> sqllist = new List<string>();
            listmodel = jssl.Deserialize<List<BarcodeHelperModel>>(data);
            string sql1 = "";
            //string sql2 = "";
            //string sql3 = "";

            if (listmodel.Count > 0)
            {
                foreach (BarcodeHelperModel lm in listmodel)
                {

                    sql1 = "update ShipmentDetail set BoxLabelSts = '" + lm.BarcodeNO + "' where itemid  " +
                           "=(select itemid from [ARGBoxLabel_T] where barcodeno = '" + lm.BarcodeNO + "')";

                    //sql2 = "update [ARGPartialBox_T] set dr = 1 where BarcodeNO = '" + lm.BarcodeNO + "'";

                    sqllist.Add(sql1);
                    //sqllist.Add(sql2);
                }
            }

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
                return "1";
            else
                return "0";

        }
    }
}