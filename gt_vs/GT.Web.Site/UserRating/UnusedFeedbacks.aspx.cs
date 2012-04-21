using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Pages;
using GT.BO.Implementation.UserRating;
using GT.Web.UI.Controls;

namespace GT.Web.Site.UserRating
{
  public partial class UnusedFeedbacks : BasePage
  {
    protected void Page_Init(object sender, EventArgs e)
    {
      gv.PageIndexChanging += ControlHelper.PageIndexChanging;
    }
  
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }
  }
}
