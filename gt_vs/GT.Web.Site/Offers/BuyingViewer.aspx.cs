using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Pages;
using Manager = GT.BO.Implementation.Offers.BuyingFacade;
using GT.Web.UI.Controls;

namespace GT.Web.Site.Offers
{
  public partial class BuyingViewer : BaseViewPage
  {

    protected void Page_Init(object sender, EventArgs e)
    {
      gv.RowDataBound += new GridViewRowEventHandler(ControlHelper.RowDataBound);
      gv.PageIndexChanging += new GridViewPageEventHandler(ControlHelper.PageIndexChanging);
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
