using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Controls;
using GT.Localization;

namespace GT.Web.Site.Menu
{
  public partial class MainMenuItemSelling : BaseMainMenuItem
  {

    public int? Number
    {
      get
      {
        var stat = GT.BO.Implementation.Statistic.GameStatistic.GetGameStatistics();
        return stat.Sum(g => g.SellingActiveCount);
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }
  }
}