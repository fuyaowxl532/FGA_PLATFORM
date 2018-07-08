using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FGA_NUtility
{
    public class SubStringHelper
    {
        /// <summary>
        /// 截取字符串
        /// </summary>
        /// <param name="str"></param>
        /// <param name="length"></param>
        /// <returns></returns>
        public static string GetShort(string str, int length)
        {
            try
            {
                if (str.Length > length)
                {
                    str = str.Substring(0,length);
                }
                return str;
            }
            catch
            {
                return str;
            }
        }
    }
}
