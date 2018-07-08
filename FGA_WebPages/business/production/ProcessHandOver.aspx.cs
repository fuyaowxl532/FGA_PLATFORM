using System;
using System.Collections;
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
    public partial class ProcessHandOver : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 页面初始化
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string InitPage(string data)
        {
            string res = string.Empty;
            try
            {
                //获取序列号
                string SEQ = "";
                string SEQ_sql = "select next value for honda_sequence_seq as HS ";
                DataSet ds_seq = new DataSet();
                ds_seq = FGA_DAL.Base.SQLServerHelper_FGA.Query(SEQ_sql);
                if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
                {
                    SEQ = "PHO" + ds_seq.Tables[0].Rows[0][0].ToString();
                }


                UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
                string sql = "SELECT DISTINCT UC.[ORGANIZATION],UC.[USERNAME],UC.[OPERATION],FPT.[TLOC] AS [WorkCenter]" +
                             " FROM [FGA_PLATFORM].[dbo].[UserCtrl] UC LEFT JOIN [FGA_PARTTRANSFER_T] FPT ON UC.OPERATION = FPT.OPERATION where UC.USERNAME = '{0}' AND UC.TRANSACTIONTYPE = '{1}' and UC.UTYPE = '01'";
                sql = string.Format(sql, model.USERNAME, data);
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<HandOverHead> luw = new List<HandOverHead>();
                    HandOverHead HOH = new HandOverHead();

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                      userctrlModel UM =  new userctrlModel(row);

                        HOH.ORGANIZATION = UM.ORGANIZATION;
                        HOH.OPERATION    = UM.OPERATION;
                        HOH.BATCHNO      = SEQ;
                        HOH.WORKCENTER   = UM.WORKCENTER;
                        luw.Add(HOH);
                    }

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(luw);
                }
            }
            catch (Exception e)
            {

            }
            return res;
        }

        /// <summary>
        /// 获取序列号
        /// </summary>
        /// <returns></returns>
        /// 
        [WebMethod]
        public static string GetSequence()
        {
            string SEQ = string.Empty;
            try
            {
                //获取序列号
                string SEQ_sql = "select next value for honda_sequence_seq as HS ";
                DataSet ds_seq = new DataSet();
                ds_seq = FGA_DAL.Base.SQLServerHelper_FGA.Query(SEQ_sql);
                if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
                {
                    SEQ = "PHO" + ds_seq.Tables[0].Rows[0][0].ToString();
                }
            }
            catch (Exception e)
            {

            }
            return SEQ;
        }

        /// <summary>
        /// 从PLEX中获取DA的信息
        /// return:0  In Progress cant't Move
        /// return:1  Operation error can't Move
        /// return:2  Location error can't Move
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string GetDAContainer(string data,string opt,string trans,string org)
        {
            string res = string.Empty;
            try
            {
                //验证当前DA是否可以交接\退片
                string sql = "SELECT * FROM [FGA_PLATFORM].[dbo].[ProcessHOAudit_T] where SerialNO = '" + data + "' and OperationNo = '"+ opt + "' and ContainerStatus = 'In Progress'";
                DataSet ds_seq = new DataSet();
                ds_seq = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
                {
                    res = "0";
                }
                else
                {
                    //获取交接的From库位
                    Hashtable ht = new Hashtable();

                    string sql_floc = "SELECT [FLOC] FROM [FGA_PLATFORM].[dbo].[FGA_PARTTRANSFER_T] where OPERATION = '" + opt + "' and TRANSACTIONTYPE = '" + trans + "' and ORGANIZATION = '" + org + "'";
                    DataSet ds_floc = new DataSet();
                    ds_floc = FGA_DAL.Base.SQLServerHelper.Query(sql_floc);
                    if (ds_floc != null && ds_floc.Tables.Count > 0 && ds_floc.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds_floc.Tables[0].Rows.Count; i++)
                        {
                            ht.Add(ds_floc.Tables[0].Rows[i][0], i);
                        }
                    }

                    //获取当前操作的From库存
                    List<PlexContainer> luw = new List<PlexContainer>();
                    PlexContainer PC = new PlexContainer();

                    if (data != "" && data != null)
                    {
                        //从plex中获取DA的信息
                        FGA_NUtility.POL.ExecuteDataSourceResult rst = PlexHelper.PlexGetResult_1("7836", "Containers_By_Part_Get",
                            "@Serial_No", data);

                        PC.SerialNO = data;
                        PC.PartNO = rst.ResultSets[0].Rows[0].Columns[3].Value;
                        PC.OperationNo = rst.ResultSets[0].Rows[0].Columns[7].Value;
                        PC.Quantity = decimal.Parse(rst.ResultSets[0].Rows[0].Columns[15].Value);
                        PC.Location = rst.ResultSets[0].Rows[0].Columns[17].Value;
                        PC.ContainerStatus = rst.ResultSets[0].Rows[0].Columns[19].Value;

                        if (PC.OperationNo.Equals(opt))
                        {
                            if (ht.Contains(PC.Location))
                            {
                                luw.Add(PC);

                                JavaScriptSerializer jssl = new JavaScriptSerializer();
                                res = jssl.Serialize(luw);
                            }
                            else
                                res = "2";
                        }
                        else
                            return "1";

                        
                    }
                }
               
            }
            catch (Exception e)
            {

            }
            return res;
        }

        /// <summary>
        /// 数据提交确认
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string transferToAudit(string data,string org,string transaction)
        {
            string errors = "";
            try
            {
                string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
                string plexid = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).PLEXID;

                PlexContainer model = new PlexContainer();
                List<PlexContainer> listmodel = new List<PlexContainer>();
                List<PlexContainer> listmodel_t = new List<PlexContainer>();
                JavaScriptSerializer jssl = new JavaScriptSerializer();
                listmodel = jssl.Deserialize<List<PlexContainer>>(data);
                List<string> sqllist = new List<string>();
                string sql1 = "";
                string sql2 = "";
              
                //首先做交接路线验证
                foreach (PlexContainer m in listmodel)
                {
                    //获取交接方式
                    string tt = "";
                    string sql_tt = "SELECT [TRANSFERTYPE] FROM [FGA_PARTTRANSFER_T] " +
                                    " where [OPERATION] = '" + m.OperationNo + "' and [FLOC] ='" + m.Location + "' and [TLOC] = '" + m.TLoc + "' ";
                    DataSet ds_seq = new DataSet();
                    ds_seq = FGA_DAL.Base.SQLServerHelper.Query(sql_tt);
                    if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
                    {
                        tt = ds_seq.Tables[0].Rows[0][0].ToString();
                        m.TransferType = tt;

                        listmodel_t.Add(m);
                    }

                    if (tt == "" || tt == null)
                    {
                        errors += "ROW: " + m.rn;
                    }

                }

                if (errors == "")
                {
                    foreach (PlexContainer m in listmodel_t)
                    {
                        if (m.TransferType == "Indirect")
                        {
                            //交接方式--Indirect
                            sql1 = "insert into ProcessHOAudit_T([Organization],[OperationNO],[TransactionType],[SerialNO],[PartNO],[From_LOC],[To_LOC],[Quantity] " +
                                            " ,[Creater],[Createdate],[ContainerStatus],[BatchNO]) values('" + org + "','" + m.OperationNo + "','" + transaction + "','{0}','{1}','{2}','{3}',{4},'{5}',getdate(),'In Progress','{6}') ";
                            sql1 = string.Format(sql1, m.SerialNO, m.PartNO, m.Location, m.TLoc, m.Quantity, puser, m.BatchNO);
                            sqllist.Add(sql1);
                        }
                        if (m.TransferType == "Direct")
                        {
                            bool rt = true;
                            FGA_NUtility.POL.ExecuteDataSourceResult esr = PlexHelper.PlexGetResult_4("27181", "Container_Update_Simple", "@Serial_No", "@Last_Action", "@Location", "@Update_By",
                            m.SerialNO, "Updated at Inventory Update Form", m.TLoc, plexid);

                            rt = esr.Error;
                            if (!rt)
                            {
                                sql2 = "insert into [ProcessHandOver_T]([SerialNO],[PartNO],[From_LOC],[To_LOC]  " +
                                        ",[Quantity],[Creater],[Createdate],[ContainerStatus], " +
                                        " [Receiver],[ReceptionDate],[BatchNO],[Operation],[Organization],[TransferType],[TransactionType])" +
                                        " values('" + m.SerialNO + "','" + m.PartNO + "','" + m.Location + "','" + m.TLoc + "'," + m.Quantity + ",'" + puser + "',getdate(),'Finish'," +
                                        " '" + puser + "',getdate(),'" + m.BatchNO + "','" + m.OperationNo + "','" + org + "','Direct','" + transaction + "') ";

                                sqllist.Add(sql2);
                            }
                        }
                    }

                    if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
                    {
                        return "1";
                    }
                }
                else
                    return errors;
            }
            catch
            { return errors; }

            return errors;
        }
    }
       
}