using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GT.Common.Data
{
    public static class DatabaseExtensions
    {
        public static DataRow ExecuteDataRow(this Database db, DbCommand cmd, out int rowCount)
        {
            rowCount = 0;
            DataSet ds = db.ExecuteDataSet(cmd);
            if (null != ds && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                rowCount = ds.Tables[0].Rows.Count;
                return ds.Tables[0].Rows[0];
            }
            else
            {
                return null;
            }
        }

        public static DataRow ExecuteDataRow(this Database db, DbCommand cmd)
        {
            int rowCount;
            return ExecuteDataRow(db, cmd, out rowCount);
        }

    }
}
