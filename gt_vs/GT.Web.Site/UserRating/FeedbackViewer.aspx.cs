using System;
using System.Data;
using System.Web.UI.WebControls;
using GT.BO.Implementation.UserRating;
using GT.BO.Implementation.UserRating.SearchFilters;
using GT.Common.Types;
using GT.Global.UserRating;
using GT.Web.UI.Pages;
using GT.BO.Implementation.Users;
using System.Linq;

namespace GT.Web.Site.UserRating
{
  public partial class FeedbackViewer : BasePage
  {
    private Feedback[] _feedbacks = null;
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

    protected Feedback[] Feedbacks
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
            gvFeedbacks.Columns[2].Visible = true; 
            gvFeedbacks.Columns[1].Visible = false;
            filter.ToUserId = Guid.Empty;
          }
          return UserRatingFacade.SearchFeedbacks(filter);
        }
        return new Feedback[] {};
      }
    }
    
    
    
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }

    protected void gvFeedbacks_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      gvFeedbacks.PageIndex = e.NewPageIndex;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      if (e != null
        && e.Row.DataItem != null
        && e.Row.RowType == DataControlRowType.DataRow)
      {
        var count = ((sender as GridView).DataSource as Feedback[]).Count();
        var pageSize = (sender as GridView).PageSize;
        if (e.Row.RowIndex != pageSize - 1
          && e.Row.DataItemIndex != count - 1)
        {
          e.Row.CssClass += "row separator";
        }
        e.Row.Attributes.Add("fdb", string.Format("{0}", (e.Row.DataItem as Feedback).FeedbackId));
      }
    }
  }
}
