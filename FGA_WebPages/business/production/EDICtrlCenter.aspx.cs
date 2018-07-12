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
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.business.production
{
    public partial class EDICtrlCenter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 页面初始化读取workcenter
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData()
        {
            string res = string.Empty;

            //获取EDI数据
            string sql = "select SERIALNO customer_name,LOCATION Customer_Part_No,DEF1 part_no,DEF2 Ship_Date," +
                         "DEF3 Quantity, DEF4 Lot_No,DEF5 BATCH_NO, DEF6 JOB_SEQUENCE,DEF7 Standard_Quantity from [serial_test]" +
                         "ORDER BY [serialno], SUBSTRING([location],1,7) ,[def2] ,[def5] ,[def7],CAST(DEF6 as int)";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<EDIReleaseModel> luw = new List<EDIReleaseModel>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    EDIReleaseModel ERM = new EDIReleaseModel(row);
                    luw.Add(ERM);
                }
            }

            //获取分类信息
            //ShipTo、ShipDate、BatchNO、StandardQuantity、CustomerPartNO前7位
            string sqlH = "SELECT  distinct [serialno] customer_name,SUBSTRING([location],1,7) Customer_Part_No,[def2] Ship_Date," +
                          "[def5] BATCH_NO,[def7] Standard_Quantity FROM [WMS_BarCode_V10].[dbo].[serial_test]";

            DataSet dsh = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sqlH);
            if (dsh != null && dsh.Tables.Count > 0 && dsh.Tables[0].Rows.Count > 0)
            {
                Dictionary<string, bool> check = new Dictionary<string, bool>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    EDIReleaseModel ERM = new EDIReleaseModel(row);
                    string key = ERM.customer_name + ERM.Customer_Part_No + ERM.Ship_Date + ERM.BATCH_NO + ERM.Standard_Quantity;
                    check.Add(key, true);

                }
            }

            return res;
        }
    }
}