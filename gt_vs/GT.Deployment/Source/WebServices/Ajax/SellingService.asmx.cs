using System;
using System.ComponentModel;
using System.Web.Script.Services;
using System.Web.Services;
using GT.BO.Implementation.Offers;
using GT.Common;
using GT.Common.Exceptions;
using GT.Web.Services;
using Resources;
using System.IO;

namespace GT.Web.Site.WebServices.Ajax
{
  /// <summary>
  /// Summary description for SellingService
  /// </summary>
  [WebService(Namespace = "http://tempuri.org/")]
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
        result = Resources.CommonResources.WebServices_Ajax_SellingService_DeleteImageSuccess;
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
    public string Upsert(Selling offer)
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
            AssistLogger.Log<ExceptionHolder>(e);
            result = CommonResources.UpdateOfferFailure;
          }
        }
        else
        {
          try
          {
            LoadSellingImageData(offer);
            SellingFacade.AddOffer(offer);
            result = CommonResources.AddOfferSuccess;
          }
          catch (Exception e)
          {
            AssistLogger.Log<ExceptionHolder>(e);
            result = CommonResources.AddOfferFailure;
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
  }
}
