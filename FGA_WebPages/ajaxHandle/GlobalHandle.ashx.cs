using FGA_BLL.UI;
using FGA_MODEL;
using FGA_MODEL.index;
using FGA_NUtility;
using FGA_NUtility.Consts;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace FGA_PLATFORM.ajaxHandle
{
    /// <summary>
    /// APT全局异步请求处理
    /// </summary>
    public class GlobalHandle : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            try
            {
                //确认身份
                bool userCheck =FGA_NUtility.ConfigHelper.GetConfigBool("AsyncUserCheck");
                if (context.Session[SysConst.S_LOGIN_USER] == null)
                    return;
                string oper = context.Request["opertype"];
                switch (oper)
                {
                    case "importexcel":
                        ImportExcel(context);
                        break;
                    case "JobnoimpExcel":
                        JobnoimpExcel(context);
                        break;
                    case "oemorderimpExcel":
                        oemorderimpExcel(context);
                        break;
                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException(this.GetType().Name, ex);
            }
        }
        /// <summary>
        /// 导入excel数据
        /// </summary>
        /// <param name="context"></param>
        private void ImportExcel(HttpContext context)
        {
            try
            {
                //从Request中取参数，注意上传的文件在Requst.Files中
                string name = context.Request["name"];
                var data = context.Request.Files["data"];
                string dir = context.Request.MapPath("~/FileTemp/");
                if (!Directory.Exists(dir))
                {
                    Directory.CreateDirectory(dir);
                }
                string file = dir + name;
                data.SaveAs(file);
                if (File.Exists(file))
                {
                    //Stream stream = FGA_NUtility.FileOper.FileToStream(file);
                    DataTable dt = ExcelRender.RenderFromExcel(file);
                    if (dt == null)
                    {
                        context.Response.Write("No data");
                    }
                    string sql=string.Empty;
                    List<string> sqllist = new List<string>();
                    for (int i=0;i<dt.Rows.Count;i++)
                    {
                        sql = @" insert into bomcost_rptbase (period_name,building_code,part_no,operation_no,container_status,onhand_qty,CREATEUSER,CREATEDATE)
                                 values ('{0}','{1}','{2}','{3}','{4}',{5},'{6}',getdate())  ";
                        sql = string.Format(sql, dt.Rows[i]["period_name"], dt.Rows[i]["building_code"], dt.Rows[i]["part_no"], dt.Rows[i]["operation_no"],
                            dt.Rows[i]["constainer_status"], dt.Rows[i]["onhand_qty"], (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME);
                       
                        sqllist.Add(sql);
                    }
                    if (sqllist.Count > 0)
                    {
                        if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
                        {
                            File.Delete(file);
                            context.Response.Write("success");
                        }
                        else
                        {
                            context.Response.Write("fail");
                        }
                    }
                }

            }
            catch (Exception)
            {
                context.Response.Write("error");
            }
        }

        /// <summary>
        /// JobStatusUpt界面导入excel数据  add by i-wxl 20161201
        /// </summary>
        /// <param name="context"></param>
        private void JobnoimpExcel(HttpContext context)
        {
            try
            {
                //从Request中取参数，注意上传的文件在Requst.Files中
                string name = context.Request["name"];
                var data = context.Request.Files["data"];
                string dir = context.Request.MapPath("~/FileTemp/");
                if (!Directory.Exists(dir))
                {
                    Directory.CreateDirectory(dir);
                }
                string file = dir + name;
                data.SaveAs(file);
                if (File.Exists(file))
                {
                    DataTable dt = ExcelRender.RenderFromExcel(file);
                    if (dt == null)
                    {
                        context.Response.Write("No data");
                    }
                    string sql = string.Empty;
                    List<string> sqllist = new List<string>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sql = @" insert into jobnostatusupt (JOBNO,CREATER,CREATEDATE)
                                 values ('{0}','{1}',getdate())  ";
                        //string aa = dt.Columns[0].ColumnName;
                        sql = string.Format(sql, dt.Rows[i][dt.Columns[0].ColumnName], (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME);

                        sqllist.Add(sql);
                    }
                    if (sqllist.Count > 0)
                    {
                        if (FGA_DAL.Base.SQLServerHelper.ExecuteSqlTran(sqllist) > 0)
                        {
                            File.Delete(file);
                            context.Response.Write("success");
                        }
                        else
                        {
                            context.Response.Write("fail");
                        }
                    }
                }

            }
            catch (Exception)
            {
                context.Response.Write("error");
            }
        }

        /// <summary>
        /// OEM_ORDERTRACKING界面导入excel数据  add by i-wxl 20170328
        /// </summary>
        /// <param name="context"></param>
        private void oemorderimpExcel(HttpContext context)
        {
            try
            {
                //从Request中取参数，注意上传的文件在Requst.Files中
                string name = context.Request["name"];
                var data = context.Request.Files["data"];
                string dir = context.Request.MapPath("~/FileTemp/");
                if (!Directory.Exists(dir))
                {
                    Directory.CreateDirectory(dir);
                }
                string file = dir + name;
                data.SaveAs(file);
                if (File.Exists(file))
                {
                    DataTable dt = ExcelRender.RenderFromExcel(file);
                    if (dt == null)
                    {
                        context.Response.Write("No data");
                    }
                    string sql = string.Empty;
                    List<string> sqllist = new List<string>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        //获取序列号
                        string SEQ = string.Empty;
                        try
                        {
                            //获取序列号
                            string SEQ_sql = "select next value for honda_sequence_seq as HS ";
                            DataSet ds_seq = new DataSet();
                            ds_seq = FGA_DAL.Base.SQLServerHelper_FGA.Query(SEQ_sql);
                            if (ds_seq != null && ds_seq.Tables.Count > 0 && ds_seq.Tables[0].Rows.Count > 0)
                            {
                                SEQ = ds_seq.Tables[0].Rows[0][0].ToString();
                                string pd = dt.Rows[i]["PlanningDate"].ToString();
                                string sd = dt.Rows[i]["ShipmentDate"].ToString();
                                sql = " INSERT INTO [FGA_OEMORDERTRK_T]([OrderNoID],[OrderNO],[PartNO],[Customer],[Program],[AddressCode],[BoxType],[KeyCenter],[StandardQuantity],[OrderQuantity] " +
                                      ",[inboundqty],[uninboundqty],[uninboundbox],[PlanningDate],[ShipmentDate],[OrderStatus],[DeliveryStatus],[Organization],[Notes],[Creater],[Createdate]) " +
                                      " VALUES('" + SEQ + "','" + dt.Rows[i]["OrderNO"] + "','" + dt.Rows[i]["PartNO"] + "','" + dt.Rows[i]["Customer"] + "','" + dt.Rows[i]["Program"] + "','"+dt.Rows[i]["AddressCode"]+"' " +
                                      ",'" + dt.Rows[i]["BoxType"] + "','" + dt.Rows[i]["KeyCenter"] + "'," + dt.Rows[i]["StandardQuantity"] + "," + dt.Rows[i]["OrderQuantity"] + ",0," + dt.Rows[i]["OrderQuantity"] + " " +
                                      "," + dt.Rows[i]["OrderQuantity"] + "/" + dt.Rows[i]["StandardQuantity"] + ",'" + Convert.ToDateTime(pd) + "','" + Convert.ToDateTime(sd) + "','Release', 'Normal'" +
                                      ",'" + dt.Rows[i]["Organization"] + "','" + dt.Rows[i]["Notes"] + "','" + (HttpContext.Current.Session[SysConst.S_LOGIN_USER] as UsersModel).USERNAME + "',getdate()) ";


                                sqllist.Add(sql);
                            }
                        }
                        catch (Exception e)
                        {

                        }

                       
                    }
                    if (sqllist.Count > 0)
                    {
                        if (FGA_DAL.Base.SQLServerHelper_WMS.ExecuteSqlTran(sqllist) > 0)
                        {
                            File.Delete(file);
                            context.Response.Write("success");
                        }
                        else
                        {
                            context.Response.Write("fail");
                        }
                    }
                }
            }
            catch (Exception)
            {
                context.Response.Write("error");
            }
        }

        /// <summary>
        /// 导出所选
        /// </summary>
        /// <param name="context"></param>
        private void ExportSelect(HttpContext context)
        {

            DataTable dt = new DataTable(); //获取新的DT

            ExcelRender.SetRenderToExcel(dt, context, FGA_NUtility.Common.getcurrenttime() + ".xls");
        }

        /// <summary>
        /// 导出全部，暂时没做导出全部
        /// </summary>
        /// <param name="context"></param>
        private void ImportAll(HttpContext context)
        {
            string postUrl = "";
            string postData = "{";
            if (ConfigHelper.GetConfigValue("") != "")//导出全部的接口暂无
            {
                postUrl = ConfigHelper.GetConfigValue("");
            }
            else
            {
                context.Response.Write("error:未配置索引地址！");
                return;
            }

            DataTable dt = new DataTable();
            DataRow rows = dt.NewRow();
            rows["文件详情"] = "";


            dt.Rows.Add(rows);
            ExcelRender.SetRenderToExcel(dt, context, FGA_NUtility.Common.getcurrenttime() + ".xls");
        }


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="context"></param>
        private void ImportSelect_access(HttpContext context)
        {
            string postData = "";
            string postUrl = "";
            if (context.Session["fygx"] == null)
                return;
            postUrl = ConfigHelper.GetConfigValue("casesdataAccesslistExcel");
            if (string.IsNullOrEmpty(postUrl))
            {
                context.Response.Write("error：未配置导出接口地址！");
                return;
            }


            Dictionary<string, string> fygx = context.Session["fygx"] as Dictionary<string, string>;//取出集合
            foreach (var item in fygx)
            {
                postData += item.Value + ",";
            }
            postData = postData.Substring(0, postData.Length - 1);


            string res = HttpHelper.GetHttpResponse(postUrl + "?rowkey=" + postData);
            JavaScriptSerializer js = new JavaScriptSerializer();
            //FGA_MODEL.casemodel.casedatamodel search = js.Deserialize<FGA_MODEL.casemodel.casedatamodel>(res);

            //DataTable dt = DataTableTemplate.CreateAcessDataTable();
            //foreach (FGA_MODEL.casemodel.casedatamd model in search.lists)
            //{
            //    DataRow rows = dt.NewRow();
            //    rows["攻击时间"] = FGA_NUtility.Common.StampToDateTime(model.capturetime + "") + "";
            //    rows["源IP"] = model.sourceip;
            //    rows["目的IP"] = model.destip;
            //    rows["等级"] = FGA_NUtility.Common.ConvertServersityLevelForText(model.attackhazardlevel);
            //    rows["服务类型"] = model.service;
            //    rows["分类"] = model.parentclassifytitle;
            //    dt.Rows.Add(rows);
            //}
            DataTable dt = new DataTable();
            ExcelRender.SetRenderToExcel(dt, context, FGA_NUtility.Common.getcurrenttime() + ".xls");
        }



    }
}