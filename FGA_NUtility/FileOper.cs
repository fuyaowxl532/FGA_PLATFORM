using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using System.Diagnostics;
using ICSharpCode.SharpZipLib.Core;
using System.Net;
using System.Net.Security;

namespace FGA_NUtility
{
    /// <summary>
    /// 文件操作
    /// </summary>
    public class FileOper
    {
        public static void CreateZipFile(string filesPath, string zipFilePath)
        {

            if (!File.Exists(filesPath))
            {
                //Console.WriteLine("Cannot find directory '{0}'", filesPath);
                return;
            }

            try
            {
                //string[] filenames = Directory.GetFiles(filesPath);
                string[] filenames = { filesPath };
                using (ZipOutputStream s = new ZipOutputStream(File.Create(zipFilePath)))
                {

                    s.SetLevel(9); // 压缩级别 0-9
                    //s.Password = "123"; //Zip压缩文件密码
                    byte[] buffer = new byte[4096]; //缓冲区大小
                    foreach (string file in filenames)
                    {
                        ZipEntry entry = new ZipEntry(Path.GetFileName(file));
                        entry.DateTime = DateTime.Now;
                        s.PutNextEntry(entry);
                        using (FileStream fs = File.OpenRead(file))
                        {
                            int sourceBytes;
                            do
                            {
                                sourceBytes = fs.Read(buffer, 0, buffer.Length);
                                s.Write(buffer, 0, sourceBytes);
                            } while (sourceBytes > 0);
                        }
                    }
                    s.Finish();
                    s.Close();
                }
            }
            catch (Exception ex)
            {
                //Console.WriteLine("Exception during processing {0}", ex);
            }
        }

        public static bool UnZipFile(string zipFilePath,string UnzipFilePath)
        {
            try
            {
                if (!File.Exists(zipFilePath))
                {
                    //Console.WriteLine("Cannot find file '{0}'", zipFilePath);
                    return false;
                }

                using (ZipInputStream s = new ZipInputStream(File.OpenRead(zipFilePath)))
                {
                    s.Password = "@abcde#";
                    ZipEntry theEntry;
                    while ((theEntry = s.GetNextEntry()) != null)
                    {

                        //Console.WriteLine(theEntry.Name);

                        string directoryName = Path.GetDirectoryName(theEntry.Name);
                        string fileName = Path.GetFileName(theEntry.Name);

                        // create directory
                        if (directoryName.Length > 0)
                        {
                            Directory.CreateDirectory(directoryName);
                        }

                        if (fileName != String.Empty)
                        {
                            using (FileStream streamWriter = File.Create(UnzipFilePath + theEntry.Name))
                            {

                                int size = 2048;
                                byte[] data = new byte[2048];
                                while (true)
                                {
                                    size = s.Read(data, 0, data.Length);
                                    if (size > 0)
                                    {
                                        streamWriter.Write(data, 0, size);
                                    }
                                    else
                                    {
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch
            {
                return false;
            }
            return true;
        }
        /// <summary>   
        /// 从文件读取 Stream  
        /// </summary>   
        public static Stream FileToStream(string fileName)
        {
            // 打开文件   
            FileStream fileStream = new FileStream(fileName, FileMode.Open, FileAccess.Read, FileShare.Read);
            // 读取文件的 byte[]   
            byte[] bytes = new byte[fileStream.Length];
            fileStream.Read(bytes, 0, bytes.Length);
            fileStream.Close();
            // 把 byte[] 转换成 Stream   
            Stream stream = new MemoryStream(bytes);
            return stream;
        }  
    }
}
