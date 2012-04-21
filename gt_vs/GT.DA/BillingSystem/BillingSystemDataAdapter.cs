using System;
using System.Data;
using System.Data.Common;
using GT.BO.Entities;
using GT.Common.Data;
using GT.Common.Types;

namespace GT.DA.BillingSystem
{
  public static class BillingSystemDataAdapter
  {
    private const string AddTransferProcName = "p_BillingSystem_AddTransfer";
    private const string GetTransfersForUserProcName = "p_BillingSystem_GetTransfersForUser";
    private const string CompleteTransferProcName = "p_BillingSystem_CompleteTransfer";
    private const string GetTransferByIdProcName = "p_BillingSystem_GetTransferById";
    private const string GetTranfsersByStatus = "p_BillingSystem_GetTransfersByStatus";


    private static class ProcNames
    {
      public const string AcknowledgeOurCommissionReceipt = "p_BillingSystem_AcknowledgeOurCommissionReceipt";
      public const string RefuseTransfer = "p_BillingSystem_RefuseTransfer";
    }

    public static DataRow AcknowledgeOurCommissionReceipt(int transferId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.AcknowledgeOurCommissionReceipt))
      {
        DB.Gt.AddInParameter(cmd, "@TransferId", DbType.Int32, transferId);
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }

    public static DataRow AddTransfer(BaseEntity transfer, out int resultCode)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(AddTransferProcName))
      {
        DB.Gt.AddInParameter(cmd, "@Transfer", DbType.Xml, transfer.ToXmlString());
        DB.Gt.AddOutParameter(cmd, "@ResultCode", DbType.Int32, 0);
        DataRow dr = DB.Gt.ExecuteDataRow(cmd);
        resultCode = TypeConverter.ToInt32(cmd.Parameters["@ResultCode"].Value);
        return dr;
      }
    }

    public static DataRow GetTransferById(int transferId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetTransferByIdProcName))
      {
        DB.Gt.AddInParameter(cmd, "@TransferId", DbType.Int32, transferId);
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }

    public static DataRow[] GetTransfersForUser(Guid userId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetTransfersForUserProcName))
      {
        DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, userId);
        return DB.Gt.ExecuteDataSet(cmd).Tables[0].Select();
      }
    }

    public static DataRow CompleteTransfer(int transferId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(CompleteTransferProcName))
      {
        DB.Gt.AddInParameter(cmd, "@TransferId", DbType.Int32, transferId);
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }

    public static DataRow[] GetTransfersByStatus(int status)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetTranfsersByStatus))
      {
        DB.Gt.AddInParameter(cmd, "@Status", DbType.Int32, status);
        return DB.Gt.ExecuteDataSet(cmd).Tables[0].Select();
      }
    }

    public static DataRow RefuseTransfer(int transferId, string description)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.RefuseTransfer))
      {
        DB.Gt.AddInParameter(cmd, "@TransferId", DbType.Int32, transferId);
        if (!String.IsNullOrEmpty(description))
        {
            DB.Gt.AddInParameter(cmd, "@Note", DbType.String, description);
        }
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }
  }
}
