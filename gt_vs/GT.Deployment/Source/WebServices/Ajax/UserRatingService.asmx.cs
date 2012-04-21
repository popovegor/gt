using System;
using System.Web.Services;
using GT.BO.Implementation.UserRating;
using GT.Common;
using GT.Common.Exceptions;
using GT.Web.Services;
using Resources;

namespace GT.Web.Site.WebServices.Ajax
{
    /// <summary>
    /// Summary description for UserRatingService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    [System.Web.Script.Services.GenerateScriptType(typeof(Feedback))]
    public class UserRatingService : BaseWebService
    {
        [WebMethod]
        public string AddFeedback(Feedback feedback)
        {
            string result = string.Empty;
            if (null != feedback)
            {
                try
                {
                    feedback.FromUserId = Credentials.UserId;
                    UserRatingFacade.AddFeedback(feedback);
                    result = CommonResources.AddFeedbackSuccess;
                }
                catch (Exception e)
                {
                    AssistLogger.Log<ExceptionHolder>(e);
                    result = CommonResources.AddFeedbackFailure;
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
