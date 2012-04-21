using System;
using System.Data;
using System.Data.Common;
using GT.BO.Entities;
using GT.Common.Types;

namespace GT.DA.Offers
{
    public class BuyingDataAdapter
    {
        private static class ProcNames
        {
            public const string Add = "p_Offers_AddBuyingOffer";
            public const string Update = "p_Offers_UpdateBuyingOffer";
            public const string GetOffersForUser = "p_Offers_GetBuyingOffersForUser";
            public const string DeleteOffer = "p_Offers_DeleteBuyingOffer";
            public const string SuggestSellingOffer = "p_Offers_SuggestSellingOffer";
            public const string GetSuggestedSellingOffers = "p_Offers_GetSuggestedSellingOffers";
            public const string GetOfferById = "p_Offers_GetBuyingOfferById";
            public const string SearchOffers = "p_Offers_SearchBuyingOffers";
            public const string GetBuyingOffersByBuyer = "p_Offers_GetBuyingOffersByBuyer";
            public const string AcceptSuggested = "p_Offers_AcceptSuggestedSellingOffer ";
            public const string AddSuggested = "p_Offers_AddSuggested";
            public const string CancelSuggested = "p_Offers_CancelSuggested";
            public const string GetOffersForSuggesting = "p_Offers_GetOffersForSuggesting";
        }

        public static DataRow AddOffer(BaseEntity bo, out int historyId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.Add))
            {
                DB.Gt.AddInParameter(cmd, "@Offer", DbType.Xml, bo.ToXmlString());
                DB.Gt.AddOutParameter(cmd, "@HistoryOfferId", DbType.Int32, 1);
                DataRow dr = DB.Gt.ExecuteDataSet(cmd).Tables[0].Rows[0];
                historyId = TypeConverter.ToInt32(cmd.Parameters["@HistoryOfferId"].Value);
                return dr;
            }
        }

        public static DataRow UpdateOffer(BaseEntity bo, out int historyId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.Update))
            {
                DB.Gt.AddInParameter(cmd, "@Offer", DbType.Xml, bo.ToXmlString());
                DB.Gt.AddOutParameter(cmd, "@HistoryOfferId", DbType.Int32, 1);
                DataRow dr = DB.Gt.ExecuteDataSet(cmd).Tables[0].Rows[0];
                historyId = TypeConverter.ToInt32(cmd.Parameters["@HistoryOfferId"].Value);
                return dr;
            }
        }

        public static DataRow[] GetOffersForUser(Guid userId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetOffersForUser))
            {
                DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, userId);
                return DB.Gt.ExecuteDataSet(cmd).Tables[0].Select();
            }
        }

        public static void DeleteOffer(Guid buyerId, int offerId, out int historyId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.DeleteOffer))
            {
                DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, buyerId);
                DB.Gt.AddInParameter(cmd, "@OfferId", DbType.Int32, offerId);
                DB.Gt.AddOutParameter(cmd, "@HistoryOfferId", DbType.Int32, 1);
                DB.Gt.ExecuteNonQuery(cmd);
                historyId = TypeConverter.ToInt32(cmd.Parameters["@HistoryOfferId"].Value);
            }
        }

        public static void SuggestSellingOffer(int buyingOfferId, int sellingOfferId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.SuggestSellingOffer))
            {
                DB.Gt.AddInParameter(cmd, "@BuyingOfferId", DbType.Int32, buyingOfferId);
                DB.Gt.AddInParameter(cmd, "@SellingOfferId", DbType.Int32, sellingOfferId);
                DB.Gt.ExecuteNonQuery(cmd);
            }
        }

        public static DataRow[] GetSuggestedSellingOffers(int buyingOfferId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetSuggestedSellingOffers))
            {
                DB.Gt.AddInParameter(cmd, "@BuyingOfferId", DbType.Int32, buyingOfferId);
                DataSet ds = DB.Gt.ExecuteDataSet(cmd);
                return ds != null && ds.Tables.Count > 0 ? ds.Tables[0].Select() : null;
            }
        }

        public static DataRow GetOfferById(int offerId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetOfferById))
            {
                DB.Gt.AddInParameter(cmd, "@BuyingOfferId", DbType.Int32, offerId);
                DataSet ds = DB.Gt.ExecuteDataSet(cmd);
                return ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0
                            ? ds.Tables[0].Rows[0]
                            : null;
            }
        }

        public static DataSet SearchOffers(BaseEntity filter)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.SearchOffers))
            {
                DB.Gt.AddInParameter(cmd, "@Filter", DbType.Xml, filter.ToXmlString());
                return DB.Gt.ExecuteDataSet(cmd);
            }
        }
        
        public static DataSet GetBuyingOffersByBuyer(Guid buyerId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetBuyingOffersByBuyer))
            {
                DB.Gt.AddInParameter(cmd, "@BuyerId", DbType.Guid, buyerId);
                return DB.Gt.ExecuteDataSet(cmd);
            }
        }

        public static int AcceptSuggested(int buyingOfferId, int suggestedId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.AcceptSuggested))
            {
                DB.Gt.AddInParameter(cmd, "@BuyingId", DbType.Int32, buyingOfferId);
                DB.Gt.AddInParameter(cmd, "@SuggestedId", DbType.Int32, suggestedId);
                DB.Gt.AddOutParameter(cmd, "@ResultCode", DbType.Int32, 0);
                DB.Gt.ExecuteScalar(cmd);
                return TypeConverter.ToInt32(cmd.Parameters["@ResultCode"].Value);
            }
        }

        public static int CancelSuggested(int buyingOfferId, int suggestedId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.CancelSuggested))
            {
                DB.Gt.AddInParameter(cmd, "@BuyingId", DbType.Int32, buyingOfferId);
                DB.Gt.AddInParameter(cmd, "@SuggestedId", DbType.Int32, suggestedId);
                DB.Gt.AddOutParameter(cmd, "@ResultCode", DbType.Int32, 0);
                DB.Gt.ExecuteScalar(cmd);
                return TypeConverter.ToInt32(cmd.Parameters["@ResultCode"].Value);
            }
        }

        public static int AddSuggested(int buyingOfferId, int suggestedId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.AddSuggested))
            {
                DB.Gt.AddInParameter(cmd, "@BuyingId", DbType.Int32, buyingOfferId);
                DB.Gt.AddInParameter(cmd, "@Suggested", DbType.Int32, suggestedId);
                DB.Gt.AddOutParameter(cmd, "@ResultCode", DbType.Int32, 0);
                DB.Gt.ExecuteScalar(cmd);
                return TypeConverter.ToInt32(cmd.Parameters["@ResultCode"].Value);
            }
        }

        public static DataRow[] GetOffersForSuggesting(int buyingId, Guid seller)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetOffersForSuggesting))
            {
                DB.Gt.AddInParameter(cmd, "@User", DbType.Guid, seller);
                DB.Gt.AddInParameter(cmd, "@BuyingId", DbType.Int32, buyingId);
                DataSet ds = DB.Gt.ExecuteDataSet(cmd);
                return ds.Tables.Count == 0 ? null : ds.Tables[0].Select();
            }
        }
    }
}
