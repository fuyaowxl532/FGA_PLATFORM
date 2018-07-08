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
    public partial class ARGPackingReWork : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetDAContainer(string serialno)
        {
            string res = string.Empty;
            try
            {
                List<PlexContainer> luw = new List<PlexContainer>();
                PlexContainer PC = new PlexContainer();

                FGA_NUtility.POL.ExecuteDataSourceResult da_rst = PlexHelper.PlexGetResult_1("7836", "Containers_By_Part_Get",
                    "@Serial_No", serialno);

                string location = da_rst.ResultSets[0].Rows[0].Columns[17].Value;
                if (location.IndexOf("FGA") < 0 && location.IndexOf("FGS") < 0)
                {
                    PC.SerialNO = da_rst.ResultSets[0].Rows[0].Columns[10].Value;
                    PC.PartNO = da_rst.ResultSets[0].Rows[0].Columns[3].Value;
                    PC.Quantity = decimal.Parse(da_rst.ResultSets[0].Rows[0].Columns[15].Value);
                    PC.OperationNo = da_rst.ResultSets[0].Rows[0].Columns[7].Value;
                    PC.Location = location;
                    PC.ContainerStatus = da_rst.ResultSets[0].Rows[0].Columns[19].Value;

                    luw.Add(PC);
                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    res = jssl.Serialize(luw);


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

        [WebMethod]
        public static string CompareQty(string serialno, string partno, string location, string oqty, string nqty, bool ck1, bool ck2, string ope)
        {
            string result = string.Empty;
            int oqty1 = Convert.ToInt32(oqty);
            int nqty1 = Convert.ToInt32(nqty);
            string plexid = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).PLEXID;
            string nserialno = string.Empty;
            string label1 = "";
            string label2 = "";
            string oper = ope;
            try
            {
                if (nqty1 <= oqty1)
                {
                    //直接move 修改operation
                    if (nqty == oqty)
                    {
                        //获取该DA号对应1300的part_operation_key
                        string sql = "SELECT [Part_Operation_Key] FROM Part_v_Part_Operation ppo left join " +
                                     " Part_v_part pp on ppo.part_key = pp.part_key where Operation_Key= 46860 and pp.Part_No = '" + partno + "'";

                        DataSet ds = new DataSet();
                        ds = FGA_DAL.Base.SQLServerHelper_Plex.Query(sql);
                        string opk = null;
                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            opk = ds.Tables[0].Rows[0][0].ToString();
                        }

                        FGA_NUtility.POL.ExecuteDataSourceResult esr = PlexHelper.PlexGetResult_6("27181", "Container_Update_Simple", "@Serial_No", "@Last_Action", "@Location", "@Note", "@Update_By", "@Part_Operation_Key",
                            serialno, "Updated at Inventory Update Form", location, "By Rework", plexid, opk);
                    }
                    else
                    {
                        if (oper == "1500")
                        {
                            //先split,获取split后的da
                            FGA_NUtility.POL.ExecuteDataSourceResult res = PlexHelper.PlexGetResult_3("9920", "Container_Split_RF", "@Serial_No", "@Quantity", "@ModUser",
                                serialno, nqty, plexid);

                            //获取新的DA
                            FGA_NUtility.POL.ExecuteDataSourceResult rst = PlexHelper.PlexGetResult_2("33468", "Containers_By_Last_Action_Today_Get",
                                   "@Last_Action", "@From_Container", "Split Container", serialno);
                            if (rst.ResultSets != null)
                            {
                                nserialno = rst.ResultSets[0].Rows[rst.ResultSets[0].RowCount - 1].Columns[0].Value;

                                //对新的DA move

                                //获取该DA号对应1300的part_operation_key
                                string sql = "SELECT [Part_Operation_Key] FROM Part_v_Part_Operation ppo left join " +
                                             " Part_v_part pp on ppo.part_key = pp.part_key where Operation_Key= 46860 and pp.Part_No = '" + partno + "'";

                                DataSet ds = new DataSet();
                                ds = FGA_DAL.Base.SQLServerHelper_Plex.Query(sql);
                                string opk = null;
                                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                                {
                                    opk = ds.Tables[0].Rows[0][0].ToString();
                                }

                                FGA_NUtility.POL.ExecuteDataSourceResult esr = PlexHelper.PlexGetResult_6("27181", "Container_Update_Simple", "@Serial_No", "@Last_Action", "@Location", "@Note", "@Update_By", "@Part_Operation_Key",
                                nserialno, "Updated at Inventory Update Form", location, "By rework", plexid, opk);

                            }

                            //按界面条件打印标签
                            if (ck1)
                            {
                                //获取旧DA标签代码
                                FGA_NUtility.POL.ExecuteDataSourceResult result11 = PlexHelper.PlexGetResult_3("1953", "Web Service Get Container Label", "@SerialNo", "@PLCName", "@IPAddress",
                                           serialno, "Rework in New", "172.17.190.44");
                                if (result11.OutputParameters != null)
                                    label1 = result11.OutputParameters[2].Value;
                            }

                            if (ck2)
                            {
                                //获取新DA标签代码
                                FGA_NUtility.POL.ExecuteDataSourceResult result22 = PlexHelper.PlexGetResult_3("1953", "Web Service Get Container Label", "@SerialNo", "@PLCName", "@IPAddress",
                                           nserialno, "Rework in New", "172.17.190.44");
                                if (result22.OutputParameters != null)
                                    label2 = result22.OutputParameters[2].Value;
                            }

                            result = "New SerialNo" + label2 + "Old SerialNo" + label1;
                        }
                        else
                        {
                            result = "ope_error";
                        }
                    }
                }
                else

                    result = "qty_error";

            }
            catch
            {

            }

            return result;
        }
    }
}