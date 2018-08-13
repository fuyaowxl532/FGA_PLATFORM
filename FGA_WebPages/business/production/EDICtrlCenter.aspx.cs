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
using System.Net.Mail;

namespace FGA_PLATFORM.business.production
{
    public partial class EDICtrlCenter : System.Web.UI.Page
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
                    if (Convert.ToInt32(dst.Tables[0].Rows[i][0]) != 25 && Convert.ToInt32(dst.Tables[0].Rows[i][0]) != 30)
                        isLocked = "Yes";
                    else
                        isLocked = "No";
                }
            }
        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(String history, String fdate,String tdate)
        {
            
            string res = string.Empty;
            try
            {
                string sql = "";

                if (history == "1")
                {
                    sql = "SELECT * FROM [FGA_EDIOrder_List] WHERE [Ship_Date] >= cast('" + fdate + "' as datetime) and [Ship_Date] < DATEADD(DAY,1 ,cast('" + tdate + "' as datetime)) " +
                           " order by [Ship_Date],[MasterID],[JOB_SEQUENCE] ";
                }
                else
                {
                    sql = "SELECT * FROM [FGA_EDIOrder_List] WHERE isnull(rstatus,0) = 0 " +
                            " order by [Ship_Date],[MasterID],[JOB_SEQUENCE] ";
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
            string res = String.Empty;
            string errmstID = String.Empty;
            //按用户查看EDI的数据
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            List<string> sqllist = new List<string>();
            List<string> sqllist1 = new List<string>();

            List<EDIOrderListModel> listmodel = new List<EDIOrderListModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<EDIOrderListModel>>(data);

            Dictionary<String, int> Dic = new Dictionary<String, int>();

            //数据校验
            //MasterID不能为空.前端检验
            //获取PartNO是否在系统中维护ModuleCode,PartType。服务器校验
            string pn = "";
            for (int i = 0; i < listmodel.Count; i++)
            {
                string dkey = listmodel[i].MasterID + "@" + listmodel[i].Standard_Quantity;
                if (String.IsNullOrEmpty(listmodel[i].MasterID))
                {
                    res = "-1";
                    break;
                }
                else
                {
                    pn = pn + ',' + '\'' + listmodel[i].Part_NO + '\'';
                    if (Dic.ContainsKey(dkey))
                    {
                        Dic[dkey] = Dic[dkey] + listmodel[i].Quantity;
                    }
                    else
                        Dic.Add(dkey, listmodel[i].Quantity);
                }
            }

            //检验MasterID之和是否等于Standard Quantity
            foreach (string key in Dic.Keys)
            {
                string value = Dic[key].ToString();
                if (key.Substring(key.IndexOf("@")+1) != value)
                    errmstID = errmstID + key;
            }
            
            if (String.IsNullOrEmpty(res))
            {
                if (String.IsNullOrEmpty(errmstID))
                {
                    foreach (EDIOrderListModel pc in listmodel)
                    {
                        string sql = "insert into [FGA_EDIOrder_List] " +
                                        "([MasterID],[customer_name],[Customer_Address_Code],[Customer_Part_No],[Customer_Part_Revision],[part_no] " +
                                        ",[part_name],[Due_Date],[Ship_Date],[ORDER_NO],[Lot_No],[BATCH_NO],[EDI_Key],[EDI_Action] " +
                                        ",[EDI_Status],[Docname],[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[rstatus],[Creator],[CreateDate]) " +
                                        "values('" + pc.MasterID + "','" + pc.Customer_Name + "','" + pc.Customer_Address_Code + "','" + pc.Customer_Part_NO + "','" + pc.Customer_Part_Revision + "','" + pc.Part_NO + "'," +
                                        "'" + pc.Part_Name + "','" + pc.Due_Date + "','" + pc.Ship_Date + "','" + pc.Order_NO + "','" + pc.Lot_NO + "','" + pc.Batch_NO + "'," + pc.EDI_Key + "" +
                                        ",'" + pc.EDI_Action + "','" + pc.EDI_Status + "','" + pc.Docname + "'," + pc.Standard_Quantity + "," + pc.Quantity + "," + pc.Job_Sequence + ",0,'" + user + "',getdate())";

                        sqllist.Add(sql);
                    }

                    if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
                    {
                        SendMailUseGmail();
                        res = "1";
                    }
                    else
                        res = "0";
                }
                else
                    res = "-2";
            }

            return res;
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

        ///送邮件
        //08022018
        public static void SendMailUseGmail()
        {
            System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();
            //hxu@fuyaousa.com
            //xshen@fuyaousa.com
            msg.To.Add("hxu@fuyaousa.com");
            msg.CC.Add("xshen@fuyaousa.com,xwang6@fuyaousa.com");

            msg.From = new MailAddress("FGA_Platform@fuyaousa.com", "autoMail", System.Text.Encoding.UTF8);
            /* 上面3个参数分别是发件人地址（可以随便写），发件人姓名，编码*/
            msg.Subject = "Small Lot新导入订单，请确认！";//邮件标题   
            msg.SubjectEncoding = System.Text.Encoding.UTF8;//邮件标题编码   
            msg.Body = "Small lot数据已导入。该邮件系统发送，请勿回复！";//邮件内容   
            msg.BodyEncoding = System.Text.Encoding.UTF8;//邮件内容编码   
            msg.IsBodyHtml = false;//是否是HTML邮件   
            msg.Priority = MailPriority.High;//邮件优先级   
            SmtpClient client = new SmtpClient();
            client.Credentials = new System.Net.NetworkCredential("FGA_Platform@fuyaousa.com", "Fuyao123!");
            //上述写你的GMail邮箱和密码   
            client.Port = 587;//Gmail使用的端口   
            client.Host = "smtp.office365.com";
            client.EnableSsl = true;//经过ssl加密   
            object userState = msg;
            try
            {
                client.SendAsync(msg, userState);
            }
            catch (System.Net.Mail.SmtpException ex)
            {
            }
        }

        /// <summary>
        /// 页面初始化读取workcenter
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string MergeData()
        {
            string res = "0";
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string sql = "SELECT * FROM [FGA_EDIOrder_List] WHERE isnull(rstatus,0) = 0 " +
                         "order by [Ship_Date],[MasterID],[JOB_SEQUENCE] ";
            DataSet ds = new DataSet();
            ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                List<EDIOrderListModel> luw = new List<EDIOrderListModel>();
                int pcycle = 0;

                for (int i = 0; i < ds.Tables[0].Rows.Count; i = i + 1 + pcycle)
                {
                    EDIOrderListModel ERM = new EDIOrderListModel(ds.Tables[0].Rows[i]);
                    int count = ERM.Quantity;

                    pcycle = 0;
                    if (i + 1 < ds.Tables[0].Rows.Count)
                    {
                        for (int j = i + 1; j < ds.Tables[0].Rows.Count; j++)
                        {
                            EDIOrderListModel ERM_Next = new EDIOrderListModel(ds.Tables[0].Rows[j]);

                            if (ERM.MasterID == ERM_Next.MasterID)
                            {
                                if (ERM.Part_NO == ERM_Next.Part_NO)
                                {
                                    count = count + ERM_Next.Quantity;
                                    pcycle++;
                                    if (j + 1 == ds.Tables[0].Rows.Count)
                                    {
                                        ERM.Quantity = count;
                                        luw.Add(ERM);
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
                    else
                    {
                        ERM.Quantity = count;
                        luw.Add(ERM);
                    }
                }

                if (luw.Count > 0)
                {
                    List<String> sqllist = new List<String>();

                    foreach (EDIOrderListModel vo in luw)
                    {
                        string insertsql = "insert into [FGA_EDI_862_T]([customer_name],[Customer_Address_Code],[Customer_Part_Revision],[Customer_Part_No],[part_no],[part_name]" +
                                           ",[Due_Date],[Ship_Date],[ORDER_NO],[Lot_No],[BATCH_NO],[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[rstatus],[MasterID],[EDI_RowID],[IsConfirm],[Creator],[CreateDate])" +
                                           "values('Honda North America','" + vo.Customer_Address_Code + "','" + vo.Customer_Part_Revision + "','" + vo.Customer_Part_NO + "','" + vo.Part_NO + "'," +
                                           "'" + vo.Part_Name + "','" + vo.Due_Date + "','" + vo.Ship_Date + "','" + vo.Order_NO + "','" + vo.Lot_NO + "','" + vo.Batch_NO + "'," + vo.Standard_Quantity + "," +
                                           "" + vo.Quantity + ",'" + vo.Job_Sequence + "','0','" + vo.MasterID + "',NEXT VALUE FOR OEM_OrderKey_seq,0,'" + model.USERNAME + "',getdate())";

                        sqllist.Add(insertsql);
                    }

                    string sqlupdate = "update [FGA_EDI_862_T] SET [FGA_EDI_862_T].PartType = [SmallLot_PartType_T].[PartType] " +
                                       "FROM [FGA_EDI_862_T] ,[SmallLot_PartType_T] WHERE[FGA_EDI_862_T].Part_NO = [SmallLot_PartType_T].[PartNO] " +
                                       "AND ISNULL([FGA_EDI_862_T].PartType,'') = ''";

                    sqllist.Add(sqlupdate);
                    sqllist.Add("UPDATE [FGA_EDIOrder_List] set [rstatus] = 1,[UpdateDate] = getdate(),[UpdateBy] = '" + model.USERNAME + "' where isnull(rstatus,0) = 0");

                    if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
                        res = "1";
                }

            }


            return res;
            ////获取EDI数据,自动获取老逻辑(销售不需加工数据)
            //string sql = "SELECT * FROM [FGA_EDIOrder_List] WHERE isnull(rstatus,0) = 0 " +
            //             "order by Customer_Name,Ship_Date,SUBSTRING(Customer_Part_NO,1,7),BATCH_NO,Standard_Quantity,Job_Sequence ";

            //DataSet ds = new DataSet();
            //ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
            //if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            //{
            //    List<EDIOrderListModel> luw = new List<EDIOrderListModel>();
            //    int pcycle    = 0;
            //    int groupqty  = 0;
            //    int newQty    = 0;
            //    int sqty      = 0;
            //    bool newGroup = true;
            //    string mid = ""; 
            //    string pdate = DateTime.Now.Year.ToString().Substring(2, 2)
            //                   + (DateTime.Now.Month.ToString().Length == 1 ? "0" + DateTime.Now.Month.ToString() : DateTime.Now.Month.ToString())
            //                   + (DateTime.Now.Day.ToString().Length == 1 ? "0" + DateTime.Now.Day.ToString() : DateTime.Now.Day.ToString());

            //    for (int i = 0; i < ds.Tables[0].Rows.Count; i = i+1+pcycle) {
                    
            //        pcycle = 0;

            //        EDIOrderListModel ERM = new EDIOrderListModel(ds.Tables[0].Rows[i]);
            //        int count = ERM.Quantity;
            //        if (newQty != 0)
            //            count = ERM.Quantity = newQty;

            //        if (newGroup)
            //        {
            //            groupqty = 0;
            //            sqty     = ERM.Standard_Quantity;
            //            mid      = pdate + i;
            //        }

            //        if (i + 1 < ds.Tables[0].Rows.Count)
            //        {
            //            for (int j = i + 1; j < ds.Tables[0].Rows.Count; j++)
            //            {
            //                EDIOrderListModel ERM_Next = new EDIOrderListModel(ds.Tables[0].Rows[j]);
            //                if (ERM.Customer_Name == ERM_Next.Customer_Name && ERM.Ship_Date == ERM_Next.Ship_Date &&
            //                    ERM.Batch_NO == ERM_Next.Batch_NO && ERM.Standard_Quantity == ERM_Next.Standard_Quantity &&
            //                    ERM.Customer_Part_NO.Substring(0, 7) == ERM_Next.Customer_Part_NO.Substring(0, 7))
            //                {
            //                    if (ERM.Part_NO == ERM_Next.Part_NO)
            //                    {
            //                        //首先判断是否新组合
            //                        if (newGroup)
            //                        {
            //                            if (count + ERM_Next.Quantity < ERM_Next.Standard_Quantity)
            //                            {
            //                                count = count + ERM_Next.Quantity;
            //                                newGroup = false;
            //                                pcycle++;
            //                                newQty = 0;
            //                                continue;
            //                            }

            //                            if (count + ERM_Next.Quantity == ERM_Next.Standard_Quantity)
            //                            {
            //                                pcycle++;
            //                                newQty = 0;
            //                                break;
            //                            }
            //                            if (count + ERM_Next.Quantity > ERM_Next.Standard_Quantity)
            //                            {
            //                                count = count + ERM_Next.Quantity - ERM_Next.Standard_Quantity;
            //                                newGroup = false;
            //                                newQty = 0;
            //                                pcycle++;
            //                            }
            //                        }
            //                        else
            //                        {
            //                            if (groupqty + count > sqty)
            //                            {
            //                                ERM.Quantity = sqty - groupqty;
            //                                newQty = count - (sqty - groupqty);
            //                                ERM.MasterID = mid;
            //                                luw.Add(ERM);
            //                                pcycle--;
            //                                newGroup = true;
            //                                break;
            //                            }
            //                            else
            //                            {
            //                                if (groupqty + count == sqty)
            //                                {
            //                                    ERM.Quantity = count;
            //                                    ERM.MasterID = mid;
            //                                    groupqty = groupqty + count;
            //                                    newGroup = true;
            //                                    luw.Add(ERM);
            //                                    pcycle++;
            //                                    newQty = 0;
            //                                    break;
            //                                }
            //                                else
            //                                {
            //                                    count = count + ERM_Next.Quantity;
            //                                    newGroup = false;
            //                                    pcycle++;
            //                                    newQty = 0;
            //                                    continue;
            //                                }
            //                            }
            //                        }
            //                    }
            //                    else
            //                    {
            //                        ERM.Quantity = count;
            //                        ERM.MasterID = mid;
            //                        groupqty = groupqty + count;

            //                        if(groupqty != sqty)
            //                            newGroup = false;
            //                        else
            //                            newGroup = true;

            //                        luw.Add(ERM);
            //                        newQty = 0;
            //                        break;
            //                    }
            //                }
            //                else
            //                {
            //                    ERM.Quantity = count;
            //                    ERM.MasterID = mid;
            //                    groupqty = groupqty + count;

            //                    if (groupqty != sqty)
            //                        newGroup = false;
            //                    else
            //                        newGroup = true;

            //                    luw.Add(ERM);
            //                    newQty = 0;
            //                    break;
            //                }
            //            }
            //        }
            //        else {
            //            ERM.Quantity = count;
            //            ERM.MasterID = mid;
            //            luw.Add(ERM);
            //            newQty = 0;
            //        }
            //    }

            //    if (luw.Count > 0)
            //    {
            //        List<String> sqllist = new List<String>();
            //        string delsql = "delete from [FGA_EDI_862_T] WHERE 1=2";
            //        sqllist.Add(delsql);

            //        foreach (EDIOrderListModel vo in luw) {
            //            string insertsql = "insert into [FGA_EDI_862_T]([customer_name],[Customer_Address_Code],[Customer_Part_Revision],[Customer_Part_No],[part_no],[part_name]" +
            //                               ",[Due_Date],[Ship_Date],[ORDER_NO],[Lot_No],[BATCH_NO],[Standard_Quantity],[Quantity],[JOB_SEQUENCE],[rstatus],[MasterID],[EDI_RowID],[Creator],[CreateDate])" +
            //                               "values('Honda North America','" + vo.Customer_Address_Code+ "','"+vo.Customer_Part_Revision+"','" + vo.Customer_Part_NO + "','" + vo.Part_NO + "'," +
            //                               "'"+ vo.Part_Name + "','" + vo.Due_Date + "','" + vo.Ship_Date + "','"+vo.Order_NO+"','" + vo.Lot_NO + "','" + vo.Batch_NO + "',"+vo.Standard_Quantity+"," +
            //                               ""+vo.Quantity+",'"+vo.Job_Sequence+"','0','"+vo.MasterID+ "',NEXT VALUE FOR OEM_OrderKey_seq,'"+ model.USERNAME + "',getdate())";

            //            sqllist.Add(insertsql);
            //        }
            //        sqllist.Add("DELETE FROM FGA_EDI_862_T WHERE Standard_Quantity = Quantity");

            //        string sqlupdate = "update [FGA_EDI_862_T] SET [FGA_EDI_862_T].PartType = [SmallLot_PartType_T].[PartType] " +
            //                           "FROM [FGA_EDI_862_T] ,[SmallLot_PartType_T] WHERE[FGA_EDI_862_T].Part_NO = [SmallLot_PartType_T].[PartNO] " +
            //                           "AND ISNULL([FGA_EDI_862_T].PartType,'') = ''";

            //        sqllist.Add(sqlupdate);
            //        sqllist.Add("UPDATE [FGA_EDIOrder_List] set [rstatus] = 1,[UpdateDate] = getdate(),[UpdateBy] = '"+ model.USERNAME+ "' where isnull(rstatus,0) = 0");
                     

            //        FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist);
            //    }
            //}

            //return res;
        }
    }
}