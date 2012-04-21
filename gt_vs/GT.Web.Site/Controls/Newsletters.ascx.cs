using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.News;

namespace GT.Web.Site.Controls
{
  public partial class Newsletters : System.Web.UI.UserControl
  {
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected IEnumerable<GT.BO.Implementation.News.News> News
    {
      get
      {
        return NewsFacade.GetAllNotEmpty().Take(5);
      }
    }
  }
}