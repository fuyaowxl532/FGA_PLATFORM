/*********************************************************************************************
 * 文件名       : SysattachmentsDAL.cs
 * 文件描述     : Sysattachments业务逻辑类 
 * 历史记录     :
 * [2013-02-27 10:46:10 / xlb] create by CodeSmith 5.3
 *********************************************************************************************/
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using RP.DataModel;
using System.Web.UI.WebControls;
using RP.Utility.Enums;
using System.IO;
using RP.Utility.Consts;

namespace RP.BusinessLogic
{    
    public class SysattachmentsBLL
    {
        #region //增删改查基本操作
        
        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool AddSysattachments(SysattachmentsModel model)
        {
            return Common.Instance._Sysattachments.AddSysattachments(model);
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdateSysattachments(SysattachmentsModel model)
        {
            return Common.Instance._Sysattachments.UpdateSysattachments(model);
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool DeleteSysattachments(SysattachmentsModel model)
        {
            return Common.Instance._Sysattachments.DeleteSysattachments(model);
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static SysattachmentsModel GetSysattachmentsInfo(SysattachmentsModel model)
        {
            return Common.Instance._Sysattachments.GetSysattachmentsInfo(model);
        }
        #endregion
        
        #region //扩展函数
        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public static List<SysattachmentsModel> GetSysattachmentsList(Hashtable where)
        {
            return Common.Instance._Sysattachments.GetSysattachmentsList(where);
        }
         /// <summary>
        /// 删除附件记录
        /// </summary>
        /// <param name="objid"></param>
        /// <returns></returns>
        public static bool DeleteSysattachmentsByObjectID(string objid)
        {
            return Common.Instance._Sysattachments.DeleteSysattachmentsByObjectID(objid);
        }

        /// <summary>
        /// 删除指定附件信息集合的文件
        /// </summary>
        /// <param name="list"></param>
        public static void DeleteSysattchmentsFile(List<SysattachmentsModel> list) 
        {
            if (list!=null)
            {
                try
                {
                    string root = Utility.ConfigHelper.GetConfigValue("SysAttachment").TrimEnd('\\');
                    string path = string.Empty;
                    foreach (SysattachmentsModel item in list)
                    {
                        path = root + item.APath;
                        if (File.Exists(path))
                            File.Delete(path);
                    }
                }
                catch { }
            }
        }
        #endregion

        #region //文件上传

        /// <summary>
        /// 保存附件到指定目录(SysAttachment配置目录)
        /// </summary>
        /// <param name="projectId">项目编号:一级目录,等于'noticeattachment'时为通知公告附件</param>
        /// <param name="atype">文件类型:二级目录,通知公告上传时忽略该参数</param>
        /// <param name="fup">上传控件</param>
        /// <returns>保存相对路径</returns>
        [Obsolete("过期")]
        public static string SaveProjectAttachment(string projectId, int atype, FileUpload fup)
        {
            string fileName = fup.PostedFile.FileName;
            string fileFmt = fileName.Substring(fileName.LastIndexOf('.'));
            string fileSaveName = DateTime.Now.ToString("yyyyMMddHHmmss");
            string sysPath = Utility.ConfigHelper.GetConfigValue("SysAttachment").TrimEnd('\\');
            string typeCode = atype.ToString().PadLeft(2, '0');
            //保存路径
            string fileSavePath = string.Empty;
            if (projectId.Equals(SysConst.NOTICE_ATT_PROJECTID)) 
                fileSavePath = string.Format(@"{0}\{1}\", sysPath, projectId); 
            else 
                fileSavePath = string.Format(@"{0}\{1}\{2}", sysPath, projectId, typeCode);
            //保存文件
            if (!Directory.Exists(fileSavePath))
                Directory.CreateDirectory(fileSavePath);
            fup.SaveAs(string.Format(@"{0}\{1}{2}",fileSavePath,fileSaveName,fileFmt));
            //返回文件物理路径
            if (projectId.Equals(SysConst.NOTICE_ATT_PROJECTID))
                return string.Format(@"{0}\\{1}{2}", projectId, fileSaveName, fileFmt); 
            else
                return string.Format(@"{0}\\{1}\\{2}{3}", projectId, typeCode, fileSaveName, fileFmt); 
        }

        /// <summary>
        /// 保存附件文件到服务器
        /// 目录结构：附件类型/年月/文件
        /// </summary>
        /// <param name="aType">附件类型编码</param>
        /// <param name="fup">上传控件</param>
        /// <returns>文件保存路径</returns>
        public static string SaveAttachmentFile(int aType, FileUpload fup) 
        {
            try
            {
                //文件名:test.jpg
                string fileName = fup.PostedFile.FileName;
                if (fileName.IndexOf('\\') >= 0)
                    fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                //文件格式:.jpg
                string fileFmt = fileName.Substring(fileName.LastIndexOf('.'));
                //根目录
                string rootPath = Utility.ConfigHelper.GetConfigValue("SysAttachment").TrimEnd('\\');
                //相对目录：\分类编号3位码\年月\
                string savePath = "\\" + aType.ToString().PadLeft(3, '0') + "\\" + DateTime.Now.ToString("yyyyMM") + "\\";
                if (!Directory.Exists(rootPath + savePath))
                    Directory.CreateDirectory(rootPath + savePath);
                //拼接全路径，检查重复
                string fileSavePath = rootPath + savePath + fileName;
                int incNum = 1;
                while (File.Exists(fileSavePath))
                {
                    string fname = fileName.Substring(0, fileName.LastIndexOf('.'));
                    fname = fname + "_" + incNum + fileFmt;
                    fileSavePath = rootPath + savePath + fname;
                    incNum++;
                }
                //保存
                fup.SaveAs(fileSavePath);
                return fileSavePath.Replace(rootPath, string.Empty);
            }
            catch (Exception ex)
            {
                Utility.SysLog.WriteException("附件保存失败", ex);
            }
            return string.Empty;
        }
        #endregion
    }
}
