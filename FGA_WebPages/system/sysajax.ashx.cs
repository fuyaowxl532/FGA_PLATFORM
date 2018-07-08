using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using FGA_MODEL.Args;
using FGA_BLL.UI;
using FGA_NUtility.Consts;
using FGA_MODEL;
using FGA_NUtility.Enums;
using System.Web.SessionState;
using System.Text;
using System.IO;
using FGA_BLL.Cache;
using Newtonsoft.Json.Converters;
using System.Data;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using FGA_NUtility;
using Newtonsoft.Json.Linq;

namespace FGA_PLATFORM.system
{
    /// <summary>
    /// 异步数据处理程序
    /// 参数:
    /// cmd 操作分类名称f
    /// </summary>
    public class sysajax : IHttpHandler, IRequiresSessionState
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
                //检查命令
                string cmd = context.Request["cmd"];
                if (!string.IsNullOrEmpty(cmd))
                {
                    switch (cmd)
                    {
                        #region //系统设置

                        case "treeuser"://用户获取
                            GetUserTreeJson(context);
                            break;

                        case "treepoweronlymenu"://权限获取仅限菜单
                            GetPowerTreeJsononlymenu(context);
                            break;
                        case "treepower"://权限获取
                            GetPowerTreeJson(context);
                            break;
                        case "powertreetable"://权限获取
                            GetPowerTreeJsonFortreeTable(context);
                            break;

                        case "treeroledel"://角色删除
                            DeleteRoleTreeNode(context);
                            break;

                        case "treerole"://角色获取
                            GetRoleTreeJson(context);
                            break;

                        case "rolepower"://获取角色模块
                            GetRolePowers(context);
                            break;
                        case "rolepowerset"://设置角色模块
                            SetRolePowers(context);
                            break;
                        case "userdel"://删除用户
                            DeleteUserByID(context);
                            break;

                        #endregion

                        default:
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException(this.GetType().Name, ex);
            }
        }

        /// <summary>
        /// 获取用户树
        /// </summary>
        /// <param name="context"></param>
        private void GetUserTreeJson(HttpContext context)
        {
            List<UsersModel> uList = new List<UsersModel>();
            Hashtable where = new Hashtable();
            List<ZTreeItem> zList = new List<ZTreeItem>();
            ZTreeItem zitem = new ZTreeItem();
            //[逻辑]读取用户信息添加到输出数据,超级管理员不显示,已删除不显示
            uList = FGA_BLL.Cache.UsersCache.Users.Where(u => (!u.IsSuperUser) && (u.STATUS != ((int)CommonState.disable).ToString()) && (u.STATUS != ((int)CommonState.delete).ToString())).ToList();
            if (uList != null && uList.Count > 0)
            {
                foreach (var item in uList)
                {
                    zitem = new ZTreeItem();
                    zitem.id = item.USERID.ToString();
                    zitem.pId = "";
                    zitem.name = item.USERNAME;
                    zitem.tag = "tag";
                    zitem.icon = SysConst.ICO_USER;
                    zList.Add(zitem);
                }
            }
            //输出
            string res = Newtonsoft.Json.JsonConvert.SerializeObject(zList);
            context.Response.Write(res);
        }

        /// <summary>
        /// 删除用户
        /// </summary>
        /// <param name="context"></param>
        private void DeleteUserByID(HttpContext context)
        {
            try
            {
                int uid =FGA_NUtility.Convertor.ToInt32(context.Request.QueryString["uid"]);
                UsersModel tmp = new UsersModel();
                tmp.USERID = uid;
                tmp = FGA_BLL.UsersBLL.GetUsersInfo(tmp);
                tmp.STATUS = ((int)CommonState.delete).ToString();
                bool res = FGA_BLL.UsersBLL.UpdateUsers(tmp);


                if (res)
                {
                    //同时要删除uid对应的Userroles表中的记录
                    //FGA_BLL.UserrolesBLL.DeleteUserroles(uid.ToString());
                    FGA_BLL.Cache.UsersCache.InitCache();//刷新缓存
                    context.Response.Write(SysOperateStatus.ok);

                }
                else
                {
                }
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteException(string.Empty, ex);
                context.Response.Write(SysOperateStatus.error);
            }
        }
        
