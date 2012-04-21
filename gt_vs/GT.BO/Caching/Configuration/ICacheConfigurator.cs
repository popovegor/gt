using System;

namespace GT.BO.Caching.Configuration
{
    public interface ICacheConfigurator
    {
        TimeSpan ReloadTimeout { get;}
        bool IsLazyLoad { get;}
        TimeSpan LockTimeout { get;}
        TimeSpan CacheExpiration { get;}
        TimeSpan PeriodicReloadTimeSpan { get;}
    }
}
