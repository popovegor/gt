using System;
using System.Net.Mail;
using GT.Common.Exceptions;

namespace GT.Common.Net.Mail
{
    public class SmtpMailMessage : MailMessage
    {
        public int MailId
        {
            get
            {
                return Subject.GetHashCode();
            }
        }

        protected SmtpMailMessage()
            : base()
        {
        }

        public SmtpMailMessage(string p_sFrom, string p_sTo, string p_sSubject, string p_sBody)
            : base(MailUtils.ExtractEmailAddress(p_sFrom), MailUtils.ExtractEmailAddress(p_sTo), p_sSubject, p_sBody)
        {
        }

        public SmtpMailMessage(string p_sFrom, string p_sTo)
            : base(MailUtils.ExtractEmailAddress(p_sFrom), MailUtils.ExtractEmailAddress(p_sTo))
        {
        }

        public SmtpMailMessage(MailAddress p_oFrom, MailAddress p_oTo)
            : base(p_oFrom, p_oTo)
        {
        }

        public bool Send()
        {
            bool bIsSent = false;
            AssistLogger.WriteInformation(
                    string.Format("Try to send E-Mail[{1}].{0}From:{2}{0}To:{3}{0}Subject:{4}", Environment.NewLine, MailId, From, To, Subject),
                    AssistLogger.Category.Email);
            try
            {
                SmtpManager.Instance.Send(this);
                bIsSent = true;
            }
            catch (Exception e)
            {
                AssistLogger.Log<ExceptionHolder>(e, AssistLogger.Category.Email, AssistLogger.Priority.High, System.Diagnostics.TraceEventType.Error);
            }
            finally
            {
                if (bIsSent)
                {
                    AssistLogger.WriteInformation(string.Format("E-Mail[{0}] has been sent successfully", MailId), AssistLogger.Category.Email);
                }
                else
                {
                    AssistLogger.WriteInformation(string.Format("E-Mail[{0}] has not been sent", MailId), AssistLogger.Category.Email);
                }
            }
            return bIsSent;
        }
    }
}
