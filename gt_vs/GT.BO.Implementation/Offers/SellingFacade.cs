using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using GT.BO.Implementation.BillingSystem;
using GT.BO.Implementation.MessageSystem;
using GT.BO.Implementation.Offers.SearchFilters;
using GT.BO.Implementation.Users;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.DA.Offers;
using GT.Global.Offers;
using GT.Global.MessageSystem;
using System.Web.Security;

namespace GT.BO.Implementation.Offers
{
  public static class SellingFacade
  {
    public static int SelectOffer(Selling offer, Guid userId)
    {
      if (offer == null || offer.SellingId < 0 || userId == Guid.Empty || offer.SellerId == Guid.Empty)
      {
        throw new ArgumentNullException();
      }

      int res = SellingDataAdapter.SelectOffer(offer.SellingId, userId);
      if (res == 1)
      {
        var user = UsersFacade.GetUser(userId);
        if (user != null)
        {
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingSelected, offer.SellerId,
            null, new[] { user.UserName, offer.Title });
          MessageFacade.AddFromSystemUser(msg);
        }
      }
      return res;
    }

    public static int ConfirmOffer(Selling offer)
    {
      int temp;
      return ConfirmOffer(ref offer, out temp);
    }

    public static int ConfirmOffer(ref Selling offer, out int historyId)
    {
      if (offer == null || offer.SellingId < 0 || offer.BuyerId == Guid.Empty || offer.SellerId == Guid.Empty)
      {
        throw new ArgumentNullException();
      }

      DataRow row;
      int res = SellingDataAdapter.ConfirmOffer(offer.SellingId, GenerateKey(7)
          , TransferFactory.CreateBuyerToOffer(offer.BuyerId, offer, string.Empty)
          , out historyId, out row);
      if (res == 1)
      {
        var user = UsersFacade.GetUser(offer.BuyerId);
        if (user != null)
        {
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingConfirmed, offer.SellerId,
            null, new[] { user.UserName, offer.Title });
          MessageFacade.AddFromSystemUser(msg);
        }
      }

      if (row != null)
      {
        offer = offer.Load<Selling>(row);
      }

