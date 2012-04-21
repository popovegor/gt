using System;
using GT.Web.UI.Pages;
using GT.Web.Site.MasterPages;

namespace GT.Web.Site.Authentication
{
    public partial class SignIn : GT.Web.UI.Pages.BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          //Standard master = Master as Standard;
          //  if (master != null)
          //  {
          //      master.LoginIsShown = false;
          //  }
        }

        void lgnAnonymousUser_LoggedIn(object sender, EventArgs e)
        {
        }
        
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
          DataBind();
        }
    }
}
