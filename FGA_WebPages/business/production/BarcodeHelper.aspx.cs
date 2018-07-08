using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_NUtility;
using FGA_NUtility.Consts;
using System.Drawing.Printing;

namespace FGA_PLATFORM.business.production
{
    public partial class BarcodeHelper : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string crtLable(string data)
        {
            //获取当前天数是一年的第几天
            string curDay = DateTime.Now.DayOfYear.ToString();
            //获取序列号100000

            string zpll = "^XA";
            try
            {
                string puser = (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME;
                statsbyscannerModel model = new statsbyscannerModel();
                List<BarcodeHelperModel> listmodel = new List<BarcodeHelperModel>();
                JavaScriptSerializer jssl = new JavaScriptSerializer();
                listmodel = jssl.Deserialize<List<BarcodeHelperModel>>(data);
                List<string> sqllist = new List<string>();
                foreach (BarcodeHelperModel m in listmodel)
                {
                    string pdate = "2017-02-11";
                    string pbarcode = m.ToolNO + ".." + m.Shift_First_Charactor + ".." + m.Customer_Part
                    + ".." + m.Customer_Part_Revision;
                    string ptime = DateTime.Now.ToString("hh:mm:ss");
                    string psn = "SN:" + " " + m.Shift_First_Charactor + " " + DateTime.Now.Year.ToString();

                    //拼接ZPL语言
                    zpll = zpll + "^FO30,20^A0,18,25^FD" +pdate+
                    "^FS^FO120,20^A0,18,25^FDTIME:" + ptime + "^FS" +
                    "^FO30,60^A0,18,25^FD" + psn + "^FS^FO350,20" +
                    "^BQ,7,N,0,N,1,0^FDQA," + pbarcode + "^FS^XZ";
                }

                return zpll;
            }
            catch
            {
                return zpll; 
            }
        }

        //从plex中获取产品label
        [WebMethod]
        public static string GetDALabel()
        {
            string label_zpl = "";

            FGA_NUtility.POL.ExecuteDataSourceResult result = PlexHelper.PlexGetResult_3("1953", "Web Service Get Container Label", "@SerialNo", "@PLCName", "@IPAddress",
                       "DA712918", "Barcode", "172.17.190.44");

            if(result.OutputParameters!=null)
                label_zpl = result.OutputParameters[2].Value;

           

            return label_zpl;
        }
    }
}