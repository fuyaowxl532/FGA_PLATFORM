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
    public partial class Sys_LogDAL
    {


        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        /// <summary>
        public List<Sys_LogModel> GetUsersListByPage(Hashtable where, SearchArgs args)
        {
            List<Sys_LogModel> list = new List<Sys_LogModel>();
            StringBuilder sb = new StringBuilder();
            List<SqlParameter> pms = new List<SqlParameter>();
            string condition = string.Empty, orderBy = string.Empty;
            if (where != null)
            {
                foreach (DictionaryEntry item in where)
                {
                    Sys_logArgs arg = (Sys_logArgs)item.Key;
                    switch (arg)
                    {
                        case Sys_logArgs.fullName:
                            sb.Append(" and fullname like concat('%',@fullname,'%') ");
                            pms.Add(new SqlParameter("@fullname", item.Value));
                            break;
                        case Sys_logArgs.type:
                              sb.Append(" and type=@type");
                              pms.Add(new SqlParameter("@type", item.Value));
                            break;
                        case Sys_logArgs.type1:
                            sb.Append(" and type1=@type1");
                            pms.Add(new SqlParameter("@type1", item.Value));
                            break;
                        //case UsersArgs.LoginId:
                        //    sb.Append(" and loginid like concat('%',@loginid,'%') ");
                        //    pms.Add(new SqlParameter("@loginid", item.Value));
                        //    break;
                        //case UsersArgs.state:
                        //    sb.Append(" and state =@state ");
                        //    pms.Add(new SqlParameter("@state", item.Value));
                        //    break;
                        case Sys_logArgs.OrderBy:
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
            sb.AppendLine("select count(*)  from sys_log s left join users u on s.Uid=u.uid  where 1=1 ");
            sb.AppendLine(condition);
            FGA_NUtility.Convertor.ToInt32(Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray()).Tables[0].Rows[0][0]);
            if (args.TotalRecords <= 0)
                return null;
            sb.Length = 0;
            //query
            if (!string.IsNullOrEmpty(orderBy))
                sb.Append("SELECT * FROM(SELECT ROW_NUMBER()OVER(ORDER BY " + orderBy + " DESC)Indexs,* FROM sys_log where 1=1 ");
            else
                sb.Append("SELECT * FROM(SELECT ROW_NUMBER()OVER(ORDER BY id DESC)Indexs,* FROM sys_log where 1=1 ");

            sb.AppendLine(condition);
            sb.AppendLine(")Tab WHERE Tab.Indexs BETWEEN ((" + args.StartIndex + ")*" + args.PageSize + ")+1 AND " + (args.StartIndex + 1) + "*" + args.PageSize);
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count < 0 || ds.Tables[0].Rows.Count < 0)
                return null;
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new Sys_LogModel(row)); 
            return list;
        }

        /// <summary>
        /// 根据where条件查询所有数据
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public List<Sys_LogModel> GetUsersListByWhere(string where)
        {
            List<Sys_LogModel> list = new List<Sys_LogModel>();
            StringBuilder sb = new StringBuilder();
            List<SqlParameter> pms = new List<SqlParameter>();
            string condition = string.Empty, orderBy = string.Empty;
            sb.Append("select id,zt,kt,action,add_time,result,type,type1,fullname,ip from sys_log s left join users u on s.Uid=u.uid  ");
            if (where != "")
            {
                sb.Append("where "+where);
            }
            sb.AppendLine(" order by add_time desc");
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count < 0 || ds.Tables[0].Rows.Count < 0)
                return null;
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new Sys_LogModel(row));
            return list;
        }

    }
}
