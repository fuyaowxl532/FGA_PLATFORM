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
    public partial class FGA_FIFO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 初始化界面Location
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string InitLocation()
        {
            string res = string.Empty;
            try
            {
                UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
                string sql = "SELECT [From_LOC] FROM [FIFO_UserLocation] where USERNAME='{0}' order by [Location]";
                sql = string.Format(sql, model.USERNAME);
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<PlexContainer> luw = new List<PlexContainer>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                        luw.Add(new PlexContainer(row));

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
        /// 从PLEX中获取DA对应的Part最早的日期
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string setSerialNO(string data)
        {
            string res = string.Empty;
            PlexContainer pc = new PlexContainer();
            //获取partkey
            FGA_NUtility.POL.ExecuteDataSourceResult result = PlexHelper.PlexGetResult_1("7836", "Containers_By_Part_Get",
               "@Serial_No", data.Substring(0,8));

            if (result.ResultSets != null)
            {
                pc.SerialNO        = result.ResultSets[0].Rows[0].Columns[10].Value;      // SerialNO
                pc.PartNO          = result.ResultSets[0].Rows[0].Columns[3].Value;       // PartNO
                pc.PartKey         = result.ResultSets[0].Rows[0].Columns[0].Value;       // PartKey
                pc.Location        = result.ResultSets[0].Rows[0].Columns[17].Value;      // Location
                pc.Quantity        = Convert.ToDecimal(result.ResultSets[0].Rows[0].Columns[15].Value);   // Quantity
                pc.ContainerStatus = result.ResultSets[0].Rows[0].Columns[19].Value;                      // Status
                pc.Createdate      = Convert.ToDateTime(result.ResultSets[0].Rows[0].Columns[39].Value);  // ADD_DATE
                
                //D1022212D9876543D
                string das = data.Substring(data.IndexOf("*") +1);
                string dd = "\'\'0\'\'";
                if (das.Length >= 8)
                {
                    for (int i = 0; i < das.Length; i =i + 8)
                    {
                        dd = dd +','+ '\'' + '\'' + das.Substring(i, 8) + '\'' + '\'';
                    }
                }
                //按照产品类别获取控制日期
                int tday = 0;
                if(pc.PartNO.Substring(0,2) =="BB")
                    tday = 7;
                if (pc.PartNO.Substring(0, 2) == "AB")
                    tday = 7;

                //按照partKey获取库位最早的Container
                string sql = "SELECT top(1) Q.Serial_No,Q.Part_No,Q.location,Q.Quantity,Q.add_date,dateadd(Day," + tday + ",Q.add_date) vdate " +
                                          " FROM OPENQUERY(PLEXODBC, " +
                                          " 'select a.serial_no,b.Part_No,c.Location,a.Quantity,a.Add_Date add_date " +
                                          " from Part_v_Container a,Part_v_Part b,Common_v_Location c,Common_v_Building d  " +
                                          " where 1=1 and a.Quantity>0 and a.Part_Key=b.Part_Key and c.Location=a.Location " +
                                          " and c.Building_Key=d.Building_Key and (d.Building_code in (''FG_Warehouse'',''M_Warehouse'') or a.location like ''C%'') " +
                                          " and a.Container_Status=''OK'' and a.active=''1'' " +
                                          " and a.Part_Key = " + pc.PartKey + " and a.serial_no not in (" + dd + ")" +
                                          " order by a.Add_Date  asc') AS Q";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                string rst1, rst2, rst3, rst4, rst5, rst = null;
                string rst6 = null;
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    rst1 = ds.Tables[0].Rows[0][0] == DBNull.Value ? null : Convert.ToString(ds.Tables[0].Rows[0][0]);
                    rst2 = ds.Tables[0].Rows[0][1] == DBNull.Value ? null : Convert.ToString(ds.Tables[0].Rows[0][1]);
                    rst3 = ds.Tables[0].Rows[0][2] == DBNull.Value ? null : Convert.ToString(ds.Tables[0].Rows[0][2]);
                    rst4 = ds.Tables[0].Rows[0][3] == DBNull.Value ? null : Convert.ToString(ds.Tables[0].Rows[0][3]);
                    rst5 = ds.Tables[0].Rows[0][4] == DBNull.Value ? null : Convert.ToString(ds.Tables[0].Rows[0][4]);
                    rst6 = ds.Tables[0].Rows[0][5] == DBNull.Value ? null : Convert.ToString(ds.Tables[0].Rows[0][5]);

                    rst = rst1 + " _PART:" + rst2 + " _LOCATION:" + rst3 + " _QTY:" + rst4 + " _ADDDATE:" + rst5 + " _VDATE:" + rst6;

                    DateTime vdate = Convert.ToDateTime(rst6);
                    if (pc.Createdate < vdate)
                    {
                        JavaScriptSerializer jssl = new JavaScriptSerializer();
                        res = jssl.Serialize(pc);
                        res = res.Replace("\\/Date(", "").Replace(")\\/", "");
                    }
                    else
                        res = "0" + rst;
                }
                else
                {
                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(pc);
                    res = res.Replace("\\/Date(", "").Replace(")\\/", "");
                }
            }

            return res;
        }

        /// <summary>
        /// 获取当天已存入数据库的DA号
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string InitSerialNO()
        {
            string das = "";

            try
            {
                string sql = "SELECT SERIALNO FROM OEM_IR WHERE [Createdate] > DATEADD(hh,-12,GETDATE()) and [Createdate]<GETDATE() and Type = 'FIFO' ";
                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        //das = das + ',' + '\'' + '\'' + ds.Tables[0].Rows[i][0] + '\'' + '\'';
                        das = das + ds.Tables[0].Rows[i][0];
                    }
                }
            }
            catch
            { return das; }

            return das;
        }

        /// <summary>
        /// 数据提交确认
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string transferToPlex(string data)
        {
            try
            {
                string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
                string plexid = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).PLEXID;

                PlexContainer model = new PlexContainer();
                List<PlexContainer> listmodel = new List<PlexContainer>();
                List<String> sqllist = new List<String>();
                JavaScriptSerializer jssl = new JavaScriptSerializer();
                listmodel = jssl.Deserialize<List<PlexContainer>>(data);

                if (listmodel.Count != 0)
                {
                    foreach (PlexContainer m in listmodel)
                    {
                        string ft = m.Location + "&" + m.TLoc + "&" + "F";
                        FGA_NUtility.POL.ExecuteDataSourceResult esr = PlexHelper.PlexGetResult_4("27181", "Container_Update_Simple", "@Serial_No", "@Last_Action", "@Location", "@Update_By",
                            m.SerialNO, "Updated at Inventory Update Form", m.TLoc, plexid);

                        string sql = "insert into OEM_IR(SerialNO,FT_Location,Type,Creater,Createdate)" +
                         " values('" + m.SerialNO + "','" + ft + "','FIFO','" + puser + "',getdate())";

                        sqllist.Add(sql);

                    }

                    int count = FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist);
                }
            }
            catch
            { return "0"; }

            return "1";
        }
    }
}