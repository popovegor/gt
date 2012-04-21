using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Common.Types;
using GT.DA.Offers;
using GT.Web.UI.Pages;
using Manager = GT.BO.Implementation.Offers.BuyingFacade;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Global.Offers;
using GT.DA.Dictionaries;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.UserRating;
using GT.Global.UserRating;

namespace GT.Web.Site.Offers
{
    public partial class BuyingManager : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                AllBind();
            }
        }

        private void AllBind()
        {
            BuyingDataBind();
            SellingDataBind();
            DataBind();
        }

        private void SellingDataBind()
        {
            DataSet offers = null;

            offers = SellingDataAdapter.GetByBuyerName(Credentials.UserName);

            if (null == offers || offers.Tables.Count <= 0 || offers.Tables[0].Rows.Count <= 0)
            {
                sellingGW.DataSource = null;
            }
            else
            {
                sellingGW.DataSource = offers.Tables[0].Select(null, String.Format("{0} DESC", GT.DA.Offers.SellingOfferFields.ModifyDate));
            }
            sellingGW.DataBind();
        }

        protected void sellingGW_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label status = e.Row.FindControl("lblStatus") as Label;
                Label date = e.Row.FindControl("lblUpdate") as Label;
                ImageButton btn1 = e.Row.FindControl("btnOne") as ImageButton;
                ImageButton btn2 = e.Row.FindControl("btnTwo") as ImageButton;
                Label delivery = e.Row.FindControl("lblDeliveryTime") as Label;

                if (status != null && btn1 != null && btn2 != null && date != null)
                {
                    TransactionPhase phase = Dictionaries.Instance.GetTransactionPhaseByName(status.Text);
                    status.Style.Add(HtmlTextWriterStyle.Color, SellingFacade.GetStatusColor(phase));

                    switch (phase)
                    {
                        case TransactionPhase.Accept:
                            btn1.AlternateText = CommonResources.Pay;
                            btn1.ToolTip = CommonResources.Pay;
                            btn1.ImageUrl = "~/App_Themes/Tutynin/Images/actions/pay.png";
                            btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferPayConfirmation));
                            btn2.AlternateText = CommonResources.Abandon;
                            btn2.ToolTip = CommonResources.Abandon;
                            btn2.ImageUrl = "~/App_Themes/Tutynin/Images/actions/cancel.png";
                            btn2.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferBuyerCancelConfirmation));
                            btn1.Visible = true;
                            btn2.Visible = true;

                            delivery.Text = String.Format(CommonResources.DeliveryTemplate, delivery.Text);
                            break;

                        case TransactionPhase.Submit:
                            btn1.AlternateText = CommonResources.GoodsGot;
                            btn1.ToolTip = CommonResources.GoodsGot;
                            btn1.ImageUrl = "~/App_Themes/Tutynin/Images/actions/finish.png";
                            btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferSubmitConfirmation));
                            btn2.AlternateText = CommonResources.Complain;

                            btn2.ImageUrl = "~/App_Themes/Tutynin/Images/actions/complain.png";
                            btn2.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferConflictConfirmation));
                            btn1.Visible = true;
                            btn2.Visible = true;

                            DateTime d = DateTime.Parse(date.Text);
                            TimeSpan diff = DateTime.Now.Subtract(d);

                            int deliver = TypeConverter.ToInt32(delivery.Text);

                            btn2.Enabled = diff.Days > deliver;
                            delivery.Text = btn2.Enabled ? CommonResources.Expired : String.Format(CommonResources.DeliveryTemplate2, deliver - diff.Days);
                            btn2.ToolTip = btn2.Enabled ? CommonResources.Complain : delivery.Text;
                            break;

                        case TransactionPhase.Start:
                            btn1.AlternateText = CommonResources.Abandon;
                            btn1.ToolTip = CommonResources.Abandon;
                            btn1.ImageUrl = "~/App_Themes/Tutynin/Images/actions/abandon.png";
                            btn1.Visible = true;
                            btn2.Visible = false;
                            btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferRefuseConfirmation));
                            delivery.Text = String.Format(CommonResources.DeliveryTemplate, delivery.Text);
                            break;

                        case TransactionPhase.Conflict:
                            delivery.Text = CommonResources.Expired;
                            btn1.Visible = false;
                            btn2.Visible = false;
                            break;

                        case TransactionPhase.Finish:
                            delivery.Text = CommonResources.Complete;
                            if (UserRatingFacade.GetUnusedBySellingId(TypeConverter.ToInt32(((DataRow)e.Row.DataItem)[SellingOfferFields.SellingId]), Credentials.UserId) != null)
                            {
                                btn1.Visible = true;
                                btn1.ImageUrl = "~/App_Themes/Tutynin/Images/actions/feedback.png";
                                btn1.ToolTip = CommonResources.PersonalAccount_Office_LeaveFeedback;
                                btn1.AlternateText = CommonResources.PersonalAccount_Office_LeaveFeedback;
                            }
                            else
                            {
                                btn1.Visible = false;
                            }
                            btn2.Visible = false;
                            break;

                        default:
                            btn1.Visible = false;
                            btn2.Visible = false;
                            break;
                    }
                }
            }
        }

        private void BuyingDataBind()
        {
            DataSet ds = BuyingDataAdapter.GetBuyingOffersByBuyer(Credentials.UserId);

            if (ds == null || ds.Tables.Count <= 0)
            {
                buyingGW.DataSource = null;
            }
            else
            {
                buyingGW.DataSource = ds.Tables[0].Rows;
            }
            buyingGW.DataBind();
        }

        protected void buyingGW_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GT.Web.Site.Controls.Offer suggested = e.Row.FindControl("sel") as GT.Web.Site.Controls.Offer;
                ImageButton btn1 = e.Row.FindControl("btnOne") as ImageButton;
                ImageButton btn2 = e.Row.FindControl("btnTwo") as ImageButton;
                ImageButton btn3 = e.Row.FindControl("btnThree") as ImageButton;
                if (suggested != null && btn1 != null && btn2 != null && btn3 != null)
                {
                    btn3.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.DemandDeleteConfirmation));
                    btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.DemandAcceptConfirmation));
                    btn2.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.DemandDeclineConfirmation));

                    if (suggested.OfferId <= 0)
                    {
                        btn1.Visible = false;
                        btn2.Visible = false;
                    }
                }
            }
        }

        protected void buyingGW_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            buyingGW.PageIndex = e.NewPageIndex;
            AllBind();
        }

        protected void sellingGW_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            sellingGW.PageIndex = e.NewPageIndex;
            AllBind();
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

                if (res == 1)
                {
                    buyingGW.PageIndex = 0;
                }
                AllBind();

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

                if (res == 1)
                {
                    buyingGW.PageIndex = 0;
                }
                AllBind();

                if (res != 1)
                {
                    errLbl.Text = CommonResources.OldDataError;
                    errLbl.Visible = true;
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
                AllBind();
            }
        }

        protected void btnOneSelling_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            Label lbl = btn.NamingContainer.FindControl("lblId") as Label;
            Label status = btn.NamingContainer.FindControl("lblStatus") as Label;

            if (lbl != null && status != null)
            {
                int offerId = int.Parse(lbl.Text);
                TransactionPhase phase = Dictionaries.Instance.GetTransactionPhaseByName(status.Text);
                Selling offer = SellingFacade.GetOfferById(offerId);

                int res = 0;
                if (phase != offer.TransactionPhase)
                {
                    res = -1;
                }
                else if (phase == TransactionPhase.Start || offer.BuyerId == Credentials.UserId)
                {
                    switch (phase)
                    {
                        case TransactionPhase.Accept:
                            res = SellingFacade.ConfirmOffer(offer);
                           
                            break;

                        case TransactionPhase.Submit:
                            res = SellingFacade.FinishOffer(offer);
                            break;

                        case TransactionPhase.Start:
                            res = SellingFacade.AbandonOffer(offer, Credentials.UserId);
                            break;

                        case TransactionPhase.Finish:
                            Response.Redirect(String.Format("/UserRating/LeaveFeedback.aspx?{0}={1}&{2}={3}", LeaveFeedbackParams.SellingId, offer.Id, LeaveFeedbackParams.ReturnUrl, Request.Url.ToString()));
                            return;
                    }
                }

                if (res == 1)
                {
                   sellingGW.PageIndex = 0;
                }

                AllBind();
                
                if (res == -1)
                {
                    errLabelSelling.Visible = true;
                    errLabelSelling.Text = CommonResources.OldDataError;
                }
                else if (res == -2)
                {
                    errLabelSelling.Visible = true;
                    errLabelSelling.Text = CommonResources.NotEnougtMoney;
                }
            }
        }

        protected void btnTwoSelling_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            Label lbl = btn.NamingContainer.FindControl("lblId") as Label;
            Label status = btn.NamingContainer.FindControl("lblStatus") as Label;

            if (lbl != null && status != null)
            {
                int offerId = int.Parse(lbl.Text);
                TransactionPhase phase = Dictionaries.Instance.GetTransactionPhaseByName(status.Text);
                Selling offer = SellingFacade.GetOfferById(offerId);

                int res = 0;
                if (phase != offer.TransactionPhase)
                {
                    res = -1;
                }
                else if (offer.BuyerId == Credentials.UserId)
                {
                    switch (phase)
                    {
                        case TransactionPhase.Accept:
                            res = SellingFacade.CancelOfferAccept(offer, Credentials.UserId);
                            break;

                        case TransactionPhase.Submit:
                            res = SellingFacade.ConflictOffer(offer, Credentials.UserId);
                            break;
                    }
                }

                if (res == 1)
                {
                    sellingGW.PageIndex = 0;
                }
                AllBind();
                
                if (res == -1)
                {
                    errLabelSelling.Visible = true;
                    errLabelSelling.Text = CommonResources.OldDataError;
                }
            }
        }
    }
}
