using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.Users;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.DA.Offers;
using GT.Web.UI.Pages;
using Resources;
using GT.Web.Site.Offers;
using GT.Web.Site.MasterPages;
using GT.Global.Offers;
using GT.Global.DetailsInfo;

namespace GT.Web.Site.DetailsInfo
{
  public partial class BuyingOfferInfo : GT.Web.UI.Pages.BasePage
  {
    const string VIEW_STATE_OFFER = "offer_";

    protected void Page_Load(object sender, EventArgs e)
    {
      if (Request.QueryString[BuyingOfferInfoPrams.ID] != null)
      {
        int id = TypeConverter.ToInt32(Request.QueryString[BuyingOfferInfoPrams.ID]);
        if (id != 0)
        {
          if (!Page.IsPostBack)
          {
            LoadData(id);
          }
        }
      }
    }

    void LoadData(int id)
    {
      Buying offer = BuyingFacade.GetOfferById(id);
      forSuggesting.Items.Clear();

      if (offer != null)
      {
        this.name.Text = offer.Title;
        this.description.Text = offer.Description;
        this.dateCreation.Text = offer.CreateDate.ToLongDateString();
        this.price.Text = offer.Price.ToString();

        User user = UsersFacade.GetUser(offer.BuyerId);
        if (user != null)
        {
          buyer.Text = user.UserName;
          buyer.NavigateUrl = String.Format(@"UserInfo.aspx?{0}={1}", UserInfoParams.USERID, offer.BuyerId);
          buyer.Attributes.Add("onclick", string.Concat("if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"", TypeConverter.ToString(offer.BuyerId), "\"}); return false;} return true"));
        }

        this.game.Text = Dictionaries.Instance.GetGameNameByGameServerId(offer.GameServerId);
        this.game.NavigateUrl = String.Format(@"GameInfo.aspx?{0}={1}",
                                              GameInfoParams.GAMEID,
                                              Dictionaries.Instance.GetGameIdByGameServerId(offer.GameServerId));

        game.Attributes.Add("onclick", string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameInfo, {GameID : ", TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(offer.GameServerId)), "}); return false;} return true;"));

        this.server.Text = Dictionaries.Instance.GetGameServerNameById(offer.GameServerId);
        this.server.NavigateUrl = String.Format(@"GameServerInfo.aspx?{0}={1}", GameServerInfoParams.GAMESERVERID, offer.GameServerId);
        server.Attributes.Add("onclick", string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameServerInfo, {GameServerID : ", TypeConverter.ToString(offer.GameServerId), "}); return false;} return true;"));

