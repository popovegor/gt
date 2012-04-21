using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Offers;
using GT.Web.UI.Pages;
using GT.Web.UI.Controls;

namespace GT.Web.Site.Offers
{
  public partial class SellingViewer : BaseViewPage
  {
    protected void Page_Init(object sender, EventArgs e)
    {
      gv.RowDataBound += new GridViewRowEventHandler(ControlHelper.RowDataBound);
      gv.PageIndexChanging += new GridViewPageEventHandler(ControlHelper.PageIndexChanging);
    }
  
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
      Server.Transfer(Request.Url.AbsolutePath, false);
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }

    protected void btnApply_Click(object sender, EventArgs e)
    {
      //TODO: implement the server handler for the filter post
    }
  }
}
