using System;
using System.ComponentModel;
using System.Web.Script.Services;
using System.Web.Services;
using GT.BO.Implementation.Offers;
using GT.Common;
using GT.Common.Exceptions;
using GT.Web.Services;
using CommonResources = GT.Localization.Resources.CommonResources;
using System.IO;
using GT.Global.Offers;

namespace GT.Web.Site.WebServices.Ajax
{
  /// <summary>
  /// Summary description for SellingService
  /// </summary>
  [WebService(Namespace = "http://gameismoney.ru/")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [ToolboxItem(false)]
  [ScriptService]
  [GenerateScriptType(typeof(Selling))]
  [GenerateScriptType(typeof(SellingImage))]
  public class SellingService : BaseWebService
  {

    [WebMethod]
    [ScriptMethod]
    public string DeleteSellingImage(int sellingId)
    {
      var result = string.Empty;
      try
      {
        SellingFacade.DeleteSellingImage(Credentials.UserId, sellingId);
        result = CommonResources.WebServices_Ajax_SellingService_DeleteImageSuccess;
      } 
      catch (Exception e)
      {
        AssistLogger.Log<ExceptionHolder>(e);
        result = "";
      }
      return result;
    }

    [WebMethod]
    [ScriptMethod]
    public string Upsert(Selling offer, int buyingId)
    {
      string result = string.Empty;
      if (null != offer)
      {
        offer.SellerId = Credentials.UserId;
        if (offer.SellingId > 0)
        {
          try
          {
            LoadSellingImageData(offer);
            SellingFacade.Update(offer);
            result = CommonResources.UpdateOfferSuccess;
          }
          catch (Exception e)
          {
            result = CommonResources.UpdateOfferFailure;
            throw AssistLogger.Log<ExceptionHolder>(e);
          }
        }
        else
        {
          try
          {
            LoadSellingImageData(offer);
            var o = SellingFacade.AddOffer(offer);
            if(buyingId > 0 && null != o)
            {
              BuyingFacade.AddSuggested(buyingId, o.SellingId);
            }
            result = CommonResources.AddOfferSuccess;
          }
          catch (Exception e)
          {
            result = CommonResources.AddOfferFailure;
            throw AssistLogger.Log<ExceptionHolder>(e);
          }
        }
      }
      else
      {
        throw AssistLogger.Log<ExceptionHolder>(new NullReferenceException());
      }
      return result;
    }

    private void LoadSellingImageData(Selling s)
    {
      if (null != s && null != s.Image && false == string.IsNullOrEmpty(s.Image.ImageName))
      {
        var fullFilePath = GT.Ajax.Controls.FileUploader.GetFullFilePath(Credentials, s.Image.ImageName);
        if (true == File.Exists(fullFilePath))
        {
          s.Image.Data = File.ReadAllBytes(fullFilePath);
        }
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string ValidateOfferKey(int offerId, string key)
    {
        Selling offer = SellingFacade.GetOfferById(offerId);
        if (offer != null)
        {
            int res = 0;
            if (offer.TransactionPhase != TransactionPhase.Submit)
            {
                res = -1;
            }
            else if (offer.SellerId == Credentials.UserId)
            {
                res = SellingFacade.ValidOffer(offer, key);
            }

            if (res == 1)
            {
                return String.Format("<p style=\"color : green\">{0}</p>", CommonResources.Correct);
            }

            if (res == -2)
            {
                return String.Format("<p style=\"color : red\">{0}</p>", CommonResources.Incorrect);
            }

            if (res == -1)
            {
                return CommonResources.OldDataError;
            }
        }

        return null;
    }
  }
}
