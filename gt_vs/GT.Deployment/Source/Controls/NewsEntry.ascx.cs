using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GT.Web.Site.Controls
{
  public partial class NewsEntry : System.Web.UI.UserControl
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    public GT.BO.Implementation.News.News Entry
    {
      get; set;
    }
  }
}