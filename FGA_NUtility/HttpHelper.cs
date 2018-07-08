/*****************************************************************************
辅助类
*****************************************************************************/
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace FGA_NUtility
{
    public class HttpHelper
    {
        /// <summary>
        /// 获取HTTP Get方式响应内容
        /// </summary>
        /// <param name="url">远程地址</param>
        /// <returns>响应内容</returns>
        public static string GetHttpResponse(string url,int timeout=25)
        {
            string jsonData = string.Empty;
            try
            {
                HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                request.Method = "GET";
                request.Timeout = timeout * 1000;
                request.ReadWriteTimeout = 2 * 1000;
                request.KeepAlive = true;
                HttpWebResponse response = request.GetResponse() as HttpWebResponse;
                using (Stream stream = response.GetResponseStream())
                {
                    using (StreamReader sRead = new StreamReader(stream, System.Text.Encoding.UTF8))
                    {
                        jsonData = sRead.ReadToEnd();
                    }
                }
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteError("GetHttpResponse " + url, ex);
                jsonData = "{\"error\":\"" + ex.Message + "\"}";
            }
            return jsonData;
        }

        /// <summary>
        /// 获取HTTP POST方式响应内容
        /// </summary>
        /// <param name="url">远程地址</param>
        /// <returns>响应内容</returns>
        public static string PostHttpResponse(string url, string parms, int timeout = 25)
        {
            string jsonData = string.Empty;
            try
            {
                HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                request.Method = "POST";
                request.ContentType = "application/json";
                request.Timeout = timeout * 1000;
                request.ReadWriteTimeout = 2 * 1000;
                request.KeepAlive = true;

                byte[] byteParam = System.Text.Encoding.UTF8.GetBytes(parms);
                request.ContentLength = byteParam.Length;
                Stream writer = request.GetRequestStream();
                writer.Write(byteParam, 0, byteParam.Length);
                writer.Close();

                HttpWebResponse response = request.GetResponse() as HttpWebResponse;
                using (Stream stream = response.GetResponseStream())
                {
                    using (StreamReader sRead = new StreamReader(stream, System.Text.Encoding.UTF8))
                    {
                        jsonData = sRead.ReadToEnd();
                    }
                }
            }
            catch (Exception ex)
            {
                FGA_NUtility.SysLog.WriteError("PostHttpResponse" + url, ex);
                jsonData = "{\"error\":\""+ex.Message+"\"}";
            }
            return jsonData;
        }


        /// <summary>
        /// 获取url主机部分
        /// 如 http://www.xxx.com/test/admin.aspx 返回 http://www.xxx.com/
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static string GetWebHost(string url) 
        {
            string host = string.Empty;
            Match mt = Regex.Match(url,@"http[s]*://[\S]*?/");
            if (mt != null && mt.Success)
                host = mt.Value;
            return host;
        }

        public static string GetCurrentHost() 
        {
            string url = HttpContext.Current.Request.Url.ToString();
            return GetWebHost(url);
        }
    }
}
