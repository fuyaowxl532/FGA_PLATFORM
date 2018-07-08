using System;
using System.IO;
using System.Text;
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
    public partial class BarcodeHelper_CA : Form
    {
        public BarcodeHelper_CA()
        {
            InitializeComponent();
            sfcBox.Text = "1";
            sfcBox.DropDownStyle = ComboBoxStyle.DropDownList;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //输入密码
            String psd = "PU789";
                //Interaction.InputBox("Please input password", "Password", "", 50, 50);

            if (!String.IsNullOrEmpty(psd))
            {
                if (psd.ToUpper() != "PU789")
                {
                    MessageBox.Show("Password is wrong!");
                    return;
                }
                else
                {
                    //判断输入的班组是否1，2，3
                    if (sfcBox.Text == "1" || sfcBox.Text == "2" || sfcBox.Text == "3")
                    {
                        string printNum = cbPrintNum.Text; //批量打印
                        for (int n = 0; n < int.Parse(printNum); n++)
                        {
                            string partNo = "FL-34-16500A18-DA";
                            string sn = getSerialNo();
                            string zpll = "^XA";
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

                            string pbarcode = tnBox.Text + sfcBox.Text + DateTime.Now.Year.ToString().Substring(2, 2)
                                + curDay + "DA" + sn + cpBox.Text + cprBox.Text;

                            string ptime = DateTime.Now.ToString("HH:mm:ss");
                            string psn = "S/N:" + " " + tnBox.Text + " " + sfcBox.Text + " "
                                + DateTime.Now.Year.ToString().Substring(2, 2) + " " + curDay
                                + " " + sn + " " + cpBox.Text + "     " + cprBox.Text;

                            //拼接ZPL语言
                            zpll = zpll + "^FO20,10^A0,12,18^FD" + partNo + "^FS" + "^FO20,40^A0,12,18^FD" + pdate +
                            "^FS^FO120,40^A0,12,18^FDTIME:" + ptime + "^FS" +
                            "^FO20,70^A0,12,18^FD" + psn + "^FS^FO310,10" +
                            "^BXN,4,200^FD" + pbarcode + "^FS^XZ";

                            PrintDialog pd = new PrintDialog();
                            pd.PrinterSettings = new PrinterSettings();
                            RawPrinterHelper.SendStringToPrinter(pd.PrinterSettings.PrinterName, zpll);
                        }
                    }
                    else
                    {
                        MessageBox.Show("Shift_First_Char is wrong" + '\n' + "Only 1 or 2 or 3 is valid.");
                        return;
                    }

                }
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        //向本地写入序列文件
        //public void Write(string SerialNO)
        //{
        //    FileStream fs = new FileStream("C:\\Fga_SerialNO.txt", FileMode.Create);
        //    //获得字节数组
        //    byte[] data = System.Text.Encoding.Default.GetBytes(SerialNO);
        //     //开始写入
        //   fs.Write(data, 0, data.Length);
        //    //清空缓冲区、关闭流
        //    fs.Flush();
        //   fs.Close();
        //}

        //读取本地文件获取序列
        //public string Read(string path)
        //{
        //   StreamReader sr = new StreamReader(path, Encoding.Default);
        //    String line = sr.ReadLine();

        //   sr.Close();

        //   return line;
        //}

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

        private void tnBox_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

    }
}
