using System;
using Resources;

namespace GT.Web.Site.Authentication
{
    public partial class PasswordRecovery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            recovery.MailDefinition.IsBodyHtml = true;
            recovery.MailDefinition.Subject = CommonResources.PasswordRecoveryMailSubject;
            recovery.MailDefinition.From = "registration@gameismoney.ru";

            DataBind();
        }

        //protected void confirmBtn_Click(object sender, EventArgs e)
        //{
        //    Page.Validate("Recovery");
        //    if (Page.IsValid)
        //    {
        //        try
        //        {
        //            string uname = Membership.GetUserNameByEmail(Email.Text);
        //            if (!String.IsNullOrEmpty(uname))
        //            {
        //                SendConfirmationMail(Membership.GetUser(uname));
                        
        //            }
        //        }
        //        catch (Exception ex)
        //        { }

        //        panel.Visible = false;
        //        CompleteText.Visible = true;
        //    }
        //}

        //private void SendConfirmationMail(MembershipUser u)
        //{
        //    HtmlTemplate<RecoveryPassword> body = new HtmlTemplate<RecoveryPassword>();
        //    body.Template.Login = u.UserName;
        //    body.Template.Password = u.GetPassword();
        //    MailMessage m = new MailMessage("registration@gameismoney.ru", u.Email, CommonResources.PasswordRecoveryMailSubject, body.GenerateHtml());
        //    m.IsBodyHtml = true;
        //    new System.Net.Mail.SmtpClient().Send(m);
        //}
    }
}
