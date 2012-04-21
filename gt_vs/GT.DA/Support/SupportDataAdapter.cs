using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using GT.BO.Entities;
using System.Data;
using GT.Common.Data;

namespace GT.DA.Support
{
  public static class SupportDataAdapter
  {
    private static class ProcNames
    {
      public const string AddFeedback = "p_Support_AddFeedback";
      public const string GetFeedbackById = "p_Support_GetFeedbackById";
    }

    public static DataRow AddFeedback(BaseEntity feedback)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.AddFeedback))
      {
        DB.Gt.AddInParameter(cmd, "@Feedback", DbType.Xml, feedback.ToXmlString());
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }

    public static DataRow GetFeedbackById(int feedbackId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetFeedbackById))
      {
        DB.Gt.AddInParameter(cmd, "@FeedbackId", DbType.Int32, feedbackId);
        return DB.Gt.ExecuteDataRow(cmd);
      }
    }

  }
}
