using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FGA_PLATFORM
{
    public partial class flip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        /// <summary>
        /// 保存分页勾选
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string SaveSelect(string biaoshi)
        {
            try
            {
                Dictionary<string, string> fygx = HttpContext.Current.Session["fygx"] as Dictionary<string, string>;//取出集合
                if (fygx == null)
                    fygx = new Dictionary<string, string>();
                fygx.Add(biaoshi, biaoshi);         //添加键值对


                HttpContext.Current.Session["fygx"] = fygx;//存入session
                return fygx.Count.ToString();
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException("flip.aspx/SaveSelect", ex);
                return "false";//返回保存失败
            }
        }
        /// <summary>
        /// 取消分页勾选
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string UnSaveSelect(string biaoshi)
        {
            try
            {
                Dictionary<string, string> fygx = HttpContext.Current.Session["fygx"] as Dictionary<string, string>;//取出集合
                if (fygx != null)
                {

                    fygx.Remove(biaoshi);     //移除回复数据类键值对（键：MD5）
                    HttpContext.Current.Session["fygx"] = fygx;//存入session
                }
                return fygx.Count.ToString();//返回清除成功
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException("flip.aspx/UnSaveSelect", ex);
                return "false";//返回清除失败
            }
        }

        [WebMethod]
        public static string SaveAll(string all, string q)
        {
            if (all != "")
            {
                all = all.Substring(0, all.Length - 1);
                string[] sz = all.Split('■');
                Dictionary<string, string> fygx = HttpContext.Current.Session["fygx"] as Dictionary<string, string>;//取出集合
                if (q == "quan")
                {
                    for (int i = 0; i < sz.Length; i++)
                    {
                        if (fygx == null)
                        {
                            fygx = new Dictionary<string, string>();
                            fygx.Add(sz[i], sz[i]);
                        }
                        else
                        {
                            if (fygx.ContainsKey(sz[i]) == false)
                            {
                                fygx.Add(sz[i], sz[i]);
                            }
                        }
                    }
                }
                else //反选了
                {
                    for (int i = 0; i < sz.Length; i++)
                    {

                        if (fygx.ContainsKey(sz[i]))
                        {
                            fygx.Remove(sz[i]);
                        }

                    }
                }
                HttpContext.Current.Session["fygx"] = fygx;//存入session
                return fygx.Count + "";
            }
            else
            {
                return "0";
            }

        }

        [WebMethod]
        public static string AllSelectInput()
        {
            string res = "";
            try
            {
                Dictionary<string, string> fygx = HttpContext.Current.Session["fygx"] as Dictionary<string, string>;//取出集合
                if (fygx != null)
                {
                    foreach (KeyValuePair<string, string> pair in fygx)
                    {
                        res += pair.Key + "\\";
                    }
                    if (res != "")
                    {
                        res = "\\" + res;
                    }
                }
                return res;
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException("flip.aspx/AllSelectInput", ex);
                return res;
            }
        }
        /// <summary>
        /// 判断集合是否有数据
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string GetSelectCount()
        {
            Dictionary<string, string> fygx = HttpContext.Current.Session["fygx"] as Dictionary<string, string>;//取出集合
            if (fygx != null)
                return fygx.Count.ToString();
            else
                return "0";
        }


        [WebMethod]
        public static string ClearSession()
        {
            try
            {
                HttpContext.Current.Session["fygx"] = null;
            }
            catch (Exception e)
            {
                return "";
            }
            return "";
        }



    }
}