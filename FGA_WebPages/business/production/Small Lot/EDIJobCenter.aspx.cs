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
using FGA_NUtility;

namespace FGA_PLATFORM.business.production
{
    public partial class EDIJobCenter : System.Web.UI.Page
    {
        protected string isLocked = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string sql = "SELECT rid FROM userroles where uid = (select userid from userinfo where username ='" + model.USERNAME + "')";
            DataSet dst = new DataSet();
            dst = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
            if (dst != null && dst.Tables.Count > 0 && dst.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dst.Tables[0].Rows.Count; i++)
                {
                    if (Convert.ToInt32(dst.Tables[0].Rows[i][0]) == 7)
                        isLocked = "Yes";
                    else
                        isLocked = "No";
                }
            }
        }

        /// <summary>
        /// 导入保存数据
        /// add by it-wxl
        /// add date 08/01/2018
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string saveDataImport(string data)
        {
            string res = String.Empty;
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();

            List<EDIOrderListModel> listmodel = new List<EDIOrderListModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<EDIOrderListModel>>(data);

            //数据校验
            //MasterID不能为空.前端检验
            //获取PartNO是否在系统中维护ModuleCode,PartType。服务器校验
            string pn = "";
            for (int i = 0; i < listmodel.Count; i++)
            {
                if (String.IsNullOrEmpty(listmodel[i].MasterID))
                {
                    res = "-1";
                    break;
                }
                else
                    pn = pn + ',' + '\'' + listmodel[i].Part_NO + '\'';
            }

            if (String.IsNullOrEmpty(res))
            {
                foreach (EDIOrderListModel vo in listmodel)
                {
                    string insertsql = "insert into [FGA_EDI_862_T]([Customer_Name],[Customer_Address_Code],[Customer_Part_Revision],[Customer_Part_No],[Part_NO],[Part_Name]" +
                                               ",[Due_Date],[Ship_Date],[Order_NO],[Lot_NO],[Batch_NO],[Standard_Quantity],[Quantity],[Job_Sequence],[rstatus],[MasterID],[EDI_RowID],[Creator],[CreateDate])" +
                                               "values('" + vo.Customer_Name + "','" + vo.Customer_Address_Code + "','" + vo.Customer_Part_Revision + "','" + vo.Customer_Part_NO + "','" + vo.Part_NO + "'," +
                                               "'" + vo.Part_Name + "','" + vo.Due_Date + "','" + vo.Ship_Date + "','" + vo.Order_NO + "','" + vo.Lot_NO + "','" + vo.Batch_NO + "'," + vo.Standard_Quantity + "," +
                                               "" + vo.Quantity + ",'" + vo.Job_Sequence + "','0','" + vo.MasterID + "',NEXT VALUE FOR OEM_OrderKey_seq,'" + user + "',getdate())";

                    sqllist.Add(insertsql);
                }

                string sqlupdate = "update [FGA_EDI_862_T] SET [FGA_EDI_862_T].PartType = [SmallLot_PartType_T].[PartType] " +
                                         "FROM [FGA_EDI_862_T] ,[SmallLot_PartType_T] WHERE[FGA_EDI_862_T].Part_NO = [SmallLot_PartType_T].[PartNO] " +
                                         "AND ISNULL([FGA_EDI_862_T].PartType,'') = ''";

                sqllist.Add(sqlupdate);

                if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
                    res = "1";
                else
                    res = "0";
            }
            

            return res;
        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData()
        {
            //按用户查看EDI的数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string ET = "";
            string sql = "";
            
            if (model.USERNAME == "Honda_front")
                ET = "Front";
            if (model.USERNAME == "Honda_rear")
                ET = "Rear"; 
            if (model.USERNAME == "Honda_side")
                ET = "Side";

            string res = string.Empty;
            try
            {
                if (model.USERNAME != "administrator")
                {
                    sql = "SELECT [customer_name],[Customer_Address_Code],[Customer_Part_No],[Customer_Part_Revision] " +
                            " ,[part_no],[Due_Date] ,[Ship_Date],[ORDER_NO] ,[Lot_No],[BATCH_NO]" +
                            " ,[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[EDI_RowID],[MasterID],isnull([LastEditDate],[CreateDate]) as [CreateDate],[PartType],[IsConfirm] " +
                            " FROM [FGA_EDI_862_T] where isnull(rstatus,0) = 0 and PARTTYPE = '" + ET + "' and isnull(IsConfirm,0) = 1 " +
                            "order by [Ship_Date],[MasterID],[JOB_SEQUENCE]";
                }

                if (model.USERNAME == "administrator" || model.USERNAME == "fy.hxu")
                {
                    sql = "SELECT [customer_name],[Customer_Address_Code],[Customer_Part_No],[Customer_Part_Revision] " +
                                                " ,[part_no],[Due_Date] ,[Ship_Date],[ORDER_NO] ,[Lot_No],[BATCH_NO]" +
                                                " ,[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[EDI_RowID],[MasterID],isnull([LastEditDate],[CreateDate]) as [CreateDate],[CreateDate],[PartType],[IsConfirm] " +
                                                " FROM [FGA_EDI_862_T] where isnull(rstatus,0) = 0  " +
                                                "order by [Ship_Date],[MasterID],[JOB_SEQUENCE]";
                }
                
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
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
                    res =res.Replace("\\/Date(","").Replace(")\\/","");
                }
            }
            catch (Exception e)
            {

            }
            return res;
        }

        [WebMethod]
        public static string ConfirmData() {

            string res = "0";
            try
            {
                string isExist = "SELECT count(*) total FROM [FGA_PLATFORM].[dbo].[FGA_EDI_862_T] where isnull([IsConfirm],0) = 0";
                if (Int32.Parse(FGA_DAL.Base.SQLServerHelper.GetSingle(isExist).ToString()) > 0)
                {
                    UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
                    string sql = "update [FGA_EDI_862_T] set [LastEditUser] = '" + model.USERNAME + "',[LastEditDate] = getdate(),[IsConfirm] = 1 where isnull([IsConfirm],0) = 0";
                    if (FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql) > 0)
                    {
                        res = "1";
                        MailHelper.SendMailUseGmail("xwang6@fuyaousa.com","","Confirm","This is a test mail!");
                    }
                       
                }
                else
                    res = "-1";
            }
            catch {
                res = "0";
            }

            return res;
        }

        [WebMethod]
        //release操作
        //对获取到的界面数据进行处理
        //1、生成Load主表              FGA_EDI_LOAD_T
        //2、生成LoadID与Part的对应表  FGA_LoadPart_T
        //3、生成Load明细表            FGA_LoadDetail_T
        //4、修改记录的状态            FGA_EDI_862_T
        public static string releaseData(string data)
        {
            try
            {
                UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

                //按用户查看EDI的数据
                string ET = "";

                if (model.USERNAME == "Honda_front")
                    ET = "Front";
                if (model.USERNAME == "Honda_rear")
                    ET = "Rear";
                if (model.USERNAME == "Honda_side")
                    ET = "Side";

                List<string> sqllist = new List<string>();

                List<EDIReleaseModel> listmodel = new List<EDIReleaseModel>();
                JavaScriptSerializer jssl = new JavaScriptSerializer();
                listmodel = jssl.Deserialize<List<EDIReleaseModel>>(data);

                //生成序列号
                string SEQ = null;
                string rowid = "'0'";

                string sql = "select next value for honda_sequence_seq as HS ";
                DataSet ds_seq = new DataSet();
                ds_seq = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
                if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
                {
                    SEQ = "FGA" + ds_seq.Tables[0].Rows[0][0].ToString();
                }
                else
                    return "0";

                //生成Load主表
                string sql1 = "insert into FGA_EDI_LOAD_T ([Quantity],[Creator],[Createdate],[LoadStatus],[LoadID],[CustomerName] " +
                              " ,[CustomerAddress],[ShipDate],[BatchNO],[PartType],[Slstatus]) values ({0},'{1}',getdate(),'Release','{6}','{2}','{3}','{4}','{5}','{7}','0')";
                sql1 = string.Format(sql1, listmodel[0].Standard_Quantity, model.USERNAME, "Honda North America", listmodel[0].Customer_Address_Code,
                    listmodel[0].Ship_Date, listmodel[0].BATCH_NO, SEQ,ET);

                FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql1);

                //生成LoadID与Part的对应表
                string sql2 = null;
                foreach (EDIReleaseModel m in listmodel)
                {
                    sql2 = "insert into FGA_LoadPart_T ([LoadID],[PartNO],[Quantity],[CustomerPart] " +
                                  " ,[JobSequence],[EDI_RowID],[Creator],[CreateDate]) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}',getdate())";
                    sql2 = string.Format(sql2, SEQ, m.part_no, m.Quantity,
                        m.Customer_Part_No, m.JOB_SEQUENCE,m.EDI_RowID, model.USERNAME);

                    rowid += "," + m.EDI_RowID;
                    FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql2);
                }

                //生成LoadDetail表
                //position排序规则：job_sequence大的排后面
                string sql3 = null;
                int ccount = listmodel[0].Standard_Quantity;

                //按排序规则重新获取EDIList
                List<EDIReleaseModel> edisort = new List<EDIReleaseModel>();
                string sqlsort = "select [customer_name],[Customer_Address_Code],[Customer_Part_No],[Customer_Part_Revision] " + 
                             " ,[part_no],[Due_Date] ,[Ship_Date],[ORDER_NO] ,[Lot_No],[BATCH_NO]" +
                             " ,[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[EDI_RowID] from  FGA_EDI_862_T where edi_rowid in (" + rowid + ") order by job_sequence desc";
                DataSet ds_sort = new DataSet();
                ds_sort = FGA_DAL.Base.SQLServerHelper.Query(sqlsort);
                if (ds_sort != null && ds_sort.Tables.Count > 0 && ds_sort.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow row in ds_sort.Tables[0].Rows)
                        edisort.Add(new EDIReleaseModel(row));
                }

                foreach (EDIReleaseModel m in edisort)
                {
                    for (int i = 0; i < m.Quantity; i++)
                    {
                        sql3 = " insert into FGA_LoadDetail_T ([customer_name],[Customer_Address_Code],[Customer_Part_No],[Customer_Part_Revision] " +
                               " ,[part_no],[Ship_Date],[Lot_No],[BATCH_NO],[Standard_Quantity] " +
                               " ,[Quantity],[JOB_SEQUENCE],[Position],[LoadID]) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}',{8}" +
                               " ,{9},{10},{11},'{12}') ";
                        sql3 = string.Format(sql3,m.customer_name, m.Customer_Address_Code,m.Customer_Part_No, m.Customer_Part_Revision,m.part_no
                            ,m.Ship_Date,m.Lot_No,m.BATCH_NO,m.Standard_Quantity,m.Quantity,m.JOB_SEQUENCE,ccount,SEQ);

                        FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql3);

                        ccount--;
                    }
                    
                }

                //修改界面状态
                string sql4 = "update FGA_EDI_862_T set rstatus = 1 where edi_rowid in ("+rowid+")";
                FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql4);

                return "1";
            }
            catch
            { return "0"; }
        }
    }
}