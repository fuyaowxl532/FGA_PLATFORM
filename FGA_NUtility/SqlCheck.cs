using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualBasic;

namespace FGA_NUtility
{
    /// <summary>
    /// 输入字符检查过滤类
    /// </summary>
    public class SqlCheck
    {
        /// <summary>
        /// //防止SQL注入方法，js验证不安全，必须后台也要验证过滤
        /// </summary>
        /// <param name="inputString"></param>
        /// <returns></returns>
        public static string CheckStr(string inputString) 
        {
            inputString = inputString.Trim();
            inputString = inputString.Replace("<", "");
            inputString = inputString.Replace(">", "");
            inputString = inputString.Replace("'", "");
            inputString = inputString.Replace("\"", "");
            inputString = inputString.Replace(";--", "");
            inputString = inputString.Replace("--", "");
            inputString = inputString.Replace("=", "");
            inputString = inputString.Replace("*", "");
            inputString = inputString.Replace("%", "");
            //and|exec|insert|select|delete|update|chr|mid|master|or|truncate|char|declare|join|count|*|%|union 等待关键字过滤
            //注意允许输入的最多字符长度 maxlength的值，太长的字符能再次拼成第一次过滤掉的关键字 如 oorr一次replace过滤后又成了 or 。
            //inputString = inputString.Replace("and", "");
            inputString = Strings.Replace(inputString, "and ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("exec", "");
            inputString = Strings.Replace(inputString, "exec ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("insert", "");
            inputString = Strings.Replace(inputString, "insert ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("select", "");
            inputString = Strings.Replace(inputString, "select ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("delete", "");
            inputString = Strings.Replace(inputString, "delete ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("update", "");
            inputString = Strings.Replace(inputString, "update ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("chr", "");
            inputString = Strings.Replace(inputString, "chr ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("mid", "");
            inputString = Strings.Replace(inputString, "mid ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("master", "");
            inputString = Strings.Replace(inputString, "master ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace(" or ", "");
            inputString = Strings.Replace(inputString, " or ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("truncate", "");
            inputString = Strings.Replace(inputString, "truncate ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("char", "");
            inputString = Strings.Replace(inputString, "char ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("declare", "");
            inputString = Strings.Replace(inputString, "declare ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("join", "");
            inputString = Strings.Replace(inputString, "join ", "", 1, -1, CompareMethod.Text); 
            //inputString = inputString.Replace("count", "");
            inputString = Strings.Replace(inputString, "count ", "", 1, -1, CompareMethod.Text); 
            
            //inputString = inputString.Replace("union", "");
            inputString = Strings.Replace(inputString, "union ", "", 1, -1, CompareMethod.Text);
            if (string.IsNullOrEmpty(inputString))
                inputString = "";
            return inputString;
        }
    }
}
