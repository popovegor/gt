using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using GT.DA.DatabaseConfiguration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;

namespace GT.DA
{
    /// <summary>
    /// Summary description for DB.
    /// </summary>
    public static class DB
    {
        private const string GtConnection = "GT";

        private static readonly object _lockObject = new object();
        private static Dictionary<string, DatabaseHolder> m_dbCollection = new Dictionary<string, DatabaseHolder>();

        static DB()
        {
            AppDomain.CurrentDomain.DomainUnload += CurrentDomain_DomainUnload;
        }

        static void CurrentDomain_DomainUnload(object sender, EventArgs e)
        {
            Dispose();
        }

        public static Database Gt
        {
			get { return GetDataBase( GtConnection ); }
        }

        private static Database GetDataBase(string p_sDataBaseName)
        {
            DatabaseHolder dbh;
            if (!m_dbCollection.TryGetValue(p_sDataBaseName, out dbh))
                lock (_lockObject)
                {
                    if (!m_dbCollection.TryGetValue(p_sDataBaseName, out dbh))
                    {
                        dbh = InitDatabase(p_sDataBaseName);
                        EnableBroker(dbh);
                        m_dbCollection.Add(p_sDataBaseName, dbh);
                    }
                }
            return dbh.DB;
        }

        private static DatabaseHolder InitDatabase(string p_sDataBaseName)
        {
            Database db = DatabaseFactory.CreateDatabase(p_sDataBaseName);
            DatabaseOptions opt = new DatabaseOptions(p_sDataBaseName);
            return new DatabaseHolder(db, opt);
        }

        private static void EnableBroker(DatabaseHolder p_dbh)
        {
            if (p_dbh.DB is SqlDatabase &&
                p_dbh.Options.EnableBroker &&
                !p_dbh.Options.IsDependencyEnabled)
                p_dbh.Options.IsDependencyEnabled = SqlDependency.Start(p_dbh.Options.ConnectionString);
        }

        public static void Dispose()
        {
            lock (_lockObject)
            {
                foreach (DatabaseHolder dbh in m_dbCollection.Values)
                {
                    if (dbh.Options.IsDependencyEnabled)
                        SqlDependency.Stop(dbh.Options.ConnectionString);
                }
                m_dbCollection.Clear();
            }
        }

        #region Nested type: DatabaseHolder

        private class DatabaseHolder
        {
            public Database DB;
            public DatabaseOptions Options;

            public DatabaseHolder(Database p_db, DatabaseOptions p_options)
            {
                DB = p_db;
                Options = p_options;
            }
        }

        #endregion

        #region Nested type: DatabaseOptions

        private class DatabaseOptions
        {
            public string ConnectionString;
            public string DatabaseName;
            public bool EnableBroker = false;
            public bool IsDependencyEnabled = false;

            public DatabaseOptions(string p_sDatabaseName)
            {
                DatabaseName = p_sDatabaseName;
                InitConnectionString();
                InitOptions();
            }

            private void InitConnectionString()
            {
                if (ConfigurationManager.ConnectionStrings[DatabaseName] != null)
                {
                    ConnectionString = ConfigurationManager.ConnectionStrings[DatabaseName].ConnectionString;
                    if (string.IsNullOrEmpty(ConnectionString))
                        throw new ConfigurationErrorsException(
                            string.Format("Connection string {0} is invalid!", DatabaseName));
                }
                else
                    throw new ConfigurationErrorsException(
                        string.Format("Connection string {0} not found!", DatabaseName));
            }

            private void InitOptions()
            {
                DatabaseSectionHandler config =
                    (DatabaseSectionHandler)
                    ConfigurationManager.GetSection(DatabaseSectionHandler.SECTION_NAME);
                if (config != null &&
                    config.DataBases != null &&
                    config.DataBases.Count > 0)
                {
                    foreach (DBConfigElement dbConfigElement in config.DataBases)
                        if (dbConfigElement.Name == DatabaseName)
                        {
                            EnableBroker = dbConfigElement.EnableBroker;
                            break;
                        }
                }
                else
                    EnableBroker = true;
            }
        }

        #endregion
    }
}