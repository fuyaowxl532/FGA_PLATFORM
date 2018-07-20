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
    public partial class Arg_CrateLabel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 界面查询
        /// add by it-wxl 05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string pncode)
        {
            
            string res = string.Empty;
            try
            {
                string sql = "SELECT SD.[ItemID],SD.[ShipmentNO],SD.[InvoiceNO],SD.[ItemCode],SD.[LabelNO] " +
                             " , UPPER(SD.[BoxType]) AS [BoxType],SD.[BoxNO],UPPER(SD.[BoxMethod]) AS [BoxMethod],SD.[InboundQuantity],SD.[ShipmentDate],ISNULL(ABT.BarcodeNO,'') AS BarcodeNO, " +
                             " ISNULL(APT.Location,'') as Location,ABT.[FinishQty] AS Quantity,ABT.[Creator],ABT.[CreateDate],ISNULL(ABT.[BoxStatus],'') AS BoxStatus,ABT.[Updator],ABT.[UpdateDate] " +
                             " FROM [ShipmentDetail] SD left join [ARGBoxLabel_T] ABT on SD.ItemID = ABT.ItemID and len(ABT.Barcodeno) > 7 left join ARGPartialBox_T APT on ABT.BarcodeNO = APT.BarcodeNO and isnull(APT.dr,0) =0 " +
                             " WHERE  ((SD.OrderStatus<> 'OrderCancel' and upper(SD.BoxType) <> 'BOX' and isnull(SD.BoxMethod,'N') = 'N' and ISNULL(SD.ChangedNumber,'') =''  and not exists " +
                             " (select 1 from ARGBoxLabel_T att where att.itemid = sd.itemid)) or (exists (select 1 from  ARGBoxLabel_T att left join ARGPartialBox_T apt on att.barcodeno = apt.barcodeno " +
                             " and isnull(apt.dr,'1') = '0'  where att.itemid = sd.itemid and att.location <> 'T4' and len(att.barcodeno) > 7 ) ))";

            
                if (!String.IsNullOrEmpty(pncode))
                    sql = sql + " and SD.[ItemCode] like  '%" + pncode + "%'";



                sql = sql + " order by SD.[ShipmentDate] asc,APT.[BoxStatus] desc,SD.[BoxType]";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<ProductLabelModel> luw = new List<ProductLabelModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ProductLabelModel ERM = new ProductLabelModel(row);
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
        /// 半箱界面查询
        /// add by it-wxl 05/04/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchPartialData(string pncode)
        {
            string res = string.Empty;
            try
            {
                string sql = "SELECT [BarcodeNO],[PartNO],[BoxType],[OrderQty],[Quantity] " +
                             ",[Creator],[CreateDate],[BoxStatus],[Location] " +
                             " FROM [WMS_BarCode_V10].[dbo].[ARGPartialBox_T] where isnull(dr,0) = 0 and len(barcodeno) > 7 and [Location] not like '%T%' ";

                //查询条件
               
                if (!String.IsNullOrEmpty(pncode))
                    sql = sql + " and [PartNO] like  '%" + pncode + "%' ";
                sql = sql + " order by CreateDate DESC";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<BarcodeHelperModel> luw = new List<BarcodeHelperModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        BarcodeHelperModel ERM = new BarcodeHelperModel(row);
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

        //获取用户权限
        [WebMethod]
        public static string getRoleInfos()
        {
            string urole = "";
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            if ("administrator".Equals(model.USERNAME))
            {
                urole = "ARGPackagingMag";
            }
            else
            {
                string rsql = "SELECT [rname] FROM [FGA_PLATFORM].[dbo].[roles] where rid = " + model.Roles[0].rid + "";
                DataSet dss = new DataSet();
                dss = FGA_DAL.Base.SQLServerHelper_FGA.Query(rsql);
                if (dss != null && dss.Tables.Count > 0 && dss.Tables[0].Rows.Count > 0)
                {
                    urole = dss.Tables[0].Rows[0][0].ToString();
                }
            }

                return urole;
        }


        /// <summary>
        /// 获取产品属性信息
        /// 箱高、垫片规格、包角、底座编码
        /// add by it-wxl 07/27/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getPartInfos(string pncode,string pnum)
        {
            string res    = string.Empty;
            int bhight    = 0;
            int grasket   = 0;
            string baseno = string.Empty;
            string corner = string.Empty;
            bool shigh    = false;
            bool sgresket = false;
            decimal width = 0;
            string brack = "";

            try
            {
                //获取玻璃宽度
                string sqlwidth = "SELECT value FROM [PlexDB].[dbo].[Part_v_Part_Attribute] WHERE Attribute_Key = 6104 " +
                                "AND PART_KEY = (SELECT PART_KEY FROM [PlexDB].[dbo].[PART_V_PART] WHERE Part_No = '" + pncode.Trim() + "') ";

                DataSet ds1 = new DataSet();
                ds1 = FGA_DAL.Base.SQLServerHelper_Plex.Query(sqlwidth);
                if (ds1 != null && ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0)
                     width = Convert.ToDecimal(ds1.Tables[0].Rows[0][0].ToString());

                //宽度小于710
                //宽段小于等于900   Xiuping Chen 20180129
                if (width <=850)
                    brack = "Rack-B";

                //特殊箱高、垫片规格
                string ssql = "SELECT [PartNO],[Value],[Ptype] FROM [FGA_PLATFORM].[dbo].[ARG_SpecialPara] where partno = '"+ pncode.Trim()+ "'";
                DataSet dss = new DataSet();
                dss = FGA_DAL.Base.SQLServerHelper_FGA.Query(ssql);
                if (dss != null && dss.Tables.Count > 0 && dss.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < dss.Tables[0].Rows.Count; i++)
                    {
                        if ("High".Equals(dss.Tables[0].Rows[i][2].ToString()))
                        {
                            bhight = Convert.ToInt32(dss.Tables[0].Rows[i][1].ToString());
                            shigh = true;
                        }
                           
                        if ("Thick".Equals(dss.Tables[0].Rows[i][2].ToString()))
                        {
                            grasket = Convert.ToInt32(dss.Tables[0].Rows[i][1].ToString());
                            sgresket = true;
                        }
                    }
                }
                if (!shigh)
                {
                    //箱高,按照玻璃宽度计算箱高
                    //<=970   1190
                    //>970 <=1120   1340
                    //>1120  1450
                    if (width <= 970)
                        bhight = 1190;
                    if (width > 970 && width <= 1120)
                        bhight = 1340;
                    if (width > 1120)
                        bhight = 1450;
                }
                
                if(!sgresket)
                    //垫片规格
                    grasket = getGrasket(Convert.ToInt32(pnum));


                //获取包角模式
                string sql = "SELECT [CornerType] FROM [FGA_PLATFORM].[dbo].[ARG_part_box_attribute] where PartNO = '"+ pncode.Trim() + "'" ;

                DataSet ds2 = new DataSet();
                ds2 = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
                if (ds2 != null && ds2.Tables.Count > 0 && ds2.Tables[0].Rows.Count > 0)
                {
                    corner = ds2.Tables[0].Rows[0][0].ToString();
                }

                //获取底座编码
                string sql_base = "SELECT pp.Part_No FROM [PlexDB].[dbo].[Part_v_BOM] pb left join[Part_v_Part_Operation] ppo on pb.Part_Key = ppo.Part_Key "+
                                "and pb.Part_Operation_Key = ppo.Part_Operation_Key "+
                                "left join Part_v_part pp on pb.Component_Part_Key = pp.Part_Key "+
                                "where pb.part_key = (select part_key from part_v_part where part_no = '"+ pncode.Trim() + "') "+
                                "and ppo.Operation_No = '1300' and pp.Part_No like 'BO%' ";
                DataSet ds3 = new DataSet();
                ds3 = FGA_DAL.Base.SQLServerHelper_Plex.Query(sql_base);
                if (ds3 != null && ds3.Tables.Count > 0 && ds3.Tables[0].Rows.Count > 0)
                {
                    baseno = ds3.Tables[0].Rows[0][0].ToString();
                }

            }
            catch (Exception e)
            {

            }

            return "high"+ bhight + "gasket"+ grasket + "corner"+ corner + "base"+ baseno +"brack" + brack;
        }

        /// <summary>
        /// 获取产品附件信息
        /// add by it-wxl 07/27/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getPartAcc(string pncode)
        {
            
            string res = string.Empty;
            try
            {
                string sql = "SELECT pp.Part_No as [Component_Part],pp.Part_Type as [Component_Type] " +
                             "FROM[PlexDB].[dbo].[Part_v_BOM] pb left join[PlexDB].[dbo].[Part_v_Part_Operation] ppo on pb.Part_Key = ppo.Part_Key " +
                             "and pb.Part_Operation_Key = ppo.Part_Operation_Key " +
                             "left join[PlexDB].[dbo].[Part_v_part] pp on pb.Component_Part_Key = pp.Part_Key " +
                             "where pb.part_key = (select part_key from[PlexDB].[dbo].[part_v_part] " +
                             "where part_no = '"+ pncode.Trim()+ "')  and pp.Part_No not like 'BH%' and pp.Part_NO not like 'BU%'" +
                             "and(ppo.Operation_No = '1500' or ppo.Operation_No = '1400') ";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_Plex.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<ARG_BoxLabelModel> luw = new List<ARG_BoxLabelModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ARG_BoxLabelModel ERM = new ARG_BoxLabelModel(row);
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
        /// 获取产品包边模式
        /// add by it-wxl 07/27/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getPartEdge(string pncode)
        {
            string res = string.Empty;
            try
            {
                string sql = "SELECT [PartNO],[EdgeType] FROM [FGA_PLATFORM].[dbo].[ARG_part_edgetype] WHERE PartNO ='"+ pncode.Trim() + "'";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<ARG_BoxLabelModel> luw = new List<ARG_BoxLabelModel>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ARG_BoxLabelModel ERM = new ARG_BoxLabelModel(row);
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
        /// 获取本箱条码号
        /// add by it-wxl 07/28/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getBoxLabel(string itemid,string invoiceno,string pncode,string orderqty, string finqty)
        {
            string barcode = null;
            string res = "";
            string user = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
            //获取当前日期
            DateTime dt = DateTime.Now;
            string boxs = "";
            string loc = "";

            try
            {
                ////判断是否重复打印
                //string sqlE = "select BarcodeNO FROM [ARGBoxLabel_T] where itemid = '" + itemid.Trim() + "'";
                //DataSet ds = new DataSet();
                //ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sqlE);
                //if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                //{
                //    res = ds.Tables[0].Rows[0][0].ToString();
                //    //打印箱签，更新打印信息(打印人、打印时间、打印次数) 
                //    //string uptsql = "update [ShipmentDetail] set [BoxLabelCount] = [BoxLabelCount] + 1 ,[BLCreator] = '" + user + "',[BLCreateDate] = getdate() where [ItemID] = '" + itemid.Trim() + "' ";
                //    //FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(uptsql);
                //}
                //else

                //判断箱牌打印顺序
                //相同品种，正式单优于库存单，交付日期3天内的可以打
                string cb = checkBoxLabel(itemid,invoiceno, pncode);
                if (cb == "0")
                {
                    int seqnum = 0;
                    string year = dt.Year.ToString().Substring(2, 2);
                    string month = dt.Month.ToString().Length > 1 ? dt.Month.ToString() : "0" + dt.Month.ToString();
                    string day = dt.Day.ToString().Length > 1 ? dt.Day.ToString() : "0" + dt.Day.ToString();

                    string seq = "select top 1 seqnum from TodayMaxNum where currdate = '" + dt.Date + "' order by seqnum desc";
                    DataSet ds1 = new DataSet();
                    ds1 = FGA_DAL.Base.SQLServerHelper_WMS.Query(seq);
                    if (ds1 != null && ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0)
                    {

                        seqnum = Convert.ToInt32(ds1.Tables[0].Rows[0][0].ToString());
                        if ((seqnum + 1) < 10)
                            barcode = year + month + day + "00" + (seqnum + 1);
                        if ((seqnum + 1) < 100 && (seqnum + 1) >= 10)
                            barcode = year + month + day + "0" + (seqnum + 1);
                        if ((seqnum + 1) >= 100)
                            barcode = year + month + day + (seqnum + 1);
                    }
                    else
                        barcode = year + month + day + "001";

                 

                    if (!String.IsNullOrEmpty(barcode))
                    {
                        //将获取的条码信息插入数据库
                        List<String> sqllist = new List<String>();

                        string insert1 = "insert into TodayMaxNum(currdate,seqnum) values('" + dt.Date + "'," + (seqnum + 1) + ")";

                        if (orderqty == finqty)
                        {
                            boxs = "Finish";
                            loc = "T3";
                        }

                        else
                        {
                            boxs = "Partial";
                            loc = "T2";
                        }

                        string insert2 = "insert into [ARGBoxLabel_T]([ItemID],[BarcodeNO],[OrderQty],[FinishQty],[BoxStatus],[Location],[PrtCount],[Creator],[CreateDate]) " +
                                      "values('" + itemid.Trim() + "','" + barcode + "'," + orderqty + "," + finqty + ",'" + boxs + "','" + loc + "',1,'" + user + "',getdate())";

                        sqllist.Add(insert1);
                        sqllist.Add(insert2);

                        FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist);

                        res = barcode;
                    }
                }
                else
                    res = cb;
            }
            catch (Exception e)
            {

            }
            return "code"+ res + "username"+ user + "cdate"+ dt.ToString();
        }

        /// <summary>
        ///PartialBox Update
        /// add by it-wxl 09/05/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string setPartialBoxLabel(string itemid, int orderqty, int finqty)
        {
            int count = 0;
            string boxs = "";
            //获取当前日期
            DateTime dt = DateTime.Now;
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

            if (orderqty == finqty)
                boxs = "Finish";
            else
                boxs = "Partial";

            string sql = "update [ARGBoxLabel_T] set OrderQty = "+ orderqty + ",FinishQty = "+ finqty + ",BoxStatus = '"+ boxs + "',Updator = '"+ puser + "',UpdateDate = getdate(),PrtCount = PrtCount+1 " +
                         " where itemid = '"+ itemid + "'";

            count = FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSql(sql);

            return "code" + count + "username" + puser + "cdate" + dt.ToString();
        }

        /// <summary>
        ///AutoRefrsh Page
        /// add by it-wxl 09/14/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string autoRefresh()
        {
            string rst = "";
            string sql = "SELECT count(*) as ct FROM [WMS_BarCode_V10].[dbo].[ARGBoxLabel_T]";
            DataSet ds1 = new DataSet();

            ds1 = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds1 != null && ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0)
                rst = ds1.Tables[0].Rows[0][0].ToString();


            return rst;
        }

        /// <summary>
        ///取消箱牌
        /// add by it-wxl 09/13/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string cancelBoxLabel(string itemid)
        {
            int count = 0;
            string rst = "";
            List<String> sqllist = new List<String>();
            //获取当前日期
            DateTime dt = DateTime.Now;
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

            string sql1 = "update [ARGPartialBox_T] set dr = 1 where barcodeno in (select barcodeno from [ARGBoxLabel_T] where itemid = '"+ itemid + "')";

            string sql2 = "delete from ARGBoxLabel_T where itemid = '"+itemid+"' ";

            sqllist.Add(sql1);
            sqllist.Add(sql2);

            count = FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist);

            if (count > 0)
                rst = "0";
            else
                rst = "1";

            return rst;

        }

        public static string checkBoxLabel(string itemid,string invoiceno,string pncode) {

            string rez = "0";

            //rez各参数含义
            //0:可创建箱牌
            //1:存在正式单没有打箱牌
            //2:控制日期内还存在箱牌未打印

            //如果当前是库存单，首先判断有没有正式单存在
            if (invoiceno.ToUpper().IndexOf("INV") > 0)
            {
                string sql1 = "select sd.ITEMID from ShipmentDetail sd where  SD.OrderStatus<> 'OrderCancel' and upper(SD.BoxType) <> 'BOX' and isnull(SD.BoxMethod,'N') = 'N' and ISNULL(SD.ChangedNumber,'') ='' " +
                              " and sd.itemcode = '"+ pncode + "' and sd.InvoiceNO like 'FGA%' and not exists (select 1 from ARGBoxLabel_T abt " +
                              " where abt.itemid = sd.itemid)";
                DataSet ds1 = new DataSet();
                ds1 = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql1);
                if (ds1 != null && ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0)
                    rez = "1";
            }
            else {
                //当前订单超过规定日期
                //系统中当前品种
                string sql2 = "select * from ShipmentDetail sd where  sd.itemcode = '" + pncode + "'  " +
                              "and sd.OrderStatus<> 'OrderCancel' and upper(sd.BoxType) <> 'BOX' and isnull(sd.BoxMethod,'N') = 'N' and ISNULL(sd.ChangedNumber,'') =''  " +
                              "and sd.ShipmentDate <=  " +
                              "(select DATEADD(day, -2, ShipmentDate) from ShipmentDetail where itemid = " + itemid.Trim() + ") and not exists (select 1 from ARGBoxLabel_T abt  " +
                              "where abt.itemid = sd.itemid)";
                DataSet ds2 = new DataSet();
                ds2 = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql2);
                if (ds2 != null && ds2.Tables.Count > 0 && ds2.Tables[0].Rows.Count > 0)
                    rez = "2";

                //存在半箱
                string sql3 = "select * from (select abt.BarcodeNO from ARGPartialBox_T apt left join [ARGBoxLabel_T] abt on abt.BarcodeNO = apt.BarcodeNO and  abt.BoxStatus = 'Partial' " +
                              " where apt.partno = '"+ pncode + "' and isnull(apt.dr,'0') = 0 and len(apt.BarcodeNO) > 8) AA where AA.BarcodeNO is not null";
                DataSet ds3 = new DataSet();
                ds3 = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql3);
                if (ds3 != null && ds3.Tables.Count > 0 && ds3.Tables[0].Rows.Count > 0)
                    rez = "3";

            }

            return rez;
        }

        /// <summary>
        ///获取下片工信息
        /// add by it-wxl 10/13/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getUnLoaderInfo(string banzu)
        {

            string P1 = "";
            string P2 = "";

            string sql = "SELECT Operator,LineLeader,Supervisor FROM [WMS_BarCode_V10].[dbo].[ARGPack_Operator] where Banzu = '"+ banzu + "'";
            DataSet ds1 = new DataSet();

            ds1 = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
            if (ds1 != null && ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                {
                    if(i==0)
                        P1 = ds1.Tables[0].Rows[0][0].ToString() == null? ds1.Tables[0].Rows[0][2].ToString():ds1.Tables[0].Rows[0][0].ToString();
                    if(i==1)
                        P2 = ds1.Tables[0].Rows[1][0].ToString() == null? ds1.Tables[0].Rows[1][2].ToString() : ds1.Tables[0].Rows[1][0].ToString();
                }
            }
              

            return "P1" + P1 + "P2" + P2;
        }

        /// <summary>
        ///获取当前用户的打印机
        ///add by it-wxl 10/13/2017
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string getPrinter()
        {

            string printer = "ZDesigner_ARGPackingSlip_OldOfice";
            string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;

            string sql = "SELECT [PrintName] FROM [FGA_PLATFORM].[dbo].[FGA_UserPrinter] where UserID ='"+ puser + "'";
            DataSet ds1 = new DataSet();

            ds1 = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
            if (ds1 != null && ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0)

                printer = ds1.Tables[0].Rows[0][0].ToString();

            return printer;
        }

        public static int getGrasket(int pnum)
        {
            //垫片规格，按照片数计算垫片规格
            //35 - 36 - 38    5
            //31 - 32 - 33 - 34 7
            //27 - 28 - 29 - 30 9
            //24 - 25 - 26    11
            //20--22--23  14
            //17 - 18--19   18
            //16  24
            //15  26
            //14  28
            //13  30
            //12  33
            //11  35
            //10  38
            //9   42
            //8   56
            int std = 0;

            if (pnum == 8)
                std = 56;
            if (pnum == 9)
                std = 42;
            if (pnum == 10)
                std = 38;
            if (pnum == 11)
                std = 35;
            if (pnum == 12)
                std = 33;
            if (pnum == 13)
                std = 30;
            if (pnum == 14)
                std = 28;
            if (pnum == 15)
                std = 26;
            if (pnum == 16)
                std = 24;
            if (pnum >= 17 && pnum <= 19)
                std = 18;
            if (pnum >= 20 && pnum <= 23)
                std = 14;
            if (pnum >= 24 && pnum <= 26)
                std = 11;
            if (pnum >= 27 && pnum <= 30)
                std = 9;
            if (pnum >= 31 && pnum <= 34)
                std = 7;
            if (pnum >= 35 && pnum <= 38)
                std = 5;


            return std;
        }
    }
}