using FGA_BLL.UI;
using FGA_MODEL;
using FGA_MODEL.index;
using FGA_NUtility.Consts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FGA_PLATFORM
{
    public partial class index : PageBase
    {
        UsersModel userModel = null;
        protected string menustr = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return;
            userModel = CurrentUser;
            ltusername.Text = userModel.USERNAME;
            menustr = GetMenu();

        }
        public static string GetMenu()
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return "";
            UsersModel userModel = new PageBase().CurrentUser;
            string res = string.Empty;
            try
            {
                //一级菜单
                var topList = FGA_BLL.Cache.PowersCache.Powers.Where(p => p.pcode.Length == (SysConst.CODE_STEP * 2) && p.bz == 0).ToList();
                //过滤掉没有权限的模块
                topList = topList.Where(p => userModel.Powers.Contains(p.pcode)).ToList();

                StringBuilder sb = new StringBuilder();
                
                foreach (PowersModel pm in topList)
                {
                    //一级菜单编写

                    var secondList = FGA_BLL.Cache.PowersCache.Powers.Where(p => p.pcode.StartsWith(pm.pcode) && (p.pcode.Length == (SysConst.CODE_STEP * 3)) && p.bz == 0).ToList();
                    secondList = secondList.Where(p => userModel.Powers.Contains(p.pcode)).ToList();//过滤掉没有权限的模块
                    if (secondList != null && secondList.Count > 0)
                    {
                        sb.Append("<li class=\"has-sub\">");
                        sb.Append("<a href='javascript:void(0)'><i id=\"" + pm.pcode + "\" class=\"icon\"></i><span class='title'>" + pm.pname + "</span></a>");
                    }
                    else
                    {
                        sb.Append("<li>");
                        if (!string.IsNullOrEmpty(pm.purl))
                        {
                            sb.Append("<a href='" + pm.purl + "' target=\"fcontent\"><i id=\"" + pm.pcode + "\" class=\"icon\"></i><span class='title'>" + pm.pname + "</span></a>");
                        }
                        else
                        {
                            sb.Append("<a href='javascript:void(0)' ><i id=\"" + pm.pcode + "\" class=\"icon\"></i><span class='title'>" + pm.pname + "</span></a>");
                        }
                       
                    }



                    if (secondList != null && secondList.Count > 0)
                    {
                        sb.Append("<ul class='nav collapse'>");
                    }
                    foreach (PowersModel pmchild in secondList)
                    {
                        //二级菜单编写

                        var thirdList = FGA_BLL.Cache.PowersCache.Powers.Where(p => p.pcode.StartsWith(pmchild.pcode) && (p.pcode.Length == (SysConst.CODE_STEP * 4)) && p.bz == 0).ToList();
                        thirdList = thirdList.Where(p => userModel.Powers.Contains(p.pcode)).ToList();//过滤掉没有权限的模块
                        if (thirdList != null && thirdList.Count > 0)
                        {
                            sb.Append("<li class=\"has-sub\">");
                            sb.Append("<a target=\"fcontent\" href=\"javascript:void(0)\"><span class=\"title\">" + pmchild.pname + "</span></a>");
                        }
                        else
                        {
                            sb.Append("<li>");
                            if (pmchild.purl.IndexOf("arg_bendinghome") < 0)
                                sb.Append("<a target=\"fcontent\" href=\"" + pmchild.purl + "\"><span class=\"title\">" + pmchild.pname + "</span></a>");
                            else
                                sb.Append("<a target=\"_blank\" href=\"" + pmchild.purl + "\"><span class=\"title\">" + pmchild.pname + "</span></a>");
                        }

                        if (thirdList != null && thirdList.Count > 0)
                        {
                            sb.Append("<ul class='nav collapse'>");
                        }
                        foreach (PowersModel pmchilds in thirdList)
                        {
                            //三级级菜单
                            sb.Append("<li>");
                         
                            sb.Append("<a target=\"fcontent\" href=\"" + pmchilds.purl + "\"><span class=\"title\">" + pmchilds.pname + "</span></a>");
                            sb.Append("</li>");
                        }
                        if (thirdList != null && thirdList.Count > 0)
                        {
                            sb.Append("</ul>");
                        }
                        sb.Append("</li>");
                    }
                    if (secondList != null && secondList.Count > 0)
                    {
                        sb.Append("</ul>");
                    }
                    sb.Append("</li>");
                }
                res = sb.ToString();
            }
            catch
            {
 
            }
            return res;
        }
        /// <summary>
        /// 菜单加载，攻击态势和apt场景重构页面直接打开新标签页
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string LoadMenu()
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return "";
            string result = string.Empty;
            try
            {
                result = GetMenu();

            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException("加载菜单", ex);
            }
            return result;

        }

        /// <summary>
        /// 退出
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [WebMethod]
        public static string LoginOut()
        {

            HttpContext.Current.Session[SysConst.S_LOGIN_USER] = null;


            return "";
        }

    }
}