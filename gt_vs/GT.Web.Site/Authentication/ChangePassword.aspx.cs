using System;
using System.Web.Security;
using System.Web.UI;
using GT.Web.UI.Pages;
using CommonResources = GT.Localization.Resources.CommonResources;

namespace GT.Web.Site.Authentication
{
    public partial class ChangePassword : BasePage
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
            Page.Validate("ChangePassword");
            if (Page.IsValid && Credentials.IsLoggedIn)
            {
                if (Membership.ValidateUser(Credentials.UserName, OldPassword.Text))
                {
                    if (Credentials.User.ChangePassword(OldPassword.Text, Password.Text))
                    {
                        panel.Visible = false;
                        CompleteText.Visible = true;
                    }
                    else
                    {
                        FailureText.Text = CommonResources.ChangePasswordNewPswInvalid;
                    }
                }
                else
                {
                    FailureText.Text = CommonResources.PasswordInvalid;
                }
            }
        }
    }
}
