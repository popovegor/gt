using System;
using System.Data;
using System.Data.Common;
using GT.BO.Caching.DataSource;
using GT.BO.Caching.Loading;
using GT.Common;
using GT.Common.Exceptions;
using GT.DA.Properties;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GT.DA.Caching.DataSource
{
    public abstract class CacheDatabaseProvider : CacheDataSourceProvider
    {
        protected DateTime? _lastLoadingDateTime = null;
        protected DateTime _lastLoadingDateTimeCandidate = DateTime.Now;

        public DateTime? LastLoadingDateTime
        {
            get { return _lastLoadingDateTime; }
            set { _lastLoadingDateTime = value; }
        }

        protected abstract Database DataSource { get; }

        protected abstract DbCommand GetCommand();

        protected virtual void PrepareCommand(DbCommand p_cmd)
        {
        }

        protected DataSet ExecuteCommand(DbCommand cmd)
        {
            PrepareCommand(cmd);
            _lastLoadingDateTimeCandidate = DBUtils.GetCurrentDateTime(DataSource);
            return DataSource.ExecuteDataSet(cmd);
        }

        public CacheDatabaseProvider() : base()
        {
        }

        #region ICacheDataSourceProvider Members

        public override bool LoadData<DataType>(CacheLoadContext<DataType> loadContext)
        {
            using (DbCommand cmd = GetCommand())
            {
                switch (loadContext.LoadType)
                {
                    case GT.BO.Caching.CacheLoadType.Entirely:
                        _lastLoadingDateTime = null;
                        break;
                    default:
                        break;
                }
                loadContext.Data = ExecuteCommand(cmd) as DataType;
            }
            return true;
        }

        #endregion

        public override void HandleDataLoadingException(Exception p_ex)
        {
            AssistLogger.WriteInformation(
                string.Format(Resources.DbCommandExecutionFailed, GetCommand().CommandText),
                AssistLogger.Category.General);
            AssistLogger.Log<ExceptionHolder>(p_ex
                , new AssistLogger.Category[] { AssistLogger.Category.Database, AssistLogger.Category.General, AssistLogger.Category.Cache }
                , AssistLogger.Priority.High
                , System.Diagnostics.TraceEventType.Error);
        }

        public override void Dispose()
        {

        }
    }
}
