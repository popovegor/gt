using System;
using GT.BO.Caching.Loading;

namespace GT.BO.Caching.DataSource
{
    public abstract class CacheDataSourceProvider : ICacheDataSourceProvider
    {
        public CacheDataSourceProvider()
        {
        }

        #region ICacheDataSourceProvider Members

        public abstract bool LoadData<DataType>(CacheLoadContext<DataType> loadContext)
            where DataType : class;

        public virtual bool HasNewData
        {
            get
            {
                return false;
            }
        }

        public abstract void HandleDataLoadingException(Exception p_ex);

        #endregion


        #region IDisposable Members

        public abstract void Dispose();

        #endregion
    }
}
