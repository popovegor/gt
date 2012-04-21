using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GT.Web.Site.HtmlTemplates
{
  public partial class TestTemplates : System.Web.UI.Page
  { 
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        DataBind();
    }
  }
}
