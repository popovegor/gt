
namespace GT.BO.Caching.Loading
{
    public class CacheLoadContext<DataType>
        where DataType : class
    {
        private DataType _data = null;
        private CacheLoadType _loadType = CacheLoadType.Default;

        public DataType Data
        {
            get { return _data; }
            set { _data = value; }
        }

        public CacheLoadType LoadType
        {
            get { return _loadType; }
            set { _loadType = value; }
        }

        public CacheLoadContext(CacheLoadType loadType)
        {
            _loadType = loadType;
        }

        public CacheLoadContext()
        {
            _loadType = CacheLoadType.Default;
        }

    }
}
