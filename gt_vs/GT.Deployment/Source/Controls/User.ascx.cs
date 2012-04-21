using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Users;
using GT.Global.Membership;

namespace GT.Web.Site.Controls
{
  public partial class User : System.Web.UI.UserControl
  {
    protected string _userName = null;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public bool IsSystemUser
    {
      get
      {
        return UserId == MembershipSettings.SystemUserKey;
      }
    }

    public Guid UserId
    {
      get;
      set;
    }

    public string UserName
    {
      get
      {
        if (string.IsNullOrEmpty(_userName) == true)
        {
          if (IsSystemUser == true)
          {
            _userName = MembershipSettings.SystemUserName;
          }
          else
          {
            var u = UsersFacade.GetUser(UserId);
            _userName = u != null ? u.UserName : string.Empty;
          }
        }
        return _userName;
      }

      set
      {
        _userName = value;
      }
    }

  }
}