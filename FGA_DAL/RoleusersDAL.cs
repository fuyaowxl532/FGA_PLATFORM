/*********************************************************************************************
 * 文件名       : RoleusersDAL.cs
 * 文件描述     : roleusers 类型数据操作部分类一，包含基本操作方法
 * 历史记录     :
 * [2013-09-18 10:34:01 / xlb] create by CodeSmith 5.3
 *********************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using RP.DataModel;
using RP.DataModel.Args;
using MySql.Data.MySqlClient;
using System.Data;
using System.Collections;

namespace RP.DataAccess
{    
    public partial class RoleusersDAL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public bool AddRoleusers(RoleusersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("insert into Roleusers ( ");
            sb.Append("RUID,RoleID,UserID");
            sb.Append(") values ( ");
            sb.Append("@RUID,@RoleID,@UserID");
            sb.Append(") ");
            List<MySqlParameter> pms = new List<MySqlParameter>();
            pms.Add(new MySqlParameter("@RUID", model.RUID));
            pms.Add(new MySqlParameter("@RoleID", model.RoleID));
            pms.Add(new MySqlParameter("@UserID", model.UserID));
            int res = Base.MySQLHelper.MySQLNonQuery(sb.ToString(), pms);
            return res > 0;
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public bool UpdateRoleusers(RoleusersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("update Roleusers set ");
            sb.Append("RoleID=@RoleID, UserID=@UserID ");
            sb.Append("where 1=1 ");
            sb.Append("and RUID=@RUID ");
            List<MySqlParameter> pms = new List<MySqlParameter>();
            pms.Add(new MySqlParameter("@RUID", model.RUID));
            pms.Add(new MySqlParameter("@RoleID", model.RoleID));
            pms.Add(new MySqlParameter("@UserID", model.UserID));
            int res = Base.MySQLHelper.MySQLNonQuery(sb.ToString(), pms);
            return res > 0;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeleteRoleusers(RoleusersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from Roleusers where 1=1 ");
            sb.Append("and RUID=@RUID ");
            List<MySqlParameter> pms = new List<MySqlParameter>();
            pms.Add(new MySqlParameter("@RUID", model.RUID));
            int res = Base.MySQLHelper.MySQLNonQuery(sb.ToString(), pms);
            return res > 0;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public RoleusersModel GetRoleusersInfo(RoleusersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Roleusers where 1=1 ");
            sb.Append("and RUID=@RUID ");
            List<MySqlParameter> pms = new List<MySqlParameter>();
            pms.Add(new MySqlParameter("@RUID", model.RUID));
            DataTable dt = Base.MySQLHelper.MySQLQueryTab(sb.ToString(), pms);
            if (dt == null || dt.Rows.Count <= 0)
                return null;
            return new RoleusersModel(dt.Rows[0]);
        }
        
        #endregion
    }
}
