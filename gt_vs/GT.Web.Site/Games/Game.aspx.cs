using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using GT.DA.Dictionaries;
using GT.Common.Types;
using GT.Web.UI.Pages;

namespace GT.Web.Site.Games
{
  public partial class Game : BaseViewPage
  {
    protected int GameId
    {
      get
      {
        return TypeConverter.ToInt32(Request.QueryString["id"], -1);
      }
    }

    private Lazy<DataRow> _game = null;

    public DataRow GameInfo { get { return _game.Value; } }

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
