using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Pages;
using GT.Global.Users;
using GT.Common.Types;
using GT.BO.Implementation.Users;
using System.Web.Security;
using GT.BO.Implementation.Helpers;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.BO.Implementation.UserRating;
using System.Data;
using GT.Global.UserRating;
using GT.Web.Security;

namespace GT.Web.Site.Users
{
  public partial class User : BasePage
  {
    protected Guid UserId
    {
      get
      {
        var userId = Request.QueryString[UserCardParams.UserId];
        if (userId != null)
        {
          return new Guid(userId);
        }
        else
        {
          return new Guid();
        }
      }
    }
    
    public new Web.Site.MasterPages.User Master
    {
      get
      {
        return (base.Master as Web.Site.MasterPages.User);
      }
    }

    private Lazy<Feedback[]> _feedbacks = null;
    protected Feedback[] Feedbacks
    {
      get
      {
        _feedbacks.Value.OrderBy( t => t.FeedbackTypeId);
        return _feedbacks.Value;
      }
    }
    
    protected Feedback[] GetFeedbacks(FeedbackType type)
    {
      return _feedbacks.Value.Where(f => f.FeedbackType == type).ToArray();
    }


    protected void Page_Init(object sender, EventArgs e)
    {
      _feedbacks = new Lazy<Feedback[]>(()
        => Master.Info != null ? UserRatingFacade.GetFeedbacksForUserAsCollection(UserId) : new Feedback[] { }, true);
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Master.DataType == UserCardParams.Data.Conversation && Credentials.IsLoggedIn == false)
      {
         Response.Redirect(AuthenticationHelper.GetLoginUrl(Request.Url.PathAndQuery), true);
      }
      conv.UserId = UserId;
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }
  }
}
