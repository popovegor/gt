using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Pages;
using GT.BO.Implementation.Statistic;
using System.Data;
using GT.DA.Dictionaries;
using GT.BO.Implementation.News;

namespace GT.Web.Site
{
  public partial class Default : BasePage
  {

    const int TOP_COUNT = 10;

    protected IEnumerable<DataRow> Games
    {
      get
      {
        List<GameStatistic> list = GameStatistic.GetGameStatistics();
        IEnumerable<GameStatistic> games = list.OrderByDescending(
          p => (p.BuyingOffersCount.HasValue ? p.BuyingOffersCount.Value : 0)
            + (p.SellingOffersCount.HasValue ? p.SellingOffersCount.Value : 0)).Take(TOP_COUNT);


        return games.Join(Dictionaries.Instance.Games.AsEnumerable(),
                            p => p.GameId, q => q[GameFields.GameId], (p, q) => q);
      }
    }

    protected IEnumerable<DataRow> Servers
    {
      get
      {
        List<GameServerStatistic> servs = GameServerStatistic.GetGameServersStatistics();
        IEnumerable<GameServerStatistic> servers = servs.OrderByDescending(
          p => (p.BuyingOffersCount.HasValue ? p.BuyingOffersCount.Value : 0)
            + (p.SellingOffersCount.HasValue ? p.SellingOffersCount.Value : 0)).Take(TOP_COUNT);

        return servers.Join(Dictionaries.Instance.GameServers.AsEnumerable(),
                            p => p.GameServerId, q => q[GameServerFields.GameServerId], (p, q) => q);
      }
    }


    protected IEnumerable<GT.BO.Implementation.News.News> News
    {
      get
      {
        return NewsFacade.GetAllNotEmpty().Take(7);
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }
  }
}
