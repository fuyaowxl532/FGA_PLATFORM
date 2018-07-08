using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_BLL;
using FGA_MODEL;
using FGA_NUtility.Consts;
using FGA_BLL.UI;

namespace FGA_PLATFORM.system
{
    public partial class RolesItem : PageBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                    return;
                string strId = string.Empty;
                try
                {
                    //若不为空，要带出参数，并赋到控件上
                    if (Request.QueryString["id"] != null && Request.QueryString["id"] != string.Empty)
                    {
                        strId = Request.QueryString["id"].Trim();
                        RolesModel tmpModel = new RolesModel();
                        tmpModel.rid = Convert.ToInt32(strId);
                        tmpModel = FGA_BLL.RolesBLL.GetRolesInfo(tmpModel);
                        this.txtRoleName.Text = tmpModel.rname;
                        this.ddpStatus.SelectedValue = tmpModel.state.ToString();
                    }
                    else
                    {
                        //当新增记录时，状态必须是正常，且只读
                        this.ddpStatus.Enabled = false;
                        this.ddpStatus.SelectedValue = "1";
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

        /// <summary>
        /// 保存角色信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OnBtnSaveClick(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return;
            try
            {
                string strId = string.Empty;
                string strRoleName = FGA_NUtility.SqlCheck.CheckStr(this.txtRoleName.Text.Trim());
                string strStatus = this.ddpStatus.SelectedValue.Trim();

                RolesModel tmpModel = new RolesModel();

             
                if (Request.QueryString["id"] != null && Request.QueryString["id"] != string.Empty)
                {
                    strId = Request.QueryString["id"].Trim();

                    tmpModel.rid = Convert.ToInt32(strId);
                    tmpModel = FGA_BLL.RolesBLL.GetRolesInfo(tmpModel);
                    //当角色名有变化时，要判断角色名和系统中其它的角色名是否有重复

                    if (tmpModel.rname.Trim() != strRoleName.Trim())
                    {
                        //判断新角色名和系统中其它的角色名是否有重复
                        if (CheckRoleNameExist(strRoleName))
                        {
                           // ShowTopMessage(string.Format("角色名<font color=red>{0}</font>已存在，请更换角色名！", strRoleName), "40px", "100%");
                            AutoCloseMessage("txtRoleName", "角色名<font color=red>" + strRoleName + "</font>已存在，请更换角色名！", "bottom left");

                            //base.ShowBottomMessage(string.Format("角色名<font color=red>{0}</font>已存在，请更换角色名！", strRoleName));
                            //ShowAlert("提示", string.Format("角色名{0}已存在，请更换角色名！", strRoleName));
                            return;
                        }
                    }
                    tmpModel.rname = strRoleName;
                    tmpModel.state = Convert.ToSByte(strStatus); ;
                    if (FGA_BLL.RolesBLL.UpdateRoles(tmpModel))
                    {
                        //刷新缓存
                        FGA_BLL.Cache.RolesCache.InitCache();
                        //ShowTopMessage("角色信息修改成功！", "40px", "100%");
                        AutoCloseMessage("btnSave", "角色信息修改成功！", "bottom right");
                        base.DoYmpromptBack(SysConst.ST_OK);
                    }
                    else
                    {
                        //ShowTopMessage("角色信息修改失败！", "40px", "100%");
                        AutoCloseMessage("btnSave", "角色信息修改失败！", "bottom right");
                        //ShowBottomMessage("角色信息修改失败！");
                    }
                }
                else
                {
                    if (strRoleName.Equals(string.Empty))
                    {
                        AutoCloseMessage("txtRoleName", "角色名不可为空！", "bottom left");
                       // base.ShowTopMessage(string.Format("角色名不可为空！", strRoleName), "40px", "100%");
                        return;
                    }
                    //判断角色名是否有重复，若重复立刻提示，并中止操作
                    if (CheckRoleNameExist(strRoleName))
                    {
                        AutoCloseMessage("txtRoleName", "角色名<font color=red>" + strRoleName + "</font>已存在，请更换角色名！", "bottom left");

                        //ShowTopMessage(string.Format("角色名<font color=red>{0}</font>已存在，请更换角色名！", strRoleName), "40px", "100%");
                        //base.ShowBottomMessage(string.Format("角色名<font color=red>{0}</font>已存在，请更换角色名！", strRoleName));
                        //ShowAlert("提示", string.Format("角色名{0}已存在，请更换角色名！", strRoleName));
                        return;
                    }
                    tmpModel.rname = strRoleName;
                    tmpModel.state = Convert.ToSByte(strStatus);
                    if (FGA_BLL.RolesBLL.AddRoles(tmpModel))
                    {
                        //ShowTopMessage("角色信息新增成功！", "40px", "100%");
                        AutoCloseMessage("btnSave", "角色信息新增成功！", "bottom right");
                        //刷新缓存
                        FGA_BLL.Cache.RolesCache.InitCache();
                        base.DoYmpromptBack(SysConst.ST_OK);
                    }
                    else
                    {
                        //ShowTopMessage("角色信息新增失败！", "40px", "100%");
                        AutoCloseMessage("btnSave", "角色信息新增失败！", "bottom right");
                    }
                }

            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException(this.GetType().Name, ex);
            }
           
           
        }

        //判断角色名是否有重复，若重复立刻提示，并中止操作
        private bool CheckRoleNameExist(string strRoleName)
        {
            RolesModel tmp = new RolesModel();
            tmp = FGA_BLL.RolesBLL.GetRolesModel(strRoleName);
            if (tmp == null)
                return false;
            else
                return true;
        }
    }
}