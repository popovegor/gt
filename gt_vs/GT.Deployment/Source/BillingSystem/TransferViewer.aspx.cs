using System;
using System.Web.UI.WebControls;
using GT.BO.Implementation.BillingSystem;
using GT.Web.UI.Pages;

namespace GT.Web.Site.BillingSystem
{
  public partial class TransferViewer : BaseViewPage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
        DataBind();
    }

    protected void gvTransfers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      gvTransfers.PageIndex = e.NewPageIndex;
    }

    protected override void OnPreRender(EventArgs e)
    {
      base.OnPreRender(e);
      gvTransfers.DataBind();
    }


    public Transfer[] Transfers
    {
      get
      {
        return BillingSystemFacade.GetTransfersForUser(Credentials.UserId);
      }
    }
  }
}
