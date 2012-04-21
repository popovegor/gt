using System.Threading;

namespace GT.BO.Caching.Management
{
    public abstract class ReadWriteCacheManager<DataType> : CacheManager<DataType>
        where DataType : class
    {
        public override void EndRead()
        {
            Monitor.Exit(_Lock);
        }

        public override void BeginWrite()
        {
            Monitor.Enter(_Lock);
        }

        public override void EndWrite()
        {
             Monitor.Exit(_Lock);
        }

        public override void BeginRead()
        {
            Monitor.Enter(_Lock);
        }
    }
}
