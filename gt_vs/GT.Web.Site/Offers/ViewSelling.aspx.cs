using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.Users;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.DA.Offers;
using GT.Global.Offers;
using GT.Web.UI.Pages;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Web.Site.MasterPages;
using GT.Global.DetailsInfo;
using GT.BO.Implementation.Helpers;
using GT.Common.Web.WebUtils;
using System.Net;
using GT.Web.Security;
using GT.BO.Implementation.UserRating;
using GT.Global.UserRating;
using System.Web.Security;

namespace GT.Web.Site.Offers
{
  public partial class ViewSelling : BaseViewPage
  {
    const string VIEW_STATE_OFFER = "offer_{8223C47B-B87C-4999-BBCC-7C7871CA3ABE}";
    const string VIEW_STATE_SELECT = "select_{8223C47B-B87C-4999-BBCC-7C7871CA3ABE}";

    DataTable m_TempTable;
    
    private Selling _offer = null;
    
    public Selling Offer
    {
      get
      {
        if (_offer == null && SellingId.HasValue == true)
        {
          _offer = SellingFacade.GetOfferById(SellingId.Value);
        }
        return _offer;
      }
    }

    public int? SellingId
    {
      get
      {
        var idAsString = Request.QueryString["id"];
        int id = TypeConverter.ToInt32(Request.QueryString["id"], 0);
        return id > 0 ? new Nullable<int>(id) : new Nullable<int>();
      }
    }

    protected void sivImage_SavedImageExists()
    {
      trImage.Style.Add(HtmlTextWriterStyle.Display, "");
    }
    
    protected void Page_PreRender(object sender, EventArgs e)
    {
      if(string.IsNullOrEmpty(description.Text) == false)
      {
        description.Text = description.Text.Replace("&#13;&#10;", "<br/>");
      }
      Title = Offer != null ? Offer.Title : Title;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      if (SellingId.HasValue == true)
      {
        if (!IsPostBack)
        {
          LoadData();
          DataBind();
        }
      }
      else
      {
        if (UserAgentUtils.IsSearchBot)
        {
          Response.Clear();
          Response.StatusCode = (int)HttpStatusCode.NotFound;
          Response.Close();
        }
        else
        {
          errLbl.Visible = true;
          info.Visible = false;
          errLbl.Text = CommonResources.OfferNotFound;
        }
      }
    }

