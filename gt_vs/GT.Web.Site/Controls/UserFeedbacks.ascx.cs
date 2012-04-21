using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using GT.BO.Implementation.UserRating;
using GT.BO.Implementation.UserRating.SearchFilters;

namespace GT.Web.Site.Controls
{
  public partial class UserFeedbacks : System.Web.UI.UserControl
  {
  
    private DataTable _feedbacksAsSeller = null;
    private DataTable _feedbacksAsBuyer = null;
  
    public Guid UserId
    {
      get;
      set;
    }
    
    protected int CountOfFeedbacksAsSeller
    {
      get
      {
        return FeedbacksAsSeller != null ? FeedbacksAsSeller.Rows.Count : 0;
      }
    }

    protected int CountOfFeedbacksAsBuyer
    {
      get
      {
        return FeedbacksAsBuyer != null ? FeedbacksAsBuyer.Rows.Count : 0;
      }
    }
  
    protected DataTable FeedbacksAsSeller
    {
      get
      {
        if (null == _feedbacksAsSeller)
        {
          var filter = new FeedbackSearchFilter();
          filter.ToSellerId = UserId;
          _feedbacksAsSeller = UserRatingFacade.SearchFeedbacksAsDataTable(filter);
        }
        return _feedbacksAsSeller;
      }
    }

    protected DataTable FeedbacksAsBuyer
    {
      get
      {
        if (null == _feedbacksAsBuyer)
        {
          var filter = new FeedbackSearchFilter();
          filter.ToBuyerId = UserId;
          _feedbacksAsBuyer = UserRatingFacade.SearchFeedbacksAsDataTable(filter);
        }
        return _feedbacksAsBuyer;
      }
    }

    protected void gvFeedbacksAsBuyer_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      gvFeedbacksAsBuyer.PageIndex = e.NewPageIndex;
    }

    protected void gvFeedbacksAsSeller_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      gvFeedbacksAsSeller.PageIndex = e.NewPageIndex;
    }

    protected void tcFeedbacks_ActiveTabChanged(object sender, EventArgs e)
    {
      //throw new NotImplementedException();
    }
  
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }
  }
}