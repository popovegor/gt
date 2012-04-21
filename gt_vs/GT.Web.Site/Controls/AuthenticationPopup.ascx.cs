using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.Security;
using GT.Web.Site.WebServices.Ajax;
using GT.Global.Security;

namespace GT.Web.Site.Controls
{
  public partial class AuthenticationPopup : System.Web.UI.UserControl
  {
    protected string Key
    {

      get
      {
        return Session[MembershipSettings.SessionSingUpSecurityKey] as string;
      }
      set
      {
        Session[MembershipSettings.SessionSingUpSecurityKey] = value;
      }
    }

    protected override void OnInit(EventArgs e)
    {
      base.OnInit(e);
      Key = Guid.NewGuid().ToString();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }
  }
}