using System;
using System.Data.Common;
using System.Data.SqlClient;
using GT.Common;
using GT.Common.Exceptions;
using GT.DA.Properties;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GT.DA
{
  /// <summary>
  /// Summary description for DBUtils.
  /// </summary>
  public static class DBUtils
  {
    public static string EscapeWildcards(string p_sInput)
    {
      return p_sInput.Replace("%", "[%]").Replace("_", "[_]");
    }

    public static void LogSqlNotificationData(SqlNotificationEventArgs p_args, Type p_type)
    {
      if (p_args != null)
      {
        string sMessage = string.Format(
            "SqlNotification received.\n\tNotification Info: {0}\n\tNotification Source: {1}\n\tNotification Type: {2}\nEntity:{3}\n",
            p_args.Info, p_args.Source,
            p_args.Type, p_type.FullName);

        if (p_args.Info == SqlNotificationInfo.Invalid ||
            p_args.Info == SqlNotificationInfo.Error ||
            p_args.Info == SqlNotificationInfo.Options ||
            p_args.Info == SqlNotificationInfo.Resource ||
            p_args.Info == SqlNotificationInfo.TemplateLimit ||
            p_args.Info == SqlNotificationInfo.Unknown)
          AssistLogger.WriteInformation(
              sMessage, AssistLogger.Category.Database);
        AssistLogger.WriteDebugInformation(sMessage, "Sql Notification");
      }
    }

    internal static DateTime GetCurrentDateTime(Database db)
    {
      try
      {
        using (DbCommand cmd = db.GetSqlStringCommand(Resources.GetDatabaseCurrentDateTime))
        {
          return (DateTime)db.ExecuteScalar(cmd);
        }
      }
      catch (Exception e)
      {
        AssistLogger.Log<ExceptionHolder>(e);
        return DateTime.Now;
      }
    }
  }
}
