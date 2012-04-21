using System;
using System.Data;
using System.Data.Common;
using GT.BO.Entities;

namespace GT.DA.Messages
{
    public static class MessageDataAdapter
    {

        private const string SearchMessagesProcName = "p_Messages_SearchMessages";
        private const string GetSendersProcName = "p_Messages_GetMessageSenders";
        private const string GetCorrespondenceProcName = "p_Messages_GetCorrespondence";
        private const string AddProcName = "p_Messages_AddMessage";
        private const string DeleteProcName = "p_Messages_DeleteMessage";
        private const string ReadProcName = "p_Messages_ReadMessage";

        [Obsolete]
        public static DataTable GetCorrespondence(Guid firstUserId, Guid secondUserId)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetCorrespondenceProcName))
            {
                if (firstUserId != Guid.Empty && secondUserId != Guid.Empty)
                {
                    DB.Gt.AddInParameter(cmd, "@FisrtUserId", DbType.Guid, firstUserId);
                    DB.Gt.AddInParameter(cmd, "@SecondUserId", DbType.Guid, secondUserId);
                }
                else
                {
                    throw new NullReferenceException();
                }
                DataSet ds = DB.Gt.ExecuteDataSet(cmd);
                return ds != null && ds.Tables.Count > 0 ? ds.Tables[0] : null;
            }
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
    }
}
