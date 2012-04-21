using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GT.Web.Site.Help
{
  public partial class About : System.Web.UI.UserControl
  {
    public string HowSellUrl { get; set; }
    public string HowBuyUrl { get; set; }
    public string BillingUrl { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
  }
}