        /// <summary>
        /// 设置角色模块
        /// </summary>
        /// <param name="context"></param>
        private void SetRolePowers(HttpContext context)
        {
            int roleId =FGA_NUtility.Convertor.ToInt32(context.Request.QueryString["rid"]);
            string powers = FGA_NUtility.SqlCheck.CheckStr(context.Request.QueryString["powers"]);
            powers = PowerReSet(powers);  //把详情加进去

            List<string> pList = new List<string>(powers.TrimEnd(SysConst.SPLIT_NM).Split(SysConst.SPLIT_NM));
            bool res = FGA_BLL.RolepowersBLL.SetRolePowers(roleId, pList);


            if (res)
            {
                context.Response.Write(SysOperateStatus.ok);
                FGA_BLL.Cache.RolepowersCache.InitCache();//刷新角色模块缓存
                
            }
            else 
            {
                
            }
            
        }


        private string PowerReSet(string powers)
        {
            if (!string.IsNullOrEmpty(powers))
            {
                List<PowersModel> list=FGA_BLL.PowersBLL.GetAllLastMenu(powers.Substring(0,powers.Length-1));
                if (list != null && list.Count > 0)
                {
                    foreach (PowersModel item in list)
                    {
                        powers += item.pcode + ",";
                    }
                }
               
            }
            return powers;
        }





        /// <summary>
        /// 删除角色
        /// </summary>
        /// <param name="context"></param>
        private void DeleteRoleTreeNode(HttpContext context)
        {
            int rid =FGA_NUtility.Convertor.ToInt32(context.Request.QueryString["rid"]);
            RolesModel tmp = new RolesModel();
            tmp.rid = rid;
            tmp = FGA_BLL.RolesBLL.GetRolesInfo(tmp);
            tmp.state = (int)CommonState.delete;
            bool res = FGA_BLL.RolesBLL.UpdateRoles(tmp);

            if (res)
            {
                context.Response.Write(SysOperateStatus.ok);
                FGA_BLL.Cache.RolesCache.InitCache();//刷新缓存
                FGA_BLL.Cache.UserrolesCache.InitCache();//刷新角色用户缓存
                FGA_BLL.Cache.RolepowersCache.InitCache();//刷新角色权限缓存
                
            }
            else
            {
                context.Response.Write(SysOperateStatus.error);
                
            }
        }
        private void GetRolePowers(HttpContext context)
        {
            int roleId =FGA_NUtility.Convertor.ToInt32(context.Request.QueryString["rid"]);
            if (roleId > 0)
            {
                var list = FGA_BLL.Cache.RolepowersCache.Rolepowers.Where(r => r.roleid == roleId).ToList();
                if (list != null && list.Count > 0)
                {
                    string[] codes = list.Select(i => i.pcode).ToArray();
                    context.Response.Write(string.Join(SysConst.SPLIT.ToString(), codes));
                }
            }
        }

        
        
            

        
        
