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
    public partial class ContainerInfos : System.Web.UI.Page
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize_3") == string.Empty ? "1000" : ConfigHelper.GetConfigValue("PageSize_3");
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        /// containertype:'" + sn + "',customercode:'" + pn + "',serialno:'" + sts + "',partno:'" + cp + "',typeno:'" + typeno + "',barcodeno:'" + barcode + "',status:'" + status + "',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "'
        [WebMethod]
        public static string SearchData(string containertype, string customercode, string serialno,string partno,string typeno,string barcodeno,string status,string ftime,string ttime, string CurrentPageIndex, string PageSize)
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
                string sql_total = "select count(*) Indexs from [FGAContainerInfos]";
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

                string sql = "select * from " +
                    "(SELECT ROW_NUMBER()OVER(ORDER BY FCI.[CustomerCode],FCI.[ContainerType],FCI.[Barcode] DESC) Indexs,FCI.[ContainerType],FCI.[CustomerCode],FCI.[Program],FCI.[PartSerialNO],FCI.[CustomerPartNO],FCI.[TypeNO],FCI.[Status],case when FCI.active = '1' then 'Active' " +
                   " when FCI.active = '0' then 'Inactive' end active " +
                   ",FCI.[Barcode],FCC.[ContainerNO],FCI.[LastUpdateDate],FCI.[ReceiptNO],FCI.[LastEditUser],FCI.[Creator],FCI.[Createdate] FROM [WMS_BarCode_V10].[dbo].[FGAContainerInfos]  FCI left join " +
                   " [WMS_BarCode_V10].[dbo].[FGA_ContainerCustMap] FCC ON FCI.[Barcode] = FCC.[Barcode] WHERE FCI.[Barcode] <> '12345678910' and 1=1 ";
                   

                //查询条件
                if (!String.IsNullOrEmpty(containertype))
                    sql = sql + " and FCI.ContainerType like '%" + containertype + "%'";
                if (!String.IsNullOrEmpty(customercode))
                    sql = sql + " and FCI.CustomerCode like  '%" + customercode + "%'";
                if (!String.IsNullOrEmpty(serialno))
                    sql = sql + " and FCI.PartSerialNO like '%" + serialno + "%'";
                if (!String.IsNullOrEmpty(partno))
                    sql = sql + " and FCI.CustomerPartNO like '%" + partno + "%'";
                if (!String.IsNullOrEmpty(typeno))
                    sql = sql + " and FCI.TypeNO like '%" + typeno + "%'";
                if (!String.IsNullOrEmpty(barcodeno))
                    sql = sql + " and FCI.Barcode like '%" + barcodeno + "%'";
                if (!String.IsNullOrEmpty(status))
                {
                    if (!status.Equals("All"))
                        sql = sql + " and FCI.Status = '" + status + "'";
                }
                if (!String.IsNullOrEmpty(ftime) || !String.IsNullOrEmpty(ttime))
                {
                    sql = sql + " and ISNULL(FCI.LastUpdateDate,FCI.CreateDate) >= '" + ftime + "' and ISNULL(FCI.LastUpdateDate,FCI.CreateDate) <='" + ttime + "'";
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

            List<ContainerViewObject> listmodel = new List<ContainerViewObject>();
            JavaScriptSerializer jssl = new JavaScriptSerializer();
            listmodel = jssl.Deserialize<List<ContainerViewObject>>(data);


            foreach (ContainerViewObject pc in listmodel)
            {
                string sql = "Insert into FGAContainerInfos([ContainerType],[CustomerCode],[Program],[PartSerialNO],[CustomerPartNO],[TypeNO],[Barcode] " +
                             ",[Status],[Creator],[CreateDate],[Active])  values('"+pc.ContainerType+ "','" + pc.CustomerCode + "','" + pc.Program + "'," +
                             "'" + pc.PartSerialNO + "','" + pc.CustomerPartNO + "','" + pc.TypeNO + "','" + pc.Barcode + "','Empty','"+ user + "',getdate(),'1') ";

                sqllist.Add(sql);
            }

            if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
            {
                return "1";
            }
            else
            {
                return "0";
            }
        }
    }
}