using System;
using GT.BO.Implementation.Offers;
using GT.Common;
using GT.Common.Exceptions;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Web.UI.Pages;
using Offer = GT.BO.Implementation.Offers.Buying;
using Resources;
using GT.Web.Site.MasterPages;

namespace GT.Web.Site.Offers
{
  public partial class EditBuying : BaseEditPage
  {
    private Buying _buying = new Buying();

    protected Buying Offer
    {
      get
      {
        if (EditPageMode == EditPageAction.Edit)
        {
          _buying = BuyingFacade.GetOfferById(Id);
          if (BuyerId != _buying.BuyerId)
          {
            throw AssistLogger.Log<ExceptionHolder>(new Exception(""));
          }
        }
        else
        {
          _buying = new Buying();
        }
        return _buying;
      }
    }

    protected Guid BuyerId
    {
      get
      {
        return Credentials.UserId;
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      PreRender += delegate(object s, EventArgs eArgs)
      {
        PageDataBind();
      };
    }

    private void PageDataBind()
    {
      DataBind();
      if (null != Offer)
      {
        cddGame.SelectedValue = TypeConverter.ToString(
            Dictionaries.Instance.GetGameIdByGameServerId(Offer.GameServerId));
        cddServer.SelectedValue = TypeConverter.ToString(Offer.GameServerId);
        txtTitle.Text = Offer.Title;
        txtDescription.Text = Offer.Description;
        txtPrice.Text = Offer.Price.ToString("#.##");
      }
    }
  }
}
