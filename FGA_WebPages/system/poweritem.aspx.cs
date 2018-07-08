using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FGA_BLL.UI;
using FGA_MODEL;
using FGA_NUtility.Consts;

namespace FGA_PLATFORM.system
{
    public partial class poweritem : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                    return;
                string parentCode = Request.QueryString["pcode"];
                string departCode = Request.QueryString["code"];
                if (!string.IsNullOrEmpty(parentCode))
                {
                    //传入父编码时为添加
                    btnSave.CommandName = CMD_ADD;
                    btnSave.CommandArgument = parentCode;
                }
                if (!string.IsNullOrEmpty(departCode))
                {
                    //传入编码为修改，加载旧数据
                    btnSave.CommandName = CMD_MOD;
                    btnSave.CommandArgument = departCode;
                    PowersModel model = FGA_BLL.Cache.PowersCache.Powers.Find(p => p.pcode == btnSave.CommandArgument);
                    if (model != null)
                    {
                        txtName.Text = model.pname;
                        txtUrl.Text = model.purl;
                        txtDescription.Text = model.pdescription;
                        if (model.bz == 0)
                        {
                            rdoYes.Checked = true;
                            rdoNo.Checked = false;
                        }
                        else
                        {
                            rdoNo.Checked = true;
                            rdoYes.Checked = false;
                        }
                    }
                }
            }
        }

        protected void OnBtnSaveClick(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session[SysConst.S_LOGIN_USER] == null)
                return;
            if (string.IsNullOrEmpty(btnSave.CommandName))
                return;
            PowersModel model = new PowersModel();
            if (btnSave.CommandName == CMD_MOD)
            {
                model = FGA_BLL.Cache.PowersCache.Powers.Find(p => p.pcode == btnSave.CommandArgument);
            }
            else
            {
                model.pcode = btnSave.CommandArgument;//添加时放入父节点编码，逻辑层替换    
            }
            model.pname = FGA_NUtility.SqlCheck.CheckStr(txtName.Text.Trim());
            model.purl = FGA_NUtility.SqlCheck.CheckStr(txtUrl.Text.Trim());
            model.pdescription = FGA_NUtility.SqlCheck.CheckStr(txtDescription.Text.Trim());
            model.bz = 1;
            if (rdoYes.Checked)
            {
                model.bz = 0;
            }
            //save


            bool res = false;
            if (btnSave.CommandName == CMD_ADD)
                res = FGA_BLL.PowersBLL.AddPowers(model);
            else
                res = FGA_BLL.PowersBLL.UpdatePowers(model);
                
            if (res)
            {
                FGA_BLL.Cache.PowersCache.InitCache();//刷新缓存
                base.DoYmpromptBack(string.Format("{0}{1}{2}", model.pcode, SysConst.SPLIT, model.pname));
            }
        }
    }
}