      return res;
    }

    public static int FinishOffer(Selling offer)
    {
      int temp;
      return FinishOffer(ref offer, out temp);
    }

    public static int FinishOffer(ref Selling offer, out int historyId)
    {
      if (offer == null || offer.SellingId < 0 || offer.BuyerId == Guid.Empty || offer.SellerId == Guid.Empty)
      {
        throw new ArgumentNullException();
      }

      DataRow row;
      int res = SellingDataAdapter.FinishOffer(offer.SellingId,
                            TransferFactory.CreateOfferToSeller(offer, offer.SellerId, "Finish offer"),
                            out historyId,
                            out row);
      if (res == 1)
      {
        var user = UsersFacade.GetUser(offer.BuyerId);
        if (user != null)
        {
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingFinised, offer.SellerId,
              null, new[] { user.UserName, offer.Title });
          MessageFacade.AddFromSystemUser(msg);
        }
      }

      if (row != null)
      {
        offer = offer.Load<Selling>(row);
      }

      return res;
    }

    public static int AbandonOffer(Selling offer, Guid userId)
    {
        if (offer == null || offer.SellingId < 0 || userId == Guid.Empty || offer.SellerId == Guid.Empty)
        {
            throw new ArgumentNullException();
        }

        int res = SellingDataAdapter.AbandonOfferBuyer(offer.SellingId, userId);

        if (res == 1)
        {
            var user = UsersFacade.GetUser(userId);
            if (user != null)
            {
                var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingBuyerAbandon, offer.SellerId,
                             null, new[] { user.UserName, offer.Title });
                MessageFacade.AddFromSystemUser(msg);
            }
        }

        return res;
    }

    public static int RejectOffer(Selling offer, Guid userId)
    {
      if (offer == null || offer.SellingId < 0 || userId == Guid.Empty || offer.SellerId == Guid.Empty)
      {
        throw new ArgumentNullException();
      }

      int res = SellingDataAdapter.RejectOfferBuyer(offer.SellingId, userId);

      if (res == 1)
      {
        var user = UsersFacade.GetUser(offer.SellerId);
        if (user != null)
        {
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingAbandoned, userId,
            null, new[] { user.UserName, offer.Title });
          MessageFacade.AddFromSystemUser(msg);
        }
      }

      return res;
    }

    public static int ConflictOffer(Selling offer, Guid conflictUserId)
    {
      int temp;
      return ConflictOffer(ref offer, conflictUserId, out temp);
    }

    public static int ConflictOffer(ref Selling offer, Guid conflictUserId, out int historyId)
    {
      if (offer == null || offer.SellingId < 0 || offer.BuyerId == Guid.Empty 
        || offer.SellerId == Guid.Empty || conflictUserId == Guid.Empty)
      {
        throw new ArgumentNullException();
      }

      if (conflictUserId != offer.SellerId && conflictUserId != offer.BuyerId)
      {
        throw new ArgumentException();
      }

      DataRow row;
      int res = SellingDataAdapter.ConflictOffer(offer.SellingId, conflictUserId, out historyId, out row);
      if (res == 1)
      {
        var conflictUser = UsersFacade.GetUser(conflictUserId);
        var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingConflicted, offer.SellerId,
            null, new[] { offer.Title, conflictUser.UserName });
        //to seller
        MessageFacade.AddFromSystemUser(msg);
        //to buyer
        msg.RecipientId = offer.BuyerId;
        MessageFacade.AddFromSystemUser(msg);
      }

      if (row != null)
      {
        offer = offer.Load<Selling>(row);
      }

      return res;
    }

    public static int DelStartOffer(Selling offer)
    {
      int temp;
      return DelStartOffer(offer, out temp);
    }

    public static int DelStartOffer(Selling offer, out int historyId)
    {
      if (offer == null || offer.SellingId < 0 || offer.SellerId == Guid.Empty)
      {
        throw new ArgumentNullException();
      }

      Dictionary<Guid, int> buyers = SellingFacade.GetOfferBuyers(offer.SellingId);

      int res = SellingDataAdapter.DeleteOffer(offer, out historyId);
      if (res == 1)
      {
        if (buyers != null && buyers.Count > 0)
        {
          var user = UsersFacade.GetUser(offer.SellerId);
          if (user != null)
          {
            foreach (KeyValuePair<Guid, int> kvp in buyers)
            {
              if (kvp.Value == 1 || kvp.Value == 4)
              {
                var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingDeleted, kvp.Key,
                  null, new[] { offer.Title, user.UserName });
                MessageFacade.AddFromSystemUser(msg);
              }
            }
          }
        }
      }
      return res;
    }

    public static int DelFinishOffer(Selling offer)
    {
      int temp;
      return DelFinishOffer(offer, out temp);
    }

    public static int DelFinishOffer(Selling offer, out int historyId)
    {
      if (offer == null || offer.SellingId < 0)
      {
        throw new ArgumentNullException();
      }

      return SellingDataAdapter.DeleteOffer(offer, out historyId);
    }

    public static int CancelOfferAccept(Selling offer, Guid cancelUserId)
    {
      int temp;
      return CancelOfferAccepted(ref offer, cancelUserId, out temp);
    }

    public static int CancelOfferAccepted(ref Selling offer, Guid cancelUserId, out int history)
    {
      if (offer == null || offer.SellingId < 0 || offer.SellerId == Guid.Empty
        || offer.BuyerId == Guid.Empty || cancelUserId == Guid.Empty)
      {
        throw new ArgumentNullException();
      }

      if (cancelUserId != offer.BuyerId && cancelUserId != offer.SellerId)
      {
        throw new ArgumentException();
      }

      DataRow row;
      int res = SellingDataAdapter.CancelOfferAccepted(offer, cancelUserId, out history, out row);
      if (res == 1)
      {
        var user = UsersFacade.GetUser(cancelUserId);
        if (user != null)
        {
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingCanceled
            , cancelUserId == offer.BuyerId ? offer.SellerId : offer.BuyerId
            , null, new[] { offer.Title, user.UserName });
          MessageFacade.AddFromSystemUser(msg);
        }
      }

      if (row != null)
      {
        offer = offer.Load<Selling>(row);
      }

      return res;
    }

    public static int CancelConfirmedOffer(Selling offer)
    {
      int temp;
      return CancelConfirmedOffer(ref offer, out temp);
    }

    public static int CancelConfirmedOffer(ref Selling offer, out int history)
    {
      if (offer == null || offer.SellingId < 0 || offer.SellerId == Guid.Empty || offer.BuyerId == Guid.Empty)
      {
        throw new ArgumentNullException();
      }

      DataRow row;
      int res = SellingDataAdapter.CancelConfirmedOffer(offer,
          TransferFactory.CreateOfferToBuyer(offer, offer.BuyerId, "Cancel offer"),
          out history,
          out row);

      if (res == 1)
      {
        var user = UsersFacade.GetUser(offer.SellerId);
        if (user != null)
        {
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingCanceled
            , offer.BuyerId, null, new[] { offer.Title, user.UserName });
          MessageFacade.AddFromSystemUser(msg);
        }
      }

      if (row != null)
      {
        offer = offer.Load<Selling>(row);
      }

      return res;
    }

    public static int AcceptOffer(Selling offer, Guid userId)
    {
      int temp;
      return AcceptOffer(ref offer, userId, out temp);
    }

    public static int AcceptOffer(ref Selling offer, Guid userId, out int historyId)
    {
      if (offer == null || offer.SellingId < 0 || userId == Guid.Empty || offer.SellerId == Guid.Empty)
      {
        throw new ArgumentNullException();
      }

      DataRow row;
      int res = SellingDataAdapter.AcceptOffer(offer.SellingId, userId, out historyId, out row);
      if (res == 1)
      {
        var user = UsersFacade.GetUser(offer.SellerId);
        if (user != null)
        {
          var msg = MessageFactory.CreateByTemplate(MessageTemplate.SellingAccepted
            , userId, null, new[] { offer.Title, user.UserName });
          MessageFacade.AddFromSystemUser(msg);
        }
      }

      if (row != null)
      {
        offer = offer.Load<Selling>(row);
      }

      return res;
    }

    public static int ValidOffer(Selling offer, string key)
    {
      int temp;
      return ValidOffer(offer, key, out temp);
    }

    public static int ValidOffer(Selling offer, string key, out int historyId)
    {
      if (offer == null || offer.SellingId < 0)
      {
        throw new ArgumentNullException();
      }

      return SellingDataAdapter.ValidOffer(offer.SellingId, key, out historyId);
    }

    public static int UpdateOfferKey(Selling offer)
    {
      int temp;
      return UpdateOfferKey(ref offer, out temp);
    }

    public static int UpdateOfferKey(ref Selling offer, out int historyId)
    {
      if (offer == null || offer.SellingId < 0)
      {
        throw new ArgumentNullException();
      }

      DataRow row;
      int res = SellingDataAdapter.UpdateOfferKey(offer.SellingId, GenerateKey(7), out historyId, out row);

      if (row != null)
      {
        offer = offer.Load<Selling>(row);
      }

      return res;
    }

    public static string GetStatusColor(TransactionPhase status)
    {
      switch (status)
      {
        case TransactionPhase.Accept:
          return "steelblue";

        case TransactionPhase.Conflict:
          return "red";

        case TransactionPhase.Start:
          return "deepskyblue";

        case TransactionPhase.Submit:
          return "green";

        case TransactionPhase.Finish:
          return "purple";
      }

      return "white";
    }

    public static Selling GetOfferFromHistory(int historyId)
    {
      return new Selling().Load<Selling>(SellingDataAdapter.GetOfferFromHistory(historyId));
    }

    public static Selling GetOfferById(int id)
    {
      return new Selling().Load<Selling>(SellingDataAdapter.GetOfferById(id));
    }

    public static Dictionary<Guid, int> GetOfferBuyers(int id)
    {
      Dictionary<Guid, int> res = new Dictionary<Guid, int>();
      DataSet ds = SellingDataAdapter.GetOfferBuyers(id);
      if (ds != null && ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
      {
        foreach (DataRow row in ds.Tables[0].Rows)
        {
          res.Add(TypeConverter.ToGuid(row[SellingOfferFields.BuyerId]),
                  TypeConverter.ToInt32(row[BuyerStatusFields.BuyerStatusId]));
        }
      }

      return res;
    }

    static string GenerateKey(int length)
    {
      string abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      StringBuilder code = new StringBuilder();
      Random rand = new Random();
      for (int i = 0; i < length; i++)
      {
        int j = rand.Next(0, abc.Length - 1);
        code.Append(abc[j]);
      }

      return code.ToString();
    }

    public static Selling[] GetOffersForUser(Guid userId)
    {
      return Array.ConvertAll<DataRow, Selling>(SellingDataAdapter.GetOffersForUser(userId)
          , delegate(DataRow dr) { return new Selling().Load<Selling>(dr); });
    }

    public static Selling AddOffer(Selling o)
    {
      int temp;
      return Add(o, out temp);
    }

    public static Selling Add(Selling o, out int historyId)
    {
      return new Selling().Load<Selling>(SellingDataAdapter.Add(o, out historyId));
    }

    public static Selling Update(Selling o)
    {
      int temp;
      return Update(o, out temp);
    }

    public static Selling Update(Selling o, out int historyId)
    {
      return new Selling().Load<Selling>(SellingDataAdapter.Update(o, out historyId));
    }

    public static DataSet SearchOffers(BaseSearchFilter filter)
    {
      return SellingDataAdapter.SearchOffers(filter);
    }
    
    public static Selling[] SearchOffersAsCollection(BaseSearchFilter filter)
    {
      var ds = SellingDataAdapter.SearchOffers(filter);
      if(ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
      {
        return Array.ConvertAll<DataRow,Selling>(ds.Tables[0].Select(),(dr)
          => new Selling().Load<Selling>(dr));
      }
      else
      {
        return new Selling[] {};
      }
    }

    internal static Selling GetOfferByTransferParticipantId(int transferParticipantId)
    {
      return new Selling().Load<Selling>(SellingDataAdapter.GetOfferByTransferParticipantId(transferParticipantId));
    }

    public static SellingImage AddImage(SellingImage si)
    {
      return new SellingImage().Load<SellingImage>(SellingDataAdapter.AddImage(si));
    }
    
    public static SellingImage GetImageBySellingId(int sellingId)
    {
      return new SellingImage().Load<SellingImage>(SellingDataAdapter.GetImageBySellingId(sellingId));
    }

    public static void DeleteSellingImage(Guid sellerId, int sellingId)
    {
      SellingDataAdapter.DeleteSellingImage(sellerId, sellingId);
    }
  }
}
