/*********************************************************************************************
 * 文件名       : PowersDAL.cs
 * 文件描述     : powers 类型数据操作部分类一，包含自定义扩展方法
 *********************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using FGA_MODEL;
using FGA_MODEL.Args;
using MySql.Data.MySqlClient;
using System.Data;
using System.Collections;
using FGA_NUtility.Consts;
using FGA_NUtility.Enums;
using System.Data.SqlClient;

namespace FGA_DAL
{
    public partial class PowersDAL
    {
        #region //扩展函数
        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public List<PowersModel> GetPowersList(Hashtable where)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from powers where 1=1 ");
            List<SqlParameter> pms = new List<SqlParameter>();
            if (where != null && where.Count > 0)
            {
                foreach (DictionaryEntry item in where)
                {
                    PowersArgs key = (PowersArgs)item.Key;
                    switch (key)
                    {
                        //case PowersArgs.XXX:
                        //    sb.Append("and XXX=@XXX ");
                        //pms.Add(new SqlParameter("@XXX", where[key]));
                        //    break;
                        default:
                            break;
                    }
                }
                string orderBy = where == null ? string.Empty : FGA_NUtility.Convertor.ToString(where[PowersArgs.OrderBy]);
                if (!string.IsNullOrEmpty(orderBy))
                    sb.Append("order by " + orderBy);
            }
            DataSet ds = FGA_DAL.Base.SQLServerHelper.Query(sb.ToString(), pms.ToArray());
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            List<PowersModel> list = new List<PowersModel>();
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new PowersModel(row));
            return list;
        }




        /// <summary>
        /// 获取一个节点编号下的最大子编号
        /// </summary>
        /// <param name="parentCode"></param>
        /// <returns></returns>
        public string GetMaxPowerCode(string parentCode)
        {
            string sql = "select max(pcode) from powers where left(pcode,@parentCodeLen)=@parentCode and len(pcode)=@childLen;";
            List<SqlParameter> pms = new List<SqlParameter>() { 
                new SqlParameter("@parentCode",parentCode),
                new SqlParameter("@parentCodeLen",parentCode.Length),
                new SqlParameter("@childLen",parentCode.Length + SysConst.CODE_STEP)
            };
            string curMax = string.Empty;
            DataSet ds = FGA_DAL.Base.SQLServerHelper.Query(sql, pms.ToArray());
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                curMax = ds.Tables[0].Rows[0][0].ToString();
            }
            if (string.IsNullOrEmpty(curMax))
                return parentCode + "001";
            curMax = curMax.Substring(parentCode.Length);
            int number = FGA_NUtility.Convertor.ToInt32(curMax);
            number++;
            curMax = number.ToString().PadLeft(3, '0');
            return parentCode + curMax;
        }

        /// <summary>
        /// 根据上级菜单 获取所有下级菜单
        /// </summary>
        /// <param name="powers"></param>
        /// <returns></returns>
        public List<PowersModel> GetAllLastMenu(string powers)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from powers where  bz = 1 ");
            //SELECT * FROM powers WHERE bz = 1 AND LEFT (pcode, LENGTH(pcode) - 3) IN  
            //( SELECT pcode FROM powers WHERE bz = 0  AND pcode IN  
            //( 001, 001001, 001002, 001003, 001003001, 001003002 ))
            // 获取到上级菜单权限里的。  然后把该下级菜单加进去
            sb.Append("  AND LEFT (pcode, LEN(pcode) - 3) IN ");
            sb.Append(" ( SELECT pcode FROM powers WHERE bz = 0  AND pcode IN  (" + powers + "))");

            DataSet ds = FGA_DAL.Base.SQLServerHelper.Query(sb.ToString(), null);
            if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
                return null;
            List<PowersModel> list = new List<PowersModel>();
            foreach (DataRow row in ds.Tables[0].Rows)
                list.Add(new PowersModel(row));
            return list;
        }


        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        //public PowersModel GetPowersListByPage(Hashtable where,SearchArgs args)
        //{
        //    throw new NotSupportedException("Method was not supported now.");
        //}
        #endregion
    }
}
