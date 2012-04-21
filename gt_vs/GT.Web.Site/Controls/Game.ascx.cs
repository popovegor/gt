using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.DA.Dictionaries;

namespace GT.Web.Site.Controls
{
  public partial class Game : System.Web.UI.UserControl
  {
    private string _name = null;

    public int? GameId { get; set; }

    public int ServerId
    {
      set
      {
        GameId = Dictionaries.Instance.GetGameIdByGameServerId(value);
      }
    }

    public bool ShowNewWindow { get; set; }

    public string Name
    {
      get
      {
        if (_name == null)
        {
          if (true == GameId.HasValue)
          {
            _name = Dictionaries.Instance.GetGameNameById(GameId.Value);
          }
          else
          {
            _name = string.Empty;
          }
        }
        return _name;
      }
      set
      {
        _name = value;
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }
  }
}