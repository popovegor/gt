using System;
using GT.BO.Implementation.Offers;
using GT.Common.Types;
using GT.Global.UserRating;
using GT.Web.UI.Pages;
using System.Data;
using GT.DA.Dictionaries;

namespace GT.Web.Site.UserRating
{
  public partial class AddFeedback : BaseEditPage
  {
    private Selling _selling = null;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected Selling Offer
    {
      get
      {
        if (null == _selling)
        {
          _selling = SellingFacade.GetOfferFromHistory(SellingHistoryId);
        }
        return _selling;
      }
    }

    protected int SellingHistoryId
    {
      get
      {
        return int.Parse(Request.QueryString["shid"]);
      }
    }

    protected Guid ToUserId
    {
      get
      {
        return Credentials.UserId.Equals(Offer.SellerId) ? Offer.BuyerId : Offer.SellerId;
      }
    }

    protected DataTable FeedbackTypes
    {
      get
      {
        string filter = string.Empty;
        if (Offer.TransactionPhase != GT.Global.Offers.TransactionPhase.Finish)
        {
          filter = string.Format("[{0}] <> {1}", FeedbackTypeFields.FeedbackTypeId, TypeConverter.ToInt32(FeedbackType.Positive));
        }
        return Dictionaries.Instance.FeedbackTypes.Select(filter).CopyToDataTable();
      }
    }

    protected override void OnPreRender(EventArgs e)
    {
      base.OnPreRender(e);
      DataBind();

      rblFeedbackType.SelectedValue = TypeConverter.ToInt32(FeedbackType.Neutral).ToString();
    }
  }
}
