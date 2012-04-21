using System.Data;
using System.Data.Common;
using GT.BO.Entities;
using System;
using GT.Common.Types;
using GT.Common.Data;

namespace GT.DA.UserRating
{
    public static class UserRatingDataAdapter
    {
        private static class ProcNames
        {
            public const string Add = "p_UserRating_AddFeedback";
            public const string GetById = "p_UserRating_GetFeedbackById";
            public const string Search = "p_UserRating_SearchFeedbacks";
            public const string GetUnusedForUser = "p_UserRating_GetUnusedFeedbacksForUser";
            public const string GetUnusedBySellingId = "p_UserRating_GetUnusedBySellingIdAndUserId";
        }

        public static DataRow AddFeedback(BaseEntity v)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.Add))
            {
                DB.Gt.AddInParameter(cmd, "@Feedback", DbType.Xml, v.ToXmlString());
                return DB.Gt.ExecuteDataSet(cmd).Tables[0].Rows[0];
            }
        }

        public static DataRow GetFeedbackById(int voteId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetById))
            {
                DB.Gt.AddInParameter(cmd, "@FeedbackId", DbType.Int32, voteId);
                return DB.Gt.ExecuteDataSet(cmd).Tables[0].Rows[0];
            }
        }

        public static DataTable SearchFeedbacks(BaseEntity filter)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.Search))
            {
                DB.Gt.AddInParameter(cmd, "@Filter", DbType.Xml, filter.ToXmlString());
                return DB.Gt.ExecuteDataSet(cmd).Tables[0];
            }
        }

        public static DataTable GetUnusedForUser(Guid userId)
        {
          using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetUnusedForUser))
          {
            DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, userId);
            var data = DB.Gt.ExecuteDataSet(cmd).Tables[0];
            return data;
          }
        }


        public static DataRow GetUnusedBySellingIdAndUserId(int sellingId, Guid userId)
        {
          using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetUnusedBySellingId))
          {
            DB.Gt.AddInParameter(cmd, "@SellingId", DbType.Int32, sellingId);
            DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, userId);
            return DB.Gt.ExecuteDataRow(cmd);
          }
        }
    }
}
