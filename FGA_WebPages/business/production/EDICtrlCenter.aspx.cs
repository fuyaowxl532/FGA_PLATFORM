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
        /// 导入保存数据
        /// add by it-wxl
        /// add date 12/20/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string saveDataImport(string data)
        {
            //按用户查看EDI的数据
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();
            List<string> sqllist1 = new List<string>();

            List<EDIReleaseModel> listmodel = new List<EDIReleaseModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<EDIReleaseModel>>(data);

            foreach (EDIReleaseModel pc in listmodel)
            {
                string sql = "insert into [FGA_EDIOrder_List] " +
                                "([customer_name],[Customer_Address_Code],[Customer_Part_No],[Customer_Part_Revision],[part_no] " +
                                ",[part_name],[Due_Date],[Ship_Date],[ORDER_NO],[Lot_No],[BATCH_NO],[EDI_Key],[EDI_Action] " +
                                ",[EDI_Status],[Docname],[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[rstatus]) " +
                                "values('"+ pc.customer_name + "','"+pc.Customer_Address_Code+"','"+pc.Customer_Part_No+"','"+pc.Customer_Part_Revision+"','"+pc.part_no+"'," +
                                "'"+pc.part_name+"','"+pc.Due_Date+"','"+pc.Ship_Date+"','"+pc.ORDER_NO+"','"+pc.Lot_No+"','"+pc.BATCH_NO+"',"+pc.EDI_Key+"" +
                                ",'"+pc.EDI_Action+"','"+pc.EDI_Status+"','"+pc.Docname+"',"+pc.Standard_Quantity+","+pc.Quantity+","+pc.JOB_SEQUENCE+",0)";

                sqllist.Add(sql);
            }

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
                return "1";
            else
                return "0";
        }

        /// <summary>
        /// 页面初始化读取workcenter
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string onSearch()
        {
            String res = String.Empty;

            return res;
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
                int pcycle    = 0;
                int groupqty  = 0;
                int sqty      = 0;
                bool newGroup = true;
                string mid = ""; 
                string pdate = DateTime.Now.Year.ToString().Substring(2, 2)
                               + (DateTime.Now.Month.ToString().Length == 1 ? "0" + DateTime.Now.Month.ToString() : DateTime.Now.Month.ToString())
                               + (DateTime.Now.Day.ToString().Length == 1 ? "0" + DateTime.Now.Day.ToString() : DateTime.Now.Day.ToString());

                for (int i = 0; i < ds.Tables[0].Rows.Count; i = i+1+pcycle) {
                    
                    pcycle = 0;
                   
                    EDIReleaseModel ERM = new EDIReleaseModel(ds.Tables[0].Rows[i]);
                    int count = ERM.Quantity;

                    if (newGroup)
                    {
                        groupqty = 0;
                        sqty     = ERM.Standard_Quantity;
                        mid      = pdate + i;
                    }

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
                                    //首先判断是否新组合
                                    if (newGroup)
                                    {
                                        if (count + ERM_Next.Quantity < ERM_Next.Standard_Quantity)
                                        {
                                            count = count + ERM_Next.Quantity;
                                            //groupqty = groupqty + ERM_Next.Quantity;
                                            newGroup = false;
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
                                            //groupqty = groupqty + count + ERM_Next.Quantity - ERM_Next.Standard_Quantity;
                                            newGroup = false;
                                            pcycle++;
                                        }
                                    }
                                    else
                                    {
                                        if (groupqty + count > sqty)
                                        {

                                        }
                                        else
                                        {
                                            if (groupqty + count == sqty)
                                            {
                                                ERM.Quantity = count;
                                                ERM.MasterID = mid;
                                                groupqty = groupqty + count;
                                                newGroup = true;
                                                luw.Add(ERM);
                                                pcycle++;
                                                break;
                                            }
                                            else
                                            {
                                                count = count + ERM_Next.Quantity;
                                                newGroup = false;
                                                pcycle++;
                                                continue;
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    ERM.Quantity = count;
                                    ERM.MasterID = mid;
                                    groupqty = groupqty + count;

                                    if(groupqty != sqty)
                                        newGroup = false;
                                    else
                                        newGroup = true;

                                    luw.Add(ERM);
                                    break;
                                }
                            }
                            else
                            {
                                ERM.Quantity = count;
                                ERM.MasterID = mid;
                                groupqty = groupqty + count;

                                if (groupqty != sqty)
                                    newGroup = false;
                                else
                                    newGroup = true;

                                luw.Add(ERM);
                                break;
                            }
                        }
                    }
                    else {
                        ERM.Quantity = count;
                        ERM.MasterID = mid;
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
                                           ",[Ship_Date],[ORDER_NO],[Lot_No],[BATCH_NO],[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[rstatus],[PartType],[MasterID])" +
                                           "values('Honda North America','" + vo.Customer_Address_Code+ "','" + vo.Customer_Part_No + "','" + vo.part_no + "'," +
                                           "'"+ vo.part_name + "','" + vo.Ship_Date + "','10000','" + vo.Lot_No + "','" + vo.BATCH_NO + "',"+vo.Standard_Quantity+"," +
                                           ""+vo.Quantity+",'"+vo.JOB_SEQUENCE+"','0','Side','"+vo.MasterID+"')";

                        sqllist.Add(insertsql);
                    }

                    FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist);
                }
            }

            return res;
        }
    }
}