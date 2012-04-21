using System;
using System.Data;
using System.Data.Common;
using GT.BO.Entities;
using System.Diagnostics;

namespace GT.DA.MessageSystem
{
  public static class MessageDataAdapter
  {

    private static class ProcNames
    {
      public const string GetConverstion = "p_MessageSystem_GetConversation";
      public const string GetConverstions = "p_MessageSystem_GetConversations";
      public const string ReadAll = "p_MessageSystem_ReadAll";
    }

    private const string SearchMessagesProcName = "p_MessageSystem_SearchMessages";
    private const string GetSendersProcName = "p_MessageSystem_GetMessageSenders";

    private const string AddProcName = "p_MessageSystem_AddMessage";
    private const string DeleteProcName = "p_MessageSystem_DeleteMessage";
    private const string ReadProcName = "p_MessageSystem_ReadMessage";

    [Obsolete]
    public static DataTable GetCorrespondence(Guid firstUserId, Guid secondUserId)
    {
      //using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetCorrespondenceProcName))
      //{
      //  if (firstUserId != Guid.Empty && secondUserId != Guid.Empty)
      //  {
      //    DB.Gt.AddInParameter(cmd, "@FirstUserId", DbType.Guid, firstUserId);
      //    DB.Gt.AddInParameter(cmd, "@SecondUserId", DbType.Guid, secondUserId);
      //  }
      //  else
      //  {
      //    return null;
      //  }
      //  DataSet ds = DB.Gt.ExecuteDataSet(cmd);
      //  return ds != null && ds.Tables.Count > 0 ? ds.Tables[0] : null;
      //}
      throw new NotSupportedException();
    }

    public static DataTable GetSenders(Guid recipientId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetSendersProcName))
      {
        if (recipientId != Guid.Empty)
        {
          DB.Gt.AddInParameter(cmd, "@RecipientId", DbType.Guid, recipientId);
        }
        else
        {
          throw new NullReferenceException();
        }
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        return ds != null && ds.Tables.Count > 0 ? ds.Tables[0] : null;
      }
    }

    public static DataRow Read(BaseEntity message)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ReadProcName))
      {
        DB.Gt.AddInParameter(cmd, "@Message", DbType.Xml, message.ToXmlString());
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        return ds.Tables[0].Rows[0];
      }
    }

    public static DataRow Add(BaseEntity message)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(AddProcName))
      {
        DB.Gt.AddInParameter(cmd, "@Message", DbType.Xml, message.ToXmlString());
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        return ds.Tables[0].Rows[0];
      }
    }

    [Obsolete]
    public static DataTable Search(BaseEntity filter)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(SearchMessagesProcName))
      {
        DB.Gt.AddInParameter(cmd, "@Filter", DbType.Xml, filter.ToXmlString());
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        return ds != null && ds.Tables.Count > 0 ? ds.Tables[0] : null;
      }
    }

    public static DataRow Delete(BaseEntity message)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(DeleteProcName))
      {
        DB.Gt.AddInParameter(cmd, "@Message", DbType.Xml, message.ToXmlString());
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        return ds.Tables[0].Rows[0];
      }
    }

    public static DataTable GetConversation(Guid userX, Guid userY)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetConverstion))
      {
        if (userX != Guid.Empty && userY != Guid.Empty)
        {
          DB.Gt.AddInParameter(cmd, "@UserX", DbType.Guid, userX);
          DB.Gt.AddInParameter(cmd, "@UserY", DbType.Guid, userY);
        }
        else
        {
          return null;
        }
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        return ds != null && ds.Tables.Count > 0 ? ds.Tables[0] : null;
      }
    }

    public static DataTable GetConversations(Guid user, int messagesInConversation)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.GetConverstions))
      {
        if (user != Guid.Empty)
        {
          DB.Gt.AddInParameter(cmd, "@User", DbType.Guid, user);
          DB.Gt.AddInParameter(cmd, "@MessageInConversation", DbType.Int32, messagesInConversation);
        }
        else
        {
          return null;
        }
        DataSet ds = DB.Gt.ExecuteDataSet(cmd);
        return ds != null && ds.Tables.Count > 0 ? ds.Tables[0] : null;
      }
    }

    public static void ReadAll(Guid userId)
    {
      using (DbCommand cmd = DB.Gt.GetStoredProcCommand(ProcNames.ReadAll))
      {
        DB.Gt.AddInParameter(cmd, "@UserId", DbType.Guid, userId);
        DB.Gt.ExecuteNonQuery(cmd);
      }
    }
  }
}
