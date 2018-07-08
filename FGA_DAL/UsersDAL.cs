/*********************************************************************************************
 * 文件名       : UsersDAL.cs
 * 文件描述     : users 类型数据操作部分类一，包含基本操作方法
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
using FGA_DAL.Base;

namespace FGA_DAL
{    
    public partial class UsersDAL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public bool AddUsers(UsersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("insert into userinfo ( ");
            sb.Append("USERNAME,EMAIL,TEL,ACTIVEDATE,STATUS,PASSWORD,CREATEDATE");
            sb.Append(") values ( ");
            sb.Append("@USERNAME,@EMAIL,@TEL,@ACTIVEDATE,@STATUS,@PASSWORD,@CREATEDATE");
            sb.Append(") ");
            List<SqlParameter> pms = new List<SqlParameter>();
            //pms.Add(new SqlParameter("@uid", model.uid));
            pms.Add(new SqlParameter("@USERNAME", model.USERNAME));
            pms.Add(new SqlParameter("@EMAIL", model.EMAIL));
            pms.Add(new SqlParameter("@TEL", model.TEL));
            pms.Add(new SqlParameter("@ACTIVEDATE", model.ACTIVEDATE));
            pms.Add(new SqlParameter("@STATUS", model.STATUS));
            pms.Add(new SqlParameter("@PASSWORD", model.PASSWORD));
            pms.Add(new SqlParameter("@CREATEDATE", model.CREATEDATE));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public bool UpdateUsers(UsersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("update userinfo set ");
            sb.Append("USERNAME=@USERNAME,EMAIL=@EMAIL,TEL=@TEL,ACTIVEDATE=@ACTIVEDATE,STATUS=@STATUS,PASSWORD=@PASSWORD ");
            sb.Append("where 1=1 ");
            sb.Append("and USERID=@USERID ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@USERID", model.USERID));
            pms.Add(new SqlParameter("@USERNAME", model.USERNAME));
            pms.Add(new SqlParameter("@EMAIL", model.EMAIL));
            pms.Add(new SqlParameter("@TEL", model.TEL));
            pms.Add(new SqlParameter("@ACTIVEDATE", model.ACTIVEDATE));
            pms.Add(new SqlParameter("@STATUS", model.STATUS));
            pms.Add(new SqlParameter("@PASSWORD", model.PASSWORD));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeleteUsers(UsersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from userinfo where 1=1 ");
            sb.Append("and USERID=@USERID ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@USERID", model.USERID));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public UsersModel GetUsersInfo(UsersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from userinfo where 1=1 ");
            sb.Append("and USERID=@USERID ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@USERID", model.USERID));
            DataSet ds = SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            return new UsersModel(ds.Tables[0].Rows[0]);
        }
        
        #endregion
    }
}
