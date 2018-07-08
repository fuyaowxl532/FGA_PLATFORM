/*********************************************************************************************
 * 文件名       : RolesDAL.cs
 * 文件描述     : roles 类型数据操作部分类一，包含自定义扩展方法
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
        #region //扩展函数
        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public List<RolesModel> GetRolesList(Hashtable where)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Roles where 1=1 ");
            List<SqlParameter> pms = new List<SqlParameter>();
            string condition = string.Empty, orderBy = string.Empty;
            if (where != null && where.Count > 0)
            {
                foreach (DictionaryEntry item in where)
                {
                    RolesArgs key = (RolesArgs)item.Key;
                    switch (key)
                    {
                        case RolesArgs.rname:
                            sb.Append("and rname like concat('%',@rname,'%') ");
                            pms.Add(new SqlParameter("@rname", item.Value));
                            break;
                        case RolesArgs.state:
                            sb.Append("and state=@state ");
                            pms.Add(new SqlParameter("@state", item.Value));
                            break;
                        case RolesArgs.OrderBy:
                            orderBy = item.Value.ToString();
                            break;
                        default:
                            break;
                    }
                }
                orderBy = where == null ? string.Empty : FGA_NUtility.Convertor.ToString(where[RolesArgs.OrderBy]);
                if (!string.IsNullOrEmpty(orderBy))
                    sb.Append("order by " + orderBy);
            }
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count < 0 || ds.Tables[0].Rows.Count < 0)
                return null;
            List<RolesModel> list = new List<RolesModel>();
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new RolesModel(row));
            return list;
        }
        ///// <summary>
        ///// 获取分页
        ///// </summary>
        ///// <returns></returns>
        //public RolesModel GetRolesListByPage(Hashtable where, SearchArgs args)
        //{
        //    throw new NotSupportedException("Method was not supported now.");
        //}
        #endregion

        /// <summary>
        /// 通过角色名称获得角色id
        /// </summary>
        /// <param name="strRoleName"></param>
        /// <returns></returns>
        public RolesModel GetRolesModel(string strRoleName)
        {
            string sql = "select * from Roles where rname=@rname";
            List<SqlParameter> pms = new List<SqlParameter>(){
                new SqlParameter("@rname",strRoleName)
            };
            DataSet ds = Base.SQLServerHelper.Query(sql.ToString(), pms.ToArray());
            if (ds == null && ds.Tables.Count >0 && ds.Tables[0].Rows.Count > 0)
                return new RolesModel(ds.Tables[0].Rows[0]);
            return null;
        }
        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        public  List<RolesModel> GetRolesListByPage(Hashtable where, SearchArgs args)
        {
            {
                List<RolesModel> list = new List<RolesModel>();
                StringBuilder sb = new StringBuilder();
                List<SqlParameter> pms = new List<SqlParameter>();
                string condition = string.Empty, orderBy = string.Empty;
                if (where != null)
                {
                    foreach (DictionaryEntry item in where)
                    {
                        RolesArgs arg = (RolesArgs)item.Key;
                        switch (arg)
                        {
                            case RolesArgs.rname:
                                sb.Append(" and rname like @rname ");
                                pms.Add(new SqlParameter("@rname", "%"+item.Value+"%"));
                                break;
                            case RolesArgs.state:
                                sb.Append(" and state =@state ");
                                pms.Add(new SqlParameter("@state", item.Value));
                                break;
                            case RolesArgs.OrderBy:
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
                sb.AppendLine("select count(1) as totalCount from roles where 1=1 ");
                sb.AppendLine(condition);
                args.TotalRecords = FGA_NUtility.Convertor.ToInt32(Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray()).Tables[0].Rows[0][0]);
                if (args.TotalRecords <= 0)
                    return null;
                sb.Length = 0;
                //query
                if (!string.IsNullOrEmpty(orderBy))
                    sb.Append("SELECT * FROM(SELECT ROW_NUMBER()OVER(ORDER BY " + orderBy + " DESC)Indexs,* FROM roles where 1=1 ");
                else
                    sb.Append("SELECT * FROM(SELECT ROW_NUMBER()OVER(ORDER BY rid DESC)Indexs,* FROM roles where 1=1 ");

                sb.AppendLine(condition);
                sb.AppendLine(")Tab WHERE Tab.Indexs BETWEEN ((" + args.StartIndex + ")*" + args.PageSize + ")+1 AND " + (args.StartIndex + 1) + "*" + args.PageSize);
                DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
                if (ds == null || ds.Tables.Count < 0 || ds.Tables[0].Rows.Count < 0)
                    return null;
                foreach (DataRow row in ds.Tables[0].Rows)
                    list.Add(new RolesModel(row));
                return list;
            }
        }
    }
}
