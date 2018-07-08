using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FGA_BLL.UI
{
    /// <summary>
    /// ztree绑定实体
    /// </summary>
    public class ZTreeItem
    {
        public ZTreeItem() { }

        public string id { get; set; }

        public string pId { get; set; }

        public string name { get; set; }

        public string icon { get; set; }
        /// <summary>
        /// 扩展信息
        /// </summary>
        public string tag { get; set; }
        public string url { get; set; }
        public string des { get; set; }
        public string state { get; set; }
        public string regioncode { get; set; }
        public int bz { get; set; }
    }
    public class ZlistJsonModel
    {
        public List<ZTreeItem> zlist { get; set; }
    }
}
