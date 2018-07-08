/*********************************************************************************************
 * 文件名       : RolesDAL.cs
 * 文件描述     : roles 类型数据操作部分类一，包含基本操作方法
 *********************************************************************************************/
using System;
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
    public partial class RolesDAL
    {
        #region //增删改查基本操作

        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public bool AddRoles(RolesModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("insert into Roles ( ");
            sb.Append("rgroup,rname,state");
            sb.Append(") values ( ");
            sb.Append("@rgroup,@rname,@state");
            sb.Append(") ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@rgroup", model.rgroup));
            pms.Add(new SqlParameter("@rname", model.rname));
            pms.Add(new SqlParameter("@state", model.state));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public bool UpdateRoles(RolesModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("update Roles set ");
            sb.Append("rgroup=@rgroup, rname=@rname, state=@state ");
            sb.Append("where 1=1 ");
            sb.Append("and rid=@rid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@rid", model.rid));
            pms.Add(new SqlParameter("@rgroup", model.rgroup));
            pms.Add(new SqlParameter("@rname", model.rname));
            pms.Add(new SqlParameter("@state", model.state));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeleteRoles(RolesModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from Roles where 1=1 ");
            sb.Append("and rid=@rid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@rid", model.rid));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public RolesModel GetRolesInfo(RolesModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Roles where 1=1 ");
            sb.Append("and rid=@rid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@rid", model.rid));
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            return new RolesModel(ds.Tables[0].Rows[0]);
        }

        #endregion
    }
}
