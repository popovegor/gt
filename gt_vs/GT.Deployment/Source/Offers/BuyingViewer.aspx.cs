using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Pages;
using Manager = GT.BO.Implementation.Offers.BuyingFacade;

namespace GT.Web.Site.Offers
{
    public partial class BuyingViewer : BaseViewPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
          PageDataBind();
        }

        private void PageDataBind()
        {
            //offers grid
            DataSet offers = null;
            offers = Manager.SearchOffers(gtViewFilter.SearchFilter);

            if (null == offers || offers.Tables.Count <= 0 || offers.Tables[0].Rows.Count <= 0)
            {
                //lblNoOffers.Visible = true;
            }
            else
            {
                dgOffers.DataSource = offers.Tables[0].Rows;
            }

            Page.DataBind();
        }
    }
}
