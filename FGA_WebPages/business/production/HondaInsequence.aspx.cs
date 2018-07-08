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
    public partial class HondaInsequence : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 从PLEX中获取DA的信息
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string GetDAContainer(string serialno, string loadid, string cpos)
        {
            string res = string.Empty;
            try
            {
                List<PlexContainer> luw = new List<PlexContainer>();
                PlexContainer PC = new PlexContainer();

                //从plex中获取DA的信息,判断DA号对应的编码是否与small lot相符合
                //编码一致,如果数量大于等于small lot数量
                //////(1)数量相等直接取该DA
                //////(2)数量大于small lot时进行自动split
                //编码一致，如果数量小于small lot数量则直接报错
                FGA_NUtility.POL.ExecuteDataSourceResult da_rst = PlexHelper.PlexGetResult_1("7836", "Containers_By_Part_Get",
                    "@Serial_No", serialno);

                string location = da_rst.ResultSets[0].Rows[0].Columns[17].Value;
                if (location.IndexOf("OT") < 0 && location.IndexOf("OL") < 0)
                {
                    PC.SerialNO = da_rst.ResultSets[0].Rows[0].Columns[10].Value;
                    PC.PartNO = da_rst.ResultSets[0].Rows[0].Columns[3].Value;
                    PC.Quantity = decimal.Parse(da_rst.ResultSets[0].Rows[0].Columns[15].Value);


                    //获取该loadid对应position产品的信息
                    //如果跟plex一致则继续，否则返回异常
                    string partno = "";
                    int qty = 0;
                    string sql = "SELECT PART_NO,QUANTITY FROM FGA_LOADDETAIL_T WHERE LOADID = '" + loadid + "' AND POSITION = " + cpos + "";

                    DataSet ds_seq = new DataSet();
                    ds_seq = FGA_DAL.Base.SQLServerHelper.Query(sql);
                    if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
                    {
                        partno = ds_seq.Tables[0].Rows[0][0].ToString();
                        qty = Convert.ToInt32(ds_seq.Tables[0].Rows[0][1].ToString());
                    }

                    if (partno.Equals(PC.PartNO))
                    {
                        if (PC.Quantity >= qty)
                        {
                            if (PC.Quantity == qty)
                            {
                                luw.Add(PC);
                                JavaScriptSerializer jssl = new JavaScriptSerializer();
                                res = jssl.Serialize(luw);
                            }
                            else
                            {
                                //自动split
                                FGA_NUtility.POL.ExecuteDataSourceResult result = PlexHelper.PlexGetResult_3("9920", "Container_Split_RF", "@Serial_No", "@Quantity", "@ModUser",
                                serialno, qty.ToString(), "2786442");
                                //从plex中获取split的DA信息
                                FGA_NUtility.POL.ExecuteDataSourceResult rst = PlexHelper.PlexGetResult_2("33468", "Containers_By_Last_Action_Today_Get",
                                 "@Last_Action", "@From_Container", "Split Container", serialno);

                                //获取当前split后最大的DA
                                int a = 0;
                                int b = 0;
                                int c = 0;

                                for (int i = 0; i < rst.ResultSets[0].RowCount; i++)
                                {
                                    a = Int32.Parse(rst.ResultSets[0].Rows[i].Columns[0].Value.Substring(1, 7));

                                    if (a > b)
                                    {
                                        b = a;
                                        c = i;
                                    }
                                }

                                PC.SerialNO = rst.ResultSets[0].Rows[c].Columns[0].Value;
                                PC.PartNO = rst.ResultSets[0].Rows[c].Columns[2].Value;
                                PC.Quantity = decimal.Parse(rst.ResultSets[0].Rows[c].Columns[6].Value);
                                luw.Add(PC);

                                JavaScriptSerializer jssl = new JavaScriptSerializer();
                                res = jssl.Serialize(luw);
                            }
                        }
                        else
                        {
                            res = "qty_error";
                        }
                    }
                }
                else
                {
                    res = "loc_error";
                }


            }
            catch (Exception e)
            {

            }
            return res;
        }

        /// <summary>
        /// 验证当前DA是否有效
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string ValidSerialNO(string serialno)
        {
            string res = string.Empty;
            try
            {
                string sql = "SELECT [SerialNO] FROM FGA_SL_DAHISTORY WHERE SERIALNO = '" + serialno + "'";

                DataSet ds_seq = new DataSet();
                ds_seq = FGA_DAL.Base.SQLServerHelper.Query(sql);
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
        /// 加载loadid时同时显示partlist
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string GetPartList(string loadid)
        {
            string res = string.Empty;
            try
            {
                string sql = "SELECT [LoadID],[PartNO],[Quantity],[CustomerPart] " +
                              " ,[JobSequence]  FROM [FGA_PLATFORM].[dbo].[FGA_LoadPart_T] where loadid = '" + loadid + "' order by jobsequence desc";
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<LoadPartList> luw = new List<LoadPartList>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        LoadPartList ERM = new LoadPartList(row);
                        luw.Add(ERM);
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
        /// 加载loadid验证是否存在历史存档
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string GetLoadIDInfos(string loadid)
        {
            string res = string.Empty;
            try
            {
                string sql = "SELECT [LoadID],[SerialNO],[SerialNO_HIS],[CurrPosition],[TotalPos],[PartNO],[Rev],[Quantity] " +
                             " ,[CustomerName],[ShipTo],[LockFlag],[LockDesc],[LastUser],[LastEditTime] FROM [FGA_PLATFORM].[dbo].[FGA_SmallLot_T] where loadid = '" + loadid + "' order by LastEditTime desc";
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<SmalllotModel> luw = new List<SmalllotModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        SmalllotModel ERM = new SmalllotModel(row);
                        luw.Add(ERM);
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

        //从plex中获取产品label
        //传回当前系统用户
        //DA890749        ^XA^EG^XZ^XA^MCY^CI28^CF0^XZ^XA^FO480,8^GB0,1192,4^FS^FO256,8^GB0,1192,4^FS
        //^FO8,8^GB792,0,4^FS^FO8,8^GB0,1192,4^FS^FO800,8^GB0,1192,4^FS^FO8,1200^GB800,0,4^FS^FO120,8^GB0,1192,4^FS
        //^FO120,720^GB240,0,4^FS^FO352,720^GB132,0,4^FS^BY2.5,2.75,168^FO272,240^B3R,N,,N,N^FDDA890749^FS
        //^FO32,40^A0R,32,32^FDFuyao Glass America Inc. 2801 W Stroop RD Moraine,^FS
        //^FO640,40^A0R,32,40^FDPART NO^FS^FO520,184^A0R,288,136^FDDW01097 GBYFGA^FS^FO192,32^A0R,32,40^FDQUANTITY^FS
        //^FO104,480^A0R,176,176^FD33^FS^FO600,40^A0R,32,40^FD(P)^FS^FO400,40^A0R,32,40^FDSERIAL^FS^FO368,40^A0R,32,40^FD(S)^FS
        //^FO440,240^A0R,44,48^FDDA890749^FS^BY3,2.5,96^FO488,240^B3R,N,,N,N^FDDW01097 GBYFGA^FS^FO160,40^A0R,32,40^FD(Q)^FS
        //^BY3,3,120^FO128,240^B3R,N,,N,N^FD33^FS^FO192,744^A0R,32,40^FDWEIGHT^FS
        //^FO200,960^A0R,40,40^FD873^FS^BY3,3,72^FO128,920^B3R,N,,N,N^FD873^FS^FO56,40^A0R,64,64^FDMADE IN USA^FS
        //^FO32,720^A0R,32,40^FDOH 45439^FS^FO32,1032^A0R,32,40^FD02^FS^FO32,1096^A0R,32,40^FD15^FS^FO32,1152^A0R,32,40^FD17^FS
        //^FO32,1040^A0R,32,40^FD   /      /^FS^FO160,744^A0R,32,40^FD(W) (LBS)^FS^FO440,744^A0R,32,40^FDIv No.^FS
        //^FO72,680^A0R,40,40^FDFGA-INV..R.inventory 03^FS^FO360,736^A0R,24,24^FD^FS^PQ2^XZ^XA^MCY^PON^LH0,0^XZ
        [WebMethod]
        public static string CreateDALabel(string serialno)
        {
            string label_zpl = "";
            string label_f = "";
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            //获取当前DA标签代码
            FGA_NUtility.POL.ExecuteDataSourceResult result = PlexHelper.PlexGetResult_3("1953", "Web Service Get Container Label", "@SerialNo", "@PLCName", "@IPAddress",
                       serialno, "Barcode", "172.17.190.44");

            if (result.OutputParameters != null)
                label_zpl = result.OutputParameters[2].Value;

            //获取剩余箱签代码
            FGA_NUtility.POL.ExecuteDataSourceResult rst = PlexHelper.PlexGetResult_2("33468", "Containers_By_Last_Action_Today_Get",
                "@Last_Action", "@Serial_No", "Split Container", serialno);

            if (rst.ResultSets != null)
            {
                //获取当前split最大的DA
                int a = 0;
                int b = 0;
                int c = 0;

                for (int i = 0; i < rst.ResultSets[0].RowCount; i++)
                {
                    a = Int32.Parse(rst.ResultSets[0].Rows[i].Columns[0].Value.Substring(1, 7));

                    if (a > b)
                    {
                        b = a;
                        c = i;
                    }
                }

                string fsn = rst.ResultSets[0].Rows[c].Columns[13].Value;

                if (!string.IsNullOrEmpty(fsn))
                {
                    FGA_NUtility.POL.ExecuteDataSourceResult rst2 = PlexHelper.PlexGetResult_3("1953", "Web Service Get Container Label", "@SerialNo", "@PLCName", "@IPAddress",
                         fsn, "Barcode", "172.17.190.44");

                    if (rst2.OutputParameters != null)
                        label_f = rst2.OutputParameters[2].Value;
                }
            }


            return "newsn" + label_zpl + "oldsn" + label_f + "username" + model.USERNAME;
        }

        //通过产品的modelcode获取partno
        [WebMethod]
        public static string GetPartNO(string modelcode, string shipto)
        {
            string partno = "";
            string sql = " SELECT PartNO FROM HONDAMODELCODE_T WHERE MODELCODE = '" + modelcode + "' and replace(SHIPTO,' ','') = replace('" + shipto + "',' ','') ";

            DataSet ds_seq = new DataSet();
            ds_seq = FGA_DAL.Base.SQLServerHelper.Query(sql);
            if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
            {
                partno = ds_seq.Tables[0].Rows[0][0].ToString();
            }

            return partno;
        }

        //加载当前position的客户版本及要货数量
        [WebMethod]
        public static string GetCustomerREV(string loadid, string pos)
        {
            string REV_QTY = "";
            string sql = " select customer_part_revision,quantity from fga_loaddetail_t where loadid = '" + loadid + "' and position = " + pos + " ";

            DataSet ds_seq = new DataSet();
            ds_seq = FGA_DAL.Base.SQLServerHelper.Query(sql);
            if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
            {
                REV_QTY = ds_seq.Tables[0].Rows[0][0].ToString() + "&" + ds_seq.Tables[0].Rows[0][1].ToString();
            }

            return REV_QTY;
        }

        //获取当前LoadID对应的lotno及batchno
        [WebMethod]
        public static string Get_LBNO(string loadid)
        {
            string lot_batch = "";
            string sql = " SELECT [Lot_No],[BATCH_NO] FROM [FGA_PLATFORM].[dbo].[FGA_LoadDetail_T]" +
                         " where loadid = '" + loadid + "' AND POSITION = 1";

            DataSet ds_seq = new DataSet();
            ds_seq = FGA_DAL.Base.SQLServerHelper.Query(sql);
            if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
            {
                lot_batch = ds_seq.Tables[0].Rows[0][0].ToString() + "&" + ds_seq.Tables[0].Rows[0][1].ToString();
            }

            //获取DA
            string sql1 = " select aa.loadid,aa.serialno,aa.cnt from (SELECT DISTINCT [LoadID],[SerialNO],COUNT(*) CNT FROM [FGA_PLATFORM].[dbo].[FGA_SmallLot_T] " +
                          " WHERE LOADID = '" + loadid + "' AND LOCKFLAG = 'N' GROUP BY [LoadID],[SerialNO] ) aa order by aa.cnt ";
            DataSet ds_seq1 = new DataSet();
            ds_seq1 = FGA_DAL.Base.SQLServerHelper.Query(sql1);
            if (ds_seq1 != null && ds_seq1.Tables.Count > 0 && ds_seq1.Tables[0].Rows.Count > 0)
            {
                lot_batch = lot_batch + "*" + ds_seq1.Tables[0].Rows[0][1].ToString();
            }

            return lot_batch;
        }

        //保存当前已打印的DA NUMBER
        [WebMethod]
        public static string SaveDALabel(string loadid, string serialno)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string sql = "insert into FGA_SL_DAHISTORY ([LoadID],[SerialNO],[CreateDate],[Creater])" +
                         "values ('{0}','{1}',getdate(),'{2}')";
            sql = string.Format(sql, loadid, serialno, model.USERNAME);

            FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql);

            return "1";
        }

        //保存当前扫描记录
        [WebMethod]
        public static string SaveScanRecord(string data)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];

            List<SmalllotModel> listmodel = new List<SmalllotModel>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<SmalllotModel>>(data);
            string sql = "";

            if (listmodel.Count > 0)
            {
                foreach (SmalllotModel lm in listmodel)
                {
                    string st = lm.ShipTo.Substring(lm.ShipTo.IndexOf("ShipTo:") + 7, lm.ShipTo.Length - lm.ShipTo.IndexOf("ShipTo:") - 7);
                    sql = "insert into FGA_SmallLot_T([LoadID],[SerialNO],[SerialNO_HIS],[CurrPosition],[TotalPos],[PartNO],[Rev],[Quantity]" +
                             ",[CustomerName],[ShipTo],[LockFlag],[LockDesc],[LastUser],[LastEditTime]) values('{0}','{1}','{2}',{3},{4},'{5}', " +
                             "'{6}',{7},'{8}','{9}','{10}','{11}','{12}',getdate())";
                    sql = string.Format(sql, lm.LoadID, lm.SerialNO, lm.SerialNO_HIS, lm.CurrPosition, lm.TotalPos, lm.PartNO, lm.Rev, lm.Quantity,
                        lm.CustomerName, st, lm.LockFlag, lm.LockDesc, model.USERNAME);
                }
            }


            if (FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql) > 0)
                return "1";
            else
                return "0";

        }

        //修改EDI_LOAD完成标志
        [WebMethod]
        public static string UpdateLoadStatus(string loadid)
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string sql = "update [FGA_EDI_LOAD_T] set slstatus = '1',LoadStatus = 'Completed',createdate = getdate(),creater = '" + model.USERNAME + "' where loadid = '" + loadid + "'";

            FGA_DAL.Base.SQLServerHelper.ExecuteSql(sql);

            return "1";
        }

        //获取当前用户名
        [WebMethod]
        public static string getUsername()
        {
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string user = model.USERNAME;

            return user;
        }

        //获取master label上面的DA号
        [WebMethod]
        public static string GetMasterDA(string loadid)
        {
            //获取DA
            string sn = "";
            string sql = "SELECT DISTINCT [LoadID],[SerialNO],COUNT(*) CNT FROM [FGA_SmallLot_T]  " +
                         "WHERE LOADID = '" + loadid + "' AND LOCKFLAG = 'N' GROUP BY [LoadID],[SerialNO] ORDER BY CNT";
            DataSet ds_seq = new DataSet();
            ds_seq = FGA_DAL.Base.SQLServerHelper.Query(sql);
            if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
            {
                sn = ds_seq.Tables[0].Rows[0][1].ToString();
            }

            return sn;
        }
    }
}