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
        public static string MergeData()
        {
            string res = string.Empty;

            //获取EDI数据
            string sql = "select SERIALNO customer_name,LOCATION Customer_Part_No,DEF1 part_no,DEF2 Ship_Date, " +
                         "DEF3 Quantity, DEF4 Lot_No,DEF5 BATCH_NO, DEF6 JOB_SEQUENCE,DEF7 Standard_Quantity from [serial_test] " +
                         "ORDER BY [serialno],[def2] , SUBSTRING([location],1,7) ,[def5] ,[def7],CAST(DEF6 as int)";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<EDIReleaseModel> luw = new List<EDIReleaseModel>();
                int pcycle = 0;

                for (int i = 0; i < ds.Tables[0].Rows.Count; i = i+1+pcycle) {

                    pcycle = 0;
                    EDIReleaseModel ERM = new EDIReleaseModel(ds.Tables[0].Rows[i]);
                    int count = ERM.Quantity;

                    if (i + 1 < ds.Tables[0].Rows.Count)
                    {
                        for (int j = i + 1; j < ds.Tables[0].Rows.Count; j++)
                        {
                            EDIReleaseModel ERM_Next = new EDIReleaseModel(ds.Tables[0].Rows[j]);
                            if (ERM.customer_name == ERM_Next.customer_name && ERM.Ship_Date == ERM_Next.Ship_Date &&
                                ERM.BATCH_NO == ERM_Next.BATCH_NO && ERM.Standard_Quantity == ERM_Next.Standard_Quantity &&
                                ERM.Customer_Part_No.Substring(0, 7) == ERM_Next.Customer_Part_No.Substring(0, 7))
                            {
                                if (ERM.part_no == ERM_Next.part_no)
                                {
                                    if (count + ERM_Next.Quantity < ERM_Next.Standard_Quantity)
                                    {
                                        count = count + ERM_Next.Quantity;
                                        pcycle++;
                                        continue;
                                    }

                                    if (count + ERM_Next.Quantity == ERM_Next.Standard_Quantity)
                                    {
                                        pcycle++;
                                        break;
                                    }
                                    if (count + ERM_Next.Quantity > ERM_Next.Standard_Quantity)
                                    {
                                        count = count + ERM_Next.Quantity - ERM_Next.Standard_Quantity;
                                        pcycle++;
                                    }
                                }
                                else
                                {
                                    ERM.Quantity = count;
                                    luw.Add(ERM);
                                    break;
                                }
                            }
                            else
                            {
                                ERM.Quantity = count;
                                luw.Add(ERM);
                                break;
                            }
                        }
                    }
                    else {
                        ERM.Quantity = count;
                        luw.Add(ERM);
                    }
                }

                if (luw.Count > 0)
                {
                    List<String> sqllist = new List<String>();
                    string delsql = "delete from [WMS_BarCode_V10].[dbo].[FGA_EDI_862_T]";
                    sqllist.Add(delsql);

                    foreach (EDIReleaseModel vo in luw) {
                        string insertsql = "insert into [FGA_EDI_862_T]([customer_name],[Customer_Address_Code],[Customer_Part_No],[part_no],[part_name]" +
                                           ",[Ship_Date],[ORDER_NO],[Lot_No],[BATCH_NO],[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[rstatus],[PartType])" +
                                           "values('Honda North America','" + vo.Customer_Address_Code+ "','" + vo.Customer_Part_No + "','" + vo.part_no + "'," +
                                           "'"+ vo.part_name + "','" + vo.Ship_Date + "','10000','" + vo.Lot_No + "','" + vo.BATCH_NO + "',"+vo.Standard_Quantity+"," +
                                           ""+vo.Quantity+",'"+vo.JOB_SEQUENCE+"','0','Side')";

                        sqllist.Add(insertsql);
                    }

                    FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist);
                }
            }

            ////获取分类信息
            ////ShipTo、ShipDate、BatchNO、StandardQuantity、CustomerPartNO前7位
            //string sqlH = "SELECT  distinct [serialno] customer_name,SUBSTRING([location],1,7) Customer_Part_No,[def2] Ship_Date, " +
            //              "[def5] BATCH_NO,[def7] Standard_Quantity FROM [WMS_BarCode_V10].[dbo].[serial_test]";

            //DataSet dsh = new DataSet();
            //dsh = FGA_DAL.Base.SQLServerHelper_WMS.Query(sqlH);
            //if (dsh != null && dsh.Tables.Count > 0 && dsh.Tables[0].Rows.Count > 0)
            //{
            //    Dictionary<string, bool> check = new Dictionary<string, bool>();
            //    foreach (DataRow row in ds.Tables[0].Rows)
            //    {
            //        EDIReleaseModel ERM = new EDIReleaseModel(row);
            //        string key = ERM.customer_name + ERM.Customer_Part_No + ERM.Ship_Date + ERM.BATCH_NO + ERM.Standard_Quantity;
            //        check.Add(key, true);


            //    }
            //}

            return res;
        }
    }
}