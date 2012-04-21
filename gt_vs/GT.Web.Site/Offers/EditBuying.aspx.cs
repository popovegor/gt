using System;
using GT.BO.Implementation.Offers;
using GT.Common;
using GT.Common.Exceptions;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Web.UI.Pages;
using Offer = GT.BO.Implementation.Offers.Buying;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Web.Site.MasterPages;
using GT.Web.Site.WebServices.Ajax;

namespace GT.Web.Site.Offers
{
  public partial class EditBuying : OfferEditPage
  {
    private Buying _buying = null;

    protected Buying Offer
    {
      get
      {
        if (null == _buying)
        {
          if (EditPageMode == EditPageAction.Edit)
          {
            _buying = BuyingFacade.GetOfferById(Id);
            if (BuyerId != _buying.BuyerId)
            {
              throw AssistLogger.Log<ExceptionHolder>(new Exception(""));
            }
          }
          else
          {
            _buying = new Buying();
          }
        }
        return _buying;
      }
    }

    protected Guid BuyerId
    {
      get
      {
        return Credentials.UserId;
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    private void PageDataBind()
    {
      DataBind();
      if (null != Offer)
      {
        cddGame.SelectedValue = TypeConverter.ToString(
            Dictionaries.Instance.GetGameIdByGameServerId(Offer.GameServerId));
        cddServer.SelectedValue = TypeConverter.ToString(Offer.GameServerId);
        txtTitle.Text = Offer.Title;
        txtDescription.Text = Offer.Description;
        txtPrice.Text = Offer.Price.ToString("#.##");
        category.ProductCategoryId = Offer.ProductCategoryId;
        category.ProductCategoryMisc = Offer.ProductCategoryMisc;
      }

    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
      Page.Validate();
      if (Page.IsValid)
      {
        try
        {

          Credentials.Profile.EmailMessageNotification = chkEmailNotification.Checked;
          Credentials.Profile.Save();
          
          Offer.BuyerId = Credentials.UserId;
          Offer.GameServerId = TypeConverter.ToInt32(ddlServer.SelectedValue, -1);
          Offer.Title = txtTitle.Text;
          Offer.Description = txtDescription.Text;


          decimal price = decimal.Zero;
          if (decimal.TryParse(txtPrice.Text, out price))
          {
            Offer.Price = price;
          }

          //set product type
          Offer.ProductCategoryId = category.ProductCategoryId;
          Offer.ProductCategoryMisc = category.ProductCategoryMisc;

          var res = new BuyingService().Upsert(Offer);
          Response.Redirect("~/Office/Buying", true);
        }
        catch (Exception ex)
        {
          AssistLogger.Log<ExceptionHolder>(ex);
          lblError.Text = CommonResources.FailedAction;
        }
      }
    }



    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      PageDataBind();
    }
  }
}
