using System;
using System.Data;
using System.Data.Common;

namespace GT.DA.Users
{
    public static class UserDataAdapter
    {
        private const string GetDynamicsForUserProcName = "p_Users_GetDynamicsForUser";

        public static DataRow GetDynamicsForUser(Guid userId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetDynamicsForUserProcName))
            {
                DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, userId);
                return DB.Gt.ExecuteDataSet(cmd).Tables[0].Rows[0];
            }
        }
    }
}
