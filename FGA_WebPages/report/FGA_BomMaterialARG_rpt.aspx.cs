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

namespace FGA_PLATFORM.report
{
    public partial class FGA_BomMaterialARG_rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SearchData(string orderno,string itemcode,string material)
        {
            //按用户查看数据
            UsersModel model = (UsersModel)HttpContext.Current.Session[SysConst.S_LOGIN_USER];
            string res = string.Empty;
            try
            {
                string sql = "select OrderNO as BatchNO,Shipmentdate,ItemCode as PartNO,Component_Part as OperationCode,replace(Qty,'.0000','') as Quantity," +
                    "MaterialQty as MaterialQty,Unit as ContainerType from ARG_OrderListBom_v  IR where 1=1 ";

                //查询条件
                if (!String.IsNullOrEmpty(orderno))
                    sql = sql + " and IR.OrderNO like '%" + orderno + "%'";
                if (!String.IsNullOrEmpty(itemcode))
                    sql = sql + " and IR.ItemCode like  '%" + itemcode + "%'";
                if (!String.IsNullOrEmpty(material))
                    sql = sql + " and IR.Component_Part like '%" + material + "%'";

                sql = sql + " order by IR.ORDERNO,IR.ITEMCODE,IR.Shipmentdate ASC,IR.COMPONENT_PART";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_WMS.Query(sql);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<PlexContainer> luw = new List<PlexContainer>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        PlexContainer ERM = new PlexContainer(row);
                        luw.Add(ERM);
                    }

                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    jssl.MaxJsonLength = Int32.MaxValue;

                    res = jssl.Serialize(luw);
                    res = res.Replace("\\/Date(", "").Replace(")\\/", "");
                }
            }
            catch (Exception e)
            {
                string aa = e.Message;
                if (aa.Length > 1)
                {
                    res = aa;
                }
            }
            return res;
        }
    }
}