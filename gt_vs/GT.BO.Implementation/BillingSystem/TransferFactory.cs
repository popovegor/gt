using System;
using GT.BO.Implementation.Offers;
using GT.Global.BillingSystem;
using GT.DA.Dictionaries;
using GT.BO.Implementation.Helpers;

namespace GT.BO.Implementation.BillingSystem
{
  public static class TransferFactory
  {
    public static Transfer CreateRealSourceToUser(RealMoneySourceType source, Guid userId
          , decimal amount, string note)
    {
      Transfer t = new Transfer();
      t.FromTransferParticipant = new TransferParticipant();
      t.FromTransferParticipant.RealMoneySourceId = (int)source;
      t.ToTransferParticipant = new TransferParticipant();
      t.ToTransferParticipant.UserId = userId;
      t.Amount = amount;
      t.Note = note;
      t.Status = TransferStatus.Pending;
      return t;
    }

    public static Transfer CreateBuyerToOffer(
       Guid buyerId, Selling offer, string note)
    {
      Transfer t = new Transfer();
      t.FromTransferParticipant = new TransferParticipant();
      t.FromTransferParticipant.UserId = buyerId;
      t.ToTransferParticipant = new TransferParticipant();
      t.ToTransferParticipant.SellingOfferId = offer.SellingId;
      t.Amount = offer.Price;
      t.Note = note;
      t.Status = TransferStatus.Completed;
      return t;
    }

    public static Transfer CreateOfferToSeller(
        Selling offer, Guid sellerId, string note)
    {
      Transfer t = new Transfer();
      t.FromTransferParticipant = new TransferParticipant();
      t.FromTransferParticipant.SellingOfferId = offer.SellingId;
      t.ToTransferParticipant = new TransferParticipant();
      t.ToTransferParticipant.UserId = sellerId;
      t.Amount = offer.Price;
      t.Note = note;
      t.Status = TransferStatus.Completed;
      return t;
    }

    public static Transfer CreateOfferToBuyer(
       Selling offer, Guid buyerId, string note)
    {
      Transfer t = new Transfer();
      t.FromTransferParticipant = new TransferParticipant();
      t.FromTransferParticipant.SellingOfferId = offer.SellingId;
      t.ToTransferParticipant = new TransferParticipant();
      t.ToTransferParticipant.UserId = buyerId;
      t.Amount = offer.Price;
      t.Note = note;
      t.Status = TransferStatus.Completed;
      return t;
    }

    public static Transfer CreateUserToUser(
        Guid fromUserId, Guid toUserId, decimal amount, string note)
    {
      Transfer t = new Transfer();
      t.FromTransferParticipant = new TransferParticipant();
      t.FromTransferParticipant.UserId = fromUserId;
      t.ToTransferParticipant = new TransferParticipant();
      t.ToTransferParticipant.UserId = toUserId;
      t.Amount = amount;
      t.Note = note;
      t.Status = TransferStatus.Completed;
      return t;
    }

    public static Transfer CreateUserToRealSource(RealMoneySource source, Guid userId, decimal amount, string note)
    {
      Transfer t = new Transfer();
      t.ToTransferParticipant = new TransferParticipant();
      t.ToTransferParticipant.RealMoneySourceId = source.RealMoneySourceId;
      t.FromTransferParticipant = new TransferParticipant();
      t.FromTransferParticipant.UserId = userId;
      t.Amount = amount;
      t.Note = note;
      t.Status = TransferStatus.Pending;
      t.OurCommission = (t.Amount * source.OurCommission).ToMoney();
      var remainder = t.Amount - t.OurCommission;
      var commisson = (remainder - remainder / (1 + source.Commission)).ToMoney();
      //if(commisson < source.MinTransferAmount)
      t.Commission = commisson;
      return t;
    }
  }
}
