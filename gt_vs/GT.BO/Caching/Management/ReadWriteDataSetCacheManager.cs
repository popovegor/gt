using System.Data;
using GT.BO.Caching.Loading;

namespace GT.BO.Caching.Management
{
    public class ReadWriteDataSetCacheManager : ReadWriteCacheManager<DataSet>
    {
        public override void MergeData(CacheLoadContext<DataSet> loadContext)
        {
            BeginWrite();
            try
            {
                DataSet dsChanges = _Data.GetChanges(DataRowState.Added | DataRowState.Deleted | DataRowState.Modified);
                if (dsChanges != null)
                {
                    loadContext.Data.Tables[0].Merge(dsChanges.Tables[0]);
                }
                loadContext.Data.AcceptChanges();
                _Data = loadContext.Data;
            }
            finally
            {
                EndWrite();
            }
        }

        public override DataSet Data
        {
            get
            {
                return base.Data;
            }
        }

        public override bool IsEmpty
        {
            get
            {
                return base.IsEmpty;
            }
        }
    }
}
