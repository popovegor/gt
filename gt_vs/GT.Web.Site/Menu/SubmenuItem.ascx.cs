using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GT.Web.Site.Menu
{
  public partial class SubmenuItem : System.Web.UI.UserControl
  {
    public string NavigateUrl { get; set; }

    public string Text { get; set; }

    public string CssClass { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
  }
}