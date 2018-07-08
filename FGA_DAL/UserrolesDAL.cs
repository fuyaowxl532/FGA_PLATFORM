/*********************************************************************************************
 * 文件名       : UserrolesDAL.cs
 * 文件描述     : userroles 类型数据操作部分类一，包含基本操作方法
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
    public partial class UserrolesDAL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public bool AddUserroles(UserrolesModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("insert into Userroles ( ");
            sb.Append("uid,rid");
            sb.Append(") values ( ");
            sb.Append("@uid,@rid");
            sb.Append(") ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@uid", model.uid));
            pms.Add(new SqlParameter("@rid", model.rid));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public bool UpdateUserroles(UserrolesModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("update Userroles set ");
            sb.Append("uid=@uid, rid=@rid ");
            sb.Append("where 1=1 ");
            sb.Append("and urid=@urid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@urid", model.urid));
            pms.Add(new SqlParameter("@uid", model.uid));
            pms.Add(new SqlParameter("@rid", model.rid));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeleteUserroles(UserrolesModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from Userroles where 1=1 ");
            sb.Append("and urid=@urid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@urid", model.urid));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public UserrolesModel GetUserrolesInfo(UserrolesModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Userroles where 1=1 ");
            sb.Append("and urid=@urid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@urid", model.urid));
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            return new UserrolesModel(ds.Tables[0].Rows[0]);
        }
        
        #endregion
    }
}
