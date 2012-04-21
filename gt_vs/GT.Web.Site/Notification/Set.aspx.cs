using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using GT.Web.Security;
using GT.Web.UI.Pages;

namespace GT.Web.Site.Notification
{
  public partial class Set : BasePage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      foreach(MembershipUser u in Membership.GetAllUsers())
      {
        var profile = CustomProfileProvider.GetProfileByUserKey(u.UserId());
        if(profile != null)
        {
          profile.EmailMessageNotification = true;
          profile.Save();
        }
      }
    }
    
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }
    
  }
}
