using System.Data.Common;
using GT.DA.Caching.DataSource;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GT.DA.SiteMap
{
    public class SiteMapCacheDatabaseProvider : CacheDatabaseProvider
    {
        private const string GetProcName = "p_SiteMap_Get";

        public SiteMapCacheDatabaseProvider()
        { }

        protected override Database DataSource
        {
            get { return DB.Gt; }
        }

        protected override DbCommand GetCommand()
        {
            return DataSource.GetStoredProcCommand(GetProcName);
        }
    }
}
