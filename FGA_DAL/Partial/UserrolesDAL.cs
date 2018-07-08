/*********************************************************************************************
 * 文件名       : UserrolesDAL.cs
 * 文件描述     : userroles 类型数据操作部分类一，包含自定义扩展方法
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
        #region //扩展函数

        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public List<UserrolesModel> GetUserrolesList(Hashtable where)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Userroles where 1=1 ");
            List<SqlParameter> pms = new List<SqlParameter>();
            if (where != null && where.Count > 0)
            {
                foreach (DictionaryEntry item in where)
                {
                    UserrolesArgs key = (UserrolesArgs)item.Key;
                    switch (key)
                    {
                        //case UserrolesArgs.XXX:
                        //    sb.Append("and XXX=@XXX ");
                        //pms.Add(new SqlParameter("@XXX", where[key]));
                        //    break;
                        default:
                            break;
                    }
                }
                string orderBy = where == null ? string.Empty : FGA_NUtility.Convertor.ToString(where[UserrolesArgs.OrderBy]);
                if (!string.IsNullOrEmpty(orderBy))
                    sb.Append("order by " + orderBy);
            }
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count < 0 || ds.Tables[0].Rows.Count < 0)
                return null;
            List<UserrolesModel> list = new List<UserrolesModel>();
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new UserrolesModel(row));
            return list;
        }
        ///// <summary>
        ///// 获取分页
        ///// </summary>
        ///// <returns></returns>
        //public UserrolesModel GetUserrolesListByPage(Hashtable where, SearchArgs args)
        //{
        //    throw new NotSupportedException("Method was not supported now.");
        //}
        /// <summary>
        /// 根据uid来获得uid对应的userroles对象
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public UserrolesModel GetUserRolesModelInfo(string uid)
        {
            string sql = "select * from userroles where uid=@uid";
            List<SqlParameter> pms = new List<SqlParameter>(){
                new SqlParameter("@uid",uid)
            };
            DataSet ds = Base.SQLServerHelper.Query(sql, pms.ToArray());
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                return new UserrolesModel(ds.Tables[0].Rows[0]);
            return null;
        }



        #endregion

        /// <summary>
        /// 根据uid来更新rid
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="rid"></param>
        /// <returns></returns>
        public bool UpdateUserroles(string uid, string rid)
        {
            string sql = "update userroles set rid=@rid where uid =@uid";
            List<SqlParameter> pms = new List<SqlParameter>(){
                new SqlParameter("@rid",rid),
                new SqlParameter("@uid",uid)
            };
            int res = Base.SQLServerHelper.ExecuteSql(sql.ToString(), pms.ToArray());
            return res > 0;
        }


        /// <summary>
        /// 删除uid对应的记录
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeleteUserroles(string uid)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from Userroles where 1=1 ");
            sb.Append("and uid=@uid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@uid", uid));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
    }
}
