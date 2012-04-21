using System;
using GT.DA.BillingSystem;
using System.Data;

namespace GT.BO.Implementation.BillingSystem
{
    public static class WebMoneyTransferFacade
    {
        public static WebMoneyTransfer Add(WebMoneyTransfer wm)
        {
            return new WebMoneyTransfer().Load<WebMoneyTransfer>(WebMoneyDataAdapter.Add(wm));
        }

        public static WebMoneyTransfer[] GetByTransferId(int transferId)
        {
            return Array.ConvertAll<DataRow, WebMoneyTransfer>(WebMoneyDataAdapter.GetByTransferId(transferId)
                     , delegate(DataRow dr) { return new WebMoneyTransfer().Load<WebMoneyTransfer>(dr); });
        }
    }
}
