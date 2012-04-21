using System;
using System.Data;
using GT.BO.Caching.Configuration;
using GT.Common.Types;

namespace GT.DA.Caching.Configuration
{
    public class CacheConfigurator : ICacheConfigurator
    {

        #region Constants
        
        public const string TypeNameColumnName = "TypeName";
        public const string ReloadColumnName = "ReloadTimeout";
        public const string LoadImmediateColumnName = "LoadImmediately";
        public const string LockColumnName = "LockTimeout";
        public const string ExpirationColumnName = "CacheExpiration";
        public const string PeriodicReloadColumnName = "PeriodicReloadTimeSpan";

        #endregion

        #region Fields
        
        private string[] m_TypeNames;
        private TimeSpan m_ReloadTimeout;
        private bool m_bLoadImmediately;
        private TimeSpan m_LockTimeout;
        private TimeSpan m_CacheExpiration;
        private TimeSpan m_PeriodicTimeSpan;

        #endregion

        public CacheConfigurator(DataRow p_dr)
        {
            string sTypeNames = TypeConverter.ToString(p_dr[TypeNameColumnName]);
            if (sTypeNames.IndexOf(",") != -1)
                m_TypeNames = sTypeNames.Split(',');
            else
                m_TypeNames = new string[] { sTypeNames };
            m_ReloadTimeout = TypeConverter.ToTimeSpan(p_dr[ReloadColumnName]);
            m_bLoadImmediately = TypeConverter.ToBool(p_dr[LoadImmediateColumnName]);
            m_LockTimeout = TypeConverter.ToTimeSpan(p_dr[LockColumnName]);
            m_CacheExpiration = TypeConverter.ToTimeSpan(p_dr[ExpirationColumnName]);
            m_PeriodicTimeSpan = TypeConverter.ToTimeSpan(p_dr[PeriodicReloadColumnName]);
        }

        public bool IsEmpty
        {
            get
            {
                return !(m_TypeNames != null && m_TypeNames.Length > 0);
            }
        }

        #region IConfigurableCache Members

        public TimeSpan ReloadTimeout
        {
            get { return m_ReloadTimeout; }
        }

        public bool IsLazyLoad
        {
            get { return !m_bLoadImmediately; }
        }

        public TimeSpan LockTimeout
        {
            get { return m_LockTimeout; }
        }

        public TimeSpan CacheExpiration
        {
            get { return m_CacheExpiration; }
        }

        public TimeSpan PeriodicReloadTimeSpan
        {
            get { return m_PeriodicTimeSpan; }
        }

        #endregion
    }
}
