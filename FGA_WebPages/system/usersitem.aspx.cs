using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_MODEL;
using FGA_BLL.UI;
using FGA_NUtility;
using FGA_BLL;
using FGA_NUtility.Consts;
using FGA_NUtility.Enums;
namespace FGA_PLATFORM.system
{
    public partial class usersitem : PageBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try //备注字段改成 IP
                {
                    if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                        return;
                    Band(); 

                    string strId = string.Empty;
                    //若不为空，要带出参数，并赋到控件上
                    if (Request.QueryString["id"] != null && Request.QueryString["id"] != string.Empty)
                    {
                        strId = Request.QueryString["id"].Trim();
                        UsersModel tmpModel = new UsersModel();
                        tmpModel.USERID = Convert.ToInt32(strId);
                        tmpModel = FGA_BLL.UsersBLL.GetUsersInfo(tmpModel);
                        this.txtLoginId.Text = tmpModel.USERNAME;
                        btnPassword.CommandName = "reset";
                        btnPassword.Text = "重置";
                        btnSave.CommandArgument = strId.ToString();
                        this.txtemail.Text = tmpModel.EMAIL;
                        this.txtPhone1.Text = tmpModel.TEL;
                        this.txtsendstarttime.Text = tmpModel.ACTIVEDATE.ToString();

                        this.ddpStatus.SelectedValue = tmpModel.STATUS.ToString();

                      //  this.txtRole.Text = FGA_BLL.Cache.UserrolesCache.GetRoleNameByUid(tmpModel.uid);
                        int userRoleid = FGA_BLL.Cache.UserrolesCache.GetRoleIDByUid(tmpModel.USERID);
                        RolesModel rm = new RolesModel();
                        rm.rid = userRoleid;
                        rm = FGA_BLL.RolesBLL.GetRolesInfo(rm);
                        if (rm.state != 1)//被禁用或删除
                            ddlRole.Items.Add(new ListItem(rm.rname + "(已" + Enum.GetName(typeof(CommonState),rm.state) + ")", rm.rid.ToString()));
                        ddlRole.SelectedValue = rm.rid.ToString();
                    }
                    else
                    {
                        //当新增记录时，状态必须是正常，且只读
                        this.ddpStatus.Enabled = false;
                        this.ddpStatus.SelectedValue = "1";
                        this.txtCreatetime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                    }
                    //判断是否可以修改
                    int isReadOnly =FGA_NUtility.Convertor.ToInt32(Request.QueryString["ro"]);
                    if (isReadOnly > 0)
                    {
                        this.btnSave.Visible = false;
                        base.EnablePageControl(this.form1.Controls, false);
                    }
                }
                catch (Exception ex)
                {
                    FGA_NUtility.SysLog.WriteException(this.GetType().Name, ex);
                }
            }
        }




        private void Band()
        {
            ddlRole.DataSource = FGA_BLL.Cache.RolesCache.Roles;
            ddlRole.DataBind();
        }

        /// <summary>
        /// 保存员工信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OnBtnSaveClick(object sender, EventArgs e)
        {
            if (Session[SysConst.S_LOGIN_USER] == null)
                return;
            try
            {
                UsersModel tmpModel = new UsersModel();



                string strId = string.Empty;
                //若不为空，是修改
                if (Request.QueryString["id"] != null && Request.QueryString["id"] != string.Empty)
                {
                    strId = Request.QueryString["id"].Trim();
                    tmpModel.USERID = Convert.ToInt32(strId);
                    tmpModel = FGA_BLL.UsersBLL.GetUsersInfo(tmpModel);
                    //当登录名有变化时，要判断登录名和系统中其它的用户名是否有重复
                    if (tmpModel.USERNAME.Trim() != this.txtLoginId.Text.Trim())
                    {
                        //判断新角色名和系统中其它的用户名是否有重复
                        if (CheckLoginIdExist(this.txtLoginId.Text.Trim()))
                        {
                            AutoCloseMessage("txtLoginId", "登录名<font color=red>" + this.txtLoginId.Text + "</font>已存在，请更换登录名！", "bottom left");
                           // ShowTopMessage(string.Format("登录名<font color=red>{0}</font>已存在，请更换登录名！", this.txtLoginId.Text), "40px", "100%");
                            //base.ShowBottomMessage(string.Format("登录名<font color=red>{0}</font>已存在，请更换登录名！", this.txtLoginId.Text.Trim()));
                            //ShowAlert("提示", string.Format("角色名{0}已存在，请更换角色名！", strRoleName));
                            return;
                        }
                    }
                    tmpModel.USERNAME = FGA_NUtility.SqlCheck.CheckStr(this.txtLoginId.Text.Trim());

                    tmpModel.STATUS = Convert.ToSByte(this.ddpStatus.SelectedValue).ToString();
                    if(!string.IsNullOrEmpty(this.txtsendstarttime.Text.Trim()))
                        tmpModel.ACTIVEDATE =Convert.ToDateTime(this.txtsendstarttime.Text);
                    tmpModel.EMAIL = this.txtemail.Text.Trim();
                    tmpModel.TEL = this.txtPhone1.Text.Trim();


                    if (FGA_BLL.UsersBLL.UpdateUsers(tmpModel))
                    {
                        RolesModel tmp1 = new RolesModel();
                       // tmp1 = FGA_BLL.RolesBLL.GetRolesModel(ddlRole.SelectedValue);
                        if (tmp1 != null)
                            FGA_BLL.UserrolesBLL.UpdateUserroles(strId, ddlRole.SelectedValue);
                        //刷新缓存
                        FGA_BLL.Cache.UsersCache.InitCache();
                        FGA_BLL.Cache.UserrolesCache.InitCache();
                        base.DoYmpromptBack(SysConst.ST_OK);

                    }
                    else
                    {
                        //ShowTopMessage("用户信息修改失败！", "40px", "100%");
                        AutoCloseMessage("btnSave", "用户信息修改失败！", "bottom right");
                    }
                }
                else
                {
                    tmpModel.USERNAME = FGA_NUtility.SqlCheck.CheckStr(this.txtLoginId.Text.Trim());
                    //判断登录名是否有重复，若重复立刻提示，并中止操作
                    if (CheckLoginIdExist(this.txtLoginId.Text.Trim()))
                    {
                        //ShowTopMessage("用户信息新增失败!", "40px", "100%");
                        AutoCloseMessage("txtLoginId", "登录名<font color=red>" + this.txtLoginId.Text + "</font>已存在，请更换登录名！", "bottom left");
                       // ShowTopMessage(string.Format("登录名<font color=red>{0}</font>已存在，请更换登录名！", this.txtLoginId.Text), "40px", "100%");
                        //ShowAlert("提示", string.Format("登录名{0}已存在，请更换登录名！", this.txtLoginId.Text));
                        return;
                    }

                    tmpModel.STATUS = Convert.ToSByte(this.ddpStatus.SelectedValue).ToString();
                    if (!string.IsNullOrEmpty(this.txtsendstarttime.Text.Trim()))
                        tmpModel.ACTIVEDATE = Convert.ToDateTime(this.txtsendstarttime.Text);
                    else
                        tmpModel.ACTIVEDATE = DateTime.Now.AddDays(7);
                    tmpModel.CREATEDATE = DateTime.Now;
                    tmpModel.EMAIL = this.txtemail.Text.Trim();
                    tmpModel.TEL = this.txtPhone1.Text.Trim();


                    //MD5三次加密
                    string psd =FGA_NUtility.ConfigHelper.GetConfigValue("DefaultPSD");
                    for (int i = 0; i < 3; i++)
                    {
                       psd = Encrypt.MD5EnCode(psd);
                    }
                    tmpModel.PASSWORD = psd;

                    if (FGA_BLL.UsersBLL.AddUsers(tmpModel))
                    {
                        //向用户角色表中增加新记录
                      //  string rid = FGA_BLL.RolesBLL.GetRolesModel(ddlRole.SelectedValue).rid.ToString();
                        string uid = FGA_BLL.UsersBLL.GetModelByLoginId(this.txtLoginId.Text).USERID.ToString();
                        UserrolesModel tmp = new UserrolesModel();
                        tmp.uid = Convert.ToInt32(uid);
                        tmp.rid = Convert.ToInt32(ddlRole.SelectedValue);
                        FGA_BLL.UserrolesBLL.AddUserroles(tmp);
                        //刷新缓存
                        FGA_BLL.Cache.UsersCache.InitCache();
                        FGA_BLL.Cache.UserrolesCache.InitCache();
                        base.DoYmpromptBack(SysConst.ST_OK);
                    }
                    else
                    {
                        //ShowBottomMessage("用户信息新增失败！");
                        //ShowTopMessage("用户信息新增失败!", "40px", "100%");
                        AutoCloseMessage("btnSave", "用户信息新增失败！", "bottom right");
                    }
                }
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException(this.GetType().Name, ex);
            }
        }

        //判断用户名是否重复
        private bool CheckLoginIdExist(string strLoginId)
        {
            UsersModel tmp = new UsersModel();
            tmp = FGA_BLL.UsersBLL.GetModelByLoginId(strLoginId);
            if (tmp == null)
                return false;
            else
                return true;
        }

        //private string ConvertToDcode(string strdeptname)
        //{
        //    return FGA_BLL.DepartmentsBLL.GetDepartmentsCode(strdeptname);
        //}

        protected void OnPasswordReset(object sender, EventArgs e)
        {
            try
            {
                int uid =FGA_NUtility.Convertor.ToInt32(btnSave.CommandArgument);
                if (uid <= 0)
                    return;
                else
                {
                    UsersModel model = new UsersModel() { USERID = uid };
                    model = FGA_BLL.UsersBLL.GetUsersInfo(model);
                    if (model == null)
                        return;
                    string defaultpsd =FGA_NUtility.ConfigHelper.GetConfigValue("DefaultPSD");
                    //三次md5加密
                    for (int i = 0; i < 3; i++)
                    {
                        defaultpsd =FGA_NUtility.Encrypt.MD5EnCode(defaultpsd);
                    }
                    model.PASSWORD = defaultpsd;

                    bool res = FGA_BLL.UsersBLL.UpdateUsers(model);


                    if (res)
                    {
                        AutoCloseMessage("btnPassword", "重置密码成功(000000)", "bottom left");
                         //ShowTopMessage("提示:重置密码成功!", "40px", "100%");
                    //ShowAlert("提示", "重置密码成功！");
                    //base.ShowBottomMessage("重置密码成功！");
                    }else
                    {
                        AutoCloseMessage("btnPassword", "重置密码失败", "bottom left");
                        //ShowTopMessage("提示:重置密码失败!", "40px", "100%");
                        //ShowAlert("提示", "重置密码失败！");
                    //base.ShowBottomMessage("重置密码失败！");
                   }
                }
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException("重置密码失败", ex);
            }
        }
    }
}