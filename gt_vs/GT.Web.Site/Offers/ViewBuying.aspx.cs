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
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Web.Site.Offers;
using GT.Web.Site.MasterPages;
using GT.Global.Offers;
using GT.Global.DetailsInfo;
using GT.BO.Implementation.Helpers;
using GT.Common.Web.WebUtils;
using System.Net;

namespace GT.Web.Site.Offers
{
  public partial class ViewBuying : OfferViewPage
  {
    const string VIEW_STATE_OFFER = "offer_{1C8F8E17-B631-4cc4-995A-725DB37B12DB}";

    Buying m_Buying;
    protected Buying BuyingOffer
    {
      get
      {
        if (m_Buying == null)
        {
          int id = TypeConverter.ToInt32(Request.QueryString[BuyingOfferInfoPrams.ID]);
          if (id != 0)
          {
            m_Buying = BuyingFacade.GetOfferById(id);
          }
        }

        return m_Buying;
      }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
      if (string.IsNullOrEmpty(description.Text) == false)
      {
        description.Text = description.Text.Replace("&#13;&#10;", "<br/>");
      }
      Title = BuyingOffer != null ? BuyingOffer.Title : Title;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      if (BuyingOffer != null)
      {
        if (!Page.IsPostBack)
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
          errLbl.Text = CommonResources.BuyingOfferNotFound;
        }
      }
    }

    void LoadData()
    {
      forSuggesting.Items.Clear();
      errLbl.Text = null;

      if (BuyingOffer != null)
      {
        if (BuyingOffer.ProductCategoryId > 0)
        {
          lblProductCategory.Text = BuyingOffer.ProductCategoryName;
          category.Visible = true;
        }
        name.Text = BuyingOffer.Title;
        description.Text = BuyingOffer.Description;
        dateCreation.Text = BuyingOffer.CreateDate.UtcToLocal().ToLongDateString();
        price.Text = BuyingOffer.Price.ToString("0.##");

        var user = UsersFacade.GetUser(BuyingOffer.BuyerId);
        if (user != null)
        {
          buyer.UserId = BuyingOffer.BuyerId;
          /*if (BuyingOffer.BuyerId != Credentials.UserId)
          {
            writeBuyer.NavigateUrl = String.Format(@"~/Users/User/{0}/Conversation", BuyingOffer.BuyerId);
          }
          else
          {
            writeBuyer.Visible = false;
          }*/
        }

        game.ServerId = BuyingOffer.GameServerId;
        server.ServerId = BuyingOffer.GameServerId;

        if (Request.IsAuthenticated)
        {
          ViewState[VIEW_STATE_OFFER] = BuyingOffer;

          DataRow[] offers = BuyingDataAdapter.GetSuggestedSellingOffers(BuyingOffer.BuyingOfferId);

          if (BuyingOffer.BuyerId == Credentials.UserId)
          {
            btnTwo.Visible = false;

            if (offers != null && offers.Length > 0)
            {
              sellersTitle.Visible = true;
              sellers.Visible = true;
              sellers.DataSource = offers;
            }
            else
            {
              sellersTitle.Visible = false;
              sellers.Visible = false;
            }
          }
          else
          {
            Selling[] os = BuyingFacade.GetOffersForSuggesting(BuyingOffer.BuyingOfferId, Credentials.UserId);
            if (os != null && os.Length > 0)
            {
              btnOne.Visible = true;
              btnOne.Text = CommonResources.ToOffer;
              forSuggesting.Style.Add(HtmlTextWriterStyle.Display, "");
              //forSuggesting.Items.Add(new ListItem(string.Empty, Int32.MinValue.ToString()));
              btnOne.OnClientClick = String.Format("var a = document.getElementById('{0}'); if (a != null && a.value == '0' ) {{ document.getElementById('{1}').innerHTML = '{2}'; return false; }}",
                                                   forSuggesting.ClientID,
                                                   errLbl.ClientID,
                                                   CommonResources.BuyingOfferInfo_OfferNotSelect);

              forSuggesting.Items.Add(new ListItem(CommonResources.BuyingOfferInfo_SelectOffer, "0"));
              foreach (Selling o in os)
              {
                forSuggesting.Items.Add(new ListItem(o.Title, o.SellingId.ToString()));
              }
              errLbl.Visible = true;
            }
            else
            {
              btnOne.Visible = false;
              forSuggesting.Visible = false;
            }
          }
        }
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
            //ClientScript.RegisterStartupScript(this.GetType(), "addSuggested", String.Format("alert('{0}');", CommonResources.RespondDemandMsg), true);
            LoadData();
            DataBind();
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
              int history = 0;
              BuyingFacade.DeleteOffer(offer.BuyerId, offer.BuyingOfferId, out history);
              Response.Redirect(String.Format("/Selling/View/{0}", suggested));
              //ClientScript.RegisterStartupScript(this.GetType(), "alertSetPhase", String.Format("alert('{0}');", CommonResources.DemandPostAccept), true);
              //LoadData();
              //DataBind();
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
              LoadData();
              DataBind();
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

    //protected void sellers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //  if (ViewState[VIEW_STATE_OFFER] != null)
    //  {
    //    Buying preOffer = (Buying)ViewState[VIEW_STATE_OFFER];
    //    Selling[] offers = BuyingFacade.GetSuggestedSellingOffers(preOffer.BuyingOfferId);
    //    sellers.PageIndex = e.NewPageIndex;
    //    sellers.DataSource = offers;
    //    sellers.DataBind();
    //  }
    //}

    protected void btnTwo_Click(object sender, EventArgs e)
    {
      Response.Redirect(String.Format("/Offers/EditSelling.aspx?{0}={1}", EditSellingParams.Buying, Request.QueryString[BuyingOfferInfoPrams.ID]));
    }

    protected string GetActionText()
    {
      if (Request.IsAuthenticated)
      {
        if (BuyingOffer.BuyerId == Credentials.UserId)
        {
          if (sellers.Visible)
          {
            return CommonResources.ViewBuying_ActionWithOffer;
          }
          else
          {
            return string.Format(CommonResources.ViewBuying_ActionWithoutOffer,
                        String.Format(@"/Selling?s=true&g={0}&gs={1}", Dictionaries.Instance.GetGameIdByGameServerId(BuyingOffer.GameServerId), BuyingOffer.GameServerId));
          }
        }
        else
        {
          if (btnOne.Visible)
          {
            return CommonResources.ChooseExisngMsg;
          }
        }
      }

      return CommonResources.SuitableOffersMsg;
    }
  }
}
