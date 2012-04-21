
using System;
using System.Data;
using GT.BO.Implementation.UserRating.SearchFilters;
using GT.DA.UserRating;
namespace GT.BO.Implementation.UserRating
{
  public class UserRatingFacade
  {
    public static Feedback LeaveFeedback(Feedback v)
    {
      return new Feedback().Load<Feedback>(UserRatingDataAdapter.AddFeedback(v));
    }

    public static Feedback GetFeedbackById(int feedbackId)
    {
      return new Feedback().Load<Feedback>(UserRatingDataAdapter.GetFeedbackById(feedbackId));
    }

    public static Feedback[] SearchFeedbacks(FeedbackSearchFilter filter)
    {
      return Array.ConvertAll(UserRatingDataAdapter.SearchFeedbacks(filter).Select()
          , dr => new Feedback().Load<Feedback>(dr));
    }

    public static DataTable SearchFeedbacksAsDataTable(FeedbackSearchFilter filter)
    {
      return UserRatingDataAdapter.SearchFeedbacks(filter);
    }
    
    public static Feedback[] GetFeedbacksForUserAsCollection(Guid userId)
    {
      var filter = new FeedbackSearchFilter();
      filter.ToUserId = userId;
      filter.Count = int.MaxValue;
      DataTable dt = UserRatingDataAdapter.SearchFeedbacks(filter);
      if(dt != null)
      {
        return Array.ConvertAll(UserRatingDataAdapter.SearchFeedbacks(filter).Select()
          , dr => new Feedback().Load<Feedback>(dr));
      }
      else
      {
        return new Feedback[] {};
      }
    }
    
    public static DataTable GetFeedbacksForUser(Guid userId, int count)
    {
      var filter = new FeedbackSearchFilter();
      filter.ToUserId = userId;
      filter.Count = count;
      return UserRatingDataAdapter.SearchFeedbacks(filter);
    }

    public static UnusedFeedback[] GetUnusedForUser(Guid userId)
    {
      return Array.ConvertAll(UserRatingDataAdapter.GetUnusedForUser(userId).Select()
        , dr => new UnusedFeedback().Load<UnusedFeedback>(dr));
    }

    public static DataTable GetUnusedForUserAsDataTable(Guid userId)
    {
      return UserRatingDataAdapter.GetUnusedForUser(userId);
    }

    public static UnusedFeedback GetUnusedBySellingId(int sellingId, Guid userId)
    {
      var dr = UserRatingDataAdapter.GetUnusedBySellingIdAndUserId(sellingId, userId);
      if(dr != null)
      {
        return new UnusedFeedback().Load<UnusedFeedback>(dr);
      }
      return null;
    }
  }
}
