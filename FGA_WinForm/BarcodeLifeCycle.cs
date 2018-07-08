using System;
using System.IO;
using System.Text;
using System.Diagnostics;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing.Printing;
using System.Data.SqlClient;
using Microsoft.VisualBasic;


namespace FGA_WinForm
{
    public partial class BarcodeLifeCycle : Form
    {
        public BarcodeLifeCycle()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string printNum = cbQty.Text;      //批量打印
            string serialNO = serialNOtb.Text; //DA号
            if (String.IsNullOrEmpty(serialNO))
            {
                MessageBox.Show("Please input SerialNO", "Warning", MessageBoxButtons.OK,MessageBoxIcon.Warning);
                return;
            }
            for (int n = 0; n < int.Parse(printNum); n++)
            {
                string sn = getSerialNo();
                string cMon = DateTime.Now.Month.ToString();
                string cDay = DateTime.Now.Day.ToString();
                string curDay = DateTime.Now.DayOfYear.ToString();

                if (curDay.Length == 1)
                    curDay = "00" + curDay;
                if (curDay.Length == 2)
                    curDay = "0" + curDay;

                string pdate = DateTime.Now.Year.ToString().Substring(2, 2) + "/"
                   + (cMon.Length == 1 ? "0" + cMon : cMon) + "/"
                   + (cDay.Length == 1 ? "0" + cDay : cDay);
                string ptime = DateTime.Now.ToString("HH:mm:ss");

                string psn = "S/N:" + " " + DateTime.Now.Year.ToString().Substring(2, 2) + " " + curDay
                   + " " + sn;

                string pbarcode = pdate + " " + ptime + " " + sn+" "+ serialNO;

                //string ptime = DateTime.Now.ToString("yyyy-MM-dd");
                //string ntime = DateTime.Now.AddDays(90).ToString("yyyy-MM-dd");

                //string pdate = DateTime.Now.Year.ToString().Substring(2, 2) + "/" + DateTime.Now.Month.ToString() + "/" +
                //              DateTime.Now.Day.ToString();

                //string ndate = DateTime.Now.Year.ToString().Substring(2, 2) + "/" + DateTime.Now.Month.ToString() + "/" +
                //              DateTime.Now.Day.ToString();


                ////1、打印失效日期
                //string zpll = "^XA^FO80,50^A0,18,18^FD" + "StartDate" +
                //"^FS^FO180,50^A0,18,18^FD" + ptime + "^FS" +
                //"^FO80,70^A0,18,18^FD" + "ExpiryDate" + "^FS^FO180,70^A0,18,18^FD" + ntime + "^XZ";

                //2、打印SMALL LOT position条码
                //int count = n + 1;
                //int nc = count + 1;
                //string zpl = "^XA^FO80,90^A0,50,50^FD" + count + "^FS^FO180,50^BCN,100,Y,N,N^FD" + count + "^FS " +
                //                 "^FO530,90^A0,50,50^FD" + nc + "^FS^FO630,50^BCN,100,Y,N,N^FD" + nc + "^FS" +
                //             " ^XZ";

                ////3、打印LH RH
                //string zpl = "^XA^FO150,70^A0,100,100^FDLH^FS " +
                //             "^FO590,70^A0,100,100^FDRH^FS" +
                //             " ^XZ";

                //4、打印GL单片标签
                string zpl = "^XA^FO22,20^A0,18,18^FD" + pdate +
                "^FS^FO102,20^A0,18,18^FD" + ptime + "^FS" +
                 "^FS^FO22,45^A0,18,18^FDSerialNO:" + serialNO + "^FS" +
                "^FO22,70^A0,18,18^FD" + psn + "^FS^FO202,22" +
                "^BXN,3,200^FD" + pbarcode + "^FS^XZ";

                PrintDialog pd = new PrintDialog();
                pd.PrinterSettings = new PrinterSettings();
                RawPrinterHelper.SendStringToPrinter(pd.PrinterSettings.PrinterName, zpl);
            }
        }

        //通过数据库获取序列号[Fga_SerialNO]
        public string getSerialNo()
        {
            string sn = null;
            SqlConnection conn = new SqlConnection("server=172.16.80.47;database=FGA_PLATFORM;uid=sa;pwd=luck2008.com");
            conn.Open();
            string sql = "select next value for Fga_SerialNo_seq";
            SqlCommand cmd = new SqlCommand(sql, conn);

            sn = cmd.ExecuteScalar().ToString();
            conn.Close();

            return sn;
        }

        private void BarcodeLifeCycle_Load(object sender, EventArgs e)
        {

        }
    }
}
