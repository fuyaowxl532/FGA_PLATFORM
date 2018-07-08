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
using FGA_MODEL.Args;

namespace FGA_PLATFORM.business.inventory
{
    public partial class ContainerTranscation : System.Web.UI.Page
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize_3") == string.Empty ? "1000" : ConfigHelper.GetConfigValue("PageSize_3");
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        /// data: "{containertype:'" + sn + "',customercode:'" + pn + "',typeno:'" + typeno + "',barcodeno:'" + barcode + "',status:'" + status + "'}",
        [WebMethod]
        public static string SearchData(string containertype, string customercode, string typeno, string barcodeno,string status,string bol, string dr, string ftime, string ttime, string CurrentPageIndex, string PageSize)
        {
            //分页查询
            SearchArgs args = new SearchArgs();
            args.CurrentIndex = int.Parse(CurrentPageIndex);
            args.PageSize = int.Parse(PageSize);
            int begin = args.StartIndex + 1;
            int end = args.StartIndex + args.PageSize;

            string res = string.Empty;
            try
            {
                //获取记录总数
                string sql_total = "select count(*) Indexs from [FGA_Container_Trans_t] IR left join [FGAContainerInfos] fci  " +
                                   "on IR.Barcode = fci.barcode where 1=1 ";
                //查询条件
                if (!String.IsNullOrEmpty(containertype))
                    sql_total = sql_total + " and fci.ContainerType like '%" + containertype + "%'";
                if (!String.IsNullOrEmpty(customercode))
                    sql_total = sql_total + " and fci.CustomerCode like  '%" + customercode + "%'";
                if (!String.IsNullOrEmpty(typeno))
                    sql_total = sql_total + " and fci.TypeNO like '%" + typeno + "%'";
                if (!String.IsNullOrEmpty(barcodeno))
                    sql_total = sql_total + " and IR.Barcode like  '%" + barcodeno + "%'";
                if (!String.IsNullOrEmpty(bol))
                    sql_total = sql_total + " and IR.ReceiptNO like  '%" + bol + "%'";
                if (!String.IsNullOrEmpty(status))
                {
                    if (!"All".Equals(status))
                        sql_total = sql_total + " and IR.Status = '" + status + "'";
                }
                if (!String.IsNullOrEmpty(dr))
                {
                    if (!"All".Equals(dr))
                        sql_total = sql_total + " and IR.dr = '" + dr + "'";
                }
                if (!String.IsNullOrEmpty(ftime) || !String.IsNullOrEmpty(ttime))
                {
                    sql_total = sql_total + " and IR.TranscationTime >= '" + ftime + "' and IR.TranscationTime <='" + ttime + "'";
                }

                DataSet dst = new DataSet();
                dst = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql_total);

                if (dst != null && dst.Tables.Count > 0 && dst.Tables[0].Rows.Count > 0)
                {
                    args.TotalRecords = Convert.ToInt32(dst.Tables[0].Rows[0][0]);
                }
                else
                {
                    return res;
                }

                string sql = "select * from (select ROW_NUMBER()OVER(ORDER BY IR.ContainerType,IR.Barcode,IR.dr,IR.TranscationTime DESC) Indexs,IR.TranscationID,IR.Barcode,IR.CustomerPartNO,IR.TranscationUser,IR.TranscationTime,IR.Status,IR.SerialNO,IR.ReceiptNO," +
                             "IR.CustomerCode,IR.ContainerType,IR.TypeNO,IR.dr  " +
                             "from (select fct.TranscationID,fct.Barcode,fci.CustomerPartNO,fct.TranscationUser,fct.TranscationTime,fct.Status,fct.SerialNO,fct.ReceiptNO, " +
                             "FCI.CustomerCode,fci.ContainerType,fci.TypeNO,fct.dr from [FGA_Container_Trans_t] fct left join [FGAContainerInfos] fci  " +
                             "on  fct.Barcode = fci.barcode) IR WHERE 1=1  ";


                //查询条件
                if (!String.IsNullOrEmpty(containertype))
                    sql = sql + " and IR.ContainerType like '%" + containertype + "%'";
                if (!String.IsNullOrEmpty(customercode))
                    sql = sql + " and IR.CustomerCode like  '%" + customercode + "%'";
                if (!String.IsNullOrEmpty(typeno))
                    sql = sql + " and IR.TypeNO like '%" + typeno + "%'";
                if (!String.IsNullOrEmpty(barcodeno))
                    sql = sql + " and IR.Barcode like  '%" + barcodeno + "%'";
                if (!String.IsNullOrEmpty(bol))
                    sql = sql + " and IR.ReceiptNO like  '%" + bol + "%'";
                if (!String.IsNullOrEmpty(status))
                {
                    if (!"All".Equals(status))
                        sql = sql + " and IR.Status = '" + status + "'";
                }
                if (!String.IsNullOrEmpty(dr))
                {
                    if (!"All".Equals(dr))
                        sql = sql + " and IR.dr = '" + dr + "'";
                }
                if (!String.IsNullOrEmpty(ftime) || !String.IsNullOrEmpty(ttime))
                {
                    sql = sql + " and IR.TranscationTime >= '" + ftime + "' and IR.TranscationTime <='" + ttime + "'";
                }

                sql = sql + ") AA where AA.indexs between " + begin + " and " + end + " ";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<ContainerViewObject> luw = new List<ContainerViewObject>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ContainerViewObject ERM = new ContainerViewObject(row);
                        ERM.Recordcnt = args.TotalRecords;

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
    }
}