using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GT.Web.Site.Controls
{
  public partial class MainMenu : System.Web.UI.UserControl
  {
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      this.DataBind();
    }
  }
}