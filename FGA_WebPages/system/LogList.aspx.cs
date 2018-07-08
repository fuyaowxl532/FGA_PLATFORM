using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_BLL.UI;
using System.Collections;
using FGA_MODEL.Args;
using FGA_MODEL;
using FGA_NUtility.Consts;
using FGA_NUtility.Enums;
using System.Text;
using FGA_NUtility;
using System.Web.Services;
using FGA_MODEL.index;
using System.Web.Script.Serialization;
using System.Data;
using FGA_BLL.Common;


namespace FGA_PLATFORM.system
{
    public partial class LogList : PageBase
    {
        protected string pagesize = ConfigHelper.GetConfigValue("PageSize") == string.Empty ? "10" : ConfigHelper.GetConfigValue("PageSize");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["fygx"] = null;
            }
        }



        [WebMethod]
        public static string getFirstMenu()
        {
            string res = string.Empty;
            
            return res;
        }


        [WebMethod]
        public static string getSecondMenu(string type)
        {
            string res = string.Empty;
            
            return res;
        }


        /// <summary>
        /// 用户信息检索
        /// </summary>
        [WebMethod]
        public static string DoLogsSearch(string txtFullName, string CurrentPageIndex, string PageSize,string type,string type1)
        {
            string json = string.Empty;
            try
            {

                if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                    return "";
                //string where = "";
                //DataTable dt = FGA_BLL.Sys_LogBLL.GetSys_LogInfoByWhere(where);
                //List<ReLogModel> list = new List<ReLogModel>();
                //foreach (DataRow item in dt.Rows)
                //{
                //    ReLogModel model = new ReLogModel();
                //    string typeName = Enum.GetName(typeof(FGA_BLL.Common.modularTypeOne), item["type"]);
                //    if (item["type1"].ToString() != "")
                //    {
                //        typeName +="-"+ Enum.GetName(typeof(FGA_BLL.Common.modularTypeOne), item["type1"]);
                //    }
                //    model.typeName = typeName;
                //    model.time = item["add_time"].ToString();
                //    model.result = item["result"].ToString();
                //    model.uName = item["uid"].ToString();
                //}

                Hashtable where = new Hashtable();
                if (!string.IsNullOrEmpty(txtFullName))
                    where.Add(Sys_logArgs.fullName, txtFullName);
                

                where.Add(Sys_logArgs.OrderBy, "add_time desc");
                SearchArgs args = new SearchArgs();
                args.CurrentIndex = int.Parse(CurrentPageIndex);
                args.PageSize = int.Parse(PageSize);
                var list = FGA_BLL.Sys_LogBLL.GetUsersListByPage(where, args);
                DataLogReWrite datausers = new DataLogReWrite();
                List<ReLogModel> reList = new List<ReLogModel>();
                if (list != null && list.Count > 0)
                {
                    datausers.totalRecord = args.TotalRecords;
                    foreach (Sys_LogModel item in list)
                    {
                        ReLogModel model = new ReLogModel();
                        string typeName = "";
                        model.typeName = typeName;
                        model.time = item.add_time;
                        model.result = item.result;
                        model.uName = item.fullName.Trim() == "" && item.uid == 0 ? "未知用户" : item.fullName;
                        model.id = item.id+"";
                        model.ip = item.ip;
                        reList.Add(model);
                    }
                    datausers.sysLoglist = reList;
                    JavaScriptSerializer jssl = new JavaScriptSerializer();
                    json = jssl.Serialize(datausers);
                }

                
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException("DoLogsSearch", ex);
            }
            return json;
        }



        /// <summary>
        /// 用户信息检索
        /// </summary>
        //[WebMethod]
        //public static string ImportLog()
        //{
        //    try
        //    {
        //        string ids = "";
        //        Dictionary<string, string> fygx =HttpContext.Current.Session["fygx"] as Dictionary<string, string>;//取出集合
        //        foreach (var item in fygx)
        //        {
        //            ids += item.Value + ",";
        //        }
        //        ids = ids.Substring(0, ids.Length - 1);
        //        if (ids != "")
        //        {
        //            var list = FGA_BLL.Sys_LogBLL.GetUsersListByWhere(" id in (" + ids + ")");
        //            if (list != null && list.Count > 0)
        //            {
        //                DataTable dt = CreateDataTable();
        //                foreach (Sys_LogModel item in list)
        //                {
        //                    DataRow rows = dt.NewRow();
        //                    string typeName = Enum.GetName(typeof(FGA_BLL.Common.modularTypeOne), item.type);
        //                    if (item.type1 != 0)
        //                    {
        //                        typeName += "-" + Enum.GetName(typeof(FGA_BLL.Common.modularTypeTwo), item.type1);
        //                    }
        //                    rows["模块"] = typeName;
        //                    rows["详情"] = item.result;
        //                    rows["时间"] = item.add_time;
        //                    rows["操作人"] = item.fullName;
        //                    dt.Rows.Add(rows);
        //                }

        //                ExcelRender.SetRenderToExcel(dt, System.Web.HttpContext.Current, FGA_NUtility.Common.getcurrenttime() + ".xls");
        //            }
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        Utility.SysLog.WriteException("ImportLog", ex);
        //    }
        //    return "true";
        //}


        //public static DataTable CreateDataTable()
        //{
        //    DataTable returnDT = new DataTable();
        //    returnDT.Columns.Add("模块", typeof(string));
        //    returnDT.Columns.Add("详情", typeof(string));
        //    returnDT.Columns.Add("时间", typeof(string));
        //    returnDT.Columns.Add("操作人", typeof(string));
        //    return returnDT;
        //}

    }


   


    /// <summary>
    /// 将从数据库取出的数据重新封装，方便序列化成json给前端直接使用
    /// </summary>
    public class DataLogReWrite
    {
        /// <summary>
        /// 总条数
        /// </summary>
        public int totalRecord { get; set; }
        public List<ReLogModel> sysLoglist { get; set; }
    }

    public class ReLogModel
    {
        public string typeName { get; set; }
        public string result { get; set; }
        public string time { get; set; }
        public string uName { get; set; }
        public string id { get; set; }
        public string ip { get; set; }
    }




     


}