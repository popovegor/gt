using System;
using System.Data;
using GT.DA.BillingSystem;
using GT.Global.BillingSystem;
using GT.DA.Dictionaries;

namespace GT.BO.Implementation.BillingSystem
{
  public static class BillingSystemFacade
  {
    public static Transfer AcknowledgeOurCommissionReceipt(int transferId)
    {
      return new Transfer().Load<Transfer>(BillingSystemDataAdapter.AcknowledgeOurCommissionReceipt(transferId));
    }

    public static Transfer AddTransfer(Transfer t)
    {
      int resultCode = 0;
      return AddTransfer(t, out resultCode);
    }

    public static Transfer AddTransfer(Transfer t, out int resultCode)
    {
      return new Transfer().Load<Transfer>(BillingSystemDataAdapter.AddTransfer(t, out resultCode));
    }

    public static Transfer GetTransferById(int transferId)
    {
      return new Transfer().Load<Transfer>(BillingSystemDataAdapter.GetTransferById(transferId));
    }

    public static Transfer[] GetTransfersForUser(Guid userId)
    {
      return Array.ConvertAll<DataRow, Transfer>(BillingSystemDataAdapter.GetTransfersForUser(userId)
          , delegate(DataRow dr) { return new Transfer().Load<Transfer>(dr); });
    }

    public static Transfer CompleteTransfer(int transferId)
    {
      return new Transfer().Load<Transfer>(BillingSystemDataAdapter.CompleteTransfer(transferId));
    }

    public static Transfer[] GetTransfersByStatus(TransferStatus status)
    {
      return Array.ConvertAll<DataRow, Transfer>(BillingSystemDataAdapter.GetTransfersByStatus((int)status)
           , delegate(DataRow dr) { return new Transfer().Load<Transfer>(dr); });
    }

    public static Transfer RefuseTransfer(int transferId)
    {
      return new Transfer().Load<Transfer>(BillingSystemDataAdapter.RefuseTransfer(transferId, null));
    }

    public static Transfer RefuseTransfer(int transferId, string description)
    {
        return new Transfer().Load<Transfer>(BillingSystemDataAdapter.RefuseTransfer(transferId, description));
    }

    public static RealMoneySource GetRealMoneySource(RealMoneySourceType moneySourceTupe)
    {
      return new RealMoneySource().Load<RealMoneySource>(
        Dictionaries.Instance.GetRealMoneySourceById((int)moneySourceTupe));
    }
  }
}
