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
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData()
        {
            string res = string.Empty;
            try
            {
                String sql = "SELECT * FROM [WMS_BarCode_V10].[dbo].[FGA_EDIOrder_List] WHERE isnull(rstatus,0) = 0 " +
                             " order by Customer_Name,Ship_Date,SUBSTRING(Customer_Part_NO, 1, 7),BATCH_NO,Standard_Quantity,Job_Sequence ";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<EDIOrderListModel> luw = new List<EDIOrderListModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        EDIOrderListModel ERM = new EDIOrderListModel(row);
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

            List<EDIOrderListModel> listmodel = new List<EDIOrderListModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<EDIOrderListModel>>(data);

            foreach (EDIOrderListModel pc in listmodel)
            {
                string sql = "insert into [FGA_EDIOrder_List] " +
                                "([customer_name],[Customer_Address_Code],[Customer_Part_No],[Customer_Part_Revision],[part_no] " +
                                ",[part_name],[Due_Date],[Ship_Date],[ORDER_NO],[Lot_No],[BATCH_NO],[EDI_Key],[EDI_Action] " +
                                ",[EDI_Status],[Docname],[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[rstatus]) " +
                                "values('"+ pc.Customer_Name + "','"+pc.Customer_Address_Code+"','"+pc.Customer_Part_NO+"','"+pc.Customer_Part_Revision+"','"+pc.Part_NO+"'," +
                                "'"+pc.Part_Name+"','"+pc.Due_Date+"','"+pc.Ship_Date+"','"+pc.Order_NO+"','"+pc.Lot_NO+"','"+pc.Batch_NO+"',"+pc.EDI_Key+"" +
                                ",'"+pc.EDI_Action+"','"+pc.EDI_Status+"','"+pc.Docname+"',"+pc.Standard_Quantity+","+pc.Quantity+","+pc.Job_Sequence+",0)";

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
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            //获取EDI数据
            string sql = "SELECT * FROM [WMS_BarCode_V10].[dbo].[FGA_EDIOrder_List] WHERE isnull(rstatus,0) = 0 " +
                         "order by Customer_Name,Ship_Date,SUBSTRING(Customer_Part_NO,1,7),BATCH_NO,Standard_Quantity,Job_Sequence ";

            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<EDIOrderListModel> luw = new List<EDIOrderListModel>();
                int pcycle    = 0;
                int groupqty  = 0;
                int newQty    = 0;
                int sqty      = 0;
                bool newGroup = true;
                string mid = ""; 
                string pdate = DateTime.Now.Year.ToString().Substring(2, 2)
                               + (DateTime.Now.Month.ToString().Length == 1 ? "0" + DateTime.Now.Month.ToString() : DateTime.Now.Month.ToString())
                               + (DateTime.Now.Day.ToString().Length == 1 ? "0" + DateTime.Now.Day.ToString() : DateTime.Now.Day.ToString());

                for (int i = 0; i < ds.Tables[0].Rows.Count; i = i+1+pcycle) {
                    
                    pcycle = 0;

                    EDIOrderListModel ERM = new EDIOrderListModel(ds.Tables[0].Rows[i]);
                    int count = ERM.Quantity;
                    if (newQty != 0)
                        count = ERM.Quantity = newQty;

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
                            EDIOrderListModel ERM_Next = new EDIOrderListModel(ds.Tables[0].Rows[j]);
                            if (ERM.Customer_Name == ERM_Next.Customer_Name && ERM.Ship_Date == ERM_Next.Ship_Date &&
                                ERM.Batch_NO == ERM_Next.Batch_NO && ERM.Standard_Quantity == ERM_Next.Standard_Quantity &&
                                ERM.Customer_Part_NO.Substring(0, 7) == ERM_Next.Customer_Part_NO.Substring(0, 7))
                            {
                                if (ERM.Part_NO == ERM_Next.Part_NO)
                                {
                                    //首先判断是否新组合
                                    if (newGroup)
                                    {
                                        if (count + ERM_Next.Quantity < ERM_Next.Standard_Quantity)
                                        {
                                            count = count + ERM_Next.Quantity;
                                            newGroup = false;
                                            pcycle++;
                                            newQty = 0;
                                            continue;
                                        }

                                        if (count + ERM_Next.Quantity == ERM_Next.Standard_Quantity)
                                        {
                                            pcycle++;
                                            newQty = 0;
                                            break;
                                        }
                                        if (count + ERM_Next.Quantity > ERM_Next.Standard_Quantity)
                                        {
                                            count = count + ERM_Next.Quantity - ERM_Next.Standard_Quantity;
                                            newGroup = false;
                                            newQty = 0;
                                            pcycle++;
                                        }
                                    }
                                    else
                                    {
                                        if (groupqty + count > sqty)
                                        {
                                            ERM.Quantity = sqty - groupqty;
                                            newQty = count - (sqty - groupqty);
                                            ERM.MasterID = mid;
                                            luw.Add(ERM);
                                            pcycle--;
                                            newGroup = true;
                                            break;
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
                                                newQty = 0;
                                                break;
                                            }
                                            else
                                            {
                                                count = count + ERM_Next.Quantity;
                                                newGroup = false;
                                                pcycle++;
                                                newQty = 0;
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
                                    newQty = 0;
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
                                newQty = 0;
                                break;
                            }
                        }
                    }
                    else {
                        ERM.Quantity = count;
                        ERM.MasterID = mid;
                        luw.Add(ERM);
                        newQty = 0;
                    }
                }

                if (luw.Count > 0)
                {
                    List<String> sqllist = new List<String>();
                    string delsql = "delete from [WMS_BarCode_V10].[dbo].[FGA_EDI_862_T]";
                    sqllist.Add(delsql);

                    foreach (EDIOrderListModel vo in luw) {
                        string insertsql = "insert into [FGA_EDI_862_T]([customer_name],[Customer_Address_Code],[Customer_Part_Revision],[Customer_Part_No],[part_no],[part_name]" +
                                           ",[Due_Date],[Ship_Date],[ORDER_NO],[Lot_No],[BATCH_NO],[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[rstatus],[MasterID],[EDI_RowID],[Creator],[CreateDate])" +
                                           "values('Honda North America','" + vo.Customer_Address_Code+ "','"+vo.Customer_Part_Revision+"','" + vo.Customer_Part_NO + "','" + vo.Part_NO + "'," +
                                           "'"+ vo.Part_Name + "','" + vo.Due_Date + "','" + vo.Ship_Date + "','"+vo.Order_NO+"','" + vo.Lot_NO + "','" + vo.Batch_NO + "',"+vo.Standard_Quantity+"," +
                                           ""+vo.Quantity+",'"+vo.Job_Sequence+"','0','"+vo.MasterID+ "',NEXT VALUE FOR OEM_OrderKey_seq,'"+ model.USERNAME + "',getdate())";

                        sqllist.Add(insertsql);
                    }
                    sqllist.Add("DELETE FROM FGA_EDI_862_T WHERE Standard_Quantity = Quantity");

                    string sqlupdate = "update [FGA_EDI_862_T] SET [FGA_EDI_862_T].PartType = [SmallLot_PartType_T].[PartType] " +
                                       "FROM [FGA_EDI_862_T] ,[SmallLot_PartType_T] WHERE[FGA_EDI_862_T].Part_NO = [SmallLot_PartType_T].[PartNO] " +
                                       "AND ISNULL([FGA_EDI_862_T].PartType,'') = ''";

                    sqllist.Add(sqlupdate);
                    sqllist.Add("UPDATE [WMS_BarCode_V10].[dbo].[FGA_EDIOrder_List] set [rstatus] = 1,[UpdateDate] = getdate(),[UpdateBy] = '"+ model.USERNAME+ "' where isnull(rstatus,0) = 0");
                     

                    FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist);
                }
            }

            return res;
        }
    }
}