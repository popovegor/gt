using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using GT.Web.Site.Support;
using GT.Common;
using GT.Common.Exceptions;
using GT.Localization.Resources;
using GT.BO.Implementation.Support;

namespace GT.Web.Site.WebServices.Ajax
{
  /// <summary>
  /// Summary description for SupportService
  /// </summary>
  [WebService(Namespace = "http://gameismoney.ru/")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [ScriptService]
  public class SupportService : System.Web.Services.WebService
  {
    [WebMethod]
    public string AddFeedback(SupportFeedback fb)
    {
      try
      {
        SupportFacade.AddFeedback(fb);
      }
      catch(Exception e)
      {
        AssistLogger.Log<ExceptionHolder>(e);
      }
      return CommonResources.AddSupportFeedbackSuccess;
    }
  }
}
