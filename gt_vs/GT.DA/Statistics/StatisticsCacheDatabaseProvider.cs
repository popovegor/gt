using GT.DA.Caching.DataSource;

namespace GT.DA.Statistics
{
    public class StatisticsCacheDatabaseProvider : CacheDatabaseProvider
    {
        public const string GetProcName = "p_Statistics_GetAll";

        public StatisticsCacheDatabaseProvider()
        { }

        protected override Microsoft.Practices.EnterpriseLibrary.Data.Database DataSource
        {
            get { return DB.Gt; }
        }

        protected override System.Data.Common.DbCommand GetCommand()
        {
            return DataSource.GetStoredProcCommand(GetProcName);
        }
    }
}
