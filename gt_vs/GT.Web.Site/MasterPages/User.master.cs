using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using GT.Global.Users;
using GT.BO.Implementation.Users;
using GT.Common.Types;
using GT.Web.UI.Pages;

namespace GT.Web.Site.MasterPages
{
  public partial class User : BaseMasterPage
  {

    private Lazy<MembershipUser> _user = null;
    public MembershipUser Info
    {
      get
      {
        return _user.Value;
      }
    }

    private Lazy<UserDynamics> _dynamics = null;
    public UserDynamics Dynamics
    {
      get
      {
        return _dynamics.Value;
      }
    }

    protected Guid UserId
    {
      get
      {
        var userId = Request.QueryString[UserCardParams.UserId];
        if (userId != null)
        {
          return new Guid(userId);
        }
        else
        {
          return new Guid();
        }
      }
    }

    public UserCardParams.Data DataType
    {
      get
      {
        var d = Request.QueryString[UserCardParams.DataType];
        return TypeConverter.ToEnumMember<UserCardParams.Data>(d, UserCardParams.Data.Info);
      }
    }

    protected bool IsSameUser
    {
      get
      {
        return Credentials.IsLoggedIn == true && UserId == Credentials.UserId;
      }
    }

  
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    
    protected void Page_Init(object sender, EventArgs e)
    {
      _user = new Lazy<MembershipUser>(()
        => Membership.GetUser(UserId as object), true);

      _dynamics = new Lazy<UserDynamics>(()
        => Info != null ? UsersFacade.GetDynamicsForUser(UserId) : new UserDynamics(), true);
    }


    protected string GetUrlForSection(UserCardParams.Data section)
    {
      return string.Format("/Users/User/{0}/{1}", UserId, section);
    }
  }
}
