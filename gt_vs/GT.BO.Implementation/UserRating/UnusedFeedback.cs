using GT.BO.Entities;
using GT.DA.UserRating;
using System;

namespace GT.BO.Implementation.UserRating
{
  public class UnusedFeedback : BaseEntity
  {
    [BaseSourceMapping(UnusedFeedbackFields.UnusedFeedbackId)]
    public int UnusedFeedbackId
    {
      get;
      set;
    }

    [BaseSourceMapping(UnusedFeedbackFields.SellingHistoryId)]
    public int SellingHistoryId
    {
      get;
      set;
    }

    [BaseSourceMapping(UnusedFeedbackFields.FromUserId)]
    public Guid FromUserId
    {
      get;
      set;
    }

    [BaseSourceMapping(UnusedFeedbackFields.ToUserId)]
    public Guid ToUserId
    {
      get;
      set;
    }

    public override int Id
    {
      get { return UnusedFeedbackId; }
      set { UnusedFeedbackId = value; }
    }
  }
}
