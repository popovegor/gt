using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GT.BO.Implementation.Notification;
using GT.BO.Implementation.MessageSystem;
using GT.Common.Net.Mail;
using GT.Localization.Resources;
using System.Net.Mail;
using GT.Web.Site.HtmlTemplates;
using GT.Web.UI.HtmlTemplateSystem;
using GT.Web.Security;
using System.Web.Security;

namespace GT.Web.Site.Notification
{
  public class NotificationSender : INotificationSender
  {
    #region INotificationSender Members

    public void Send(Message m)
    {
      var user = Membership.GetUser(m.RecipientId);
      if (user != null && user.IsOnline == false)
      {
        var profile = CustomProfileProvider.GetProfileByUserKey(m.RecipientId);
        if (profile != null && profile.EmailMessageNotification == true)
        {
          HtmlTemplate<NewMessageNotification> body = new HtmlTemplate<NewMessageNotification>();
          body.Template.SenderId = m.SenderId;
          body.Template.RecipientId = m.RecipientId;
          var to = new MailAddress(user.Email, user.UserName);
          var mail = SmtpManager.Instance.CreateMail(to
            , CommonResources.Notification_NewMessageSubject
            , body.GenerateHtml());
          SmtpManager.Instance.Send(mail);
        }
      }
    }

    #endregion
  }
}
