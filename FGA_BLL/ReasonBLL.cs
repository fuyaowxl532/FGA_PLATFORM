using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FGA_MODEL;

namespace FGA_BLL
{
    public class ReasonBLL
    {
        #region //增删改查基本操作

        /// <summary>
        /// 增
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool AddReason(ReasonModel model)
        {
            return Common.Instance._Reason.AddReasonCode(model);
        }
        /// <summary>
        /// 改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool UpdateReason(ReasonModel model)
        {
            return Common.Instance._Reason.UpdateReasonCode(model);
        }
        /// <summary>
        /// 删
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static bool DeleteReason(ReasonModel model)
        {
            return Common.Instance._Reason.DeleteReasonCode(model);
        }
        /// <summary>
        /// 查
        /// </summary>
        /// <param name="model">empty model with key value</param>
        /// <returns></returns>
        public static ReasonModel GetReasonInfo(ReasonModel model)
        {
            return Common.Instance._Reason.GetReasonCodeInfo(model);
        }
        #endregion

        #region //扩展函数
        /// <summary>
        /// 获取简单集合
        /// </summary>
        /// <returns></returns>
        public static List<ReasonModel> GetReasonList(Hashtable where)
        {
            return Common.Instance._Reason.GetReasonCodeList(where);
        }

        ///// <summary>
        ///// 获取分页
        ///// </summary>
        ///// <returns></returns>
        //public static List<ReasonModel> GetReasonListByPage(Hashtable where, SearchArgs args)
        //{
        //    return Common.Instance._Reason.GetReasonListByPage(where, args);
        //}

        //public static ReasonModel GetReasonModel(string strRoleName)
        //{
        //    return Common.Instance._Reason.GetReasonModel(strRoleName);
        //}
        #endregion
    }
}
