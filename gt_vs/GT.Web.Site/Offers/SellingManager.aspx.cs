using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Offers;
using GT.Common.Types;
using GT.DA.Offers;
using GT.Global.Offers;
using GT.Web.UI.Pages;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.DA.Dictionaries;
using System.Web.Services;
using System.Web.Script.Services;
using GT.BO.Implementation.UserRating;
using GT.Global.UserRating;

namespace GT.Web.Site.Offers
{
    public partial class SellingManager : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SellerDataBind();
                DataBind();
            }
        }

        private void SellerDataBind()
        {
            DataSet offers = null;
            
            offers = SellingDataAdapter.GetBySellerName(Credentials.UserName);

            if (null == offers || offers.Tables.Count <= 0 || offers.Tables[0].Rows.Count <= 0)
            {
                gvSeller.DataSource = null;
            }
            else
            {
                gvSeller.DataSource = offers.Tables[0].Rows;
            }
            gvSeller.DataBind();
        }

        protected void gvSeller_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label sellerStatus = e.Row.FindControl("lblStatusSeller") as Label;
                Label date = e.Row.FindControl("lblUpdateSeller") as Label;
                ImageButton btn0 = e.Row.FindControl("btnZeroSeller") as ImageButton;
                ImageButton btn1 = e.Row.FindControl("btnOneSeller") as ImageButton;
                ImageButton btn2 = e.Row.FindControl("btnTwoSeller") as ImageButton;
                ImageButton btn3 = e.Row.FindControl("btnThreeSeller") as ImageButton;
                Button btnValid = e.Row.FindControl("btnValid") as Button;
                TextBox txtValid = e.Row.FindControl("txtBoxValid") as TextBox;
                Label buyerId = e.Row.FindControl("lblBuyerId") as Label;
                Label delivery = e.Row.FindControl("lblDeliveryTimeSeller") as Label;

                if (sellerStatus != null && btn1 != null && btn2 != null && btn3 != null && date != null && delivery != null)
                {
                    btn3.Visible = true;
                    TransactionPhase phase = Dictionaries.Instance.GetTransactionPhaseByName(sellerStatus.Text);
                    sellerStatus.Style.Add(HtmlTextWriterStyle.Color, SellingFacade.GetStatusColor(phase));

                    switch (phase)
                    {
                        case TransactionPhase.Start:
                            btn1.AlternateText = CommonResources.Select;
                            btn1.ToolTip = CommonResources.Select;
                            btn1.ImageUrl = "~/App_Themes/Tutynin/Images/actions/select.png";
                            btn2.AlternateText = CommonResources.Decline;
                            btn2.ToolTip = CommonResources.Decline;
                            btn2.ImageUrl = "~/App_Themes/Tutynin/Images/actions/reject.png";
                            bool buyersExist = String.IsNullOrEmpty(buyerId.Text);
                            btn0.Visible = buyersExist;
                            btn1.Visible = !buyersExist;
                            btn2.Visible = !buyersExist;
                            btn3.Visible = true;
                            btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferSelectConfirmation));
                            btn2.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferDeclineConfirmation));
                            btn3.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferDeleteConfirmation));
                            delivery.Text = String.Format(CommonResources.DeliveryTemplate, delivery.Text);

                            break;

                        case TransactionPhase.Submit:
                            btn1.AlternateText = CommonResources.Decline;
                            btn1.ToolTip = CommonResources.Decline;
                            btn1.ImageUrl = "~/App_Themes/Tutynin/Images/actions/cancel.png";
                            btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferCancelConfirmation));
                            btn2.AlternateText = CommonResources.Complain;
                            btn2.ImageUrl = "~/App_Themes/Tutynin/Images/actions/complain.png";
                            btn2.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferConflictConfirmation));
                            btn1.Visible = true;
                            btn2.Visible = true;
                            btn3.Visible = false;
                            btnValid.Visible = true;
                            txtValid.Visible = true;

                            DateTime d = DateTime.Parse(date.Text);
                            TimeSpan diff = DateTime.Now.Subtract(d);

                            int deliver = TypeConverter.ToInt32(delivery.Text);

                            btn2.Enabled = diff.Days > deliver;
                            delivery.Text = btn2.Enabled ? CommonResources.Expired : String.Format(CommonResources.DeliveryTemplate2, deliver - diff.Days);
                            btn2.ToolTip = btn2.Enabled ? CommonResources.Complain : delivery.Text;
                            break;

                        case TransactionPhase.Accept:
                            btn1.AlternateText = CommonResources.Cancel;
                            btn1.ToolTip = CommonResources.Cancel;
                            btn1.ImageUrl = "~/App_Themes/Tutynin/Images/actions/cancel.png";
                            btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferCancelConfirmation));
                            btn1.Visible = true;
                            btn2.Visible = false;
                            btn3.Visible = false;
                            delivery.Text = String.Format(CommonResources.DeliveryTemplate, delivery.Text);
                            break;

                        case TransactionPhase.Conflict:
                            btn3.Visible = false;
                            btn1.Visible = false;
                            btn2.Visible = false;
                            delivery.Text = CommonResources.Expired;
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
                            btn3.Visible = true;
                            btn3.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferDeleteConfirmation));
                            break;

                        default:
                            btn1.Visible = false;
                            btn2.Visible = false;
                            break;
                    }
                }
            }
        }

        protected void gvSeller_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSeller.PageIndex = e.NewPageIndex;
            SellerDataBind();
        }

        protected void btnOneSeller_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            Label lbl = btn.NamingContainer.FindControl("lblIdSeller") as Label;
            Label buyerId = btn.NamingContainer.FindControl("lblBuyerId") as Label;
            Label status = btn.NamingContainer.FindControl("lblStatusSeller") as Label;

            if (lbl != null && buyerId != null && status != null)
            {
                int offerId = int.Parse(lbl.Text);
                Guid bId = new Guid(buyerId.Text);
                TransactionPhase phase = Dictionaries.Instance.GetTransactionPhaseByName(status.Text);
                Selling offer = SellingFacade.GetOfferById(offerId);
                int res = 0;

                if (offer.TransactionPhase != phase)
                {
                    res = -1;
                }
                else if (offer.SellerId == Credentials.UserId)
                {
                    switch (phase)
                    {
                        case TransactionPhase.Accept:
                            res = SellingFacade.CancelOfferAccept(offer, Credentials.UserId);
                            break;

                        case TransactionPhase.Start:
                            res = SellingFacade.AcceptOffer(offer, bId);
                            if (res == -2)
                            {
                                errLblSeller.Visible = true;
                                errLblSeller.Text = CommonResources.OldDataError;
                            }
                            break;

                        case TransactionPhase.Submit:
                            res = SellingFacade.CancelConfirmedOffer(offer);
                            break;

                        case TransactionPhase.Finish:
                            Response.Redirect(String.Format("../UserRating/LeaveFeedback.aspx?{0}={1}&{2}={3}", LeaveFeedbackParams.SellingId, offer.Id, LeaveFeedbackParams.ReturnUrl, Request.Url.ToString()));
                            return;
                    }
                }

                if (res == 1)
                {
                    gvSeller.PageIndex = 0;
                }

                SellerDataBind();

                if (res == -1)
                {
                    errLblSeller.Visible = true;
                    errLblSeller.Text = CommonResources.OldDataError;
                }
            }
        }

        protected void btnTwoSeller_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            Label lbl = btn.NamingContainer.FindControl("lblIdSeller") as Label;
            Label buyerId = btn.NamingContainer.FindControl("lblBuyerId") as Label;
            Label status = btn.NamingContainer.FindControl("lblStatusSeller") as Label;

            if (lbl != null && buyerId != null && status != null)
            {
                int offerId = int.Parse(lbl.Text);
                Guid bId = new Guid(buyerId.Text);
                TransactionPhase phase = Dictionaries.Instance.GetTransactionPhaseByName(status.Text);
                Selling offer = SellingFacade.GetOfferById(offerId);
                int res = 0;

                if (phase != offer.TransactionPhase)
                {
                    res = -1;
                }
                else if (offer.SellerId == Credentials.UserId)
                {
                    switch (phase)
                    {
                        case TransactionPhase.Start:
                            res = SellingFacade.RejectOffer(offer, bId);
                            break;

                        case TransactionPhase.Submit:
                            res = SellingFacade.ConflictOffer(offer, Credentials.UserId);
                            break;
                    }
                }

                if (res == 1)
                {
                    gvSeller.PageIndex = 0;
                }

                SellerDataBind();

                if (res == -1)
                {
                    errLblSeller.Visible = true;
                    errLblSeller.Text = CommonResources.OldDataError;
                }
            }
        }

        protected void btnThreeSeller_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            Label lbl = btn.NamingContainer.FindControl("lblIdSeller") as Label;
            Label status = btn.NamingContainer.FindControl("lblStatusSeller") as Label;

            if (lbl != null  && status != null)
            {
                int offerId = int.Parse(lbl.Text);
                TransactionPhase phase = Dictionaries.Instance.GetTransactionPhaseByName(status.Text);
                Selling offer = SellingFacade.GetOfferById(offerId);
                int res = 0;

                if (phase != offer.TransactionPhase)
                {
                    res = -1;
                }
                else if (offer.SellerId == Credentials.UserId)
                {
                    switch (phase)
                    {
                        case TransactionPhase.Finish:
                            res = SellingFacade.DelFinishOffer(offer);
                            break;

                        case TransactionPhase.Start:
                            res = SellingFacade.DelStartOffer(offer);
                            break;
                    }
                }

                SellerDataBind();

                if (res == -1)
                {
                    errLblSeller.Visible = true;
                    errLblSeller.Text = CommonResources.OldDataError;
                }
            }
        }
    }
}