            /// <summary>
        /// 获取所有模块节点
        /// </summary>
        /// <param name="context"></param>
        private void GetPowerTreeJsononlymenu(HttpContext context)
        {
            var list = FGA_BLL.Cache.PowersCache.Powers;
            list = list.Where(i => i.bz == 0).ToList(); //不展示的菜单过滤掉
            if (list != null && list.Count > 0)
            {
                List<ZTreeItem> zList = new List<ZTreeItem>();
                ZTreeItem zitem = new ZTreeItem();
                foreach (var item in list)
                {
                    zitem = new ZTreeItem();
                    zitem.id = item.pcode;
                    zitem.pId = "0";
                    if (item.pcode.Length > SysConst.CODE_STEP)
                        zitem.pId = item.pcode.Substring(0, item.pcode.Length - SysConst.CODE_STEP);
                    zitem.name = item.pname;
                    if(item.bz==0)
                        zitem.icon = SysConst.ICO_POWER;
                    else
                        zitem.icon = SysConst.ICO_POWER_DIS;
                    zitem.tag = string.Empty;
                    zList.Add(zitem);
                }
                string res = Newtonsoft.Json.JsonConvert.SerializeObject(zList);
                context.Response.Write(res);
            }
        }
               

        

        
        /// <summary>
        /// 获取所有模块节点
        /// </summary>
        /// <param name="context"></param>
        private void GetPowerTreeJson(HttpContext context)
        {
            var list = FGA_BLL.Cache.PowersCache.Powers;
            //list = list.Where(i => i.bz == 0).ToList(); //不展示的菜单过滤掉
            if (list != null && list.Count > 0)
            {
                List<ZTreeItem> zList = new List<ZTreeItem>();
                ZTreeItem zitem = new ZTreeItem();
                foreach (var item in list)
                {
                    zitem = new ZTreeItem();
                    zitem.id = item.pcode;
                    zitem.pId = "0";
                    if (item.pcode.Length > SysConst.CODE_STEP)
                        zitem.pId = item.pcode.Substring(0, item.pcode.Length - SysConst.CODE_STEP);
                    zitem.name = item.pname;
                    if(item.bz==0)
                        zitem.icon = SysConst.ICO_POWER;
                    else
                        zitem.icon = SysConst.ICO_POWER_DIS;
                    zitem.tag = string.Empty;
                    zList.Add(zitem);
                }
                string res = Newtonsoft.Json.JsonConvert.SerializeObject(zList);
                context.Response.Write(res);
            }
        }
        /// <summary>
        /// 获取权限powertreetable
        /// </summary>
        /// <param name="context"></param>
        private void GetPowerTreeJsonFortreeTable(HttpContext context)
        {
            var list = FGA_BLL.Cache.PowersCache.Powers;
           // list = list.Where(i => i.bz == 0).ToList(); //不展示的菜单过滤掉

            if (list != null && list.Count > 0)
            {
                ZlistJsonModel zjm = new ZlistJsonModel();
                List<ZTreeItem> zList = new List<ZTreeItem>();
                ZTreeItem zitem = new ZTreeItem();
                foreach (var item in list)
                {
                    zitem = new ZTreeItem();
                    zitem.id = item.pcode;
                    zitem.pId = "0";
                    if (item.pcode.Length > SysConst.CODE_STEP)
                        zitem.pId = item.pcode.Substring(0, item.pcode.Length - SysConst.CODE_STEP);
                    zitem.name = item.pname;
                    zitem.icon = string.Empty;
                    zitem.tag = string.Empty;
                    zitem.url = item.purl;
                    zitem.des = item.pdescription;
                    zitem.bz = item.bz;
                    zList.Add(zitem);
                }
                zjm.zlist = zList;
                string res = Newtonsoft.Json.JsonConvert.SerializeObject(zjm);
                context.Response.Write(res);
            }
        }
        /// <summary>
        /// 获取角色节点(不依附于部门)
        /// </summary>
        /// <param name="context"></param>
        private void GetRoleTreeJson(HttpContext context)
        {
            var list = FGA_BLL.Cache.RolesCache.Roles;
            if (list != null && list.Count > 0)
            {
                List<ZTreeItem> zList = new List<ZTreeItem>();
                ZTreeItem zitem = new ZTreeItem();
                //输出角色信息
                foreach (var item in list)
                {
                    zitem = new ZTreeItem();
                    zitem.id = item.rid.ToString();
                    zitem.pId = "0";
                    zitem.name = item.rname;
                    zitem.tag = item.state.ToString();
                    zitem.icon = item.state > 0 ? SysConst.ICO_USER : SysConst.ICO_USER_DIS;
                    zList.Add(zitem);
                }
                //输出
                string res = Newtonsoft.Json.JsonConvert.SerializeObject(zList);
                context.Response.Write(res);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}