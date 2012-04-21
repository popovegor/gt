using GT.DA.Caching.DataSource;

namespace GT.DA.Dictionaries
{
    public class DictionariesCacheDatabaseProvider : CacheDatabaseProvider
    {
        public const string GetProcName = "p_Dictionaries_GetAll";

        public DictionariesCacheDatabaseProvider()
        {}

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
