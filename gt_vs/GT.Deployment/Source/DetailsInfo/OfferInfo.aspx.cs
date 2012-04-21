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
using Resources;
using GT.Web.Site.MasterPages;
using GT.Global.DetailsInfo;

namespace GT.Web.Site.DetailsInfo
{
  public partial class OfferInfo : GT.Web.UI.Pages.BasePage
  {
    const string VIEW_STATE_OFFER = "offer_";
    const string VIEW_STATE_SELECT = "select_";

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
        errLbl.Visible = true;
        info.Visible = false;
        errLbl.Text = CommonResources.OfferNotFound;
      }
    }

    void LoadData()
    {
      buyersTitle.Visible = false;
      Selling offer = SellingFacade.GetOfferById(SellingId.Value);

      if (offer != null)
      {
        this.name.Text = offer.Title;
        this.description.Text = offer.Description;
        this.dateCreation.Text = offer.CreateDate.ToLongDateString();
        this.price.Text = offer.Price.ToString();

        User user = UsersFacade.GetUser(offer.SellerId);
        if (user != null)
        {
          seller.Text = user.UserName;
          seller.NavigateUrl = String.Format(@"UserInfo.aspx?{0}={1}", UserInfoParams.USERID, offer.SellerId);
          seller.Attributes.Add("onclick", string.Concat("if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"", TypeConverter.ToString(offer.SellerId), "\"}); return false;} return true"));
        }

        game.Text = Dictionaries.Instance.GetGameNameByGameServerId(offer.GameServerId);
        game.NavigateUrl = String.Format(@"GameInfo.aspx?{0}={1}", GameInfoParams.GAMEID,
                                              Dictionaries.Instance.GetGameIdByGameServerId(offer.GameServerId));

        game.Attributes.Add("onclick", string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameInfo, {GameID : ", TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(offer.GameServerId)), "}); return false;} return true;"));

        server.Text = Dictionaries.Instance.GetGameServerNameById(offer.GameServerId);
        server.NavigateUrl = String.Format(@"GameServerInfo.aspx?{0}={1}", GameServerInfoParams.GAMESERVERID, offer.GameServerId);
        server.Attributes.Add("onclick", string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameServerInfo, {GameServerID : ", TypeConverter.ToString(offer.GameServerId), "}); return false;} return true;"));

        deliveryVal.Text = String.Format(CommonResources.DeliveryTemplate, offer.DeliveryTime);

        if (Request.IsAuthenticated)
        {
          ViewState[VIEW_STATE_OFFER] = offer;
          DataTable table = null;

          if (offer.TransactionPhase != TransactionPhase.Start)
          {
            trUpdate.Style.Add(HtmlTextWriterStyle.Display, "");
            dateUpdateVal.Text = offer.UpdateDate.ToLocalTime().ToLongDateString();
          }
          else
          {
            DataSet ds = SellingDataAdapter.GetOfferBuyers(SellingId.Value);
            if (ds != null && ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
            {
              table = ds.Tables[0];
            }
          }

          if (offer.SellerId == Credentials.UserId)
          {
            trStatus.Style.Add(HtmlTextWriterStyle.Display, "");
            this.statusVal.Text = Dictionaries.Instance.GetTransactionPhaseNameById((int)offer.TransactionPhase);
            this.statusVal.Style.Add(HtmlTextWriterStyle.Color, SellingFacade.GetStatusColor(offer.TransactionPhase));

            if (offer.BuyerId != Guid.Empty)
            {
              trBuyer.Style.Add(HtmlTextWriterStyle.Display, "");
              User u = UsersFacade.GetUser(offer.BuyerId);
              buyerVal.NavigateUrl = String.Format(@"UserInfo.aspx?{0}={1}", UserInfoParams.USERID, offer.BuyerId);
              buyerVal.Attributes.Add("onclick", string.Concat("if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"", TypeConverter.ToString(u.UserId), "\"}); return false;} return true"));
              buyerVal.Text = TypeConverter.ToString(u.UserName);
            }

            switch (offer.TransactionPhase)
            {
              case TransactionPhase.Start:

                if (table != null)
                {
                  DataRow[] rows = table.Select(String.Format("{0} = 1", BuyerStatusFields.BuyerStatusId));
                  if (rows.Length > 0)
                  {
                    this.buyersTitle.Visible = true;
                    this.buyers.Visible = true;
                    this.buyers.DataSource = rows;
                    //this.buyers.DataBind();
                  }
                }
                btnOne.Visible = false;
                btnTwo.Visible = false;
                //btnThree.Visible = true;
                //btnThree.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferDeleteConfirmation));
                break;

              case TransactionPhase.Accept:
                btnOne.Text = CommonResources.Cancel;
                btnOne.ToolTip = CommonResources.Cancel;
                //btnOne.ImageUrl = "../App_Themes/Tutynin/Images/actions/cancel.png";
                btnOne.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferCancelConfirmation));
                btnOne.Visible = true;
                btnTwo.Visible = false;
                //btnThree.Visible = false;
                break;

              case TransactionPhase.Submit:
                btnOne.Text = CommonResources.Decline;
                btnOne.ToolTip = CommonResources.Decline;
                //btnOne.ImageUrl = "../App_Themes/Tutynin/Images/actions/cancel.png";
                btnOne.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferCancelConfirmation));
                btnTwo.Text = CommonResources.Complain;
                // btnTwo.ImageUrl = "../App_Themes/Tutynin/Images/actions/complain.png";
                btnTwo.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferConflictConfirmation));
                btnOne.Visible = true;
                btnTwo.Visible = true;
                //btnThree.Visible = false;

                TimeSpan diff = DateTime.Now.Subtract(offer.UpdateDate);
                btnTwo.Enabled = diff.Days > offer.DeliveryTime;
                deliveryVal.Text = btnTwo.Enabled ? CommonResources.Expired : String.Format(CommonResources.DeliveryTemplate2, offer.DeliveryTime - diff.Days);
                btnTwo.ToolTip = btnTwo.Enabled ? CommonResources.Complain : deliveryVal.Text;

                trKey.Style.Add(HtmlTextWriterStyle.Display, "");
                keyTxt.Text = CommonResources.Validate;
                keyBox.Visible = true;
                keyBtn.Visible = true;

                break;

              case TransactionPhase.Conflict:
                btnOne.Visible = false;
                btnTwo.Visible = false;
                //btnThree.Visible = false;
                deliveryVal.Text = CommonResources.Expired;
                break;

              case TransactionPhase.Finish:
                btnOne.Visible = false;
                btnTwo.Visible = false;
                //btnThree.Visible = true;
                //btnThree.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferDeleteConfirmation));
                deliveryVal.Text = CommonResources.Complete;
                break;
            }
          }
          else
          {
            btnOne.Visible = false;
            btnTwo.Visible = false;
            //btnThree.Visible = false;
            ViewState[VIEW_STATE_SELECT] = false;

            if (offer.BuyerId == Credentials.UserId)
            {
              trStatus.Style.Add(HtmlTextWriterStyle.Display, "");
              this.statusVal.Visible = true;
              this.statusVal.Text = offer.TransactionPhase.ToString();
              this.statusVal.Style.Add(HtmlTextWriterStyle.Color, SellingFacade.GetStatusColor(offer.TransactionPhase));

              if (!String.IsNullOrEmpty(offer.ValidKey))
              {
                this.keyTxt.Visible = true;
                this.keyVal.Visible = true;
                this.keyVal.Text = offer.ValidKey;
              }

              trBuyer.Style.Add(HtmlTextWriterStyle.Display, "");
              buyerVal.Visible = true;
              buyerVal.NavigateUrl = String.Format(@"UserInfo.aspx?{0}={1}", UserInfoParams.USERID, offer.BuyerId);
              User u = UsersFacade.GetUser(offer.BuyerId);
              buyerVal.Attributes.Add("onclick", string.Concat("if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"", TypeConverter.ToString(u.UserId), "\"}); return false;} return true"));
              this.buyerVal.Text = u.UserName;

              switch (offer.TransactionPhase)
              {
                case TransactionPhase.Accept:
                  btnOne.Text = CommonResources.Pay;
                  btnOne.ToolTip = CommonResources.Pay;
                  //btnOne.ImageUrl = "../App_Themes/Tutynin/Images/actions/pay.png";
                  btnOne.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferPayConfirmation));
                  btnTwo.Text = CommonResources.Cancel;
                  btnTwo.ToolTip = CommonResources.Cancel;
                  //btnTwo.ImageUrl = "../App_Themes/Tutynin/Images/actions/cancel.png";
                  btnTwo.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferCancelConfirmation));
                  btnOne.Visible = true;
                  btnTwo.Visible = true;
                  break;

                case TransactionPhase.Submit:
                  btnOne.Text = CommonResources.GoodsGot;
                  btnOne.ToolTip = CommonResources.GoodsGot;
                  //btnOne.ImageUrl = "../App_Themes/Tutynin/Images/actions/finish.png";
                  btnOne.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferSubmitConfirmation));
                  btnTwo.Text = CommonResources.Complain;
                  //btnTwo.ImageUrl = "../App_Themes/Tutynin/Images/actions/complain.png";
                  btnTwo.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferConflictConfirmation));
                  btnOne.Visible = true;
                  btnTwo.Visible = true;

                  TimeSpan diff = DateTime.Now.Subtract(offer.UpdateDate);
                  btnTwo.Enabled = diff.Days > offer.DeliveryTime;

                  deliveryVal.Text = btnTwo.Enabled ? CommonResources.Expired : String.Format(CommonResources.DeliveryTemplate2, offer.DeliveryTime - diff.Days);
                  btnTwo.ToolTip = btnTwo.Enabled ? CommonResources.Complain : deliveryVal.Text;
                  break;
              }
            }
            else if (table != null)
            {
              DataRow[] rows = table.Select(String.Format("{0} = '{1}'", SellingOfferFields.BuyerId, Credentials.UserId));
              if (rows != null && rows.Length == 1)
              {
                int state = TypeConverter.ToInt32(rows[0][BuyerStatusFields.BuyerStatusId]);
                if (state == 1 || state == 4)
                {
                  btnOne.Text = CommonResources.Abandon;
                  btnOne.ToolTip = CommonResources.Abandon;
                  //btnOne.ImageUrl = "../App_Themes/Tutynin/Images/actions/reject.png";
                  btnOne.Visible = true;
                  btnOne.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferRefuseConfirmation)); btnTwo.Visible = false;
                  ViewState[VIEW_STATE_SELECT] = true;
                }
                else if (state == 3)
                {
                  btnOne.Text = CommonResources.Accept;
                  btnOne.ToolTip = CommonResources.Accept;
                  //btnOne.ImageUrl = "../App_Themes/Tutynin/Images/actions/accept.png";
                  btnOne.Visible = true;
                  btnOne.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferAcceptConfirmation)); btnTwo.Visible = false;
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
                //btnOne.ImageUrl = "../App_Themes/Tutynin/Images/actions/accept.png";
                btnOne.ToolTip = CommonResources.Accept;
                btnOne.Visible = true;
                btnOne.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferAcceptConfirmation)); btnTwo.Visible = false;
              }
            }
            else if (offer.TransactionPhase == TransactionPhase.Start)
            {
              btnOne.Text = CommonResources.Accept;
              //btnOne.ImageUrl = "../App_Themes/Tutynin/Images/actions/accept.png";
              btnOne.ToolTip = CommonResources.Accept;
              btnOne.Attributes.Add("onclick", String.Format("return confirm('{0}');", CommonResources.OfferAcceptConfirmation)); btnOne.Visible = true;
              btnTwo.Visible = false;
            }
          }
        }
      }
      else
      {
        errLbl.Visible = true;
        info.Visible = false;
        errLbl.Text = CommonResources.OfferNotFound;
      }
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
          }
        }
        else if (preOffer.SellerId == Credentials.UserId)
        {
          switch (preOffer.TransactionPhase)
          {
            case TransactionPhase.Accept: res = SellingFacade.CancelOfferAccept(preOffer, Credentials.UserId); break;
            case TransactionPhase.Submit: res = SellingFacade.CancelConfirmedOffer(preOffer); break;
          }
        }
        if (res == -1) { errLbl.Visible = true; errLbl.Text = CommonResources.OldDataError; }
        else if (res == 1)
        {
          switch (preOffer.TransactionPhase)
          {
            case TransactionPhase.Accept:
              if (preOffer.SellerId != Credentials.UserId)
              {
                ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostPay), true);
              }
              else { ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostCancel), true); }
              break;
            case TransactionPhase.Submit:
              if (preOffer.SellerId != Credentials.UserId)
              {
                ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostSubmit), true);
              }
              else { ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostCancel), true); }
              break;
            case TransactionPhase.Start:
              if (ViewState[VIEW_STATE_SELECT] != null && (bool)ViewState[VIEW_STATE_SELECT])
              { ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostRefuse), true); }
              else
              {
                ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostAccept), true);
              } break;
          }

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
          switch (preOffer.TransactionPhase)
          {
            case TransactionPhase.Accept:
              ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostRefuse), true); break;
            case TransactionPhase.Submit:
              ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostConflict), true); break;
          }

          LoadData();
          DataBind();
        }
        else if (res == -1) { errLbl.Visible = true; errLbl.Text = CommonResources.OldDataError; }
      }
    }

    protected void btnThree_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Selling preOffer = (Selling)ViewState[VIEW_STATE_OFFER];
        if (preOffer.SellerId == Credentials.UserId)
        {
          int res = 0; switch (preOffer.TransactionPhase)
          {
            case TransactionPhase.Finish: res = SellingFacade.DelFinishOffer(preOffer); break;
            case TransactionPhase.Start: res = SellingFacade.DelStartOffer(preOffer); break;
          }
          if (res == 1)
          {
            ClientScript.RegisterStartupScript(this.GetType(), "closing", "window.close();", true);
          }
          else if (res == -1)
          {
            errLbl.Visible = true; errLbl.Text = CommonResources.OldDataError;
          }
        }
      }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Selling offer = (Selling)ViewState[VIEW_STATE_OFFER];
        GT.Web.Site.Controls.Button btn = (GT.Web.Site.Controls.Button)sender;
        Label lbl = btn.NamingContainer.FindControl("buyerIdLbl") as Label;
        if (lbl != null)
        {
          Guid bId = new Guid(lbl.Text); if (Credentials.UserId == offer.SellerId && bId != Guid.Empty)
          {
            int res = SellingFacade.AcceptOffer(offer, bId);
            if (res == 1)
            {
              ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostSelect), true);
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
        GT.Web.Site.Controls.Button btn = (GT.Web.Site.Controls.Button)sender;
        Label lbl = btn.NamingContainer.FindControl("buyerIdLbl") as Label;
        if (lbl != null)
        {
          Guid bId = new Guid(lbl.Text); if (Credentials.UserId == offer.SellerId && bId != Guid.Empty)
          {
            int res = SellingFacade.RejectOffer(offer, bId);
            if (res == 1)
            {
              ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.OfferPostDecline), true);
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

    protected void buyers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      buyers.PageIndex = e.NewPageIndex;
      BuyersDataBind();
    }

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

    protected void keyBtn_Click(object sender, EventArgs e)
    {
      if (ViewState[VIEW_STATE_OFFER] != null)
      {
        Selling preOffer = (Selling)ViewState[VIEW_STATE_OFFER];

        if (preOffer.SellerId == Credentials.UserId)
        {
          int res = SellingFacade.ValidOffer(preOffer, this.keyBox.Text);
          if (res == 1)
          {
            this.keyVal.Visible = true;
            this.keyVal.Text = CommonResources.Correct;
            this.keyVal.Style.Add(HtmlTextWriterStyle.Color, "green");
            this.keyBox.Visible = false;
            this.keyBtn.Visible = false;
          }
          else if (res == -2)
          {
            this.keyVal.Visible = true;
            this.keyVal.Text = CommonResources.Incorrect;
            this.keyVal.Style.Add(HtmlTextWriterStyle.Color, "red");
          }
          else if (res == -1)
          {
            errLbl.Visible = true;
            errLbl.Text = CommonResources.OldDataError;
          }
        }
        else
        {
        }
      }
    }
  }
}