    void LoadData()
    {
      buyersTitle.Visible = false;
      Selling offer = Offer;

      if (offer != null)
      {
        name.Text = offer.Title;
        description.Text = offer.Description;
        dateCreation.Text = offer.CreateDate.UtcToLocal().ToLongDateString();
        price.Text = offer.Price.ToString("0.##");
        if (offer.ProductCategoryId > 0)
        {
          lblProductCategory.Text = offer.ProductCategoryName;
          category.Visible = true;
        }

        seller.UserId = offer.SellerId;
        //writeSeller.NavigateUrl = String.Format("~/Users/User/{0}/Conversation", offer.SellerId);

        game.ServerId = offer.GameServerId;
        server.ServerId = offer.GameServerId;

        deliveryVal.Text = String.Format(CommonResources.DeliveryTemplate, offer.DeliveryTime);

        if (Request.IsAuthenticated)
        {
          ViewState[VIEW_STATE_OFFER] = offer;

          if (offer.TransactionPhase != TransactionPhase.Start)
          {
            trUpdate.Style.Add(HtmlTextWriterStyle.Display, "");
            dateUpdateVal.Text = offer.ModifyDate.UtcToLocal().ToLongDateString();
          }
          else
          {
            DataSet ds = SellingDataAdapter.GetOfferBuyers(SellingId.Value);
            if (ds != null && ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
            {
              m_TempTable = ds.Tables[0];
            }
          }

          if (offer.SellerId == Credentials.UserId)
          {
            trStatus.Style.Add(HtmlTextWriterStyle.Display, "");
            statusVal.Text = Dictionaries.Instance.GetTransactionPhaseNameById((int)offer.TransactionPhase);
            statusVal.Style.Add(HtmlTextWriterStyle.Color, SellingFacade.GetStatusColor(offer.TransactionPhase));
            //writeSeller.Visible = false;

            if (offer.BuyerId != Guid.Empty)
            {
              trBuyer.Style.Add(HtmlTextWriterStyle.Display, "");
              buyerVal.UserId = offer.BuyerId;
              writeBuyer.Visible = true;
              writeBuyer.NavigateUrl = String.Format("~/Users/User/{0}?dt=Conversation", offer.BuyerId);
            }

            switch (offer.TransactionPhase)
            {
              case TransactionPhase.Start:

                if (m_TempTable != null)
                {
                  DataRow[] rows = m_TempTable.Select(String.Format("{0} = 1", BuyerStatusFields.BuyerStatusId));
                  if (rows.Length > 0)
                  {
                    buyersTitle.Visible = true;
                    buyers.Visible = true;
                    buyers.DataSource = rows;
                    //this.buyers.DataBind();
                  }
                }

                btnOne.Visible = false;
                btnTwo.Visible = false;
                break;

              case TransactionPhase.Accept:
                btnOne.Text = CommonResources.Cancel;
                btnOne.ToolTip = CommonResources.Cancel;
                btnOne.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferCancelConfirmation);
                btnOne.Visible = true;
                btnTwo.Visible = false;
                break;

              case TransactionPhase.Submit:
                btnOne.Text = CommonResources.Decline;
                btnOne.ToolTip = CommonResources.Decline;
                btnOne.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferCancelConfirmation);
                btnTwo.Text = CommonResources.Complain;
                btnTwo.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferConflictConfirmation);
                btnOne.Visible = true;
                btnTwo.Visible = true;

                TimeSpan diff = DateTime.Now.Subtract(offer.ModifyDate.UtcToLocal());
                btnTwo.Enabled = diff.Days > offer.DeliveryTime;
                deliveryVal.Text = btnTwo.Enabled ? CommonResources.Expired : String.Format(CommonResources.DeliveryTemplate2, offer.DeliveryTime - diff.Days);
                btnTwo.ToolTip = btnTwo.Enabled ? CommonResources.Complain : deliveryVal.Text;

                trKey.Style.Add(HtmlTextWriterStyle.Display, "");
                keyTxt.Text = CommonResources.SellingViewer_ValidateKey;
                keyBox.Visible = true;
                keyBtn.Visible = true;

                break;

              case TransactionPhase.Conflict:
                btnOne.Visible = false;
                btnTwo.Visible = false;
                deliveryVal.Text = CommonResources.Expired;
                break;

              case TransactionPhase.Finish:
                if (UserRatingFacade.GetUnusedBySellingId(offer.Id, offer.SellerId) != null)
                {
                  btnOne.Visible = true;
                  btnOne.Text = CommonResources.PersonalAccount_Office_LeaveFeedback;
                  btnOne.ToolTip = CommonResources.PersonalAccount_Office_LeaveFeedback;
                }
                else
                {
                  btnOne.Visible = false;
                }
                btnTwo.Visible = false;
                deliveryVal.Text = CommonResources.Complete;
                break;
            }
          }
          else
          {
            btnOne.Visible = false;
            btnTwo.Visible = false;
            ViewState[VIEW_STATE_SELECT] = false;

            if (offer.BuyerId == Credentials.UserId)
            {
              trStatus.Style.Add(HtmlTextWriterStyle.Display, "");
              this.statusVal.Visible = true;
              this.statusVal.Text = Dictionaries.Instance.GetTransactionPhaseNameById((int)offer.TransactionPhase);
              this.statusVal.Style.Add(HtmlTextWriterStyle.Color, SellingFacade.GetStatusColor(offer.TransactionPhase));

              if (!String.IsNullOrEmpty(offer.ValidKey))
              {
                this.keyTxt.Visible = true;
                this.keyVal.Visible = true;
                this.keyVal.Text = offer.ValidKey;
              }

              trBuyer.Style.Add(HtmlTextWriterStyle.Display, "");
              buyerVal.Visible = true;
              buyerVal.UserId = offer.BuyerId;

              switch (offer.TransactionPhase)
              {
                case TransactionPhase.Accept:
                  btnOne.Text = CommonResources.Pay;
                  btnOne.ToolTip = CommonResources.Pay;
                  btnOne.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferPayConfirmation);
                  btnTwo.Text = CommonResources.Cancel;
                  btnTwo.ToolTip = CommonResources.Cancel;
                  btnTwo.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferCancelConfirmation);
                  btnOne.Visible = true;
                  btnTwo.Visible = true;

                  break;

                case TransactionPhase.Submit:
                  btnOne.Text = CommonResources.GoodsGot;
                  btnOne.ToolTip = CommonResources.GoodsGot;
                  btnOne.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferSubmitConfirmation);
                  btnTwo.Text = CommonResources.Complain;
                  btnTwo.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferConflictConfirmation);
                  btnOne.Visible = true;
                  btnTwo.Visible = true;

