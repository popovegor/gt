using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GT.BO.Implementation.Statistic
{
  public static class StatisticFacade
  {
    public static GameStat GetGameStatById(int gameId)
    {
      return new GameStat().Load<GameStat>(GT.DA.Statistics.Statistics.Instance.GetGameById(gameId));
    }
  }
}
