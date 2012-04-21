using GT.BO.Caching.Loading;

namespace GT.BO.Caching.Management
{
    public abstract class ReadOnlyCacheManager<DataType> : CacheManager<DataType>
        where DataType : class
    {
        public override void MergeData(CacheLoadContext<DataType> loadContext)
        {
            _Data = loadContext.Data;
        }

        public override void BeginRead()
        {   
        }

        public override void EndRead()
        {   
        }

        public override void BeginWrite()
        {  
        }

        public override void EndWrite()
        {
        }
    }
}
