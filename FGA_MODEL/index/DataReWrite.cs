using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FGA_MODEL.index
{
    /// <summary>
    /// 将从数据库取出的数据重新封装，方便序列化成json给前端直接使用
    /// </summary>
    public class DataReWrite
    {
        /// <summary>
        /// 总条数
        /// </summary>
        public int totalRecord { get; set; }
        public List<UserReWrite> userlist { get; set; }
        public List<RoleReWrite> rolelist { get; set; }
        public List<BoxLabelReWrite> boxLabellist { get; set; }
    }
    /// <summary>
    /// 重新封装后的user,字段值可直接在前端展现
    /// </summary>
    public class UserReWrite
    {


        public String rolename { get; set; }

        /// <summary>
        /// 主键
        /// </summary>
        public Int32 USERID { get; set; }

        public String USERNAME { get; set; }

        public string PASSWORD { get; set; }

        public string EMAIL { get; set; }

        public string TEL { get; set; }

        public string  ACTIVEDATE { get; set; }

        public string STATUS { get; set; }

        public string CREATEDATE { get; set; }
    }
    /// <summary>
    /// 重新封装后的role,字段值可直接在前端展现
    /// </summary>
    public class RoleReWrite
    {
        /// <summary>
        /// 主键
        /// </summary>
        public Int32 rid{ get;set; }
        
        public String rgroup{ get;set; }  
        
        public String rname{ get;set; }  
        
        public string state{ get;set; }  
    }

    /// <summary>
    /// 重新封装后的boxlabel,字段值可直接在前端展现
    /// </summary>
    public class BoxLabelReWrite
    {
        public string PartNO { get; set; }
        public decimal BoxHeight { get; set; }
        public decimal GasketThick { get; set; }
        public string CornerType { get; set; }
        public string BaseNO { get; set; }
        public string EdgeType { get; set; }
        public string Component_Part { get; set; }
        public string Component_Type { get; set; }
        public string Creator { get; set; }
        public DateTime Createtime { get; set; }
    }



}
