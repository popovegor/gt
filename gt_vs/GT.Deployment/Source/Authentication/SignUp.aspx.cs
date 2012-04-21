using System;
using System.Net.Mail;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Common.Net.Mail;
using GT.Web.Site.HtmlTemplates;
using GT.Web.UI.HtmlTemplateSystem;
using GT.Web.UI.Pages;
using Resources;
using GT.Web.Site.MasterPages;


namespace GT.Web.Site.Authentication
{
  public partial class SignUp : GT.Web.UI.Pages.BasePage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      StandardPage master = Master as StandardPage;
      if (master != null)
      {
        master.LoginIsShown = false;
      }

      cuwRegisterUser.StartNextButtonText = CommonResources.Agree;
      cuwRegisterUser.ContinueButtonText = CommonResources.Continue;
      DataBind();
    }

    private enum CreateUserWizardStep
    {
      Confirmation = 0,
      Creation = 1,
      Completion = 2
    }

    protected void cuwRegisterUser_CreateButtonClick(object sender, EventArgs e)
    {
      if (Page.IsValid)
      {
        string name = cuwRegisterUser.UserName;
        string password = cuwRegisterUser.Password;
        string confirm = cuwRegisterUser.ConfirmPassword;
        string email = cuwRegisterUser.Email;
        string question = cuwRegisterUser.Question;
        string answer = cuwRegisterUser.Answer;
        MembershipCreateStatus status;
        MembershipUser u = Membership.CreateUser(name, password, email, question, answer, false, out status);
        HandleMembershipCreateStatus(status);
        if (u != null)
        {
          SendRegistrationMail(u);
          cuwRegisterUser.MoveTo(cwsCompletion);
        }
      }
    }

    private void SendRegistrationMail(MembershipUser user)
    {
      HtmlTemplate<CompleteRegistration> body = new HtmlTemplate<CompleteRegistration>();
      body.Template.Login = cuwRegisterUser.UserName;
      body.Template.Password = cuwRegisterUser.Password;
      body.Template.Code = user.ProviderUserKey.ToString();
      body.Template.Host = Request.Url.Host;
      MailMessage m = new MailMessage(SmtpManager.Instance.Config.RegistrationEmail, user.Email, CommonResources.RegistrationEmailSubject, body.GenerateHtml());
      m.IsBodyHtml = true;
      SmtpManager.Instance.Send(m);
    }

    private void HandleMembershipCreateStatus(MembershipCreateStatus status)
    {
      Label l = cuwsCreation.Controls[0].FindControl("FailureText") as Label;
      switch (status)
      {
        case MembershipCreateStatus.DuplicateEmail:
          l.Text = CommonResources.SignUpDuplicateEmail;
          break;
        case MembershipCreateStatus.DuplicateProviderUserKey:
          break;
        case MembershipCreateStatus.DuplicateUserName:
          l.Text = CommonResources.SignUpDuplicateUserName;
          break;
        case MembershipCreateStatus.InvalidAnswer:
          l.Text = CommonResources.SignUpInvalidAnswer;
          break;
        case MembershipCreateStatus.InvalidEmail:
          l.Text = CommonResources.SignUpInvalidEmail;
          break;
        case MembershipCreateStatus.InvalidPassword:
          l.Text = CommonResources.SignUpInvalidPassword;
          break;
        case MembershipCreateStatus.InvalidProviderUserKey:
          break;
        case MembershipCreateStatus.InvalidQuestion:
          l.Text = CommonResources.SignUpInvalidQuestion;
          break;
        case MembershipCreateStatus.InvalidUserName:
          l.Text = CommonResources.SignUpInvalidUserName;
          break;
        case MembershipCreateStatus.ProviderError:
          break;
        case MembershipCreateStatus.Success:
          break;
        case MembershipCreateStatus.UserRejected:
          break;
        default:
          break;
      }
    }

    protected void cuwRegisterUser_CancelButtonClick(object sender, EventArgs e)
    {
      Response.Redirect(FormsAuthentication.DefaultUrl, true);
    }

    protected void cuwRegisterUser_Agree(object sender, EventArgs e)
    { 
      switch ((CreateUserWizardStep)cuwRegisterUser.ActiveStepIndex)
      {
        case CreateUserWizardStep.Confirmation:
          cuwRegisterUser.MoveTo(cuwsCreation);
          break;
      }
    }
  }
}
