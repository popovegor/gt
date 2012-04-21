using System;
using System.Web.Services;
using GT.BO.Implementation.Offers;
using GT.Web.Services;
using Resources;
using GT.Common;
using GT.Common.Exceptions;

namespace GT.Web.Site.WebServices.Ajax
{
    /// <summary>
    /// Summary description for BuyingService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
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
                    AssistLogger.Log<ExceptionHolder>(e);
                    result = CommonResources.WebServices_Ajax_BuyingService_UpsertBuyingFailure;
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
