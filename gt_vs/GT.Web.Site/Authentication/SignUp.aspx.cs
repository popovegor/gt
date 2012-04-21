using System;
using System.Net.Mail;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Common.Net.Mail;
using GT.Web.Site.HtmlTemplates;
using GT.Web.UI.HtmlTemplateSystem;
using GT.Web.UI.Pages;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Web.Site.MasterPages;
using GT.Web.Site.WebServices.Ajax;
using System.Runtime.Remoting.Contexts;
using System.Web;
using GT.Global.Security;
using GT.Web.Security;
using GT.Common;
using GT.Common.Exceptions;


namespace GT.Web.Site.Authentication
{
  public partial class SignUp : GT.Web.UI.Pages.BasePage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      //Standard master = Master as Standard;
      //if (master != null)
      //{
      //  master.LoginIsShown = false;
      //}

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

        if (u != null)
        {
          if (Roles.FindUsersInRole(RolesSettings.User, u.UserName).Length == 0)
          {
            Roles.AddUserToRole(u.UserName, RolesSettings.User);
          }
          try
          {
          var profile = CustomProfileProvider.GetProfileByUserKey(u.UserId());
          profile.EmailMessageNotification = true;
          profile.Save();
          }
          catch(Exception ex)
          {
            AssistLogger.Log<ExceptionHolder>(ex);
          }
          UsersService.SendRegistrationMail(u, password);
          cuwRegisterUser.MoveTo(cwsCompletion);
        }
        else
        {
          HandleMembershipCreateStatus(status);
        }
      }
    }

    private void HandleMembershipCreateStatus(MembershipCreateStatus status)
    {
      (cuwsCreation.Controls[0].FindControl("FailureText") as Label).Text
        = UsersService.GetMembershipCreateStatusMessage(status);
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
