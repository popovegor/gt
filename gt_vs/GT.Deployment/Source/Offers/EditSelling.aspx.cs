using System;
using GT.BO.Implementation.Offers;
using GT.Common;
using GT.Common.Exceptions;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Web.UI.Pages;
using GT.Global.Offers;
using Resources;
using GT.Web.Site.MasterPages;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using GT.Ajax.Controls.Configuration;
using System.Web.UI;
using GT.Web.Site.Controls;

namespace GT.Web.Site.Offers
{
  public partial class EditSelling : BaseEditPage
  {
    private Selling _selling = new Selling();

    protected Selling Offer
    {
      get
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
          _selling = new Selling();
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
          , string.Join("|", System.Array.ConvertAll(AllowedImageExtensions, ext => string.Format(@"(.{0})", ext) )));
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

    protected void Page_Error(object sender, EventArgs e)
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

    protected void Page_PreRender(object sender, EventArgs e)
    {
    }

    private void PageDataBind()
    {
      DataBind();
      if (Request.QueryString[EditSellingParams.Buing] != null)
      {
        int id = TypeConverter.ToInt32(Request.QueryString[EditSellingParams.Buing]);
        if (id > 0)
        {
          Buying bo = BuyingFacade.GetOfferById(id);
          cddGame.SelectedValue = TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(bo.GameServerId));
          cddServer.SelectedValue = TypeConverter.ToString(bo.GameServerId);
          txtTitle.Text = bo.Title;
          txtDescription.Text = bo.Description;
          txtPrice.Text = bo.Price.ToString("0.##");
          return;
        }
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
      }
    }
  }
}
