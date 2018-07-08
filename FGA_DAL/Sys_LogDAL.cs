/*********************************************************************************************
 * 文件名       : Sys_LogDAL.cs
 * 文件描述     : sys_log 类型数据操作部分类一，包含基本操作方法
 *********************************************************************************************/
using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using FGA_MODEL;
using FGA_MODEL.Args;
using MySql.Data.MySqlClient;
using System.Data;
using System.Collections;
using System.Data.SqlClient;

namespace FGA_DAL
{    
    public partial class Sys_LogDAL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增 zt：页面名 kt：方法名  action：类型，是常规性日志还是出错信息 result：日志详细信息  type：一级菜单 type1:二级菜单
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public bool AddSys_Log(Sys_LogModel model)
        {
            string ip = HttpContext.Current.Request.UserHostAddress == "::1" ? "127.0.0.1" : HttpContext.Current.Request.UserHostAddress;
            model.ip = ip;
            StringBuilder sb = new StringBuilder();
            sb.Append("insert into Sys_Log ( ");
            sb.Append("id,zt,kt,action,result,type,type1,uid,ip");
            sb.Append(") values ( ");
            sb.Append("@id,@zt,@kt,@action,@result,@type,@type1,@uid,@ip");
            sb.Append(") ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@id", model.id));
            pms.Add(new SqlParameter("@zt", model.zt));
            pms.Add(new SqlParameter("@kt", model.kt));
            pms.Add(new SqlParameter("@action", model.action));
           // pms.Add(new SqlParameter("@add_time", model.add_time));
            pms.Add(new SqlParameter("@result", model.result));
            pms.Add(new SqlParameter("@type", model.type));
            pms.Add(new SqlParameter("@type1", model.type1));
            pms.Add(new SqlParameter("@uid", model.uid));
            pms.Add(new SqlParameter("@ip", model.ip));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 改  zt：页面名 kt：方法名  action：类型，是常规性日志还是出错信息 result：日志详细信息  type：模块
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public bool UpdateSys_Log(Sys_LogModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("update Sys_Log set ");
            sb.Append("zt=@zt, kt=@kt, action=@action, result=@result, type=@type,type1=@type1,uid=@uid,ip=@ip ");
            sb.Append("where 1=1 ");
            sb.Append("and id=@id ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@id", model.id));
            pms.Add(new SqlParameter("@zt", model.zt));
            pms.Add(new SqlParameter("@kt", model.kt));
            pms.Add(new SqlParameter("@action", model.action));
          //  pms.Add(new SqlParameter("@add_time", model.add_time));
            pms.Add(new SqlParameter("@result", model.result));
            pms.Add(new SqlParameter("@type", model.type));
            pms.Add(new SqlParameter("@type1", model.type1));
            pms.Add(new SqlParameter("@uid", model.uid));
            pms.Add(new SqlParameter("@ip", model.ip));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeleteSys_Log(Sys_LogModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from Sys_Log where 1=1 ");
            sb.Append("and id=@id ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@id", model.id));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public Sys_LogModel GetSys_LogInfo(Sys_LogModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Sys_Log where 1=1 ");
            sb.Append("and id=@id ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@id", model.id));
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            return new Sys_LogModel(ds.Tables[0].Rows[0]);
        }


       
        
        #endregion
    }
}
