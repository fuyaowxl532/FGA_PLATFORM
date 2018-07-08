/*********************************************************************************************
 * 文件名       : PowersDAL.cs
 * 文件描述     : powers 类型数据操作部分类一，包含基本操作方法

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
    public partial class PowersDAL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public bool AddPowers(PowersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("insert into Powers ( ");
            sb.Append("pcode,pname,pdescription,purl,bz");
            sb.Append(") values ( ");
            sb.Append("@pcode,@pname,@pdescription,@purl,@bz");
            sb.Append(") ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@pcode", model.pcode));
            pms.Add(new SqlParameter("@pname", model.pname));
            pms.Add(new SqlParameter("@pdescription", model.pdescription));
            pms.Add(new SqlParameter("@purl", model.purl));
            pms.Add(new SqlParameter("@bz", model.bz));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public bool UpdatePowers(PowersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("update Powers set ");
            sb.Append("pname=@pname, pdescription=@pdescription, purl=@purl,bz=@bz ");
            sb.Append("where 1=1 ");
            sb.Append("and pcode=@pcode ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@pcode", model.pcode));
            pms.Add(new SqlParameter("@pname", model.pname));
            pms.Add(new SqlParameter("@pdescription", model.pdescription));
            pms.Add(new SqlParameter("@purl", model.purl));
            pms.Add(new SqlParameter("@bz", model.bz));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeletePowers(PowersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from Powers where 1=1 ");
            sb.Append("and pcode=@pcode ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@pcode", model.pcode));
            int res = Base.SQLServerHelper.ExecuteSql(sb.ToString(), pms.ToArray());
            return res > 0;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public PowersModel GetPowersInfo(PowersModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Powers where 1=1 ");
            sb.Append("and pcode=@pcode ");
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@pcode", model.pcode));
            DataSet ds = Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            return new PowersModel(ds.Tables[0].Rows[0]);
        }
        
        #endregion
    }
}
