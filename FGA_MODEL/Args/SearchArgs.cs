using System;
using System.Collections.Generic;
using System.Text;

namespace FGA_MODEL.Args
{
    /// <summary>
    /// 翻页查询辅助类
    /// </summary>
    public class SearchArgs
    {
        private int pageSize = 0;
        /// <summary>
        /// 每页大小(必须)
        /// </summary>
        public int PageSize
        {
            get { return pageSize; }
            set { pageSize = value; }
        }


        private int currentIndex = 0;
        /// <summary>
        /// 当前页码(必须)
        /// </summary>
        public int CurrentIndex
        {
            get { return currentIndex; }
            set { currentIndex = value; }
        }


        private int totalRecords = 0;
        /// <summary>
        /// 总记录数(查询后赋值)
        /// </summary>
        public int TotalRecords
        {
            get { return totalRecords; }
            set { totalRecords = value; }
        }
        /// <summary>
        /// 总页数(TotalRecords赋值后直接读取)
        /// </summary>
        public int TotalPages
        {
            get
            {
                if (pageSize <= 0 || totalRecords <= 0)
                    return 0;
                int temp = totalRecords % pageSize;
                temp = (temp > 0) ? (totalRecords / pageSize + 1) : (totalRecords / pageSize);
                return temp;
            }
        }
        /// <summary>
        /// 数据记录起点索引(PageSize和CurrentIndex赋值后直接读取)
        /// </summary>
        public int StartIndex 
        {
            get 
            {
                int s = (currentIndex - 1) * pageSize;
                return s;
            }
        }
    }
}
