/*********************************************************************************************
 * 文件名       : SysattachmentsDAL.cs
 * 文件描述     : sysattachments 类型数据操作部分类一，包含基本操作方法
 * 历史记录     :
 * [2013-10-09 16:23:33 / xlb] create by CodeSmith 5.3
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
    public partial class SysattachmentsDAL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model">new model</param>
        /// <returns></returns>
        public bool AddSysattachments(SysattachmentsModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("insert into Sysattachments ( ");
            sb.Append("AName,AType,APath,ACreateTime,ProjectID,ObjectID");
            sb.Append(") values ( ");
            sb.Append("@AName,@AType,@APath,@ACreateTime,@ProjectID,@ObjectID");
            sb.Append(") ");
            List<MySqlParameter> pms = new List<MySqlParameter>();
            //pms.Add(new MySqlParameter("@AID", model.AID));
            pms.Add(new MySqlParameter("@AName", model.AName));
            pms.Add(new MySqlParameter("@AType", model.AType));
            pms.Add(new MySqlParameter("@APath", model.APath));
            pms.Add(new MySqlParameter("@ACreateTime", model.ACreateTime));
            pms.Add(new MySqlParameter("@ProjectID", model.ProjectID));
            pms.Add(new MySqlParameter("@ObjectID", model.ObjectID));
            int res = Base.MySQLHelper.MySQLNonQuery(sb.ToString(), pms);
            return res > 0;
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model">model to be updated</param>
        /// <returns></returns>
        public bool UpdateSysattachments(SysattachmentsModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("update Sysattachments set ");
            sb.Append("AName=@AName, AType=@AType, APath=@APath, ACreateTime=@ACreateTime,ProjectID=@ProjectID,ObjectID=@ObjectID ");
            sb.Append("where 1=1 ");
            sb.Append("and AID=@AID ");
            List<MySqlParameter> pms = new List<MySqlParameter>();
            pms.Add(new MySqlParameter("@AID", model.AID));
            pms.Add(new MySqlParameter("@AName", model.AName));
            pms.Add(new MySqlParameter("@AType", model.AType));
            pms.Add(new MySqlParameter("@APath", model.APath));
            pms.Add(new MySqlParameter("@ACreateTime", model.ACreateTime));
            pms.Add(new MySqlParameter("@ProjectID", model.ProjectID));
            pms.Add(new MySqlParameter("@ObjectID", model.ObjectID));
            int res = Base.MySQLHelper.MySQLNonQuery(sb.ToString(), pms);
            return res > 0;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public bool DeleteSysattachments(SysattachmentsModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("delete from Sysattachments where 1=1 ");
            sb.Append("and AID=@AID ");
            List<MySqlParameter> pms = new List<MySqlParameter>();
            pms.Add(new MySqlParameter("@AID", model.AID));
            int res = Base.MySQLHelper.MySQLNonQuery(sb.ToString(), pms);
            return res > 0;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public SysattachmentsModel GetSysattachmentsInfo(SysattachmentsModel model)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from Sysattachments where 1=1 ");
            sb.Append("and AID=@AID ");
            List<MySqlParameter> pms = new List<MySqlParameter>();
            pms.Add(new MySqlParameter("@AID", model.AID));
            DataTable dt = Base.MySQLHelper.MySQLQueryTab(sb.ToString(), pms);
            if (dt == null || dt.Rows.Count <= 0)
                return null;
            return new SysattachmentsModel(dt.Rows[0]);
        }
        
        #endregion
    }
}
