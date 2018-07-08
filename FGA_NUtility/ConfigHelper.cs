using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Runtime.InteropServices;
using System.Collections;
using System.IO;
using System.Xml;

namespace FGA_NUtility
{
    /// <summary>
    /// 提供配置文件读取辅助函数
    /// </summary>
    public class ConfigHelper
    {
        /// <summary>
        /// 获取配置字符串
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static string GetConfigValue(string key) 
        {
            return ConfigurationManager.AppSettings[key] + string.Empty;
        }
        /// <summary>
        /// 获取配置数字
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static int GetConfigInt(string key) 
        {
            return FGA_NUtility.Convertor.ToInt32(GetConfigValue(key));
        }

        /// <summary>
        /// 获取配置开关
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static bool GetConfigBool(string key)
        {
            string value = GetConfigValue(key).ToLower();
            if (value == "1" || value == "true" || value == "y")
                return true;
            return false;
        }

        /// <summary>
        /// 获取配置字符串数组
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static List<string> GetConfigList(string key,char split)
        {
            string str = GetConfigValue(key);
            string[]ary = str.Split(split);
            return new List<string>(ary);
        }
    }
}
