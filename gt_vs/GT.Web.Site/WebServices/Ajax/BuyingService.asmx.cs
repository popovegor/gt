using System;
using System.Web.Services;
using GT.BO.Implementation.Offers;
using GT.Web.Services;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Common;
using GT.Common.Exceptions;

namespace GT.Web.Site.WebServices.Ajax
{
    /// <summary>
    /// Summary description for BuyingService
    /// </summary>
    [WebService(Namespace = "http://gameismoney.ru/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class BuyingService : BaseWebService
    {

        [WebMethod]
        public string Upsert(Buying o)
        {
            string result = string.Empty;
            if (null != o)
            {
                try
                {
                    o.BuyerId = Credentials.UserId;
                    if (o.BuyingOfferId > 0)
                    {
                        BuyingFacade.UpdateOffer(o);
                        result = CommonResources.UpdateOfferSuccess;
                    }
                    else
                    {
                      
                        BuyingFacade.AddOffer(o);
                        result = CommonResources.AddOfferSuccess;  
                    }
                }
                catch (Exception e)
                {
                  result = CommonResources.WebServices_Ajax_BuyingService_UpsertBuyingFailure;
                    throw AssistLogger.Log<ExceptionHolder>(e);
                   
                }
            }
            else
            {
                throw new NullReferenceException();
            }
            return result;
        }
    }
}
