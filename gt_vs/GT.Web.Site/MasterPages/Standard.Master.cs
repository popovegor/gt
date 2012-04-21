using System;
using System.Web.UI;
using GT.Global.Cookies;
using System.Text.RegularExpressions;
using GT.Web.UI.Pages;

namespace GT.Web.Site.MasterPages
{
  public partial class Standard : BaseMasterPage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      menu.DataBind();
      cphTitle.DataBind();
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
    }
  }
}
