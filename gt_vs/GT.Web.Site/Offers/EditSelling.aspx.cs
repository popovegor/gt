using System;
using System.Web.UI;
using GT.Ajax.Controls.Configuration;
using GT.BO.Implementation.Offers;
using GT.Common;
using GT.Common.Exceptions;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Global.Offers;
using GT.Web.Site.WebServices.Ajax;
using GT.Web.UI.Pages;
using CommonResources = GT.Localization.Resources.CommonResources;

namespace GT.Web.Site.Offers
{
  public partial class EditSelling : OfferEditPage
  {
    private GT.BO.Implementation.Offers.Selling _selling = null;

    protected GT.BO.Implementation.Offers.Selling Offer
    {
      get
      {
        if (_selling == null)
        {
          if (EditPageMode == EditPageAction.Edit)
          {
            _selling = SellingFacade.GetOfferById(Id);
            if (SellerId != _selling.SellerId)
            {
              throw AssistLogger.Log<ExceptionHolder>(new Exception(""));
            }
          }
          else
          {
            _selling = new GT.BO.Implementation.Offers.Selling();
          }
        }
        return _selling;
      }
    }

    protected Guid SellerId
    {
      get
      {
        return Credentials.UserId;
      }
    }

    public int BuyingId
    {
      get
      {
        return TypeConverter.ToInt32(Request.QueryString[EditSellingParams.Buying], -1);
      }
    }

    protected string[] AllowedImageExtensions
    {
      get
      {
        return AjaxControlConfigurationSection.Section.AllowedFileExtensions;
      }
    }

    protected string ImageValidationMessage
    {
      get
      {
        return string.Format(CommonResources.Offers_EditSelling_ImageValidationMessage, string.Join(", ", AllowedImageExtensions));
      }
    }

    protected string ImageValidationRegularExpression
    {
      get
      {
        return string.Format("(.+)({0})"
          , string.Join("|", System.Array.ConvertAll(AllowedImageExtensions, ext => string.Format(@"(.{0})", ext))));
      }
    }

    protected void sivImage_SavedImageExists()
    {
      pnlImage.Style.Add(HtmlTextWriterStyle.Display, "");
      ClientScript.RegisterStartupScript(typeof(Page), Guid.NewGuid().ToString(), "var savedImageExists = true", true);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      PageDataBind();
    }

    protected void fuImage_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
    }

    protected void fuImage_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
      try
      {
        if (true == fuImage.HasFile)
        {
          fuImage.SaveAs(Credentials);
        }
      }
      catch (Exception ex)
      {
        AssistLogger.Log<ExceptionHolder>(ex);
        fuImage.FailedValidation = true;
        e.state = AjaxControlToolkit.AsyncFileUploadState.Failed;
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
          Offer.GameServerId = TypeConverter.ToInt32(ddlServer.SelectedValue, -1);
          Offer.Title = txtTitle.Text;
          var price = decimal.Zero;
          if (true == decimal.TryParse(txtPrice.Text, out  price))
          {
            Offer.Price = price;
          }

          Offer.Description = txtDescription.Text;
          int delivery = 0;
          if (int.TryParse(txtDeliveryTime.Text, out delivery) == true)
          {
            Offer.DeliveryTime = delivery;
          }

          if (string.IsNullOrEmpty(fuImage.FileName) == false)
          {
            Offer.Image = new SellingImage();
            Offer.Image.ImageName = fuImage.FileName;
            fuImage.RemoveFileFromSession();
          }

          //set product type
          Offer.ProductCategoryId = category.ProductCategoryId;
          Offer.ProductCategoryMisc = category.ProductCategoryMisc;

          Offer.SellerId = Credentials.UserId;
          var res = new SellingService().Upsert(Offer, BuyingId);
          Response.Redirect("~/Office/Selling", true);
        }
        catch (Exception ex)
        {
          AssistLogger.Log<ExceptionHolder>(ex);
          lblError.Text = CommonResources.FailedAction;
        }
      }
    }

    private void PageDataBind()
    {
      DataBind();
      if (BuyingId > 0)
      {
        GT.BO.Implementation.Offers.Buying bo = BuyingFacade.GetOfferById(BuyingId);
        if (bo != null)
        {
          cddGame.SelectedValue = TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(bo.GameServerId));
          cddServer.SelectedValue = TypeConverter.ToString(bo.GameServerId);
          txtTitle.Text = bo.Title;
          txtDescription.Text = bo.Description;
          txtPrice.Text = bo.Price.ToString("0.##");
          txtDeliveryTime.Text = Offer.DeliveryTime.ToString();
          category.ProductCategoryId = bo.ProductCategoryId;
          category.ProductCategoryMisc = bo.ProductCategoryMisc;
        }
        return;
      }

      if (null != Offer)
      {
        cddGame.SelectedValue = TypeConverter.ToString(
            Dictionaries.Instance.GetGameIdByGameServerId(Offer.GameServerId));
        cddServer.SelectedValue = TypeConverter.ToString(Offer.GameServerId);
        txtTitle.Text = Offer.Title;
        txtDescription.Text = Offer.Description;
        txtPrice.Text = Offer.Price.ToString("0.##");
        txtDeliveryTime.Text = Offer.DeliveryTime.ToString();
        category.ProductCategoryId = Offer.ProductCategoryId;
        category.ProductCategoryMisc = Offer.ProductCategoryMisc;
      }
    }
  }
}
