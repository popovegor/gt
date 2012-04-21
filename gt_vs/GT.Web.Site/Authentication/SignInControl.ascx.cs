using System;
using GT.Web.UI.Controls;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace GT.Web.Site.Authentication
{
    public partial class SignInControl : BaseControl
    {
        protected static class ControlNames
        {
          public const string User = "UserName";
          public const string Password = "Password";
          public const string FailureText = "FailureText";
          public const string RememberMe = "RememberMe";
        }
    
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        
        protected void btnSignIn_OnClick(object sender, EventArgs e)
        {
          Page.Validate("loginCtrl");
          var failure = Page.FindControl(lvLogin.UniqueID + IdSeparator.ToString() + ControlNames.FailureText) as Label;
          failure.Visible = true;
          if(Page.IsValid == true)
          {
            var user = Request.Form[lvLogin.UniqueID + IdSeparator.ToString() + ControlNames.User];
            var pwd = Request.Form[lvLogin.UniqueID + IdSeparator.ToString() + ControlNames.Password];
            var auth = Membership.ValidateUser(user, pwd);
            if(auth == true)
            {
              var remember = Page.FindControl(lvLogin.UniqueID + IdSeparator.ToString() + ControlNames.RememberMe) as CheckBox;
              FormsAuthentication.SetAuthCookie(user, remember.Checked);
              var redirect = FormsAuthentication.GetRedirectUrl(user, false);
              if(string.IsNullOrEmpty(redirect) == true)
              {
                redirect = FormsAuthentication.DefaultUrl;
              }
              Response.Redirect(redirect, true);
              failure.Visible = false;
            }
          }
        }
    }
}