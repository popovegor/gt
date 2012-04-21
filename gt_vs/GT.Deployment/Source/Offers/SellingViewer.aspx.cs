using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Offers;
using GT.Web.UI.Pages;

namespace GT.Web.Site.Offers
{
    public partial class SellingViewer : BaseViewPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Server.Transfer(Request.Url.AbsolutePath, false);
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
          PageDataBind();
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            //TODO: implement the server handler for the filter post
        }

        private void PageDataBind()
        {
            //offers grid
            DataSet offers = null;
            offers = SellingFacade.SearchOffers(gtViewFilter.SearchFilter);

            if (null == offers || offers.Tables.Count <= 0 || offers.Tables[0].Rows.Count <= 0)
            {
            }
            else
            {
                dgOffers.DataSource = offers.Tables[0].Rows;
            }

            Page.DataBind();
        }
    }
}
