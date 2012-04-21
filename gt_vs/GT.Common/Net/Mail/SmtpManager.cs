using System.Configuration;
using System.Net.Mail;
using GT.Common.Patterns;
using System;
using GT.Common.Exceptions;
using GT.Localization.Resources;
using System.ComponentModel;

namespace GT.Common.Net.Mail
{
  public sealed class SmtpManager : Singleton<SmtpManager>
  {
    private object m_oSendLocker = new object();
    private SmtpConfigurationSection _config = null;

    public SmtpManager()
    {
      _config = (SmtpConfigurationSection)ConfigurationManager.GetSection(SmtpConfigurationSection.SectionName);
    }

    public void Send(MailMessage mail)
    {
      if (_config.Enabled == true)
      {
        try
        {
          var client = new SmtpClient();
          //client.SendCompleted += new SendCompletedEventHandler(SendCompleted);
          //client.SendAsync(mail, mail);
          client.Send(mail);
        }
        catch (Exception e)
        {
          AssistLogger.Log<ExceptionHolder>(e);
        }
      }
    }
    
    private static void SendCompleted(object sender, AsyncCompletedEventArgs e)
    {
      if(e.Error != null)
      {
        AssistLogger.Log<ExceptionHolder>(e.Error);
      }
      if(e.Cancelled == true)
      {
        AssistLogger.WriteInformation("Message has been canceled.", AssistLogger.Category.General);
      }
      if(e.Error == null && e.Cancelled == false)
      {
        AssistLogger.WriteInformation("Message has been sent successfully.", AssistLogger.Category.General);
      }
    }

    public SmtpConfigurationSection Config
    {
      get
      {
        return _config;
      }
    }

    public MailMessage CreateMail(MailAddress to, string subject, string body)
    {
      var m = new MailMessage(
        new MailAddress(Config.NoreplyEmail, CommonResources.GameIsMoney), to);
      m.Subject = subject;
      m.Body = body;
      m.IsBodyHtml = true;

      return m;
    }
  }
}
