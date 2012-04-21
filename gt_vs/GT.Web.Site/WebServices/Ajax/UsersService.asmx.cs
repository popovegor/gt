using System;
using System.ComponentModel;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;
using GT.BO.Implementation.Users;
using GT.Common.Web.Cookie;
using GT.DA.Dictionaries;
using GT.Global.Security;
using GT.Web.Services;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Web.UI.HtmlTemplateSystem;
using System.Web;
using System.Net.Mail;
using GT.Common.Net.Mail;
using GT.Web.Site.HtmlTemplates;

namespace GT.Web.Site.WebServices.Ajax
{
  /// <summary>
  /// Summary description for UsersService
  /// </summary>
  [WebService(Namespace = "http://gameismoney.ru/")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [ToolboxItem(false)]
  [ScriptService]
  public class UsersService : BaseWebService
  {
    [WebMethod]
    public UserDynamics GetDynamics()
    {
      Guid userId = Credentials.UserId;
      return UsersFacade.GetDynamicsForUser(userId);
    }

    [WebMethod]
    public void SetTimeZone(int offset, bool dst)
    {
      int timeZoneId = 0;
      var tz = Dictionaries.Instance.GetTimeZoneInfoByOffset(offset, dst, out timeZoneId);
      if (tz != null && timeZoneId != int.MinValue)
      {
        Context.SetTimeZoneId(timeZoneId.ToString());
      }
    }
 
    [WebMethod(EnableSession = true)]
    public string SignUp(string userName, string password, string email, string question, string answer, string key)
    {
      string resultText = CommonResources.SignUpError;
      string sessionKey = Session[MembershipSettings.SessionSingUpSecurityKey] as string;
      if (string.IsNullOrEmpty(sessionKey) == false && string.IsNullOrEmpty(key) == false && key.Equals(sessionKey))
      {
        MembershipCreateStatus status;
        var u = Membership.CreateUser(userName, password, email, question, answer, true, out status);

        if (u != null)
        {
          Roles.AddUserToRole(u.UserName, RolesSettings.NonactivatedUser);
          SendRegistrationMail(u, password);
          resultText = string.Empty;
        }
        else
        {
          resultText = GetMembershipCreateStatusMessage(status);
        }
      }
      return resultText;
    }
    
    public static string GetMembershipCreateStatusMessage(MembershipCreateStatus status)
    { 
      string message = string.Empty; //if it's empty then ok 
      switch (status)
      {
        case MembershipCreateStatus.DuplicateEmail:
          message = CommonResources.SignUpDuplicateEmail;
          break;
        case MembershipCreateStatus.DuplicateUserName:
          message = CommonResources.SignUpDuplicateUserName;
          break;
        case MembershipCreateStatus.InvalidAnswer:
          message = CommonResources.SignUpInvalidAnswer;
          break;
        case MembershipCreateStatus.InvalidEmail:
          message = CommonResources.SignUpInvalidEmail;
          break;
        case MembershipCreateStatus.InvalidPassword:
          message = CommonResources.SignUpInvalidPassword;
          break;

        case MembershipCreateStatus.InvalidQuestion:
          message = CommonResources.SignUpInvalidQuestion;
          break;
        case MembershipCreateStatus.InvalidUserName:
          message = CommonResources.SignUpInvalidUserName;
          break;
        case MembershipCreateStatus.ProviderError:
        case MembershipCreateStatus.UserRejected:
        case MembershipCreateStatus.DuplicateProviderUserKey:
        case MembershipCreateStatus.InvalidProviderUserKey:
          message = CommonResources.SignUpError;
          break;
        case MembershipCreateStatus.Success:
          break;
      }
      return message;
    }
    
    public static void SendRegistrationMail(MembershipUser user, string password) 
    {
      HtmlTemplate<CompleteRegistration> body = new HtmlTemplate<CompleteRegistration>(); 
      body.Template.Login = user.UserName;
      body.Template.Password = password;  
      body.Template.Code = user.ProviderUserKey.ToString();
      body.Template.Host = HttpContext.Current.Request.Url.Host;
      var to = new MailAddress(user.Email, user.UserName);
      var m = SmtpManager.Instance.CreateMail(to
        , CommonResources.RegistrationEmailSubject
        , body.GenerateHtml());
      SmtpManager.Instance.Send(m);
    }
  }
}
