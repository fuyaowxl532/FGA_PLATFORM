using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FGA_MODEL.index
{
    /// <summary>
    /// arg_bendinghome.aspx页面小车信息实体类
    /// </summary>
    public class arg_bendingModel
    {
        /// <summary>
        /// 当前小车号
        /// </summary>
        public string curcarno { get; set; }
       /// <summary>
       /// 30个小车的信息
       /// </summary>
        public List<planmodel> planlist { get; set; }
             
    }
    /// <summary>
    /// 单个小车plan信息实体
    /// </summary>
    public class planmodel
    {
        /// <summary>
        /// JobNo#
        /// </summary>
        public string jobno { get; set; }
        /// <summary>
        /// 本场编号
        /// </summary>
        public string codeitem { get; set; }
        /// <summary>
        ///小车编号（1-30）
        /// </summary>
        public string carno { get; set; }
    }
}
