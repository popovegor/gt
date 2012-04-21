using System.Collections.Generic;
using System.Data;
using GT.BO.Caching;
using GT.BO.Caching.Management;
using GT.DA.Caching.Configuration;
using GT.Global.Caching;

namespace GT.DA.Statistics
{
    public class Statistics : DataSetCache<CacheConfigurator, StatisticsCacheDatabaseProvider, ReadOnlyDataSetCacheManager>
    {
        Dictionary<StatisticTypes, DataTable[]> m_Statistics;

        #region Singleton

        private Statistics()
        {
        }

        public static Statistics Instance
        {
            get { return Nested.instance; }
        }

        private class Nested
        {
            internal static readonly Statistics instance = new Statistics();

            static Nested()
            {
                instance._configurator = CacheConfigurationManager.GetConfigurationForType(CacheTypes.Statistics);
                instance._dataSourceProvider = new StatisticsCacheDatabaseProvider();
                instance._manager = new ReadOnlyDataSetCacheManager();
                instance.m_Statistics = new Dictionary<StatisticTypes,DataTable[]>();
            }
        }

        #endregion

        protected override void AfterReloadCache()
        {
            m_Statistics.Clear();

            m_Statistics.Add(StatisticTypes.Game, new DataTable[] { Data.Tables[0],
                                                                    Data.Tables[1],
                                                                    Data.Tables[2]});
                                                                    
            Games[0].PrimaryKey = new[] {Games[0].Columns[StatisticsFields.GameId]};

            m_Statistics.Add(StatisticTypes.GameServer, new DataTable[] {Data.Tables[3],
                                                                         Data.Tables[4],
                                                                         Data.Tables[5]});
        }

        public DataTable[] Statistic(StatisticTypes statisticType)
        {
            this.ReloadCacheIfNeeded();
            return m_Statistics[statisticType];
        }

        #region games

        public DataTable[] Games
        {
            get
            {
                return Statistic(StatisticTypes.Game);
            }
        }
        
        
        public DataRow GetGameById(int gameId)
        {
          return Games[0].Rows.Find(gameId);
        }

        #endregion

        #region game servers

        public DataTable[] GameServers
        {
            get { return Statistic(StatisticTypes.GameServer); }
        }

        #endregion 
    }
}
