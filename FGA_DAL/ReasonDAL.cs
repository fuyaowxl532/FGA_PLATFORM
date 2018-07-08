using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_MODEL;

namespace FGA_DAL
{
    public partial class ReasonDAL
    {
        #region //增删改查基本操作

        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public bool AddReasonCode(ReasonModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("insert into ReasonCode ( ");
            sb.Append("reason,reasondesc");
            sb.Append(") values ( ");
            sb.Append(",@reason,@reasondesc");
            sb.Append(") ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@reason", model.reason));
            pms.Add(new SqlParameter("@reasondesc", model.ReasonDesc));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public bool UpdateReasonCode(ReasonModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("update ReasonCode set ");
            sb.Append("reason=@reason, reasondesc=@reasondesc ");
            sb.Append("where 1=1 ");
            sb.Append("and id=@id ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@reason", model.reason));
            pms.Add(new SqlParameter("@reasondesc", model.ReasonDesc));
            pms.Add(new SqlParameter("@id", model.id));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeleteReasonCode(ReasonModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from ReasonCode where 1=1 ");
            sb.Append("and rid=@rid ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@rid", model.id));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public ReasonModel GetReasonCodeInfo(ReasonModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from ReasonCode where 1=1 ");
            sb.Append("and id=@id ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@id", model.id));
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            return new ReasonModel(ds.Tables[0].Rows[0]);
        }

        #endregion
    }
}
