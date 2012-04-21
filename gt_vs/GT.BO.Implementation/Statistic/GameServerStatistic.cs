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
  public class GameServerStatistic
  {
    const int TOP_USERS = 10;

    int m_GameServerId;
    int? m_SellingOffersCount;
    int? m_BuyingOffersCount;
    int? m_SellingActiveCount;
    decimal? m_Money;

    Dictionary<MembershipUser, int> m_TopBuyers;
    Dictionary<MembershipUser, int> m_TopSellers;

    private GameServerStatistic(int gameServerId)
    {
      if (gameServerId <= 0)
      {
        throw new ArgumentNullException();
      }

      m_GameServerId = gameServerId;
      m_BuyingOffersCount = 0;
      m_Money = 0;
      m_SellingOffersCount = 0;

      m_TopBuyers = new Dictionary<MembershipUser, int>();
      m_TopSellers = new Dictionary<MembershipUser, int>();
    }

    public int GameServerId
    {
      get
      {
        return m_GameServerId;
      }
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

    static GameServerStatistic GetGSFromList(List<GameServerStatistic> list, int id)
    {
      GameServerStatistic gs = list.Where(p => p.m_GameServerId == id).FirstOrDefault();
      if (gs == null)
      {
        gs = new GameServerStatistic(id);
        gs.m_SellingOffersCount = 0;
        gs.m_BuyingOffersCount = 0;
        gs.m_Money = 0;
        gs.m_SellingActiveCount = 0;
        list.Add(gs);
      }

      return gs;
    }

    public static List<GameServerStatistic> GetGameServersStatistics()
    {
      List<GameServerStatistic> res = new List<GameServerStatistic>();

      try
      {
        DataTable[] ds = Statistics.Instance.GameServers;

        foreach (DataTable t in ds)
        {
          foreach (DataRow row in t.Rows)
          {
            int id = TypeConverter.ToInt32(row[StatisticsFields.GameServerId]);
            GameServerStatistic gs = GetGSFromList(res, id);
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

    public static GameServerStatistic GetGameServerStatisticByGameServerid(int gameServerId)
    {
      GameServerStatistic gs = new GameServerStatistic(gameServerId);

      try
      {

        DataTable[] ds = Statistics.Instance.GameServers;
        foreach (DataTable t in ds)
        {
          DataRow[] rows = t.Select(String.Format("{0} = {1}", StatisticsFields.GameServerId, gameServerId));
          foreach (DataRow row in rows)
          {
            gs.GetDataFromRow(row);
          }
        }
      }
      catch (Exception ex)
      {
        AssistLogger.Log<ExceptionHolder>(ex);
        throw ex;
      }

      return gs;
    }
  }
}
