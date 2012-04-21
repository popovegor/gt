using System;
using System.Text.RegularExpressions;
using GT.Common.Exceptions;

namespace GT.Common.Net.Mail
{
    public static class MailUtils
    {
        public static string ExtractEmailAddress(string p_sAddress)
        {
            string sExtractedEmail = string.Empty;
            try
            {
                sExtractedEmail = Regex.Match(p_sAddress, @"\b([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})\b").Value;
            }
            catch (Exception e)
            {
                AssistLogger.Log<ExceptionHolder>(e);
            }
            return sExtractedEmail;
        }
    }
}
