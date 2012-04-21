using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Common.Types;
using GT.DA.Offers;
using GT.Web.UI.Pages;
using Manager = GT.BO.Implementation.Offers.BuyingFacade;
using Resources;

namespace GT.Web.Site.Offers
{
    public partial class BuyingManager : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BuyerDataBind();
                DataBind();
            }
        }

        private void BuyerDataBind()
        {
            DataSet ds = BuyingDataAdapter.GetBuyingOffersByBuyer(Credentials.UserId);

            if (ds == null || ds.Tables.Count <= 0)
            {
                gvBuyer.DataSource = null;
            }
            else
            {
                gvBuyer.DataSource = ds.Tables[0].Rows;
            }
            gvBuyer.DataBind();
        }

        protected void gvBuyer_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HyperLink suggested = e.Row.FindControl("hplSuggested") as HyperLink;
                ImageButton btn1 = e.Row.FindControl("btnOne") as ImageButton;
                ImageButton btn2 = e.Row.FindControl("btnTwo") as ImageButton;
                ImageButton btn3 = e.Row.FindControl("btnThree") as ImageButton;
                if (suggested != null && btn1 != null && btn2 != null && btn3 != null)
                {
                    btn3.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.DemandDeleteConfirmation));
                    btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.DemandAcceptConfirmation));
                    btn2.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.DemandDeclineConfirmation));

                    if (string.IsNullOrEmpty(suggested.Text))
                    {
                        btn1.Visible = false;
                        btn2.Visible = false;
                    }
                }
            }
        }

        protected void gvBuyer_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBuyer.PageIndex = e.NewPageIndex;
            BuyerDataBind();
        }

        protected void btnOne_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            Label lbl = btn.NamingContainer.FindControl("lblId") as Label;
            Label suggestedId = btn.NamingContainer.FindControl("lblSuggested") as Label;

            if (lbl != null && suggestedId != null)
            {
                int buyingOfferId = TypeConverter.ToInt32(lbl.Text);
                int suggestedOffer = TypeConverter.ToInt32(suggestedId.Text);

                int res = Manager.AcceptSuggested(buyingOfferId, suggestedOffer);

                if (res == -2)
                {
                    errLbl.Text = CommonResources.NotEnougtMoney;
                    errLbl.Visible = true;
                }
                else
                if (res != 1)
                {
                    errLbl.Text = CommonResources.OldDataError;
                    errLbl.Visible = true;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.DemandPostAccept), true);
                    BuyerDataBind();
                }
            }
        }

        protected void btnTwo_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            Label lbl = btn.NamingContainer.FindControl("lblId") as Label;
            Label suggestedId = btn.NamingContainer.FindControl("lblSuggested") as Label;

            if (lbl != null && suggestedId != null)
            {
                int buyingOfferId = TypeConverter.ToInt32(lbl.Text);
                int suggestedOffer = TypeConverter.ToInt32(suggestedId.Text);

                int res = Manager.CancelSuggested(buyingOfferId, suggestedOffer);

                if (res != 1)
                {
                    errLbl.Text = CommonResources.OldDataError;
                    errLbl.Visible = true;
                }
                else
                {
                    BuyerDataBind();
                }
            }
        }

        protected void btnThree_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            Label lbl = btn.NamingContainer.FindControl("lblId") as Label;

            if (lbl != null)
            {
                int buyingOfferId = TypeConverter.ToInt32(lbl.Text);
                int temp;

                Manager.DeleteOffer(Credentials.UserId, buyingOfferId, out temp);
                BuyerDataBind();
            }
        }
    }
}
