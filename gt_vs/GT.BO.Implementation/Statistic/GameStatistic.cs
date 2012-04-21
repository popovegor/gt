using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using GT.BO.Implementation.Users;
using GT.Common;
using GT.Common.Exceptions;
using GT.Common.Types;
using GT.DA.Statistics;
using System.Web.Security;
using GT.Web.Security;

namespace GT.BO.Implementation.Statistic
{
    public class GameStatistic
    {
        const int TOP_USERS = 10;

        int m_GameId;
        int? m_SellingOffersCount;
        int? m_BuyingOffersCount;
        int? m_SellingActiveCount;
        decimal? m_Money;

        Dictionary<MembershipUser, int> m_TopBuyers;
        Dictionary<MembershipUser, int> m_TopSellers;

        private GameStatistic(int gameId)
        {
            if (gameId <= 0)
            {
                throw new ArgumentNullException();
            }

            m_GameId = gameId;
            m_BuyingOffersCount = 0;
            m_SellingOffersCount = 0;
            m_Money = 0;

            m_TopBuyers = new Dictionary<MembershipUser, int>();
            m_TopSellers = new Dictionary<MembershipUser, int>();
        }

        void GetDataFromRow(DataRow row)
        {
            if (row.Table.Columns.Contains(StatisticsFields.BuyerId))
            {
                if (m_TopBuyers.Count < TOP_USERS)
                {
                    m_TopBuyers.Add(UsersFacade.GetUser(TypeConverter.ToGuid(row[StatisticsFields.BuyerId])), 
                                    TypeConverter.ToInt32(row[StatisticsFields.Total]));
                }
            }

            if (row.Table.Columns.Contains(StatisticsFields.SellerId))
            {
                if (m_TopSellers.Count < TOP_USERS)
                {
                    m_TopSellers.Add(UsersFacade.GetUser(TypeConverter.ToGuid(row[StatisticsFields.SellerId])),
                                     TypeConverter.ToInt32(row[StatisticsFields.Total]));
                }
            }

            if (row.Table.Columns.Contains(StatisticsFields.BuyingTotal))
            {
                m_BuyingOffersCount = TypeConverter.ToInt32(row[StatisticsFields.BuyingTotal]);
            }

            if (row.Table.Columns.Contains(StatisticsFields.SellingTotal))
            {
                m_SellingOffersCount = TypeConverter.ToInt32(row[StatisticsFields.SellingTotal]);
            }

            if (row.Table.Columns.Contains(StatisticsFields.MoneyTotal))
            {
                m_Money = TypeConverter.ToDecimal(row[StatisticsFields.MoneyTotal]);
            }
            if (row.Table.Columns.Contains(StatisticsFields.SellingActive))
            {
              m_SellingActiveCount = TypeConverter.ToInt32(row[StatisticsFields.SellingActive]);
            }
        }

        public int GameId
        {
            get
            {
                return m_GameId;
            }
        }

        public int? SellingOffersCount
        {
            get
            {
                return m_SellingOffersCount;
            }
        }

        public int? BuyingOffersCount
        {
            get
            {
                return m_BuyingOffersCount;
            }
        }

        public int? SellingActiveCount
        {
          get
          {
            return m_SellingActiveCount;
          }
        }

        public decimal? Money
        {
            get
            {
                return m_Money;
            }
        }

        public Dictionary<MembershipUser, int> TopBuyers
        {
            get
            {
                return m_TopBuyers;
            }
        }

        public Dictionary<MembershipUser, int> TopSellers
        {
            get
            {
                return m_TopSellers;
            }
        }

        static GameStatistic GetGSFromList(List<GameStatistic> list, int id)
        {
            GameStatistic gs = list.Where(p => p.m_GameId == id).FirstOrDefault();
            if (gs == null)
            {
                gs = new GameStatistic(id);
                gs.m_SellingOffersCount = 0;
                gs.m_BuyingOffersCount = 0;
                gs.m_Money = 0;
                list.Add(gs);
            }

            return gs;
        }

        public static List<GameStatistic> GetGameStatistics()
        {
            List<GameStatistic> res = new List<GameStatistic>();

            try
            {
                DataTable[] ds = Statistics.Instance.Games;
                foreach (DataTable t in ds)
                {
                    foreach (DataRow row in t.Rows)
                    {
                        int id = TypeConverter.ToInt32(row[StatisticsFields.GameId]);
                        GameStatistic gs = GetGSFromList(res, id);
                        gs.GetDataFromRow(row);
                    }
                }
            }
            catch (Exception ex)
            {
                AssistLogger.Log<ExceptionHolder>(ex);
                throw ex;
            }

            return res;
        }

        public static GameStatistic GetGameStatisticByGameid(int gameId)
        {
            GameStatistic gs = new GameStatistic(gameId);

            DataTable[] ds = Statistics.Instance.Games;

            foreach (DataTable t in ds)
            {
                DataRow[] rows = t.Select(String.Format("{0} = {1}", StatisticsFields.GameId, gameId));
                foreach (DataRow row in rows)
                {
                    gs.GetDataFromRow(row);
                }
            }

            return gs;
        }
    }
}