                  TimeSpan diff = DateTime.Now.Subtract(offer.ModifyDate.UtcToLocal());
                  btnTwo.Enabled = diff.Days > offer.DeliveryTime;

                  deliveryVal.Text = btnTwo.Enabled ? CommonResources.Expired : String.Format(CommonResources.DeliveryTemplate2, offer.DeliveryTime - diff.Days);
                  btnTwo.ToolTip = btnTwo.Enabled ? CommonResources.Complain : deliveryVal.Text;

                  trKey.Style.Add(HtmlTextWriterStyle.Display, "");
                  keyTxt.Text = CommonResources.SellingViewer_Key;
                  keyVal.Text = offer.ValidKey;
                  break;

                case TransactionPhase.Finish:
                  if (UserRatingFacade.GetUnusedBySellingId(offer.Id, offer.BuyerId) != null)
                  {
                    btnOne.Visible = true;
                    btnOne.Text = CommonResources.PersonalAccount_Office_LeaveFeedback;
                    btnOne.ToolTip = CommonResources.PersonalAccount_Office_LeaveFeedback;
                  }
                  break;
              }
            }
            else if (m_TempTable != null)
            {
              DataRow[] rows = m_TempTable.Select(String.Format("{0} = '{1}'", SellingOfferFields.BuyerId, Credentials.UserId));
              if (rows != null && rows.Length == 1)
              {
                int state = TypeConverter.ToInt32(rows[0][BuyerStatusFields.BuyerStatusId]);
                if (state == 1 || state == 4)
                {
                  btnOne.Text = CommonResources.Abandon;
                  btnOne.ToolTip = CommonResources.Abandon;
                  btnOne.Visible = true;
                  btnOne.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferRefuseConfirmation);
                  btnTwo.Visible = false;
                  ViewState[VIEW_STATE_SELECT] = true;
                }
                else if (state == 3)
                {
                  btnOne.Text = CommonResources.Accept;
                  btnOne.ToolTip = CommonResources.Accept;
                  btnOne.Visible = true;
                  btnOne.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferAcceptConfirmation);
                  btnTwo.Visible = false;
                }
                else if (state == 2)
                {
                  errLbl.Text = CommonResources.SellerHasDeclineYouMsg;
                  errLbl.Visible = true;
                }
              }
              else if (rows != null && rows.Length == 0 && offer.TransactionPhase == TransactionPhase.Start)
              {
                btnOne.Text = CommonResources.Accept;
                btnOne.ToolTip = CommonResources.Accept;
                btnOne.Visible = true;
                btnOne.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferAcceptConfirmation);
                btnTwo.Visible = false;
              }
            }
            else if (offer.TransactionPhase == TransactionPhase.Start)
            {
              btnOne.Text = CommonResources.Accept;
              btnOne.ToolTip = CommonResources.Accept;
              btnOne.OnClientClick = String.Format("return confirm('{0}');", CommonResources.OfferAcceptConfirmation);
              btnOne.Visible = true;
              btnTwo.Visible = false;
            }
          }
        }
        else if (offer.BuyerId == Guid.Empty)
        {
          btnOne.Visible = true;
          btnOne.Text = CommonResources.Accept;
          btnOne.OnClientClick = String.Format(@"location.href = '{0}?ReturnUrl={1}'; return false;", FormsAuthentication.LoginUrl, Request.RawUrl);
        }
      }
      else
      {
        errLbl.Visible = true;
        info.Visible = false;
        errLbl.Text = CommonResources.OfferNotFound;
      }
    }

    protected string GetActionText()
    {
      Selling offer = SellingFacade.GetOfferById(SellingId.Value);

      if (offer != null)
      {
        if (Request.IsAuthenticated)
        {
          if (offer.SellerId == Credentials.UserId)
          {
            switch (offer.TransactionPhase)
            {
              case TransactionPhase.Start:
                return buyers.Visible ? CommonResources.SellingViewer_StartBuyersActionSeller :
                                        String.Format(CommonResources.SellingViewer_StartActionSeller, String.Format(@"/Buying?s=true&g={0}&gs={1}", Dictionaries.Instance.GetGameIdByGameServerId(offer.GameServerId), offer.GameServerId));
              case TransactionPhase.Accept:
                return CommonResources.SellingViewer_AcceptActionSeller;

              case TransactionPhase.Submit:
                return String.Format(CommonResources.SellingViewer_SubmitActionSeller, String.Format("<a href=\"~/Help/General\" target=\"_blank\">{0}</a>", CommonResources.FAQ));

              case TransactionPhase.Conflict:
                return CommonResources.SellingViewer_ConflictAction;

              case TransactionPhase.Finish:
                if (btnOne.Visible)
                {
                  return CommonResources.SellingViewer_FinishActionWithFeedbackSeller;
                }
                else
                {
                  return CommonResources.SellingViewer_FinishAction;
                }
            }
          }

          if (offer.BuyerId == Credentials.UserId)
          {
            switch (offer.TransactionPhase)
            {
              case TransactionPhase.Accept:
                decimal needMoney = UsersFacade.GetDynamicsForUser(Credentials.UserId).MoneyAvailable - offer.Price;
                return String.Format(CommonResources.SellingViewer_AcceptActionBuyer,
                                                       needMoney < 0 ?
                                                       String.Format(CommonResources.SellingViewer_AcceptNeedMoneyActionBuyer,
                                                                     "<a href=\"/Office/TopUp\">пополнив</a>",
                                                                     Math.Abs(needMoney).ToString("0.##"))
                                                       : null);
              case TransactionPhase.Submit:
                return CommonResources.SellingViewer_SubmitActionBuyer;

              case TransactionPhase.Conflict:
                return CommonResources.SellingViewer_ConflictAction;

              case TransactionPhase.Finish:
                if (btnOne.Visible)
                {
                  return CommonResources.SellingViewer_FinishActionWithFeedbackBuyer;
                }
                else
                {
                  return CommonResources.SellingViewer_FinishAction;
                }
            }
          }

          if (m_TempTable != null)
          {
            DataRow[] rows = m_TempTable.Select(String.Format("{0} = '{1}'", SellingOfferFields.BuyerId, Credentials.UserId));
            if (rows != null && rows.Length == 1)
            {
              int state = TypeConverter.ToInt32(rows[0][BuyerStatusFields.BuyerStatusId]);
              if (state == 1 || state == 4)
              {
                return CommonResources.SellingViewer_CancelActionBuyer;
              }
              else if (state == 3)
              {
                return CommonResources.SellingViewer_StartActionBuyer;
              }
            }
            else if (rows != null && rows.Length == 0 && offer.TransactionPhase == TransactionPhase.Start)
            {
              return CommonResources.SellingViewer_StartActionBuyer;
            }
          }
          else if (offer.TransactionPhase == TransactionPhase.Start)
          {
            return CommonResources.SellingViewer_StartActionBuyer;
          }
        }
        else if (offer.BuyerId == Guid.Empty)
        {
          return CommonResources.SellingViewer_StartActionBuyer;
        }
      }

      return null;
    }

    protected void btnOne_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Selling preOffer = (Selling)ViewState[VIEW_STATE_OFFER];

        int res = 0;
        if (preOffer.SellerId != Credentials.UserId)
        {
          switch (preOffer.TransactionPhase)
          {
            case TransactionPhase.Accept:
              if (preOffer.BuyerId == Credentials.UserId)
              {
                res = SellingFacade.ConfirmOffer(preOffer);
                if (res == -2)
                {
                  errLbl.Visible = true; errLbl.Text = CommonResources.NotEnougtMoney;
                }
              } break;
            case TransactionPhase.Submit:
              if (preOffer.BuyerId == Credentials.UserId) { res = SellingFacade.FinishOffer(preOffer); } break;
            case TransactionPhase.Start:
              if (ViewState[VIEW_STATE_SELECT] != null && (bool)ViewState[VIEW_STATE_SELECT])
              {
                res = SellingFacade.AbandonOffer(preOffer, Credentials.UserId);
              }
              else
              {
                res = SellingFacade.SelectOffer(preOffer, Credentials.UserId); if (res == -2) { errLbl.Visible = true; errLbl.Text = CommonResources.NotEnougtMoney; }
              } break;

            case TransactionPhase.Finish:
              Response.Redirect(String.Format("../UserRating/LeaveFeedback.aspx?{0}={1}&{2}={3}", LeaveFeedbackParams.SellingId, preOffer.Id, LeaveFeedbackParams.ReturnUrl, Request.Url.ToString()));
              return;
          }
        }
        else if (preOffer.SellerId == Credentials.UserId)
        {
          switch (preOffer.TransactionPhase)
          {
            case TransactionPhase.Accept: res = SellingFacade.CancelOfferAccept(preOffer, Credentials.UserId); break;
            case TransactionPhase.Submit: res = SellingFacade.CancelConfirmedOffer(preOffer); break;
            case TransactionPhase.Finish:
              Response.Redirect(String.Format("../UserRating/LeaveFeedback.aspx?{0}={1}&{2}={3}", LeaveFeedbackParams.SellingId, preOffer.Id, LeaveFeedbackParams.ReturnUrl, Request.Url.ToString()));
              return;
          }
        }
        if (res == -1) { errLbl.Visible = true; errLbl.Text = CommonResources.OldDataError; }
        else if (res == 1)
        {
          //switch (preOffer.TransactionPhase)
          //{
          //  case TransactionPhase.Accept:
          //    if (preOffer.SellerId != Credentials.UserId)
          //    {
          //      ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostPay), true);
          //    }
          //    else { ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostCancel), true); }
          //    break;
          //  case TransactionPhase.Submit:
          //    if (preOffer.SellerId != Credentials.UserId)
          //    {
          //      ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostSubmit), true);
          //    }
          //    else { ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostCancel), true); }
          //    break;
          //  case TransactionPhase.Start:
          //    if (ViewState[VIEW_STATE_SELECT] != null && (bool)ViewState[VIEW_STATE_SELECT])
          //    { ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostRefuse), true); }
          //    else
          //    {
          //      ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostAccept), true);
          //    } break;
          //}

          LoadData();
          DataBind();
        }
      }
    }

    protected void btnTwo_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Selling preOffer = (Selling)ViewState[VIEW_STATE_OFFER];

        int res = 0;
        if (preOffer.BuyerId == Credentials.UserId)
        {
          switch (preOffer.TransactionPhase)
          {
            case TransactionPhase.Accept: res = SellingFacade.CancelOfferAccept(preOffer, Credentials.UserId); break;
            case TransactionPhase.Submit: res = SellingFacade.ConflictOffer(preOffer, Credentials.UserId); break;
          }
        }
        else if (preOffer.SellerId == Credentials.UserId)
        {
          switch (preOffer.TransactionPhase)
          {
            case TransactionPhase.Submit:
              res = SellingFacade.ConflictOffer(preOffer, Credentials.UserId); break;
          }
        }
        if (res == 1)
        {
          if (preOffer.TransactionPhase == TransactionPhase.Start)
          {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "redirectScript", String.Format("alert('{0}');location.href='/Office/Selling'", CommonResources.OfferPostBuyerCancel), true);
          }

          //switch (preOffer.TransactionPhase)
          //{
          //  case TransactionPhase.Accept:
          //    ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostRefuse), true); break;
          //  case TransactionPhase.Submit:
          //    ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostConflict), true); break;
          //}

          LoadData();
          DataBind();
        }
        else if (res == -1) { errLbl.Visible = true; errLbl.Text = CommonResources.OldDataError; }
      }
    }

    //protected void btnThree_Click(object sender, EventArgs e)
    //{
    //  if (ViewState[VIEW_STATE_OFFER] != null)
    //  {
    //    Selling preOffer = (Selling)ViewState[VIEW_STATE_OFFER];
    //    if (preOffer.SellerId == Credentials.UserId)
    //    {
    //      int res = 0; switch (preOffer.TransactionPhase)
    //      {
    //        case TransactionPhase.Finish: res = SellingFacade.DelFinishOffer(preOffer); break;
    //        case TransactionPhase.Start: res = SellingFacade.DelStartOffer(preOffer); break;
    //      }
    //      if (res == 1)
    //      {
    //        ClientScript.RegisterStartupScript(this.GetType(), "closing", "window.close();", true);
    //      }
    //      else if (res == -1)
    //      {
    //        errLbl.Visible = true; errLbl.Text = CommonResources.OldDataError;
    //      }
    //    }
    //  }
    //}

    protected void btn1_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Selling offer = (Selling)ViewState[VIEW_STATE_OFFER];
        ImageButton btn = (ImageButton)sender;
        Label lbl = btn.NamingContainer.FindControl("buyerIdLbl") as Label;
        if (lbl != null)
        {
          Guid bId = new Guid(lbl.Text); if (Credentials.UserId == offer.SellerId && bId != Guid.Empty)
          {
            int res = SellingFacade.AcceptOffer(offer, bId);
            if (res == 1)
            {
              //ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostSelect), true);
              LoadData();
              DataBind();
            }
            else if (res == -1)
            {
              errLbl.Visible = true; errLbl.Text = CommonResources.OldDataError;
            }
            else if (res == -2)
            {
              errLbl.Visible = true; errLbl.Text = CommonResources.OldDataError;
            }
          }
        }
      }
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Selling offer = (Selling)ViewState[VIEW_STATE_OFFER];
        ImageButton btn = (ImageButton)sender;
        Label lbl = btn.NamingContainer.FindControl("buyerIdLbl") as Label;
        if (lbl != null)
        {
          Guid bId = new Guid(lbl.Text); if (Credentials.UserId == offer.SellerId && bId != Guid.Empty)
          {
            int res = SellingFacade.RejectOffer(offer, bId);
            if (res == 1)
            {
              //ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostDecline), true);
              BuyersDataBind();
            }
            else if (res == -1)
            {
              errLbl.Visible = true; errLbl.Text = CommonResources.OldDataError;
            }
          }
        }
      }
    }

    //protected void buyers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //  buyers.PageIndex = e.NewPageIndex;
    //  BuyersDataBind();
    //}

    void BuyersDataBind()
    {
      int offerId = TypeConverter.ToInt32(Request.QueryString["id"]);
      if (offerId > 0)
      {
        DataSet ds = SellingDataAdapter.GetOfferBuyers(offerId);
        if (ds != null && ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
        {
          buyers.DataSource = ds.Tables[0].Select(String.Format("{0} = 1", BuyerStatusFields.BuyerStatusId));
          buyers.DataBind();
        }
      }
    }

    protected void buyers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      if (e.Row.RowType == DataControlRowType.DataRow)
      {
        ImageButton btn1 = e.Row.FindControl("btn1") as ImageButton;
        ImageButton btn2 = e.Row.FindControl("btn2") as ImageButton;
        if (btn1 != null && btn2 != null)
        {
          btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferSelectConfirmation));
          btn2.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferDeclineConfirmation));
        }
      }
    }
  }
}
