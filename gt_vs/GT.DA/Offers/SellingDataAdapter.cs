using System;
using System.Data;
using System.Data.Common;
using GT.BO.Entities;
using GT.Common.Data;
using GT.Common.Types;
using System.IO;

namespace GT.DA.Offers
{
  public static class SellingDataAdapter
  {
    private static class ProcNames
    {
      public const string GetById = "p_Offers_GetSellingOfferById";
      public const string Add = "p_Offers_AddSelling";
      public const string Update = "p_Offers_UpdateSelling";
      public const string Delete = "p_Offers_DeleteSellingOffer";
      public const string GetForUser = "p_Offers_GetSellingOffersForUser";
      public const string GetOfferFromHistrory = "p_Offers_GetSellingOfferFromHistory";
      public const string GetOfferByTransferParticipantId = "p_Offers_GetSellingOfferByTransferParticipantId";
      public const string Search = "p_Offers_SearchSellingOffers";
      public const string AddImage = "p_Offers_AddSellingImage";
      public const string GetImageBySellingId = "p_Offers_GetSellingImageBySellingId";
      public const string DeleteSellingImage = "p_Offers_DeleteSellingImage";

      public static string GetByBuyerName = "p_Offers_GetSellingOffersByBuyerName";
      public static string GetBySellerName = "p_Offers_GetSellingOffersBySellerName";
      public static string AcceptOffer = "p_Offers_AcceptSellingOffer";
      public static string RejectOffer = "p_Buyers_Reject";
      public static string AbandonOffer = "p_Buyers_Abandon";
      public static string ConfirmOffer = "p_Offers_ConfirmSellingOffer";
      public static string FinishOffer = "p_Offers_FinishSellingOffer";
      public static string ConflictOffer = "p_Offers_ConflictSellingOffer";
      public static string GetOfferInfo = "p_Offers_GetOfferInfo";
      public static string GetOfferBuyers = "p_Offers_GetSellingOfferBuyers";
      public static string SelectOffer = "p_Offers_SelectSellingOffer";
      public static string UpdateOfferKey = "p_Offers_UpdateSellingOfferKey";
      public static string ValidOffer = "p_Offers_ValidateSellingOffer";
      public static string CancelOfferAccept = "p_Offers_CancelAcceptedSellingOffer";
      public static string CancelConfirmedOffer = "p_Offers_CancelConfirmedSellingOffer";
    }

