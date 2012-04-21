using System;
using System.Data;
using GT.BO.Implementation.Statistic;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Web.UI.Pages;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Common.Web.WebUtils;
using System.Net;

namespace GT.Web.Site.Games
{
  public partial class Game_old : BasePage
  {
    protected int GameId
    {
      get
      {
        return TypeConverter.ToInt32(Request.QueryString["id"], -1);
      }
    }

    private Lazy<DataRow> _game = null;

    public DataRow Info { get { return _game.Value; } }

    protected void Page_Init(object sender, EventArgs e)
    {
      _game = new Lazy<DataRow>(()
        => Dictionaries.Instance.GetGameById(GameId), true);
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
