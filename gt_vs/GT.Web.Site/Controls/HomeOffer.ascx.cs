using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Global.Entities;

namespace GT.Web.Site.Controls
{
  public partial class HomeOffer : System.Web.UI.UserControl
  {
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public EntityType Entity
    {
      get;
      set;
    }

    public GT.BO.Implementation.Offers.BaseOffer BaseOffer
    {
      get;
      set;
    }
  }
}