    public static DataRow AddImage(BaseEntity sellingImage)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.AddImage))
      {
        DB.Gt.AddInParameter(cmd, "@SellingImage", DbType.Xml, sellingImage.ToXmlString());
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }

    /*public static int DeleteImage()
    {
      
    }*/

    public static int DeleteOffer(BaseEntity offer, out int historyId)
    {
      return DeleteOffer(offer, null, out historyId);
    }

    public static int DeleteOffer(BaseEntity offer, BaseEntity transfer, out int historyId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.Delete))
      {
        DB.Gt.AddInParameter(cmd, "@Offer", DbType.Xml, offer.ToXmlString());
        if (null != transfer)
        {
          DB.Gt.AddInParameter(cmd, "@Transfer", DbType.Xml, transfer.ToXmlString());
        }
        DB.Gt.AddOutParameter(cmd, "@SellingHistoryId", DbType.Int32, 0);
        DB.Gt.AddOutParameter(cmd, "@ResultCode", DbType.Int32, 0);
        DB.Gt.ExecuteNonQuery(cmd);
        historyId = Convert.ToInt32(DB.Gt.GetParameterValue(cmd, "@SellingHistoryId"));
        return Convert.ToInt32(DB.Gt.GetParameterValue(cmd, "@ResultCode"));
      }
    }

    public static DataRow Add(BaseEntity offer, out int historyId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.Add))
      {
        DB.Gt.AddInParameter(cmd, "@Offer", DbType.Xml, offer.ToXmlString());
        DB.Gt.AddOutParameter(cmd, "@History", DbType.Int32, 0);
        DataRow res = DB.Gt.ExecuteDataSet(cmd).Tables[0].Rows[0];
        historyId = TypeConverter.ToInt32(cmd.Parameters["@History"].Value);
        return res;
      }
    }

    public static DataRow Update(BaseEntity offer, out int historyId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.Update))
      {
        DB.Gt.AddInParameter(cmd, "@Offer", DbType.Xml, offer.ToXmlString());
        DB.Gt.AddOutParameter(cmd, "@History", DbType.Int32, 0);
        DataRow res = DB.Gt.ExecuteDataSet(cmd).Tables[0].Rows[0];
        historyId = TypeConverter.ToInt32(cmd.Parameters["@History"].Value);
        return res;
      }
    }

    public static DataRow GetOfferById(int id)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetById))
      {
        DB.Gt.AddInParameter(cmd, "@Id", DbType.Int32, id);
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        return ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0
            ? ds.Tables[0].Rows[0]
            : null;
      }
    }

    public static DataSet SearchOffers(BaseEntity filter)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.Search))
      {
        DB.Gt.AddInParameter(cmd, "@Filter", DbType.Xml, filter.ToXmlString());
        return DB.Gt.ExecuteDataSet(cmd);
      }
    }

    public static DataSet GetByBuyerName(string name)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetByBuyerName))
      {
        DB.Gt.AddInParameter(cmd, "@BuyerName", DbType.String, name);
        return DB.Gt.ExecuteDataSet(cmd);
      }
    }

    public static DataSet GetBySellerName(string name)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetBySellerName))
      {
        DB.Gt.AddInParameter(cmd, "@SellerName", DbType.String, name);
        return DB.Gt.ExecuteDataSet(cmd);
      }
    }

    public static int AcceptOffer(int offerId, Guid buyerId, out int history, out DataRow offer)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.AcceptOffer))
      {
        DB.Gt.AddInParameter(cmd, "@OfferId", DbType.Int32, offerId);
        DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, buyerId);
        DB.Gt.AddOutParameter(cmd, "@Resultcode", DbType.Int32, 0);
        DB.Gt.AddOutParameter(cmd, "@HistoryId", DbType.Int32, 0);
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        history = TypeConverter.ToInt32(cmd.Parameters["@HistoryId"].Value);
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count == 1)
        {
          offer = ds.Tables[0].Rows[0];
        }
        else
        {
          offer = null;
        }

        return TypeConverter.ToInt32(cmd.Parameters["@Resultcode"].Value);
      }
    }

    public static int AbandonOfferBuyer(int offerId, Guid buyerId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.AbandonOffer))
      {
        DB.Gt.AddInParameter(cmd, "@OfferId", DbType.Int32, offerId);
        DB.Gt.AddInParameter(cmd, "@BuyerId", DbType.Guid, buyerId);
        return TypeConverter.ToInt32(DB.Gt.ExecuteScalar(cmd));
      }
    }

    public static int RejectOfferBuyer(int offerId, Guid buyerId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.RejectOffer))
      {
        DB.Gt.AddInParameter(cmd, "@OfferId", DbType.Int32, offerId);
        DB.Gt.AddInParameter(cmd, "@BuyerId", DbType.Guid, buyerId);
        return TypeConverter.ToInt32(DB.Gt.ExecuteScalar(cmd));
      }
    }

    public static int ConfirmOffer(int offerId, string key, BaseEntity transfer, out int history, out DataRow offer)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.ConfirmOffer))
      {
        DB.Gt.AddInParameter(cmd, "@OfferId", DbType.Int32, offerId);
        DB.Gt.AddInParameter(cmd, "@Key", DbType.StringFixedLength, key);
        DB.Gt.AddInParameter(cmd, "@Transfer", DbType.Xml, transfer.ToXmlString());
        DB.Gt.AddOutParameter(cmd, "@Resultcode", DbType.Int32, 0);
        DB.Gt.AddOutParameter(cmd, "@HistoryId", DbType.Int32, 0);
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        history = TypeConverter.ToInt32(cmd.Parameters["@HistoryId"].Value);
        if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count == 1)
        {
          offer = ds.Tables[1].Rows[0];
        }
        else
        {
          offer = null;
        }

        return TypeConverter.ToInt32(cmd.Parameters["@Resultcode"].Value);
      }
    }

    public static int FinishOffer(int offerId, BaseEntity transfer, out int history, out DataRow offer)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.FinishOffer))
      {
        DB.Gt.AddInParameter(cmd, "@OfferId", DbType.Int32, offerId);
        DB.Gt.AddInParameter(cmd, "@Transfer", DbType.Xml, transfer.ToXmlString());
        DB.Gt.AddOutParameter(cmd, "@HistoryId", DbType.Int32, 0);
        DB.Gt.AddOutParameter(cmd, "@Resultcode", DbType.Int32, 0);
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        history = TypeConverter.ToInt32(cmd.Parameters["@HistoryId"].Value);
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count == 1)
        {
          offer = ds.Tables[0].Rows[0];
        }
        else
        {
          offer = null;
        }

        return TypeConverter.ToInt32(cmd.Parameters["@Resultcode"].Value);
      }
    }

    public static int ConflictOffer(int offerId, Guid conflictUser, out int history, out DataRow offer)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.ConflictOffer))
      {
        DB.Gt.AddInParameter(cmd, "@OfferId", DbType.Int32, offerId);
        DB.Gt.AddOutParameter(cmd, "@Resultcode", DbType.Int32, 0);
        DB.Gt.AddOutParameter(cmd, "@HistoryId", DbType.Int32, 0);
        DB.Gt.AddInParameter(cmd, "@ConflictUser", DbType.String, conflictUser.ToString());
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        history = TypeConverter.ToInt32(cmd.Parameters["@HistoryId"].Value);
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count == 1)
        {
          offer = ds.Tables[0].Rows[0];
        }
        else
        {
          offer = null;
        }

        return TypeConverter.ToInt32(cmd.Parameters["@Resultcode"].Value);
      }
    }

    public static int CancelOfferAccepted(BaseEntity offer, Guid actionOwner, out int history, out DataRow cancaledOffer)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.CancelOfferAccept))
      {
        DB.Gt.AddInParameter(cmd, "@Offer", DbType.Xml, offer.ToXmlString());
        DB.Gt.AddOutParameter(cmd, "@Resultcode", DbType.Int32, 0);
        DB.Gt.AddOutParameter(cmd, "@HistoryId", DbType.Int32, 0);
        DB.Gt.AddInParameter(cmd, "@ActionOwner", DbType.Guid, actionOwner);
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        history = TypeConverter.ToInt32(cmd.Parameters["@HistoryId"].Value);
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count == 1)
        {
          cancaledOffer = ds.Tables[0].Rows[0];
        }
        else
        {
          cancaledOffer = null;
        }

        return TypeConverter.ToInt32(cmd.Parameters["@Resultcode"].Value);
      }
    }

    public static int CancelConfirmedOffer(BaseEntity offer, BaseEntity transfer, out int history, out DataRow cancaledOffer)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.CancelConfirmedOffer))
      {
        DB.Gt.AddInParameter(cmd, "@Offer", DbType.Xml, offer.ToXmlString());
        DB.Gt.AddInParameter(cmd, "@Transfer", DbType.Xml, transfer.ToXmlString());
        DB.Gt.AddOutParameter(cmd, "@Resultcode", DbType.Int32, 0);
        DB.Gt.AddOutParameter(cmd, "@HistoryId", DbType.Int32, 0);
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        history = TypeConverter.ToInt32(cmd.Parameters["@HistoryId"].Value);
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count == 1)
        {
          cancaledOffer = ds.Tables[0].Rows[0];
        }
        else
        {
          cancaledOffer = null;
        }

        return TypeConverter.ToInt32(cmd.Parameters["@Resultcode"].Value);
      }
    }

    public static DataSet GetOfferInfo(int offerId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetOfferInfo))
      {
        DB.Gt.AddInParameter(cmd, "@Id", DbType.Int32, offerId);
        return DB.Gt.ExecuteDataSet(cmd);
      }
    }

    public static DataSet GetOfferBuyers(int offerId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetOfferBuyers))
      {
        DB.Gt.AddInParameter(cmd, "@Id", DbType.Int32, offerId);
        return DB.Gt.ExecuteDataSet(cmd);
      }
    }

    public static int SelectOffer(int offerId, Guid userId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.SelectOffer))
      {
        DB.Gt.AddInParameter(cmd, "@OfferId", DbType.Int32, offerId);
        DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, userId);
        DB.Gt.AddOutParameter(cmd, "@ResultCode", DbType.Int32, 0);
        DB.Gt.ExecuteScalar(cmd);
        return TypeConverter.ToInt32(cmd.Parameters["@ResultCode"].Value);
      }
    }

    public static int UpdateOfferKey(int offerId, string key, out int history, out DataRow offer)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.UpdateOfferKey))
      {
        DB.Gt.AddInParameter(cmd, "@Id", DbType.Int32, offerId);
        DB.Gt.AddInParameter(cmd, "@Key", DbType.StringFixedLength, key);
        DB.Gt.AddOutParameter(cmd, "@Resultcode", DbType.Int32, 0);
        DB.Gt.AddOutParameter(cmd, "@HistoryId", DbType.Int32, 0);
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        history = TypeConverter.ToInt32(cmd.Parameters["@HistoryId"].Value);
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count == 1)
        {
          offer = ds.Tables[0].Rows[0];
        }
        else
        {
          offer = null;
        }

        return TypeConverter.ToInt32(cmd.Parameters["@Resultcode"].Value);
      }
    }

    public static int ValidOffer(int offerId, string key, out int historyId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.ValidOffer))
      {
        DB.Gt.AddInParameter(cmd, "@OfferId", DbType.Int32, offerId);
        DB.Gt.AddInParameter(cmd, "@Key", DbType.StringFixedLength, key);
        DB.Gt.AddOutParameter(cmd, "@Resultcode", DbType.Int32, 0);
        historyId = TypeConverter.ToInt32(DB.Gt.ExecuteScalar(cmd));
        return TypeConverter.ToInt32(cmd.Parameters["@Resultcode"].Value);
      }
    }

    public static DataRow[] GetOffersForUser(Guid userId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetForUser))
      {
        DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, userId);
        return DB.Gt.ExecuteDataSet(cmd).Tables[0].Select();
      }
    }

    public static DataRow GetOfferFromHistory(int historyId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetOfferFromHistrory))
      {
        DB.Gt.AddInParameter(cmd, "@HistoryId", DbType.Int32, historyId);
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }

    public static DataRow GetOfferByTransferParticipantId(int transferParticipantId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetOfferByTransferParticipantId))
      {
        DB.Gt.AddInParameter(cmd, "@TransferParticipantId", DbType.Int32, transferParticipantId);
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }

    public static DataRow GetImageBySellingId(int sellingId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetImageBySellingId))
      {
        DB.Gt.AddInParameter(cmd, "@SellingId", DbType.Int32, sellingId);
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }

    public static void DeleteSellingImage(Guid sellerId, int sellingId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.DeleteSellingImage))
      {
        DB.Gt.AddInParameter(cmd, "@SellerId", DbType.Guid, sellerId);
        DB.Gt.AddInParameter(cmd, "@SellingId", DbType.Int32, sellingId);
        DB.Gt.ExecuteNonQuery(cmd);
      }
    }
  }
}
