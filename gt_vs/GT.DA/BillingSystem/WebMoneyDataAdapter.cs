using System;
using System.Data;
using GT.BO.Entities;
using System.Data.Common;
using GT.Common.Data;

namespace GT.DA.BillingSystem
{
    public static class WebMoneyDataAdapter
    {
        const string AddProcName = "p_BillingSystem_WebMoney_Add";
        const string GetByTransferIdProcName = "p_BillingSystem_WebMoney_GetByTransferId";

        public static DataRow Add(BaseEntity wm)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(AddProcName))
            {
                DB.Gt.AddInParameter(cmd, "@wm", DbType.Xml, wm.ToXmlString());
                DataRow dr = DB.Gt.ExecuteDataRow(cmd);
                return dr;
            }
        }

        public static DataRow[] GetByTransferId(int transferId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetByTransferIdProcName))
            {
                DB.Gt.AddInParameter(cmd, "@TransferId", DbType.Int32, transferId);
                return DB.Gt.ExecuteDataSet(cmd).Tables[0].Select();
            }
        }
    }
}
