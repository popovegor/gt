using GT.BO.Caching.Loading;

namespace GT.BO.Caching.Management
{
    public abstract class CacheManager<DataType> : ICacheManager<DataType>
        where DataType : class
    {
        protected object _Lock = new object();

        protected volatile DataType _Data = null;

        #region ICacheManager<DataType> Members

        public virtual bool IsEmpty
        {
            get
            {
                return _Data == null;
            }
        }

        public virtual DataType Data
        {
            get
            {
                return _Data;
            }
        }

        public virtual void Dispose()
        {
            lock (_Lock)
            {
                _Data = null;
            }
        }

        public abstract void MergeData(CacheLoadContext<DataType> loadContext);

        public abstract void BeginRead();

        public abstract void EndRead();

        public abstract void BeginWrite();

        public abstract void EndWrite();

        #endregion
    }
}
