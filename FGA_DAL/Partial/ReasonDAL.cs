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
    public partial class ReasonDAL
    {
        #region //扩展函数
        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public List<ReasonModel> GetReasonCodeList(Hashtable where)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from ReasonCode where 1=1 ");
            List<SqlParameter> pms = new List<SqlParameter>();
            string condition = string.Empty, orderBy = string.Empty;
            //if (where != null && where.Count > 0)
            //{
                //foreach (DictionaryEntry item in where)
                //{
                //    ReasonCodeArgs key = (ReasonCodeArgs)item.Key;
                //    switch (key)
                //    {
                //        case ReasonCodeArgs.rname:
                //            sb.Append("and rname like concat('%',@rname,'%') ");
                //            pms.Add(new SqlParameter("@rname", item.Value));
                //            break;
                //        case ReasonCodeArgs.state:
                //            sb.Append("and state=@state ");
                //            pms.Add(new SqlParameter("@state", item.Value));
                //            break;
                //        case ReasonCodeArgs.OrderBy:
                //            orderBy = item.Value.ToString();
                //            break;
                //        default:
                //            break;
                //    }
                //}
            //    orderBy = where == null ? string.Empty : FGA_NUtility.Convertor.ToString(where[ReasonCodeArgs.OrderBy]);
            //    if (!string.IsNullOrEmpty(orderBy))
            //        sb.Append("order by " + orderBy);
            //}
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count < 0 || ds.Tables[0].Rows.Count < 0)
                return null;
            List<ReasonModel> list = new List<ReasonModel>();
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new ReasonModel(row));
            return list;
        }
        ///// <summary>
        ///// 获取分页
        ///// </summary>
        ///// <returns></returns>
        //public ReasonCodeModel GetReasonCodeListByPage(Hashtable where, SearchArgs args)
        //{
        //    throw new NotSupportedException("Method was not supported now.");
        //}
        #endregion

        
        ///// <summary>
        ///// 获取分页
        ///// </summary>
        ///// <returns></returns>
        //public List<ReasonCodeModel> GetReasonCodeListByPage(Hashtable where, SearchArgs args)
        //{
        //    {
        //        List<ReasonCodeModel> list = new List<ReasonCodeModel>();
        //        StringBuilder sb = new StringBuilder();
        //        List<SqlParameter> pms = new List<SqlParameter>();
        //        string condition = string.Empty, orderBy = string.Empty;
        //        if (where != null)
        //        {
        //            foreach (DictionaryEntry item in where)
        //            {
        //                ReasonCodeArgs arg = (ReasonCodeArgs)item.Key;
        //                switch (arg)
        //                {
        //                    case ReasonCodeArgs.rname:
        //                        sb.Append(" and rname like concat('%',@rname,'%') ");
        //                        pms.Add(new SqlParameter("@rname", item.Value));
        //                        break;
        //                    case ReasonCodeArgs.state:
        //                        sb.Append(" and state =@state ");
        //                        pms.Add(new SqlParameter("@state", item.Value));
        //                        break;
        //                    case ReasonCodeArgs.OrderBy:
        //                        orderBy = item.Value.ToString();
        //                        break;
        //                    default:
        //                        break;
        //                }
        //            }
        //            condition = sb.ToString();
        //            sb.Length = 0;
        //        }
        //        //count
        //        sb.AppendLine("select count(1) as totalCount from ReasonCode where 1=1 ");
        //        sb.AppendLine(condition);
        //        args.TotalRecords = FGA_NUtility.Convertor.ToInt32(Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray()).Tables[0].Rows[0][0]);
        //        if (args.TotalRecords <= 0)
        //            return null;
        //        sb.Length = 0;
        //        //query
        //        if (!string.IsNullOrEmpty(orderBy))
        //            sb.Append("SELECT * FROM(SELECT ROW_NUMBER()OVER(ORDER BY " + orderBy + " DESC)Indexs,* FROM ReasonCode where 1=1 ");
        //        else
        //            sb.Append("SELECT * FROM(SELECT ROW_NUMBER()OVER(ORDER BY rid DESC)Indexs,* FROM ReasonCode where 1=1 ");

        //        sb.AppendLine(condition);
        //        sb.AppendLine(")Tab WHERE Tab.Indexs BETWEEN ((" + args.StartIndex + ")*" + args.PageSize + ")+1 AND " + (args.StartIndex + 1) + "*" + args.PageSize);
        //        DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
        //        if (ds == null || ds.Tables.Count < 0 || ds.Tables[0].Rows.Count < 0)
        //            return null;
        //        foreach (DataRow row in ds.Tables[0].Rows)
        //            list.Add(new ReasonCodeModel(row));
        //        return list;
        //    }
        //}
    }
}
