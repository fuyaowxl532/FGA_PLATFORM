using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace FGA_NUtility
{
    /// <summary>
    /// 提供一系列函数转换函数
    /// </summary>
    public class Convertor
    {
        public static readonly DateTime SysMinDateTime = DateTime.Parse("1900-01-01");

        public static Boolean ToBoolean(object @value)
        {
            if (@value != null)
            {
                string temp = @value.ToString().Trim().ToUpper();
                if ("TRUE".Equals(temp))
                    return true;
                if ("1".Equals(temp))
                    return true;
            }
            return false;
        }


        public static Byte ToByte(object @value)
        {
            if (@value == null)
                return 0;
            Byte bt = 0;
            if (Byte.TryParse(@value.ToString(), out bt))
                return bt;
            else
                return 0;
        }

        public static SByte ToSByte(object @value)
        {
            if (@value == null)
                return 0;
            SByte bt = 0;
            if (SByte.TryParse(@value.ToString(), out bt))
                return bt;
            else
                return 0;
        }

        public static Int16 ToInt16(object @value)
        {
            if (@value == null)
                return 0;
            Int16 i;
            if (Int16.TryParse(@value.ToString(), out i))
                return i;
            else
                return 0;
        }

        public static UInt16 ToUInt16(object @value)
        {
            if (@value == null)
                return 0;
            UInt16 i;
            if (UInt16.TryParse(@value.ToString(), out i))
                return i;
            else
                return 0;
        }

        public static Int32 ToInt32(object @value)
        {
            if (@value == null)
                return 0;
            Int32 i;
            if (Int32.TryParse(@value.ToString(), out i))
                return i;
            else
                return 0;
        }

        public static UInt32 ToUInt32(object @value)
        {
            if (@value == null)
                return 0;
            UInt32 i;
            if (UInt32.TryParse(@value.ToString(), out i))
                return i;
            else
                return 0;
        }

        public static Int64 ToInt64(object @value)
        {
            if (@value == null)
                return 0;
            Int64 i;
            if (Int64.TryParse(@value.ToString(), out i))
                return i;
            else
                return 0;
        }

        public static UInt64 ToUInt64(object @value)
        {
            if (@value == null)
                return 0;
            UInt64 i;
            if (UInt64.TryParse(@value.ToString(), out i))
                return i;
            else
                return 0;
        }


        public static Decimal ToDecimal(object @value)
        {
            if (@value == null)
                return decimal.Zero;
            decimal d;
            if (decimal.TryParse(@value.ToString(), out d))
                return d;
            else
                return decimal.Zero;
        }

        public static Double ToDouble(object @value)
        {
            if (@value == null)
                return 0D;
            double d;
            if (double.TryParse(@value.ToString(), out d))
                return d;
            else
                return 0D;
        }

        public static String ToString(object obj)
        {
            if (obj == null)
                return string.Empty;
            else
                return obj.ToString().Trim();
        }

        public static DateTime ToDateTime(object obj)
        {
            if (obj == null)
                return SysMinDateTime;
            DateTime dt = SysMinDateTime;
            DateTime.TryParse(obj.ToString(), out dt);
            dt = dt <= SysMinDateTime ? SysMinDateTime : dt;
            return dt;
        }

        public static Guid ToGuid(object obj)
        {
            if (obj == null)
                return Guid.Empty;
            else
            {
                string str = ToString(obj);
                if (System.Text.RegularExpressions.Regex.IsMatch(str, "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", System.Text.RegularExpressions.RegexOptions.IgnoreCase))
                    return new Guid(str);
                else
                    return Guid.Empty;
            }
        }


        public static string XmlRemove(object inputObj, int maxLen_output)
        {
            string input = ToString(inputObj);
            input = Regex.Replace(input, @"<script[\s\S]*?>[\s\S]*?>", string.Empty, RegexOptions.IgnoreCase);
            input = Regex.Replace(input, @"<[\s\S]*?>|&lt;[\s\S]*?&gt;|&nbsp;|\s", string.Empty, RegexOptions.IgnoreCase);
            input = Regex.Replace(input, @"&lt;[\s\S]*?&gt;", string.Empty, RegexOptions.IgnoreCase);
            input = Regex.Replace(input, @"<[\s\S]*?>", string.Empty, RegexOptions.IgnoreCase);
            if (maxLen_output > 0 && input.Length > maxLen_output)
                return input.Substring(0, maxLen_output) + " ...";
            else
                return input;
        }

        public static string ToShortDateString(object obj)
        {
            DateTime dt = ToDateTime(obj);
            if (dt <= SysMinDateTime)
                return string.Empty;
            return dt.ToString("MM-dd HH:mm:ss");
        }

        public static string ToDateString(object obj, bool isDate)
        {
            DateTime dt = ToDateTime(obj);
            if (dt <= SysMinDateTime)
                return string.Empty;
            if (isDate)
                return dt.ToString("yyyy-MM-dd");
            else
                return dt.ToString("yyyy-MM-dd HH:mm:ss");
        }

        public static string GetEnumName(Type tp, object obj)
        {
            int value = ToInt32(obj);
            if (tp == null || value < 0)
                return string.Empty;
            string enumName = string.Empty;
            foreach (int i in Enum.GetValues(tp))
            {
                if (value == i)
                {
                    enumName = Enum.GetName(tp, i);
                    break;
                }
            }

            //符号替换
            if (enumName.StartsWith("_"))
                enumName = enumName.Replace("_", "");
            else
                enumName = enumName.Replace("_", "、");

            return enumName;
        }
        // 时间戳转为C#格式时间
        public static DateTime StampToDateTime(string timeStamp)
        {
            DateTime dateTimeStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            long lTime = long.Parse(timeStamp+"0000");
            TimeSpan toNow = new TimeSpan(lTime);

            return dateTimeStart.Add(toNow);
        }
        // DateTime时间格式转换为Unix时间戳格式
        public static long DateTimeToStamp(System.DateTime time)
        {
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1));
            return (long)(time - startTime).TotalMilliseconds;
        }
        /// <summary>
        /// 将IPv4格式的字符串转换为long型表示
        /// </summary>
        /// <param name="strIPAddress">IPv4格式的字符</param>
        /// <returns></returns>
        public static long IPToNumber(string strIPAddress)
        {
            //将目标IP地址字符串strIPAddress转换为数字
            string[] arrayIP = strIPAddress.Split('.');
            long sip1 = Int64.Parse(arrayIP[0]);
            long sip2 = Int64.Parse(arrayIP[1]);
            long sip3 = Int64.Parse(arrayIP[2]);
            long sip4 = Int64.Parse(arrayIP[3]);
            long tmpIpNumber;
            tmpIpNumber = sip1 * 256 * 256 * 256 + sip2 * 256 * 256 + sip3 * 256 + sip4;
            return tmpIpNumber;
        }



        /// <summary>
        /// 将long型表示的IP还原成正常IPv4格式。
        /// </summary>
        /// <param name="intIPAddress">数值型的IP</param>
        /// <returns>计算好的IP地址</returns>
        public static string NumberToIP(long n_ip)
        {   //临时用于装载需要计算的ip字符串的数值
            long tmp_ip = n_ip;
            //返回计算好的ip地址字符串
            string str_ip = string.Empty;

            for (int i = 3; i >= 0; i--)
            {  //整除得到当前节点ip字符串
                str_ip += tmp_ip / Convert.ToInt64(Math.Pow(256, i));
                //判断是否为最后不用加.
                str_ip += (i > 0 ? "." : "");
                //取余得到下级需要计算的ip字符串的数值
                tmp_ip = n_ip % Convert.ToInt64(Math.Pow(256, i));
            }

            return str_ip;
        }
    }
}
