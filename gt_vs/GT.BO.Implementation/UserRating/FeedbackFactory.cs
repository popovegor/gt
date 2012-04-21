using System;
using GT.Global.UserRating;

namespace GT.BO.Implementation.UserRating
{
    public static class FeedbackFactory
    {
        public static Feedback CreateBuyerToSeller(Guid buyerId, Guid sellerId, FeedbackType type, string note, int sellingHistoryId)
        {
            return CreateInternal(buyerId, sellerId, type, note, sellingHistoryId);
        }

        public static Feedback CreateSellerToBuyer(Guid sellerId, Guid buyerId, FeedbackType type, string note, int sellingHistoryId)
        {
            return CreateInternal(sellerId, buyerId, type, note, sellingHistoryId);
        }

        private static Feedback CreateInternal(Guid from, Guid to, FeedbackType type, string note, int sellingHistoryId)
        {
            Feedback v = new Feedback();
            v.FromUserId = from;
            v.ToUserId = to;
            v.FeedbackType = type;
            v.Comment = note;
            v.SellingHistoryId = sellingHistoryId;
            return v;
        }
    }
}
