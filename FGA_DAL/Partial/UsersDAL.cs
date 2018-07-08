/*********************************************************************************************
 * 文件名       : UsersDAL.cs
 * 文件描述     : users 类型数据操作部分类一，包含自定义扩展方法
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
        #region //扩展函数

        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public List<UsersModel> GetUsersList(Hashtable where)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from userinfo where 1=1 ");
            List<SqlParameter> pms = new List<SqlParameter>();
            string condition = string.Empty, orderBy = string.Empty;
            if (where != null && where.Count > 0)
            {
                foreach (DictionaryEntry item in where)
                {
                    UsersArgs key = (UsersArgs)item.Key;
                    switch (key)
                    {
                        case UsersArgs.USERNAME:
                            sb.Append(" and USERNAME like concat('%',@USERNAME,'%') ");
                            pms.Add(new SqlParameter("@USERNAME", item.Value));
                            break;
                        case UsersArgs.STATUS:
                            sb.Append(" and STATUS =@STATUS ");
                            pms.Add(new SqlParameter("@STATUS", item.Value));
                            break;
                        case UsersArgs.OrderBy:
                            orderBy = item.Value.ToString();
                            break;
                        default:
                            break;
                    }
                }
                orderBy = where == null ? string.Empty : FGA_NUtility.Convertor.ToString(where[UsersArgs.OrderBy]);
                if (!string.IsNullOrEmpty(orderBy))
                    sb.Append("order by " + orderBy);
            }
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            List<UsersModel> list = new List<UsersModel>();
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new UsersModel(row));
            return list;
        }
        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        /// <summary>
        public List<UsersModel> GetUsersListByPage(Hashtable where, SearchArgs args)
        {
            List<UsersModel> list = new List<UsersModel>();
            StringBuilder sb = new StringBuilder();
            List<SqlParameter> pms = new List<SqlParameter>();
            string condition = string.Empty, orderBy = string.Empty;
            condition = " and USERNAME!='administrator' ";
            if (where != null)
            {
                foreach (DictionaryEntry item in where)
                {
                    UsersArgs arg = (UsersArgs)item.Key;
                    switch (arg)
                    {
                        case UsersArgs.USERNAME:
                            sb.Append(" and USERNAME like @USERNAME ");
                            pms.Add(new SqlParameter("@USERNAME", "%"+item.Value+"%"));
                            break;
                        case UsersArgs.STATUS:
                            sb.Append(" and STATUS =@STATUS ");
                            pms.Add(new SqlParameter("@STATUS", item.Value));
                            break;
                        case UsersArgs.OrderBy:
                            orderBy = item.Value.ToString();
                            break;
                        default:
                            break;
                    }
                }
                condition = sb.ToString();
                sb.Length = 0;
            }
            //count
            sb.AppendLine("select count(1) as totalCount from userinfo where 1=1 ");
            sb.AppendLine(condition);
            args.TotalRecords = FGA_NUtility.Convertor.ToInt32(Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray()).Tables[0].Rows[0][0]);
            if (args.TotalRecords <= 0)
                return null;
            sb.Length = 0;
            //query
            if (!string.IsNullOrEmpty(orderBy))
                sb.Append("SELECT * FROM(SELECT ROW_NUMBER()OVER(ORDER BY " + orderBy + " )Indexs,* FROM userinfo where 1=1 ");
            else
                sb.Append("SELECT * FROM(SELECT ROW_NUMBER()OVER(ORDER BY USERID DESC)Indexs,* FROM userinfo where 1=1 ");

            sb.AppendLine(condition);
            sb.AppendLine(")Tab WHERE Tab.Indexs BETWEEN (" + args.StartIndex + ")+1 AND " + (args.StartIndex+1) + "+" + args.PageSize);
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count < 0 || ds.Tables[0].Rows.Count < 0)
                return null;
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new UsersModel(row));
            return list;
        }

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="loginid"></param>
        /// <param name="psd"></param>
        /// <returns></returns>
        public UsersModel UserLogin(string loginid, string psd)
        {
            string sql = "select * from userinfo where USERNAME=@USERNAME and PASSWORD=@PASSWORD ";
            List<SqlParameter> pms = new List<SqlParameter>(){
                new SqlParameter("@USERNAME",loginid),
                new SqlParameter("@PASSWORD",psd)
            };
            DataSet tab = SQLServerHelper.Query(sql, pms.ToArray());
            if (tab != null && tab.Tables.Count > 0 && tab.Tables[0].Rows.Count > 0)
                return new UsersModel(tab.Tables[0].Rows[0]);
            return null;
        }
        #endregion

        /// <summary>
        /// 根据loginid来获取uid
        /// </summary>
        /// <param name="loginid"></param>
        /// <returns></returns>
        public UsersModel GetModelByLoginId(string loginid)
        {
            string sql = "select * from userinfo where USERNAME=@USERNAME ";
            SqlParameter[] parameters = {
                                 new SqlParameter("@USERNAME", loginid)
                             };
            DataSet tab = Base.SQLServerHelper.Query(sql, parameters);
            if (tab != null && tab.Tables.Count > 0 && tab.Tables[0].Rows.Count > 0)
                return new UsersModel(tab.Tables[0].Rows[0]);
            return null;
        }
    }
}
