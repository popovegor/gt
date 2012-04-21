using System;
using System.Web.Profile;
using System.Web.Security;
using System.Linq;

namespace GT.Web.Security
{
  public class CustomProfileProvider : SqlProfileProvider
  {
    public static CustomUserProfile GetProfileByUserKey(Guid userKey)
    {
      MembershipUser u = Membership.GetUser(userKey);
      if (null != u)
      {
        return System.Web.Profile.ProfileBase.Create(u.UserName) as CustomUserProfile;
      }
      return null;
    }
  }
}