        if (Request.IsAuthenticated)
        {
          ViewState[VIEW_STATE_OFFER] = offer;

          DataRow[] offers = BuyingDataAdapter.GetSuggestedSellingOffers(offer.BuyingOfferId);

          if (offer.BuyerId == Credentials.UserId)
          {
            //btnOne.Text = CommonResources.Delete;
            //btnOne.Visible = true;
            //btnOne.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.DemandDeleteConfirmation));

            if (offers != null && offers.Length > 0)
            {
              sellersTitle.Style.Add(HtmlTextWriterStyle.Display, "");
              sellers.Style.Add(HtmlTextWriterStyle.Display, "");
              sellers.DataSource = offers;
              DataBind();
            }
          }
          else
          {
            btnTwo.Visible = true;
            btnTwo.Text = CommonResources.CreateForDemand;

            trAction.Style.Add(HtmlTextWriterStyle.Display, "");
            actionLbl.Text = CommonResources.SuitableOffersMsg;

            Selling[] os = BuyingFacade.GetOffersForSuggesting(offer.BuyingOfferId, Credentials.UserId);
            if (os != null && os.Length > 0)
            {
              btnOne.Visible = true;
              btnOne.Text = CommonResources.ToOffer;
              forSuggesting.Visible = true;
              forSuggesting.Items.Add(new ListItem(string.Empty, Int32.MinValue.ToString()));

              actionLbl.Text = CommonResources.ChooseExisngMsg;

              foreach (Selling o in os)
              {
                forSuggesting.Items.Add(new ListItem(o.Title, o.SellingId.ToString()));
              }
            }
            else
            {
              btnOne.Visible = false;
              forSuggesting.Visible = false;
            }
          }
        }
      }
      else
      {
        errLbl.Visible = true;
        info.Visible = false;
        errLbl.Text = CommonResources.BuyingOfferNotFound;
      }
    }

    protected void suggested_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ImageButton btn1 = e.Row.FindControl("btn1") as ImageButton;
            ImageButton btn2 = e.Row.FindControl("btn2") as ImageButton;
            if (btn1 != null && btn2 != null)
            {
                btn1.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.DemandAcceptConfirmation));
                btn2.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.DemandDeclineConfirmation));
            }
        }
    }

    protected void btnOne_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Buying preOffer = (Buying)ViewState[VIEW_STATE_OFFER];
        if (preOffer.BuyerId == Credentials.UserId)
        {
          int temp;
          BuyingFacade.DeleteOffer(Credentials.UserId, preOffer.BuyingOfferId, out temp);
          ClientScript.RegisterStartupScript(this.GetType(), "closeWindow", "window.close();", true);
        }
        else
        {
          int res = BuyingFacade.AddSuggested(preOffer.BuyingOfferId, TypeConverter.ToInt32(forSuggesting.SelectedValue));
          if (res == 1)
          {
            ClientScript.RegisterStartupScript(this.GetType(), "addSuggested", String.Format("alert('{0}');", CommonResources.RespondDemandMsg), true);
            LoadData(preOffer.BuyingOfferId);
          }
          else
          {
            errLbl.Visible = true;
            errLbl.Text = CommonResources.OldDataError;
          }
        }
      }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Buying offer = (Buying)ViewState[VIEW_STATE_OFFER];
        ImageButton btn = (ImageButton)sender;
        Label lbl = btn.NamingContainer.FindControl("suggestedIdLbl") as Label;
        if (lbl != null)
        {
          int suggested;
          if (Credentials.UserId == offer.BuyerId && int.TryParse(lbl.Text, out suggested))
          {
            int res = BuyingFacade.AcceptSuggested(offer.BuyingOfferId, suggested);

            if (res == 1)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.DemandPostAccept), true);
                LoadData(offer.BuyingOfferId);
            }
            else if (res == -1)
            {
              errLbl.Visible = true;
              errLbl.Text = CommonResources.OldDataError;
            }
            else if (res == -2)
            {
              errLbl.Visible = true;
              errLbl.Text = CommonResources.NotEnougtMoney;
            }
          }
        }
      }
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Buying offer = (Buying)ViewState[VIEW_STATE_OFFER];
        ImageButton btn = (ImageButton)sender;
        Label lbl = btn.NamingContainer.FindControl("suggestedIdLbl") as Label;
        if (lbl != null)
        {
          int suggested;
          if (Credentials.UserId == offer.BuyerId && int.TryParse(lbl.Text, out suggested))
          {
            int res = BuyingFacade.CancelSuggested(offer.BuyingOfferId, suggested);

            if (res == 1)
            {
                LoadData(offer.BuyingOfferId);
            }
            else if (res == -1)
            {
              errLbl.Visible = true;
              errLbl.Text = CommonResources.OldDataError;
            }
          }
        }
      }
    }

    protected void sellers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Buying preOffer = (Buying)ViewState[VIEW_STATE_OFFER];
        Selling[] offers = BuyingFacade.GetSuggestedSellingOffers(preOffer.BuyingOfferId);
        sellers.PageIndex = e.NewPageIndex;
        sellers.DataSource = offers;
        sellers.DataBind();
      }
    }

    protected void btnTwo_Click(object sender, EventArgs e)
    {
      Response.Redirect(String.Format("../Offers/EditSelling.aspx?{0}=0&{1}={2}", EditSellingParams.ID, EditSellingParams.Buing, Request.QueryString[BuyingOfferInfoPrams.ID]));
    }
  }
}
