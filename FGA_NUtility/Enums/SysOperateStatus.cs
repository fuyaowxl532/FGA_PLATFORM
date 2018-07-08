using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FGA_NUtility.Enums
{
    /// <summary>
    /// 系统操作结果状态枚举
    /// </summary>
    public enum SysOperateStatus
    {
        /// <summary>
        /// 操作成功
        /// </summary>
        ok,
        /// <summary>
        /// 数据原因导致的错误
        /// </summary>
        dataerror,
        /// <summary>
        /// 未知错误
        /// </summary>
        error
    }
}
