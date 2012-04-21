using System;
using System.Data;
using GT.BO.Caching.DataSource;

namespace GT.DA.Caching.DataSource
{
    public class FakeCacheDatabaseProvider : CacheDataSourceProvider
    {
        public override bool LoadData<DataType>(GT.BO.Caching.Loading.CacheLoadContext<DataType> loadContext)
        {
            DataSet ds = new DataSet();
            ds.Tables.Add(new DataTable());
            loadContext.Data = ds as DataType;
            return true;
        }

        public override void HandleDataLoadingException(Exception p_ex)
        {
            //do nothing
        }

        public override void Dispose()
        {
            //do nothing
        }
    }
}
