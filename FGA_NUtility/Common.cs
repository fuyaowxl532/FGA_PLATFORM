using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;

namespace FGA_NUtility
{
  public  class Common
    {
        // 时间戳转为C#格式时间
      /// <summary>
      /// 13位数字穿过来的
      /// </summary>
      /// <param name="timeStamp"></param>
      /// <returns></returns>
        public static DateTime StampToDateTime(string timeStamp)
        {
            //DateTime dateTimeStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1, 0, 0, 0));
            ////long lTime = long.Parse(timeStamp + "0000000");
            //long lTime = long.Parse(timeStamp);
            //TimeSpan toNow = new TimeSpan(lTime);

            //return dateTimeStart.Add(toNow);
            DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1)); 
            long lTime = long.Parse(timeStamp + "0000");
            TimeSpan toNow = new TimeSpan(lTime);
            return dtStart.Add(toNow);
        }
        // DateTime时间格式转换为Unix时间戳格式
        /// <summary>
        /// 13位数字
        /// </summary>
        /// <param name="timeStamp"></param>
        /// <returns></returns>
        public static long DateTimeToStamp(System.DateTime time)
        {
            //System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1));
            //return (int)(time - startTime).TotalSeconds;
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
            long t = (time.Ticks - startTime.Ticks) / 10000;   //除10000调整为13位      
            return t; 
        }
      /// <summary>
      /// 秒
      /// </summary>
      /// <param name="time"></param>
      /// <returns></returns>
        public static long DateTimeToStampSecond(System.DateTime time)
        {
            //System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1));
            //return (int)(time - startTime).TotalSeconds;
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
            long t = (time.Ticks - startTime.Ticks) / 10000000;       
            return t;
        }

       /// <summary>
       /// 传入数字，得到图片的危害等级
       /// </summary>
       /// <param name="level"></param>
       /// <returns></returns>
        public static string ConvertServersityLevel(int level)
        {
            string res = "";
            switch (level)
            {
                case 0:
                    res = "无";
                    break;
                case 1:
                    res = "<img src=\"../images/alert6.png\" title=\"低\" />";
                    break;
                case 2:
                    res = "<img src=\"../images/alert5.png\" title=\"中\" />";
                    break;
                case 3:
                    res = "<img src=\"../images/alert4.png\" title=\"高\" />";
                    break;
            }
            return res;
        }
        /// <summary>
        /// 传入数字，得到文字的危害等级
        /// </summary>
        /// <param name="level"></param>
        /// <returns></returns>
        public static string ConvertServersityLevelForText(int level)
        {
            string res = "";
            switch (level)
            {
                case 0:
                    res = "无";
                    break;
                case 1:
                    res = "低";
                    break;
                case 2:
                    res = "中";
                    break;
                case 3:
                    res = "高";
                    break;
                default:
                    res = "";
                    break;
            }
            return res;
        }

        public static string getcurrenttime()//获得字符串形式的当前时间
        {
            string timestr = "";
            timestr = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Millisecond.ToString();
            return timestr;
        }

      /// <summary>
      /// 
      /// </summary>
      /// <param name="type"></param>
      /// <returns></returns>
        public static string ConvertIcon(string type)
       {
          string res = "";
          if (!string.IsNullOrEmpty(type))
          {
              switch (type.ToLower())
              {
                  case "pdf":
                      res = "<img src=\"../images/icon/pdf.png\" title=\"pdf\" />";
                      break;
                  case "doc":
                      res = "<img src=\"../images/icon/doc.png\" title=\"doc\" />";
                      break;
                  case "docx":
                      res = "<img src=\"../images/icon/docx.png\" title=\"docx\" />";
                      break;
                  case "xls":
                      res = "<img src=\"../images/icon/xls.png\" title=\"xls\" />";
                      break;
                  case "xlxs":
                      res = "<img src=\"../images/icon/xlxs.png\" title=\"xlxs\" />";
                      break;
                  case "ppt":
                      res = "<img src=\"../images/icon/ppt.png\" title=\"ppt\" />";
                      break;
                  case "pptx":
                      res = "<img src=\"../images/icon/pptx.png\" title=\"pptx\" />";
                      break;
                  case "bmp":
                      res = "<img src=\"../images/icon/bmp.png\" title=\"bmp\" />";
                      break;
                  case "gif":
                      res = "<img src=\"../images/icon/gif.png\" title=\"gif\" />";
                      break;
                  case "html":
                      res = "<img src=\"../images/icon/html.png\" title=\"html\" />";
                      break;
                  case "htm":
                      res = "<img src=\"../images/icon/htm.png\" title=\"htm\" />";
                      break;
                  case "jpg":
                      res = "<img src=\"../images/icon/jpg.png\" title=\"jpg\" />";
                      break;
                  case "jpeg":
                      res = "<img src=\"../images/icon/jpeg.png\" title=\"jpeg\" />";
                      break;
                  case "txt":
                      res = "<img src=\"../images/icon/txt.png\" title=\"txt\" />";
                      break;
                  case "rar":
                      res = "<img src=\"../images/icon/rar.png\" title=\"rar\" />";
                      break;
                  case "zjp":
                      res = "<img src=\"../images/icon/zjp.png\" title=\"zjp\" />";
                      break;
                  default:
                      res = "<img src=\"../images/icon/unkown.png\" title=\"unkown\" />";
                      break;
              }
          }
          return res;
            
      }

        public static string ReplaceUrl(string strurl)
        {
            if (strurl.Contains("&"))
            {
                strurl = strurl.Replace("&", "¤");
            }
            if (strurl.Contains("#"))
            {
                strurl = strurl.Replace("#", "ξ");
            }
            if (strurl.Contains("?"))
            {
                strurl = strurl.Replace("?", "£");
            }
            if (strurl.Contains("+"))
            {
                strurl = strurl.Replace("+", "卍");
            }
            strurl = System.Web.HttpUtility.UrlEncode(strurl, System.Text.Encoding.UTF8);
            if (strurl.Contains("%"))
            {
                strurl = strurl.Replace("%", "⊕");
            }
            return strurl;
        }

        public static string UnReplaceUrl(string strurl)
        {
            if (strurl.Contains("⊕"))
            {
                strurl = strurl.Replace("⊕", "%");
            }
            strurl = System.Web.HttpUtility.UrlDecode(strurl, System.Text.Encoding.UTF8);
            if (strurl.Contains("¤"))
            {
                strurl = strurl.Replace("¤", "&");
            }
            if (strurl.Contains("ξ"))
            {
                strurl = strurl.Replace("ξ", "#");
            }
            if (strurl.Contains("£"))
            {
                strurl = strurl.Replace("£", "?");
            }
            if (strurl.Contains("卍"))
            {
                strurl = strurl.Replace("卍", "+");
            }
            return strurl;
        }

      /// <summary>
      /// 获取用户ip
      /// </summary>
      /// <returns></returns>
        public static string GetWebClientIp()
        {
            string userIP = "";

            try
            {
                if (System.Web.HttpContext.Current == null
            || System.Web.HttpContext.Current.Request == null
            || System.Web.HttpContext.Current.Request.ServerVariables == null)
                    return "";

                string CustomerIP = "";

                //CDN加速后取到的IP   
                CustomerIP = System.Web.HttpContext.Current.Request.Headers["Cdn-Src-Ip"];
                if (!string.IsNullOrEmpty(CustomerIP))
                {
                    return CustomerIP;
                }

                CustomerIP = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];


                if (!String.IsNullOrEmpty(CustomerIP))
                    return CustomerIP;

                if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != null)
                {
                    CustomerIP = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                    if (CustomerIP == null)
                        CustomerIP = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                }
                else
                {
                    CustomerIP = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

                }

                if (string.Compare(CustomerIP, "unknown", true) == 0)
                    return System.Web.HttpContext.Current.Request.UserHostAddress;
                return CustomerIP;
            }
            catch { }

            return userIP;
        }  


    }
}
