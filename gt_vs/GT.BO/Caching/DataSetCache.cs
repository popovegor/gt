using System.Collections.Generic;
using System.Data;
using GT.BO.Caching.Configuration;
using GT.BO.Caching.DataSource;
using GT.BO.Caching.Functionality;
using GT.BO.Caching.Loading;
using GT.BO.Caching.Management;


namespace GT.BO.Caching
{
    public abstract class DataSetCache<CacheConfiguratorType, CacheDataSourceProviderType, CacheManagerType>
        : Cache<DataSet, CacheConfiguratorType, CacheDataSourceProviderType, CacheManagerType>, IDataSetCache
        where CacheConfiguratorType : class, ICacheConfigurator
        where CacheDataSourceProviderType : class, ICacheDataSourceProvider
        where CacheManagerType : CacheManager<DataSet>
    {

        public DataSetCache(CacheConfiguratorType p_oConfigurator, CacheDataSourceProviderType p_oProvider, CacheManagerType p_oManager)
            : base(p_oConfigurator, p_oProvider, p_oManager)
        {
        }

        public DataSetCache()
        { }

        protected override IEnumerable<string> FillDisplayColumns(CacheLoadContext<DataSet> loadContext)
        {
            List<string> cols = new List<string>();
            for (int i = 0; i < loadContext.Data.Tables.Count; i++)
                for (int j = 0; j < loadContext.Data.Tables[i].Columns.Count; j++)
                {
                    string sName = loadContext.Data.Tables[i].Columns[j].ColumnName;
                    if (!cols.Contains(sName))
                    {
                        cols.Add(sName);
                    }
                }
            return cols;
        }
    }
}
