using System;
using GT.BO.Implementation.Offers;
using GT.Common.Types;
using GT.Global.UserRating;
using GT.Web.UI.Pages;
using System.Data;
using GT.DA.Dictionaries;
using GT.Web.Site.WebServices.Ajax;
using GT.BO.Implementation.UserRating;
using System.Linq;

namespace GT.Web.Site.UserRating
{
  public partial class LeaveFeedback : BaseEditPage
  {
    private Selling _selling = null;
    private UnusedFeedback _unused = null;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected string ReturnUrl
    {
      get
      {
        return TypeConverter.ToString(Request.QueryString[LeaveFeedbackParams.ReturnUrl]);
      }
    }

    protected UnusedFeedback UnusedFeedback
    {
      get
      {
        if (_unused == null)
        {
          if (SellingHistoryId > 0)
          {
            var unuseds = UserRatingFacade.GetUnusedForUser(Credentials.UserId);
            _unused = unuseds.SingleOrDefault(u => u.SellingHistoryId == SellingHistoryId);
          }
          else if (SellingId > 0)
          {
            _unused = UserRatingFacade.GetUnusedBySellingId(SellingId, Credentials.UserId);
          }
        }
        return _unused;
      }
    }

    protected Selling Offer
    {
      get
      {
        if (null == _selling)
        {

          if (UnusedFeedback != null)
          {
            _selling = SellingFacade.GetOfferFromHistory(UnusedFeedback.SellingHistoryId);
          }
        }
        return _selling;
      }
    }

    protected int SellingHistoryId
    {
      get
      {
        return TypeConverter.ToInt32(Request.QueryString[LeaveFeedbackParams.SellingHistoryId], 0);
      }
    }

    protected int SellingId
    {
      get
      {
        return TypeConverter.ToInt32(Request.QueryString[LeaveFeedbackParams.SellingId], 0);
      }
    }

    protected DataTable FeedbackTypes
    {
      get
      {
        string filter = string.Empty;
        if (Offer != null)
        {
          if (Offer.TransactionPhase != GT.Global.Offers.TransactionPhase.Finish)
          {
            filter = string.Format("[{0}] <> {1}", FeedbackTypeFields.FeedbackTypeId, TypeConverter.ToInt32(FeedbackType.Positive));
          }
          return Dictionaries.Instance.FeedbackTypes.Select(filter).CopyToDataTable();
        }
        else
        {
          return null;
        }
      }
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      if (UnusedFeedback != null)
      {
        rblFeedbackType.SelectedValue = TypeConverter.ToInt32(FeedbackType.Neutral).ToString();
      }
      else
      {
        mv.SetActiveView(vFailure);
      }
      DataBind();
    }

    protected void btnLeave_Click(object sender, EventArgs e)
    {
      Page.Validate();
      if (Page.IsValid && UnusedFeedback != null)
      {
        var user = UnusedFeedback.ToUserId;
        var type = TypeConverter.ToEnumMember<FeedbackType>(rblFeedbackType.SelectedValue);
        var comment = txtComment.Text;
        var f = new Feedback() { Comment = comment, FeedbackType = type, FromUserId = Credentials.UserId, ToUserId = user, SellingHistoryId = UnusedFeedback.SellingHistoryId };
        UserRatingFacade.LeaveFeedback(f);
        Response.Redirect(string.IsNullOrEmpty(ReturnUrl) == false
          ? ReturnUrl
          : string.Format("/UserRating/FeedbackViewer.aspx?{0}={1}", FeedbackFilterParams.ForOthers, true)
        , true);
      }
    }
  }
}
