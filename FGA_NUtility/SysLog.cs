using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Reflection;

namespace FGA_NUtility
{
    /// <summary>
    /// 系统错误日志
    /// </summary>
    public class SysLog
    {
        /// <summary>
        /// locker
        /// </summary>
        static object _lock = new object();

        public static void WriteError(string title,Exception ex) 
        {
            DoWrite(SysLogType.ERROR,title,ex);
        }

        public static void WriteException(string title, Exception ex)
        {
            DoWrite(SysLogType.EXCEPTION, title, ex);
        }

        public static void WriteLog(string msg)
        {
            DoWrite(SysLogType.INFORMATION, msg, null);
        }

        /// <summary>
        /// 保存日志记录
        /// </summary>
        /// <param name="ex"></param>
        private static void DoWrite(SysLogType logType, string msg, Exception ex)
        {
            try
            {
                lock (_lock)
                {
                    string filepath =FGA_NUtility.ConfigHelper.GetConfigValue("LogPath");
                    if (string.IsNullOrEmpty(filepath))
                        return;
                    filepath = filepath.EndsWith("\\") ? filepath : (filepath + "\\");
                    if (!Directory.Exists(filepath))
                        Directory.CreateDirectory(filepath);
                    string fileName = filepath + DateTime.Now.ToString("yyyyMMdd") + ".log";
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("-----------------------------------------------------------------------------------");
                    sb.AppendLine(">>" + logType.ToString() + "<<      " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                    sb.AppendLine("-----------------------------------------------------------------------------------");
                    if (!string.IsNullOrEmpty(msg))
                        sb.AppendLine(msg);
                    if (ex != null)
                        sb.AppendLine(ex.ToString());
                    File.AppendAllText(fileName, sb.ToString());
                }
            }
            catch { }
        }

        /// <summary>
        /// 系统日志类型
        /// </summary>
        public enum SysLogType
        {
            /// <summary>
            /// 错误：
            /// </summary>
            ERROR,
            /// <summary>
            /// 异常：
            /// </summary>
            EXCEPTION,
            /// <summary>
            /// 信息：
            /// </summary>
            INFORMATION
        }
    }
}
