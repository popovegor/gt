using System;
using System.Net.Mail;
using System.Web.Security;
using System.Web.UI;
using GT.Common.Cryptography;
using GT.Web.Site.HtmlTemplates;
using GT.Web.UI.HtmlTemplateSystem;
using GT.Web.UI.Pages;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Common.Net.Mail;

namespace GT.Web.Site.Authentication
{
    public partial class ChangeEmail : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Credentials.IsLoggedIn)
            {
                Response.Redirect("SignIn.aspx");
            }
            DataBind();
        }

        protected void confirmBtn_Click(object sender, EventArgs e)
        {
            Page.Validate("ChangeMail");
            if (Page.IsValid && Credentials.IsLoggedIn)
            {
                if (String.Compare(Credentials.User.Email, Email.Text, true) == 0)
                {
                    if (Membership.FindUsersByEmail(NewEmail.Text) == null)
                    {
                        if (Membership.ValidateUser(Credentials.UserName, Password.Text))
                        {
                            SendConfirmationMail(Credentials.User, NewEmail.Text);
                            panel.Visible = false;
                            CompleteText.Visible = true;
                        }
                        else
                        {
                            FailureText.Text = CommonResources.PasswordInvalid;
                        }
                    }
                    else
                    {
                        FailureText.Text = CommonResources.SignUpDuplicateEmail;
                    }
                }
                else
                {
                    FailureText.Text = CommonResources.ChangeEmailOldMailError;
                }
            }
        }

        private void SendConfirmationMail(MembershipUser user, string newEmail)
        {
            HtmlTemplate<ChangeEmailConfirmation> body = new HtmlTemplate<ChangeEmailConfirmation>();
            body.Template.Email = newEmail;
            body.Template.Code = user.ProviderUserKey.ToString();
            body.Template.Checker = Hash.ReadableHash(Hash.MD5, newEmail + body.Template.Code);
            body.Template.Host = Request.Url.Host;
            var to = new MailAddress(newEmail, user.UserName);
            var m = SmtpManager.Instance.CreateMail(to
              , CommonResources.ChangeEmailEmailSubject
              , body.GenerateHtml());
            SmtpManager.Instance.Send(m);
        }
    }
}
