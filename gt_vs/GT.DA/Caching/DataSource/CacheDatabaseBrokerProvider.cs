using System;
using System.Data.Common;
using System.Data.SqlClient;
using GT.BO.Caching;

namespace GT.DA.Caching.DataSource
{
    public abstract class CacheDatabaseBrokerProvider<DataType> : CacheDatabaseProvider
        where DataType : class
    {
        protected SqlDependency m_Dependency = null;
        protected ClearCacheDelegate m_ClearCache = null;
        protected HandleExceptionDelegate m_HandleException = null;

        protected object m_BrokerLockObject = new object();

        public CacheDatabaseBrokerProvider(ClearCacheDelegate p_ClearCache, HandleExceptionDelegate p_HandleException)
        {
            m_ClearCache = p_ClearCache;
            m_HandleException = p_HandleException;
        }

        protected override void PrepareCommand(DbCommand p_command)
        {
            try
            {
                if (p_command is SqlCommand)
                {
                    SqlCommand command = p_command as SqlCommand;
                    ClearDependency();
                    command.Notification = null;
                    m_Dependency = new SqlDependency(command);
                    m_Dependency.OnChange += Dependency_OnChange;
                }
            }
            catch (Exception ex)
            {
                if (null != m_HandleException)
                {
                    m_HandleException(ex);
                }
            }
        }

        protected virtual void Dependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            try
            {
                DBUtils.LogSqlNotificationData(e, GetType());
                if (e != null && e.Info != SqlNotificationInfo.Invalid && e.Info != SqlNotificationInfo.Error)
                {
                    lock (m_BrokerLockObject)
                    {
                        ((SqlDependency)sender).OnChange -= Dependency_OnChange;
                    }
                }
                if (m_ClearCache != null)
                {
                    m_ClearCache();
                }
            }
            catch (Exception ex)
            {
                if (null != m_HandleException)
                {
                    m_HandleException(ex);
                }
            }
        }

        public override void HandleDataLoadingException(Exception p_exc)
        {
            ClearDependency();
        }

        private void ClearDependency()
        {
            if (m_Dependency != null)
            {
                m_Dependency.OnChange -= Dependency_OnChange;
                m_Dependency = null;
            }
        }

        public override void Dispose()
        {
            ClearDependency();
            m_ClearCache = null;
            m_HandleException = null;
            base.Dispose();
        }
    }
}
