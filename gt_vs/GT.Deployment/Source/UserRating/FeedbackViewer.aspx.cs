using System;
using System.Data;
using System.Web.UI.WebControls;
using GT.BO.Implementation.UserRating;
using GT.BO.Implementation.UserRating.SearchFilters;
using GT.Common.Types;
using GT.Global.UserRating;
using GT.Web.UI.Pages;
using GT.BO.Implementation.Users;

namespace GT.Web.Site.UserRating
{
  public partial class FeedbackViewer : BasePage
  {
    private DataTable _feedbacks = null;
    private UserDynamics _dynamics = null;

    protected void Page_Load(object sender, EventArgs e)
    {
    }
    
    protected UserDynamics Dynamics
    {
      get
      {
        if (_dynamics == null)
        {
          _dynamics = UsersFacade.GetDynamicsForUser(Credentials.UserId);
        }
        return _dynamics ?? new UserDynamics();
      }
    }

    protected bool ForOthers
    {
      get
      {
        return TypeConverter.ToBool(Request.QueryString[FeedbackFilterParams.ForOthers]);
      }
    }

    protected bool AsBuyer
    {
      get
      {
        return TypeConverter.ToBool(Request.QueryString[FeedbackFilterParams.AsBuyer]);
      }
    }
    
    protected bool AsSeller
    {
      get
      {
        return TypeConverter.ToBool(Request.QueryString[FeedbackFilterParams.AsSeller]);
      }
    }

    protected DataTable Feedbacks
    {
      get
      {
        if(null == _feedbacks)
        {
          var filter = new FeedbackSearchFilter();
          filter.ToUserId = Credentials.UserId;
          if(true == AsSeller)
          {
            filter.ToSellerId = Credentials.UserId;
          }
          if(true == AsBuyer)
          {
            filter.ToBuyerId = Credentials.UserId;
          }
          if(true == ForOthers)
          {
            filter.FromUserId = Credentials.UserId;
            gvFeedbacks.Columns[3].Visible = true; 
            gvFeedbacks.Columns[2].Visible = false;
            filter.ToUserId = Guid.Empty;
          }
          return UserRatingFacade.SearchFeedbacksAsDataTable(filter);
        }
        return null;
      }
    }

    protected override void OnPreRender(EventArgs e)
    {
      base.OnPreRender(e);
      DataBind();
    }

    protected void gvFeedbacks_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      gvFeedbacks.PageIndex = e.NewPageIndex;
    }
  }
}
