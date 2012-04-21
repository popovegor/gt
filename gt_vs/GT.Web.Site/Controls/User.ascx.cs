using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Users;
using GT.Global.Security;
using GT.Web.UI.Controls;
using CommonResources = GT.Localization.Resources.CommonResources;
using System.ComponentModel;

namespace GT.Web.Site.Controls
{
  public partial class User : BaseControl
  {
    protected string _userName = null;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public bool ShowNewWindow { get; set; }
    
    public bool ShowUserCard {get; set;}
    
    public bool IsEmpty
    {
      get
      {
        return UserId == Guid.Empty;
      }
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
    
    public bool MeSubstitution
    {
      get; set;
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
        return MeSubstitution == true && _userName.Equals(Credentials.UserName, StringComparison.InvariantCultureIgnoreCase) 
          ? CommonResources.Me : _userName;
      }

      set
      {
        _userName = value;
      }
    }
  }
}