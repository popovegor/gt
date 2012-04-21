using System;
using System.Data;
using GT.BO.Implementation.MessageSystem;
using GT.BO.Implementation.Offers.SearchFilters;
using GT.BO.Implementation.Users;
using GT.DA.Offers;
using GT.Global.MessageSystem;

namespace GT.BO.Implementation.Offers
{
  public static class BuyingFacade
  {
    public static Buying AddOffer(Buying bo)
    {
      int hId = 0;
      return AddOffer(bo, out hId);
    }

    public static Buying AddOffer(Buying bo, out int historyId)
    {
      return new Buying().Load<Buying>(BuyingDataAdapter.AddOffer(bo, out historyId));
    }

    public static Buying UpdateOffer(Buying bo)
    {
      int hid = 0;
      return UpdateOffer(bo, out hid);
    }

    public static Buying UpdateOffer(Buying bo, out int historyId)
    {
      return new Buying().Load<Buying>(BuyingDataAdapter.UpdateOffer(bo, out historyId));
    }

    public static void DeleteOffer(Guid buyerId, int buyingOfferId, out int historyId)
    {
        Selling[] sellings = GetSuggestedSellingOffers(buyingOfferId);
        Buying bo = GetOfferById(buyingOfferId);
        if (bo.BuyerId == buyerId)
        {
            BuyingDataAdapter.DeleteOffer(buyerId, buyingOfferId, out historyId);
            var u = UsersFacade.GetUser(buyerId);
            if (u != null)
            {
                foreach (Selling s in sellings)
                {
                    var msg = MessageFactory.CreateByTemplate(MessageTemplate.BuyingDeleted, s.SellerId,
                      null, new[] { bo.Title, u == null ? string.Empty : u.UserName });
                    MessageFacade.AddFromSystemUser(msg);
                }
            }
        }
        else
        {
            historyId = -1;
        }
    }

    public static Buying[] GetOffersForUser(Guid userId)
    {
      return Array.ConvertAll<DataRow, Buying>(BuyingDataAdapter.GetOffersForUser(userId)
          , dr => new Buying().Load<Buying>(dr));
    }

    public static void SuggestSellingOffer(int buyingOfferId, int sellingOfferId)
    {
      BuyingDataAdapter.SuggestSellingOffer(buyingOfferId, sellingOfferId);
    }

    public static Selling[] GetSuggestedSellingOffers(int buyingOfferId)
    {
      return Array.ConvertAll<DataRow, Selling>(BuyingDataAdapter.GetSuggestedSellingOffers(buyingOfferId)
          , dr => new Selling().Load<Selling>(dr));
    }

    public static Buying GetOfferById(int offerId)
    {
      return new Buying().Load<Buying>(BuyingDataAdapter.GetOfferById(offerId));
    }

    public static DataSet SearchOffers(BaseSearchFilter filter)
    {
      return BuyingDataAdapter.SearchOffers(filter);
    }

    public static Buying[] SearchOffersAsCollection(BaseSearchFilter filter)
    {
      var ds = BuyingDataAdapter.SearchOffers(filter);
      if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
      {
        return Array.ConvertAll<DataRow, Buying>(ds.Tables[0].Select(), (dr)
          => new Buying().Load<Buying>(dr));
      }
      else
      {
        return new Buying[] { };
      }
    }

    public static int AcceptSuggested(int buyingOfferId, int suggested)
    {
      int res = BuyingDataAdapter.AcceptSuggested(buyingOfferId, suggested);
      if (res == 1)
      {
        Selling o = new Selling().Load<Selling>(SellingDataAdapter.GetOfferById(suggested));
        Buying bo = new Buying().Load<Buying>(BuyingDataAdapter.GetOfferById(buyingOfferId));
        if (o != null && o.SellerId != Guid.Empty && bo != null && bo.BuyerId != Guid.Empty)
        {
          var u = UsersFacade.GetUser(bo.BuyerId);
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.BuyingAccepted, o.SellerId,
            null, new[] { bo.Title, u == null ? string.Empty : u.UserName });
          MessageFacade.AddFromSystemUser(msg);
        }
      }

      return res;
    }

    public static int CancelSuggested(int buyingOfferId, int suggested)
    {
      int res = BuyingDataAdapter.CancelSuggested(buyingOfferId, suggested);

      if (res == 1)
      {
        Selling o = new Selling().Load<Selling>(SellingDataAdapter.GetOfferById(suggested));
        Buying bo = new Buying().Load<Buying>(BuyingDataAdapter.GetOfferById(buyingOfferId));
        if (o != null && o.SellerId != Guid.Empty && bo != null && bo.BuyerId != Guid.Empty)
        {
          var u = UsersFacade.GetUser(bo.BuyerId);
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.BuyingRejected, o.SellerId,
            null, new[] { o.Title, bo.Title, u == null ? string.Empty : u.UserName });
          MessageFacade.AddFromSystemUser(msg);
        }

      }

      return res;
    }

    public static int AddSuggested(int buyingOfferId, int suggested)
    {
      int res = BuyingDataAdapter.AddSuggested(buyingOfferId, suggested);
      if (res == 1)
      {
        Selling o = new Selling().Load<Selling>(SellingDataAdapter.GetOfferById(suggested));
        Buying bo = new Buying().Load<Buying>(BuyingDataAdapter.GetOfferById(buyingOfferId));
        if (o != null && o.SellerId != Guid.Empty && bo != null && bo.BuyerId != Guid.Empty)
        {
          var u = UsersFacade.GetUser(o.SellerId);
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingSuggested, bo.BuyerId,
            null, new[] { o.Title, u == null ? string.Empty : u.UserName, bo.Title });
          MessageFacade.AddFromSystemUser(msg);
        }
      }
      return res;
    }

    public static Selling[] GetOffersForSuggesting(int buyingOfferId, Guid sellerId)
    {
      DataRow[] rows = BuyingDataAdapter.GetOffersForSuggesting(buyingOfferId, sellerId);
      if (rows != null)
      {
        return Array.ConvertAll<DataRow, Selling>(rows
            , dr => new Selling().Load<Selling>(dr));
      }

      return null;
    }
  }
}
