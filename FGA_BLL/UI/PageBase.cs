using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Wuqi.Webdiyer;
using FGA_NUtility.Enums;
using FGA_MODEL;
using FGA_NUtility.Consts;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;
using System.Web;
using FGA_MODEL.Args;
using System.Collections;

namespace FGA_BLL.UI
{
    public class PageBase : System.Web.UI.Page
    {
        #region //消息

        protected void DoYmpromptBack(string value)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ypt", "<script language='javascript'>window.parent.ymPrompt.doHandler('" + value + "', true);</script>");
        }

        /// <summary>
        /// 弹出提示消息框
        /// </summary>
        /// <param name="title">标题</param>
        /// <param name="msg">内容</param>
        public void ShowAlert(string title, string msg)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myscript", "<script language='javascript'>qmalert('" + title + "','" + msg + "');</script>", false);
        }
        /// <summary>
        /// 弹出提示消息框并跳转
        /// </summary>
        /// <param name="title">标题</param>
        /// <param name="msg">内容</param>
        public void ShowAlert(string title, string msg, string url)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myscript", "<script language='javascript'>qmalertto('" + title + "','" + msg + "',400,150,'" + url + "');</script>", false);
        }
        /// <summary>
        /// 在父页面上弹出提示消息框
        /// </summary>
        /// <param name="title">标题</param>
        /// <param name="msg">内容</param>
        public void ShowAlertOnParent(string title, string msg)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myscript", "<script language='javascript'>window.parent.qmalert('" + title + "','" + msg + "');</script>", false);
        }

        public void ShowBottomMessage(string msg)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myscript", "<script language='javascript'>showBottomMessage('" + msg + "');</script>", false);
        }
        /// <summary>
        /// 顶部部提示条 msg:提示信息；height:高度；指定具体高度（px）;不确定可填auto,width:宽度，指定具体宽度（px）或100%
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="height"></param>
        /// <param name="width"></param>
        public void ShowTopMessage(string msg,string height,string width)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myscript", "<script language='javascript'>showTopMessage('" + msg + "','"+height+"','"+width+"');</script>", false);
        }

         /// <summary>
        /// 气泡自动关闭提示框
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="height"></param>
        /// <param name="width"></param>
        public void AutoCloseMessage(string id,string msg,string align)
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "myscript", "<script language='javascript'>showTopMessage('" + msg + "','"+height+"','"+width+"');</script>", false);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myscript", "<script language='javascript'> AutoClose('"+id+"', '"+msg+"', '"+align+"');</script>", false);
        }

        public void AddScript(string script)
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "myscript", "<script language='javascript'>" + script + "</script>", false);
        }
        /// <summary>
        /// 客户端重定向方法 location.href (解决response自带方法在非IE浏览器下重新请求服务端的问题)
        /// </summary>
        /// <param name="url"></param>
        public void Redirect(string url)
        {
            Response.Write(string.Format("<script>location.href='{0}';</script>", url));
        }
        #endregion

        #region //操作类型
        protected const string CMD_ADD = "add";
        protected const string CMD_MOD = "mod";
        #endregion

        #region //登录用户

        /// <summary>
        /// 登录用户全部信息
        /// </summary>
        public UsersModel CurrentUser
        {
            get
            {
                UsersModel model = (UsersModel)Session[SysConst.S_LOGIN_USER];

                //model = FGA_BLL.UsersBLL.GetUsersInfo(new UsersModel() { uid = 1 });//测试：超级管理员

                if (model != null)
                {
                    //用户角色配置
                    var roles = FGA_BLL.Cache.UserrolesCache.Userroles;
                    if (roles != null)
                        model.Roles = roles.Where(r => r.uid == model.USERID).ToList();
                    //用户所拥有的全部权限(超级管理员：直接给全部权限 其他：按角色加载模块)
                    if (model.IsSuperUser)
                    {
                        var powers = FGA_BLL.Cache.PowersCache.Powers;
                        if (powers != null)
                            model.Powers = new List<string>(powers.Select(p => p.pcode).ToArray());
                    }
                    else
                    {
                        if (model.Roles != null && model.Roles.Count > 0)
                        {
                            List<int> roleids = model.Roles.Select(r => r.rid).Distinct().ToList();
                            if (roleids != null && roleids.Count > 0)
                            {

                                RolesModel rm = new RolesModel();
                                rm.rid=roleids[0];
                                rm =  FGA_BLL.RolesBLL.GetRolesInfo(rm);
                                if (rm.state == 1)//如果当前用户的角色已被删除或禁用将不具备权限
                                {
                                    var rowpowers = FGA_BLL.Cache.RolepowersCache.Rolepowers;
                                    if (rowpowers != null)
                                    {
                                        List<RolepowersModel> powers = rowpowers.Where(p => roleids.Contains(p.roleid)).ToList();
                                        if (powers != null && powers.Count > 0)
                                            model.Powers = powers.Select(p => p.pcode).Distinct().ToList();
                                    }
                                }
                            }
                        }
                    }
                }
                return model == null ? new UsersModel() : model;
            }
        }
        /// <summary>
        /// 检查用户攻击态势页面权限
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public bool AttackSituation()
        {
            var plist = FGA_BLL.Cache.PowersCache.Powers.Where(p => p.purl.Contains("attacksituation.html")).ToList();
            if (plist != null && plist.Count > 0)
            {
                if (!CheckPower(plist[0].pcode))
                {
                    return false;
                }
            }
            return true;
        }
        /// <summary>
        /// 检查当前用户权限
        /// </summary>
        /// <param name="pcode"></param>
        /// <returns></returns>
        public bool CheckPower(string pcode)
        {
            if (CurrentUser != null && CurrentUser.Powers.Contains(pcode))
                return true;
            return false;
        }
        /// <summary>
        /// 初始化检查用户登录以及页面权限
        /// </summary>
        public override void ProcessRequest(System.Web.HttpContext context)
        {
            base.ProcessRequest(context);
            string script = @"
                        var winroot = window.parent;
                        for(var i=0;i<10;i++){
                            if(winroot.parent!=null && typeof(winroot.parent)!='undefined')
                                winroot = winroot.parent;
                            else
                                break;
                        }
                        winroot.location.href='/login.aspx';
                    ";
            if (CurrentUser == null || string.IsNullOrEmpty(CurrentUser.USERNAME))
            {
                
                //context.Response.Write("<script language='javascript'>" + script + "</script>");
                context.Response.Redirect("/404.htm");
            }
            string url= context.Request.Url.AbsolutePath.ToLower();
            if (!string.IsNullOrEmpty(url)&&url.IndexOf('/')!=-1)
            {
                int i=0;
                if (url.Contains(".html"))
                {
                    i = url.IndexOf(".html") + 5;
                }
                else if (url.Contains(".htm"))
                {
                    i = url.IndexOf(".htm") + 4;
                }
                else if (url.Contains(".aspx"))
                {
                    i = url.IndexOf(".aspx") + 5;
                }
                 
                url= url.Substring(0, i);
                url = url.Substring(url.LastIndexOf('/')+1,url.Length-url.LastIndexOf('/')-1);
            }
            var plist = FGA_BLL.Cache.PowersCache.Powers.Where(p => p.purl.ToLower().Contains(url)).ToList();
            if (plist != null && plist.Count > 0)
            {
                if (!CheckPower(plist[0].pcode))
                {
                    context.Response.Redirect("/404.htm");
                    //context.Response.Write("<script language='javascript'>" + script + "</script>");
                }
            }
        }

        #endregion

        #region //分页控件初始化

        /// <summary>
        /// 设置分页控件
        /// </summary>
        /// <param name="pager"></param>
        /// <returns></returns>
        public AspNetPager ResetPager(AspNetPager pager)
        {
            pager.CssClass = "pager";
            pager.FirstPageText = "First";
            pager.LastPageText = "Last";
            pager.NextPageText = "Next";
            pager.PrevPageText = "prev";
            pager.AlwaysShow = true;
            pager.Wrap = false;
            pager.PageSize =FGA_NUtility.ConfigHelper.GetConfigInt("PageSize");
            pager.SubmitButtonText = "To";
            pager.ShowBoxThreshold = Int32.MaxValue;
            return pager;
        }

        #endregion

        #region //辅助函数
        /// <summary>
        /// 填充枚举值到下拉框
        /// </summary>
        /// <param name="enumType">枚举类型</param>
        /// <param name="ddl">下拉框</param>
        /// <param name="isShowDefault">是否首项显示-全部-项</param>
        public void ListControlItemFill(Type enumType, ListControl ddl, bool isShowDefault)
        {
            ddl.Items.Clear();
            if (isShowDefault)
                ddl.Items.Add(new ListItem("- 请选择 -", string.Empty));
            string enumName = string.Empty;
            foreach (int item in Enum.GetValues(enumType))
            {
                enumName = Enum.GetName(enumType, item);

                //符号替换
                if (enumName.StartsWith("_"))
                    enumName = enumName.Replace("_", "");
                else
                    enumName = enumName.Replace("_", "、");

                ddl.Items.Add(new ListItem(enumName, item.ToString()));
            }
        }

        /// <summary>
        /// 页面控件可用状态开关
        /// </summary>
        /// <param name="isEnable"></param>
        public void EnablePageControl(ControlCollection controls, bool isEnable)
        {
            if (controls == null || controls.Count <= 0)
                return;
            foreach (Control item in controls)
            {
                if (item is TextBox)
                {
                    TextBox tb = (TextBox)item;
                    tb.ReadOnly = !isEnable;
                    tb.Style["border"] = "0";
                    tb.Style["background-color"] = "transparent";
                    tb.Attributes["onfocus"] = "this.blur();";
                    if (tb.TextMode == TextBoxMode.MultiLine)
                        tb.Style["overflow"] = "auto";
                }
                else if (item is RadioButton)
                {
                    RadioButton tb = (RadioButton)item;
                    tb.Enabled = isEnable;
                }
                else if (item is CheckBox)
                {
                    CheckBox tb = (CheckBox)item;
                    tb.Enabled = isEnable;
                }
                else if (item is Button)
                {
                    Button tb = (Button)item;
                    tb.Enabled = isEnable;
                }
                else if (item is DropDownList)
                {
                    DropDownList ddl = (DropDownList)item;
                    ddl.Enabled = false;
                }
                EnablePageControl(item.Controls, isEnable);
            }
        }
        /// <summary>
        /// 按钮可用状态开关
        /// </summary>
        /// <param name="button"></param>
        /// <param name="isEnable"></param>
        public void EnableButton(Button button, bool isEnable)
        {
            if (isEnable)
            {
                button.Enabled = true;
                button.CssClass = "btn btn-primary";
            }
            else
            {
                button.Enabled = false;
                button.CssClass = "btn btn-default";
            }
        }
        /// <summary>
        /// 页面输出替换空字符串为符号
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        protected string PrintN(object obj)
        {
            string str = obj + string.Empty;
            if (string.IsNullOrEmpty(str))
                return SysConst.EMPTY;
            return str;
        }



        /// <summary>
        /// 当前页面是否在弹出容器中显示(用于保存信息结束后页面回传处理方式)
        /// </summary>
        public bool IsOpenInPrompt
        {
            get
            {
                string temp = Request.QueryString["prompt"];
                return !string.IsNullOrEmpty(temp);
            }
        }
        #endregion

        #region //防刷新

        /// <summary>
        /// 名称常量
        /// </summary>
        const string TOKEN_HID = "hidtoken";
        const string TOKEN_KEY = "_pagetoken";
        /// <summary>
        /// 检查token
        /// </summary>
        /// <param name="instance"></param>
        /// <returns></returns>
        public bool IsValidToken(object instance)
        {
            string reqToken = Request.Params[TOKEN_HID] + string.Empty;
            string sessionToken = Session[instance.GetType().Name + TOKEN_KEY] + string.Empty;
            return reqToken.Equals(sessionToken);
        }
        /// <summary>
        /// 生成页面token
        /// </summary>
        public void GenarateToken(object instance)
        {
            string token = Guid.NewGuid().ToString();
            HiddenField hidtoken = new HiddenField();
            hidtoken.ID = TOKEN_HID;
            hidtoken.Value = token;
            ((System.Web.UI.Page)instance).Form.Controls.Add(hidtoken);
            Session[instance.GetType().Name + TOKEN_KEY] = token;
        }

        #endregion
    }
}
