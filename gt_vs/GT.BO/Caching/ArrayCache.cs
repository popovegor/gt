using GT.BO.Caching.Configuration;
using GT.BO.Caching.DataSource;
using GT.BO.Caching.Functionality;
using GT.BO.Caching.Management;

namespace GT.BO.Caching
{
    public abstract class ArrayCache<ArrayItemType, CacheConfiguratorType, CacheDataSourceProviderType, CacheManagerType>
        : Cache<ArrayItemType[], CacheConfiguratorType, CacheDataSourceProviderType, CacheManagerType>, IArrayCache<ArrayItemType>
        where ArrayItemType : class, IArrayCacheItem
        where CacheConfiguratorType : class, ICacheConfigurator
        where CacheDataSourceProviderType : class, ICacheDataSourceProvider
        where CacheManagerType : ArrayCacheManager<ArrayItemType>
    {

        #region Constructors

        public ArrayCache(
            CacheConfiguratorType p_oConfigurator,
            CacheDataSourceProviderType p_oDataSourceProvider,
            CacheManagerType p_oManager) : base(p_oConfigurator, p_oDataSourceProvider, p_oManager)
        {
        }

        public ArrayCache()
        {
        }

        #endregion

        #region IArrayCache<ArrayItemType> Members

        public ArrayItemType this[int itemIndex]
        {
            get
            {
                ReloadCacheIfNeeded();
                return _manager[itemIndex];
            }
            set
            {
                ReloadCacheIfNeeded();
                _manager[itemIndex] = value;
            }
        }

        #endregion
    }
}
