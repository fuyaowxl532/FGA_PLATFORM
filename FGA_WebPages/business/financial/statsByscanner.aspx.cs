using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_MODEL.Financial;
using FGA_NUtility;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.business.financial
{
    public partial class statsByscanner : System.Web.UI.Page
    {
        public static string pcycleno = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            pcycleno = Request.QueryString["cycleno"];
        }

        //页面加载表头
        [WebMethod]
        public static string SearchHead(string cycleno) {

            string res = String.Empty;
            string sql = "SELECT [CycleNO],[StartBy],[StartDate],[Location] FROM [WMS_BarCode_V10].[dbo].[FGA_CycleInventory_H] " +
                         "where [CycleNO] ='"+cycleno+"'";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<CycleInventory_H> luw = new List<CycleInventory_H>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    CycleInventory_H ERM = new CycleInventory_H(row);
                    luw.Add(ERM);
                }

                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(luw);
                res = res.Replace("\\/Date(", "").Replace(")\\/", "");
            }

            return res;
        }

        //加载盘点详情
        [WebMethod]
        public static string SearchDetail(string cycleno) {

            string res = String.Empty;
            string sql = "SELECT * " +
                         "FROM [WMS_BarCode_V10].[dbo].[FGA_CycleInventory_Detail] where CycleNO = '"+ cycleno + "' AND ISNULL(DR,'0') = 0 ORDER BY CycleRowID ASC";
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<CycleInventory_Detail> luw = new List<CycleInventory_Detail>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    CycleInventory_Detail ERM = new CycleInventory_Detail(row);
                    luw.Add(ERM);
                }

                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(luw);
                res = res.Replace("\\/Date(", "").Replace(")\\/", "");
            }
            

            return res;
        }

        [WebMethod]
        public static string getCycleNOByuser() {

            string res = "";
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

            string sql = "SELECT [CycleNO] FROM [WMS_BarCode_V10].[dbo].[FGA_CycleInventory_H] WHERE [StartBy] = '"+ puser + "'";
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                res = ds.Tables[0].Rows[0][0].ToString();
            }

            return res;
        }

        [WebMethod]
        public static string createCycleNO(string location)
        {

            string res = String.Empty;
            string CycleNo = "INV";
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

            string sql = "select next value for FGA_CycleInventory_seq as CycleID";
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            CycleNo = CycleNo + ds.Tables[0].Rows[0][0].ToString();

            string insertSql = "insert into [FGA_CycleInventory_H]([CycleNO],[Location],[CycleStatus],[StartBy],[StartDate],[Dr]) " +
                               "values('"+ CycleNo + "','"+ location + "','In Process','"+ puser + "',getdate(),'0')";

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(insertSql) > 0)
            {
                List<CycleInventory_H> luw = new List<CycleInventory_H>();
                CycleInventory_H ERM = new CycleInventory_H();

                ERM.CycleNO = CycleNo;
                ERM.StartBy = puser;

                luw.Add(ERM);

                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(luw);
            }

            return res;
        }

        //禁用，该方法写在getDataBySerialNO
        //update by it-wxl 20180503
        [WebMethod]
        public static string SaveData(string data,string CycleNO)
        {
            string res = "0";
            try
            {
                string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

                CycleInventory_Detail model = new CycleInventory_Detail();
                List<CycleInventory_Detail> listmodel = new List<CycleInventory_Detail>();
                JavaScriptSerializer jssl = new JavaScriptSerializer();
                listmodel = jssl.Deserialize<List<CycleInventory_Detail>>(data);
                List<string> sqllist = new List<string>();
                foreach (CycleInventory_Detail m in listmodel)
                {
                    string sql = "insert into [FGA_CycleInventory_Detail] ([CycleNO],[CycleStatus],[SerialNO],[PartNO],[Location],[Quantity]," +
                                 "[ActualQty],[creator],[createtime],[TargetLocation],[PartName],[OperationCode]) " +
                                 "values ('{0}','In Process','{1}','{2}','{3}',{4},{5},'{6}',getdate(),'{7}','{8}','{9}')";
                    sql = string.Format(sql, CycleNO, m.SerialNO, m.PartNO, m.Location,m.Quantity ,m.ActualQty, puser, m.TargetLocation,m.PartName,m.OperationCode);
                    sqllist.Add(sql);
                }
                if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
                    res = "1";
            }
            catch
            { return "0"; }

            return res;
        }

        [WebMethod]
        public static string updateData(string data)//更新实际数量及库位
        {
            try
            {
                string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
                CycleInventory_Detail model = new CycleInventory_Detail();
                List<CycleInventory_Detail> listmodel = new List<CycleInventory_Detail>();
                JavaScriptSerializer jssl = new JavaScriptSerializer();
                listmodel = jssl.Deserialize<List<CycleInventory_Detail>>(data);
                List<string> sqllist = new List<string>();
                foreach (CycleInventory_Detail m in listmodel)
                {
                    string sql = " update [FGA_CycleInventory_Detail] set [ActualQty] = "+m.ActualQty+",[Creator]='"+puser+"',[createtime] = GETDATE() " +
                                 " where [SerialNO] = '"+m.SerialNO+"' and [CycleNO] ='"+m.CycleNO+"' ";
                    sqllist.Add(sql);
                }
                if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
                {
                    return "1";
                }
            }
            catch
            { return "0"; }
            return "0";
        }

        [WebMethod]
        public static string getDataBySerialNO(string data, string CycleNO,string targetLoc)//从plex获取DA号对应的信息
        {
            string res = string.Empty;
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            CycleInventory_Detail model = new CycleInventory_Detail();
            FGA_NUtility.POL.ExecuteDataSourceResult esr = PlexHelper.PlexGetResult_1("10837", "Container_Get", "@Serial_No", data);

            string sql = null;

            if (esr.ResultSets != null)
            {
                model.PartNO = esr.ResultSets[0].Rows[0].Columns[23].Value;
                model.PartName = esr.ResultSets[0].Rows[0].Columns[42].Value;
                model.Location = esr.ResultSets[0].Rows[0].Columns[9].Value;
                model.Quantity = Decimal.Parse(esr.ResultSets[0].Rows[0].Columns[14].Value);
                model.ActualQty = Decimal.Parse(esr.ResultSets[0].Rows[0].Columns[14].Value);
                model.OperationCode = esr.ResultSets[0].Rows[0].Columns[40].Value;

                sql = "insert into [FGA_CycleInventory_Detail] ([CycleNO],[CycleStatus],[SerialNO],[PartNO],[Location],[Quantity]," +
                      "[ActualQty],[creator],[createtime],[TargetLocation],[PartName],[OperationCode],[Dr]) " +
                      "values ('" + CycleNO + "','In Process','" + data + "','" + model.PartNO + "','" + model.Location + "'," + model.Quantity + "," + model.Quantity + ",'" + puser + "',getdate()," +
                      "'" + targetLoc + "','" + model.PartName + "','" + model.OperationCode + "','0')";
            }
            else
            {
                sql = "insert into [FGA_CycleInventory_Detail] ([CycleNO],[CycleStatus],[SerialNO],[PartNO],[Location],[Quantity]," +
                       "[ActualQty],[creator],[createtime],[TargetLocation],[PartName],[OperationCode],[Dr]) " +
                       "values ('" + CycleNO + "','In Process','" + data + "','" + model.PartNO + "','" + model.Location + "'," + model.Quantity + "," + model.Quantity + ",'" + puser + "',getdate()," +
                       "'" + targetLoc + "','" + model.PartName + "','" + model.OperationCode + "','1')";
            }

            //将获取的信息存入数据库,保存成功才返回界面。否则报错
            //Update by IT-WXL  20180502
          

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql) > 0)
            {
                JavaScriptSerializer jssl = new JavaScriptSerializer();
                res = jssl.Serialize(model);
            }

            return res;
        }

        [WebMethod]
        public static string SynToPlex(string data, string toloc,string CycleNO)//同步结果到Plex
        {
            string res = string.Empty;
       
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            string plexid = "";
            string sql = "select plexid from userinfo where username = '" + puser + "'";
            DataSet ds2 = new DataSet();
            ds2 = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
            if (ds2 != null && ds2.Tables.Count > 0 && ds2.Tables[0].Rows.Count > 0)
            {
                plexid = ds2.Tables[0].Rows[0][0].ToString();
            }

            int count = 0;
            string msg = "";

            CycleInventory_Detail model = new CycleInventory_Detail();
            List<CycleInventory_Detail> listmodel = new List<CycleInventory_Detail>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<CycleInventory_Detail>>(data);

            string cMon = DateTime.Now.Month.ToString();
            string cDay = DateTime.Now.Day.ToString();
            string pdate = DateTime.Now.Year.ToString().Substring(2, 2) + 
                (cMon.Length == 1 ? "0" + cMon : cMon) +  
                (cDay.Length == 1 ? "0" + cDay : cDay);

            foreach (CycleInventory_Detail vo in listmodel)
            {
                FGA_NUtility.POL.ExecuteDataSourceResult da_rst = null;

                if (vo.Quantity != vo.ActualQty)
                {
                    da_rst = PlexHelper.PlexGetResult_7("27181", "Container_Update_Simple",
                    "@Serial_No", "@Location", "@Quantity", "@Last_Action", "@Update_By", "@Tracking_No", "@Adjustment_Reason_Key", vo.SerialNO, toloc.Trim(), vo.ActualQty.ToString(),
                    "Cycle Inventory", plexid, "inv" + pdate,"2874");
                }
                else
                {
                    da_rst = PlexHelper.PlexGetResult_6("27181", "Container_Update_Simple",
                    "@Serial_No", "@Location", "@Last_Action", "@Update_By", "@Tracking_No", "@Adjustment_Reason_Key", vo.SerialNO, toloc.Trim(), "Cycle Inventory", plexid, "inv" + pdate,"2874");
                }

                if (!da_rst.Error)
                    count++;
                else
                    msg = msg + vo.SerialNO + '\n';
            }

            if (!String.IsNullOrEmpty(msg))
                res = "Finished: " + count + '\n' + "Follow SerialNO is unsuccessful: " + '\n' + msg;
            else
            {
                res = "Finished: " + count;
                //更改CycleInventory_H状态
                string synsql = "update [FGA_CycleInventory_H] set CycleStatus = 'Completed',[CompleteBy] ='" + puser + "',[CompleteDate] = getdate() where CycleNO = '" + CycleNO + "'";
                FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(synsql);
            }

            return res;
        }

        [WebMethod]
        public static string validate(string sn)//验证当前DA号当天是否重复扫描.0已扫描1未扫描
        {
            string res = string.Empty;

            try
            {
                string sql = "SELECT * FROM [WMS_BarCode_V10].[dbo].[FGA_CycleInventory_Detail] " +
                             "where SerialNO = '"+ sn + "' and createtime >= '"+ DateTime.Now.ToString("yyyy-MM-dd") + "' and isnull(dr,'0') = '0' ";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<CycleInventory_Detail> luw = new List<CycleInventory_Detail>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        CycleInventory_Detail ERM = new CycleInventory_Detail(row);
                        luw.Add(ERM);
                    }

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(luw);
                    res = res.Replace("\\/Date(", "").Replace(")\\/", "");
                }
            }
            catch
            {
            }

            return res;
        }

        [WebMethod]
        public static string delRecord(string cycleno, string serialno)//更新实际数量及库位
        {
            string res = "0";
            try
            {
                string sql = "update [WMS_BarCode_V10].[dbo].[FGA_CycleInventory_Detail] set dr ='1' where CycleNO = '"+ cycleno + "' and SerialNO = '"+ serialno + "' ";

                if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql) > 0)
                    res = "1";
                else
                    res = "0";
            }
            catch
            { return "0"; }

            return res;
        }

        [WebMethod]
        public static string checkConnect()
        {

            string res = String.Empty;

            string sql = "select next value for FGA_CheckConnect_seq as cid";
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
          
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                res = ds.Tables[0].Rows[0][0].ToString();
            }

            return res;
        }
    }
}