using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FGA_NUtility.Consts
{
    public class SysConst
    {
        #region //图片

        /// <summary>
        /// 部门图标 正常/禁用
        /// </summary>
        public const string ICO_DEPT = "../images/home.png";
        public const string ICO_DEPT_DIS = "../images/home0.png";
        /// <summary>
        /// 模块图标
        /// </summary>
        public const string ICO_POWER = "../images/folder.png";
        public const string ICO_POWER_DIS = "../images/folder-noview.png";
        public const string ICO_AttackType = "../images/wand.png";
        /// <summary>
        /// 用户/角色图标
        /// </summary>
        public const string ICO_USER = "../images/user.png";
        public const string ICO_USER_DIS = "../images/user0.png";

        #endregion

        #region //session键名
        /// <summary>
        /// 验证码
        /// </summary>
        public const string S_CHECK_CODE = "__ValidateCode__";
        /// <summary>
        /// 登录用户
        /// </summary>
        public const string S_LOGIN_USER = "__login_user__";
        #endregion


        #region //其他

        public const string NOTICE_ATT_PROJECTID = "noticeattachment";

        public const string AUTO_NUMBER = "自动编号";
        /// <summary>
        /// 系统超级用户固定id
        /// </summary>
        public const string ADMIN = "administrator";

        /// <summary>
        /// 编码层阶
        /// </summary>
        public const int CODE_STEP = 3;
        /// <summary>
        /// 统一分隔符
        /// </summary>
        public const char SPLIT = '卐';
        public const char SPLIT2 = '⊙';
        public const char SPLIT3 = '=';
        public const char SPLIT_NM = ',';
        public const string EMPTY = "--";
        public const string TREE_CHAR = "├";
        public const string ST_OK = "ok";

        /// <summary>
        /// 步骤进度条样式
        /// </summary>
        public const string S_DONE = "sdone";
        public const string S_DOING = "sdoing";
        public const string S_WAIT = "swait";
        #endregion

    }
}
