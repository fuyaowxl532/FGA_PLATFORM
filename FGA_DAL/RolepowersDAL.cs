/*********************************************************************************************
 * 文件名       : RolepowersDAL.cs
 * 文件描述     : rolepowers 类型数据操作部分类一，包含基本操作方法
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
    public partial class RolepowersDAL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public bool AddRolepowers(RolepowersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("insert into Rolepowers ( ");
            sb.Append("rpid,roleid,pcode");
            sb.Append(") values ( ");
            sb.Append("@rpid,@roleid,@pcode");
            sb.Append(") ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@rpid", model.rpid));
            pms.Add(new SqlParameter("@roleid", model.roleid));
            pms.Add(new SqlParameter("@pcode", model.pcode));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public bool UpdateRolepowers(RolepowersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("update Rolepowers set ");
            sb.Append("roleid=@roleid, pcode=@pcode ");
            sb.Append("where 1=1 ");
            sb.Append("and rpid=@rpid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@rpid", model.rpid));
            pms.Add(new SqlParameter("@roleid", model.roleid));
            pms.Add(new SqlParameter("@pcode", model.pcode));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeleteRolepowers(RolepowersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from Rolepowers where 1=1 ");
            sb.Append("and rpid=@rpid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@rpid", model.rpid));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public RolepowersModel GetRolepowersInfo(RolepowersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Rolepowers where 1=1 ");
            sb.Append("and rpid=@rpid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@rpid", model.rpid));
             DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            return new RolepowersModel(ds.Tables[0].Rows[0]);
        }
        
        #endregion
    }
}
