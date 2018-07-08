/*********************************************************************************************
 * 文件名       : UsersModel.cs
 * 文件描述     : 表模型 users 
 *********************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using FGA_NUtility;
using FGA_NUtility.Consts;

namespace FGA_MODEL
{   
    [Serializable]
    public class UsersModel
    { 
        #region //属性
        
        /// <summary>
        /// 主键
        /// </summary>
        public Int32 USERID { get; set; }
        
        public String USERNAME{ get;set; }

        public String PLEXID { get;set; }

        public string PASSWORD { get; set; }

        public string EMAIL { get; set; }

        public string TEL { get; set; }

        public DateTime ACTIVEDATE { get; set; }

        public string STATUS { get; set; }

        public DateTime CREATEDATE { get; set; }

        #endregion

        #region //扩展属性
        /// <summary>
        /// 用户所属部门名称
        /// </summary>
        public string DName { get; set; }
        /// <summary>
        /// 用户拥有的角色集合
        /// </summary>
        public List<UserrolesModel> Roles { get; set; }
        /// <summary>
        /// 用户所有角色拥有的权限集合
        /// </summary>
        public List<string> Powers { get; set; }
        /// <summary>
        /// 超级用户：administrator
        /// </summary>
        public bool IsSuperUser
        {
            get
            {
                return USERNAME.Equals(SysConst.ADMIN, StringComparison.OrdinalIgnoreCase);
            }
        }
        #endregion
        
        #region //函数
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public UsersModel()
        {
        
        }
        
        /// <summary>
        /// 根据DataRow构造函数
        /// </summary>
        public UsersModel(DataRow row)
        {
            if(row.Table.Columns.Contains("USERID"))
                USERID = Convertor.ToInt32(row["USERID"]);     
            if(row.Table.Columns.Contains("USERNAME"))
                USERNAME = Convertor.ToString(row["USERNAME"]);
              if(row.Table.Columns.Contains("PLEXID"))
                PLEXID = Convertor.ToString(row["PLEXID"]);
            if (row.Table.Columns.Contains("PASSWORD"))
                PASSWORD = Convertor.ToString(row["PASSWORD"]);
            if (row.Table.Columns.Contains("EMAIL"))
                EMAIL = Convertor.ToString(row["EMAIL"]);
            if (row.Table.Columns.Contains("TEL"))
                TEL = Convertor.ToString(row["TEL"]);
            if (row.Table.Columns.Contains("ACTIVEDATE"))
                ACTIVEDATE = Convertor.ToDateTime(row["ACTIVEDATE"]);
            if (row.Table.Columns.Contains("STATUS"))
                STATUS = Convertor.ToString(row["STATUS"]);
            if (row.Table.Columns.Contains("CREATEDATE"))
                CREATEDATE = Convertor.ToDateTime(row["CREATEDATE"]);

            DName = string.Empty;
            Roles = new List<UserrolesModel>();
            Powers = new List<string>();
        }

        #endregion
    }
}
