using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RP.DataModel;
using System.Collections;
using RP.DataModel.Args; 
using System.IO;

namespace RP.BusinessLogic
{
    public class NoticesBLL
    {
        #region //增删改查基本操作
        /// <summary>
        /// 添加通告信息（同时添加附件信息）
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool AddNotices(NoticesModel model)
        {
            int nid = Common.Instance._Notices.AddNoticesReturnID(model);
            //添加附件信息
            if (nid > 0 && model.Attachments != null)
            {
                for (int i = 0; i < model.Attachments.Count; i++)
                {
                    model.Attachments[i].ObjectID = nid.ToString();
                    SysattachmentsBLL.AddSysattachments(model.Attachments[i]);
                }
            }
            return nid > 0;
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdateNotices(NoticesModel model)
        {
            bool res = Common.Instance._Notices.UpdateNotices(model);
            if (res && model.Attachments!=null && model.Attachments.Count>0)
            {
                //增加新增的附件
                for (int i = 0; i < model.Attachments.Count; i++)
                {
                    if (model.Attachments[i].AID <= 0)
                    {
                        model.Attachments[i].ObjectID = model.NID.ToString();
                        SysattachmentsBLL.AddSysattachments(model.Attachments[i]);
                    }
                }
            }
            return res;
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool DeleteNotices(int nid)
        {
            //[逻辑]删除前找到通知附件，删除成功后进行删除
            List<SysattachmentsModel> attlist = null;
            try
            {
                Hashtable where = new Hashtable();
                where.Add(SysattachmentsArgs.ObjectID, nid);
                attlist = BusinessLogic.SysattachmentsBLL.GetSysattachmentsList(where);
            }
            catch { }
            //删除合同
            bool res = Common.Instance._Notices.DeleteNoticesAll(nid);
            if (res && attlist != null && attlist.Count > 0)
            {
                BusinessLogic.SysattachmentsBLL.DeleteSysattchmentsFile(attlist);
            }
            return res;
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static NoticesModel GetNoticesInfo(NoticesModel model)
        {
            model = Common.Instance._Notices.GetNoticesInfo(model);
            if (model != null)
            {
                //附件
                Hashtable where = new Hashtable();
                where.Add(SysattachmentsArgs.ObjectID, model.NID);
                var list = SysattachmentsBLL.GetSysattachmentsList(where);
                if (list != null && list.Count > 0)
                    model.Attachments = list;
                //创建人名
                model.NCreaterName = BusinessLogic.Cache.UsersCache.GetName(model.NCreater);
            }
            return model;
        }
        #endregion

        #region //扩展函数
        /// <summary>
        /// 获取分页
        /// </summary>
        /// <returns></returns>
        public static List<NoticesModel> GetNoticesListByPage(Hashtable where, SearchArgs args)
        {
            if (args == null || args.PageSize <= 0 || args.CurrentIndex <= 0)
                return null;
            List<NoticesModel> list = Common.Instance._Notices.GetNoticesListByPage(where, args);
            if (list!=null && list.Count>0)
            {
                foreach (var item in list)
                {
                    item.NCreaterName = BusinessLogic.Cache.UsersCache.GetName(item.NCreater);
                }
            }
            return list;
        }

        #endregion
    }
}
