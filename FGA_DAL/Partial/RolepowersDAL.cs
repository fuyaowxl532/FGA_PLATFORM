/*********************************************************************************************
 * 文件名       : RolepowersDAL.cs
 * 文件描述     : rolepowers 类型数据操作部分类一，包含自定义扩展方法
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
        #region //扩展函数
        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public List<RolepowersModel> GetRolepowersList(Hashtable where)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Rolepowers where 1=1 ");
            List<SqlParameter> pms = new List<SqlParameter>();
            if (where != null && where.Count > 0)
            {
                foreach (DictionaryEntry item in where)
                {
                    RolepowersArgs key = (RolepowersArgs)item.Key;
                    switch (key)
                    {
                        //case RolepowersArgs.XXX:
                        //    sb.Append("and XXX=@XXX ");
                        //pms.Add(new SqlParameter("@XXX", where[key]));
                        //    break;
                        default:
                            break;
                    }
                }
                string orderBy = where == null ? string.Empty : FGA_NUtility.Convertor.ToString(where[RolepowersArgs.OrderBy]);
                if (!string.IsNullOrEmpty(orderBy))
                    sb.Append("order by " + orderBy);
            }
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count < 0 || ds.Tables[0].Rows.Count < 0)
                return null;
            List<RolepowersModel> list = new List<RolepowersModel>();
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new RolepowersModel(row));
            return list;
        }

        /// <summary>
        /// 设定
        /// </summary>
        /// <param name="roleId"></param>
        /// <param name="pCodes"></param>
        /// <returns></returns>
        public bool SetRolePowers(int roleId, List<string> pCodes)
        {
            List<string> sqls = new List<string>();
            List<SqlParameter> pms = new List<SqlParameter>();
            //sqls.Add(" delete from rolepowers where RoleID=@RoleID ");
            //pms.Add(new SqlParameter("@RoleID", roleId));
            string sql = "delete from rolepowers where RoleID='{0}' ";
            sql = string.Format(sql,roleId);
            sqls.Add(sql);
            for (int i = 0; i < pCodes.Count; i++)
            {
                //sqls.Add("insert into rolepowers(RoleID,PCode) values(@RoleID,@PCode" + i + ") ");
                //pms.Add(new SqlParameter("@PCode" + i, pCodes[i]));
                sql = "insert into rolepowers(RoleID,PCode) values('{0}','{1}') ";
                sql = string.Format(sql, roleId, pCodes[i]);
                sqls.Add(sql);
            }
            //return Base.SQLServerHelper.ExecuteSqlTran(sqls, pms);

            return Base.SQLServerHelper.ExecuteSqlTran(sqls)>0?true:false;
        }
        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        //public RolepowersModel GetRolepowersListByPage(Hashtable where,SearchArgs args)
        //{
        //    throw new NotSupportedException("Method was not supported now.");
        //}
        
        #endregion
    }
}
