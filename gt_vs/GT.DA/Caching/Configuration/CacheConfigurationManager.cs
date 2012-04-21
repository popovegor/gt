using System;
using System.Data;
using System.Data.Common;
using GT.BO.Caching.Configuration;
using GT.Common;
using GT.Common.Exceptions;
using GT.Global.Caching;

namespace GT.DA.Caching.Configuration
{
    public static class CacheConfigurationManager
    {

        #region Constants

        private const string GetProcName = "p_Caches_GetConfiguration";

        #endregion

        private static readonly object m_LockObject = new object();
        //private static SqlDependency m_Dependency = null;
        private static DataTable m_dtConfig = null;

        private static DataTable Config
        {
            get
            {
                if (m_dtConfig == null)
                {
                    try
                    {
                        DbCommand command = DB.Gt.GetStoredProcCommand(GetProcName);

                        DataSet ds = DB.Gt.ExecuteDataSet(command);
                        if (ds != null &&
                            ds.Tables.Count > 0)
                            lock (m_LockObject)
                                m_dtConfig = ds.Tables[0];
                        else
                            throw new Exception("CacheConfiguration is empty.");
                    }
                    catch (Exception e)
                    {
                        AssistLogger.Log<ExceptionHolder>(e, AssistLogger.Category.Database);
                    }
                }
                lock (m_LockObject)
                    return m_dtConfig;
            }
        }

        /// <summary>
        /// Возвращает конфигуратор
        /// </summary>
        /// <param name="p_CacheType">тип кэша</param>
        /// <returns></returns>
        public static CacheConfigurator GetConfigurationForType(CacheTypes p_CacheType)
        {
            DataRow[] dr = Config.Select(string.Format("{0} = '{1}'", CacheConfigurator.TypeNameColumnName,
                Enum.GetName(typeof(CacheTypes), p_CacheType)));

            if (dr != null && dr.Length > 0)
                return new CacheConfigurator(dr[0]);
            else
                throw AssistLogger.Log<ExceptionHolder>(new CacheConfigurationNotFoundException(), AssistLogger.Category.Database);
        }

        public static ICacheConfigurator GetConfigurationForType(Type p_type)
        {
            DataRow[] dr = Config.Select(string.Format("{0} = '{1}'", CacheConfigurator.TypeNameColumnName, p_type.FullName));
            if (dr != null &&
                dr.Length > 0)
                return new CacheConfigurator(dr[0]);
            else
                throw AssistLogger.Log<ExceptionHolder>(new CacheConfigurationNotFoundException(), AssistLogger.Category.Database);
        }
    }
}