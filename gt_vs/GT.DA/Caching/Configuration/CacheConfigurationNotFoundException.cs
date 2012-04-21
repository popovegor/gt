using System;

namespace GT.DA.Caching.Configuration
{
    public class CacheConfigurationNotFoundException : Exception
    {
        public CacheConfigurationNotFoundException()
            : base()
        { }

        public CacheConfigurationNotFoundException(Type p_type)
            : base(string.Format("CachedEntityConfiguration not found for type {0}.", p_type))
        {
        }
    }
}
