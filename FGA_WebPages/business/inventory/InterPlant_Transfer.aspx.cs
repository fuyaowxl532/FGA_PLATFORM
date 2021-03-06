﻿using System;
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

namespace FGA_PLATFORM.business.inventory
{
    public partial class InterPlant_Transfer : System.Web.UI.Page
    {
        protected string role = "";
        protected string pusername = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            pusername = model.USERNAME;
            string sql = "SELECT rid FROM userroles where uid = (select userid from userinfo where username ='" + model.USERNAME + "')";
            DataSet dst = new DataSet();
            dst = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
            if (dst != null && dst.Tables.Count > 0 && dst.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dst.Tables[0].Rows.Count; i++)
                {
                    if (Convert.ToInt32(dst.Tables[0].Rows[i][0]) == 28)
                        role = "FGAMaterialMag";
                    if (Convert.ToInt32(dst.Tables[0].Rows[i][0]) == 29)
                        role = "FGAMaterialReceiver";
                }
            }
        }

        /// <summary>
        /// 界面查询
        /// add by it-wxl 05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string transferNO, string status, string fdate, string tdate, string roler)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string puser = model.USERNAME;

            string res = string.Empty;
            try
            {
                string sql = "SELECT [TransferNO],[Factory],[Transtatus],[Creator],[CreateDate],[T_Location],[Receiver],[ReceptionDate]" +
                             "FROM [WMS_BarCode_V10].[dbo].[InterPlantTransfer_H] where 1=1 and isnull(dr,'0') = '0' ";

                if (!"administrator".Equals(puser) && !"FGAMaterialMag".Equals(roler))
                    sql = sql + " and T_Location IN (SELECT [Location] FROM [IPTransfer_Receiver_t] WHERE [Receiver] ='" + puser + "')";

                if (!"All".Equals(status))
                    sql = sql + " and [Transtatus] like  '" + status + "'";

                if (!String.IsNullOrEmpty(transferNO))
                    sql = sql + " and [TransferNO] like  '" + transferNO + "'";

                if (!String.IsNullOrEmpty(fdate))
                    sql = sql + " and [CreateDate] >= cast('" + fdate + "' as datetime)";
                if (!String.IsNullOrEmpty(tdate))
                    sql = sql + " and [CreateDate] <= cast('" + tdate + "' as datetime)";


                sql = sql + " order by [CreateDate] desc,[TransferNO] desc";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<InterPlantTransferModel> luw = new List<InterPlantTransferModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        InterPlantTransferModel ERM = new InterPlantTransferModel(row);
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
        /// 获取发料明细
        /// add by it-wxl 05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getDetail(string transferNO)
        {

            string res = string.Empty;
            try
            {
                string sql = "SELECT [SerialNO],[PartNO],[F_Location],[Quantity] FROM [WMS_BarCode_V10].[dbo].[IPTransfer_Detail_t] where [TransferNO] = '" + transferNO + "' and isnull(dr,'0') = '0' order by [SerialNO]";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<InterPlantTransferModel> luw = new List<InterPlantTransferModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        InterPlantTransferModel ERM = new InterPlantTransferModel(row);
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
        /// 确认接收
        /// add by it-wxl 05/31/2018
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string onActionReceive(string transferNO, string location)
        {
            string res = "";
            int count = 0;
            string msg = "";
            string plexid = "2786442";
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            string sql = "select plexid from userinfo where username = '" + puser + "'";
            DataSet ds2 = new DataSet();
            ds2 = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
            if (ds2 != null && ds2.Tables.Count > 0 && ds2.Tables[0].Rows.Count > 0)
            {
                plexid = ds2.Tables[0].Rows[0][0].ToString();
            }

            try
            {
                string sqlinfos = "SELECT [SerialNO] FROM [WMS_BarCode_V10].[dbo].[IPTransfer_Detail_t] where [TransferNO] = '" + transferNO + "' and isnull(dr,'0') = 0 ";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sqlinfos);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<InterPlantTransferModel> luw = new List<InterPlantTransferModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        InterPlantTransferModel ERM = new InterPlantTransferModel(row);

                        FGA_NUtility.POL.ExecuteDataSourceResult da_rst = PlexHelper.PlexGetResult_4("27181", "Container_Update_Simple",
                        "@Serial_No", "@Location", "@Last_Action", "@Update_By", ERM.SerialNO, location, "Inter-Plant Transfer by scanner", plexid);

                        if (!da_rst.Error)
                            count++;
                        else
                            msg = msg + ERM.SerialNO + '\n';
                    }
                }

                if (!String.IsNullOrEmpty(msg))
                    res = "Finished: " + count + '\n' + "Follow SerialNO is unsuccessful: " + '\n' + msg;
                else
                {
                    res = "Finished: " + count;
                    //更改CycleInventory_H状态
                    string synsql = "update [InterPlantTransfer_H] set [Transtatus] = 'Completed',[Receiver] ='" + puser + "',[ReceptionDate] = getdate() where [TransferNO] = '" + transferNO + "'";
                    FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(synsql);
                }

            }
            catch (Exception e)
            {

            }

            return res;
        }

        /// <summary>
        /// remove record
        /// add by it-wxl 06/05/2018
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string removePart(string transferNO, string serialNO)
        {
            string res = "";
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

            string sql = "update [IPTransfer_Detail_t] set dr ='1',UpdateBy = '" + puser + "',UpdateDate = getdate() where TransferNO ='" + transferNO + "' AND SerialNO ='" + serialNO + "'";
            int m = FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql);

            if (m == 0)
                res = "Error";

            return res;

        }

        /// <summary>
        /// remove record
        /// add by it-wxl 06/05/2018
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string onCancel(string transferNO)
        {
            string res = "";
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

            string sql = "update [InterPlantTransfer_H] set Transtatus = 'Cancel' where TransferNO ='" + transferNO + "'";
            int m = FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql);

            if (m == 0)
                res = "Error";

            return res;

        }

        /// <summary>
        /// remove record
        /// add by it-wxl 06/05/2018
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string onReject(string transferNO)
        {
            string res = "";
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

            string sql = "update [InterPlantTransfer_H] set Transtatus = 'Reject' where TransferNO ='" + transferNO + "'";
            int m = FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql);

            if (m == 0)
                res = "Error";

            return res;

        }

    }
}