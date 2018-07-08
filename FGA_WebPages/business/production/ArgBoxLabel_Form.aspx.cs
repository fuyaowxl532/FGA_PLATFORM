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
    public partial class ArgBoxLabel_Form : System.Web.UI.Page
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
        public static string SearchData(string tabid,string partno)
        {
            string res = string.Empty;
            try
            {
                string sql = "";
                //属性
                if (tabid == "attribute")
                {
                     sql = "SELECT  [PartNO],[BoxHeight],[GasketThick],[CornerType],[BaseNO],[Creator],[CreateDate] " +
                                 " FROM[FGA_PLATFORM].[dbo].[ARG_part_box_attribute]";
                }
                //附件
                if (tabid == "attribute")
                {
                     sql = "SELECT [PartNO],[Component_Part],[Component_Type],[Creator],[CreateDate] FROM [FGA_PLATFORM].[dbo].[ARG_part_accessory] where 1=1 ";
                }
                //包边模式
                if (tabid == "attribute")
                {
                     sql = "SELECT [PartNO],[EdgeType],[Creator],[CreateDate] FROM [FGA_PLATFORM].[dbo].[ARG_part_edgetype] where 1=1 ";
                }


                //查询条件
                if (!String.IsNullOrEmpty(partno))
                    sql = sql + " and [PartNO] like '" + partno + "'";

                DataSet ds = new DataSet();
                ds = FGA_DAL.Base.SQLServerHelper_FGA.Query(sql);
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
    }
}