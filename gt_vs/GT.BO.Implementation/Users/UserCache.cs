using System;
using System.Collections.Generic;
using GT.BO.Caching;
using GT.BO.Caching.Loading;
using GT.BO.Caching.Management;
using GT.DA.Caching.Configuration;
using GT.Global.Caching;
using System.Web.Security;

namespace GT.BO.Implementation.Users
{
  internal class UserCache : ArrayCache<_User, CacheConfigurator
      , UserCacheDataSourceProvider, ArrayCacheManager<_User>>
  {

    #region Singleton

    private UserCache()
    {
    }

    public static UserCache Instance
    {
      get { return Nested.instance; }
    }

    private class Nested
    {
      internal static readonly UserCache instance = new UserCache();

      static Nested()
      {
        instance._configurator = CacheConfigurationManager.GetConfigurationForType(CacheTypes.Users);
        instance._dataSourceProvider = new UserCacheDataSourceProvider();
        instance._manager = new ArrayCacheManager<_User>();
      }
    }

    #endregion

    protected override IEnumerable<string> FillDisplayColumns(CacheLoadContext<_User[]> _loadContext)
    {
      return null;
    }

    public _User this[string userName]
    {
      get
      {
        foreach (_User u in Data)
        {
          if (u.Data.UserName.Equals(userName, StringComparison.InvariantCultureIgnoreCase) == true)
          {
            return u;
          }
        }
        return null;
      }
      set
      {
        foreach (_User u in Data)
        {
          if (u.Data.UserName.Equals(userName, StringComparison.InvariantCultureIgnoreCase) == true)
          {
            Data[u.ItemIndex] = value;
          }
        }
      }
    }

    public _User this[Guid userId]
    {
      get
      {
        foreach (_User u in Data)
        {
          if (u.Id == userId)
          {
            return u;
          }
        }
        return null;
      }
      set
      {
        foreach (_User u in Data)
        {
          if (u.Id == userId)
          {
            Data[u.ItemIndex] = value;
          }
        }
      }
    }

  }
}
