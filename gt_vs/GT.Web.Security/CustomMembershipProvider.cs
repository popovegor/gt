using System.Web.Security;
using GT.Global.Security;
using System;
using Microsoft.Practices.EnterpriseLibrary.Caching;

namespace GT.Web.Security
{
  public class CustomMembershipProvider : SqlMembershipProvider
  {

    public ICacheManager cache = CacheFactory.GetCacheManager("Membership Cache Manager");

    public MembershipUser GetSystemUser()
    {
      return GetUser(MembershipSettings.SystemUserKey, false);
    }

    private static string GetCacheKey(object providerUserKey)
    {
      return string.Format("Membership_{0}", providerUserKey);
    }

    public override void UpdateUser(MembershipUser user)
    {
      base.UpdateUser(user);
      if (user != null)
      {
        var key = GetCacheKey(user.ProviderUserKey);
        cache.Remove(key);
      }
    }

    public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
    {
      MembershipUser user = null;
      var key = GetCacheKey(providerUserKey);
      if (userIsOnline == true)
      {
        cache.Remove(key);
      }
      user = cache.GetData(key) as MembershipUser;
      if (user == null)
      {
        user = base.GetUser(providerUserKey, userIsOnline);
        if (user != null)
        {
          cache.Add(key, user);
        }
      }

      return user;
    }

    public override MembershipUser GetUser(string username, bool userIsOnline)
    {
      var user = base.GetUser(username, userIsOnline);
      var key = GetCacheKey(user.ProviderUserKey);
      if (userIsOnline == true)
      {
        cache.Remove(key);
      }
      return user;
    }

    public override string GetUserNameByEmail(string email)
    {
      return base.GetUserNameByEmail(email);
    }
  }

  public static class MembershipUserExtensions
  {
    public static Guid UserId(this MembershipUser user)
    {
      return (Guid)user.ProviderUserKey;
    }
  }
}
