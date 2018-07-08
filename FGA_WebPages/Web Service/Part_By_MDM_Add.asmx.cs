using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using FGA_NUtility;

namespace FGA_PLATFORM.Web_Service
{
    /// <summary>
    /// Part_By_MDM_Add 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class Part_By_MDM_Add : System.Web.Services.WebService
    {
        
        [WebMethod(Description = "Add part to plex by MDM")]
        public string part_mdm_add(string partno, string partname, string parttype, string partstatus, string partgroup, string partsource,
            string partpgroup, string unit, string desc, string dept)
        {
            string res = "";

            FGA_NUtility.POL.ExecuteDataSourceResult da_rst = null;

            da_rst = PlexHelper.PlexGetResult_10("12564", "Part_And_Attributes_Add_Update",
                 "@Part_No", "@Name", "@Part_Type", "@Part_Status", "@Part_Group", "@Part_Source", "@Part_Product_Group",
                 "@Unit", "@Description", "@Department_Code", partno, partname, parttype, partgroup, partgroup, partsource, partpgroup, unit, desc, dept);

            if (!String.IsNullOrEmpty(da_rst.OutputParameters[0].ToString()))
                res = "Successful";
            else
            {
                res = da_rst.OutputParameters[2].ToString();
            }

            return res;
        }
    }
}
