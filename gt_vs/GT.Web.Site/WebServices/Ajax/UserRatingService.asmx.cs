using System;
using System.Web.Services;
using GT.BO.Implementation.UserRating;
using GT.Common;
using GT.Common.Exceptions;
using GT.Web.Services;
using CommonResources = GT.Localization.Resources.CommonResources;

namespace GT.Web.Site.WebServices.Ajax
{
    /// <summary>
    /// Summary description for UserRatingService
    /// </summary>
    [WebService(Namespace = "http://gameismoney.ru/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    [System.Web.Script.Services.GenerateScriptType(typeof(Feedback))]
    public class UserRatingService : BaseWebService
    {
        [WebMethod]
        private string LeaveFeedback(Feedback feedback)
        {
            string result = string.Empty;
            if (null != feedback)
            {
                try
                {
                    feedback.FromUserId = Credentials.UserId;
                    UserRatingFacade.LeaveFeedback(feedback);
                    result = CommonResources.AddFeedbackSuccess;
                }
                catch (Exception e)
                {
                  result = CommonResources.AddFeedbackFailure;
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
