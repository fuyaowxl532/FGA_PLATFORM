using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;

namespace FGA_NUtility
{
    public class MailHelper
    {
        public static string SendMailUseGmail(string recipient,string cc,string subject,string content)
        {
            string res = "0";

            System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();
            msg.To.Add(recipient);
            if(!String.IsNullOrEmpty(cc))
                msg.CC.Add(cc);

            msg.From = new MailAddress("FGA_Platform@fuyaousa.com", "FGA_Platform", System.Text.Encoding.UTF8);
            /* 上面3个参数分别是发件人地址（可以随便写），发件人姓名，编码*/
            msg.Subject = subject;//邮件标题   
            msg.SubjectEncoding = System.Text.Encoding.UTF8;//邮件标题编码   
            msg.Body = content;//邮件内容   
            msg.BodyEncoding = System.Text.Encoding.UTF8;//邮件内容编码   
            msg.IsBodyHtml = false;//是否是HTML邮件   
            msg.Priority = MailPriority.High;//邮件优先级   
            SmtpClient client = new SmtpClient();
            client.Credentials = new System.Net.NetworkCredential("FGA_Platform@fuyaousa.com", "Fuyao123!");
            //上述写你的GMail邮箱和密码   
            client.Port = 587;//Gmail使用的端口   
            client.Host = "smtp.office365.com";
            client.EnableSsl = true;//经过ssl加密   
            object userState = msg;
            try
            {
                client.SendAsync(msg, userState);
                res = "1";
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                res = "0";
            }

            return res;
        }

    }
}
