using System;
using System.Data;
using GT.Global.Security;
using GT.DA.MessageSystem;
using System.Collections.Generic;
using GT.Common.Types;
using GT.DA.MessageSystemystem;
using GT.Common.Collections;
using GT.BO.Implementation.Notification;

namespace GT.BO.Implementation.MessageSystem
{
  public static class MessageFacade
  {
    //set it in the global.asax for this web application
    public static INotificationSender NotificationSender { get; set; }

    private static void SendNotification(Message m)
    {
      if (NotificationSender != null)
      {
        NotificationSender.Send(m);
      }
    }

    public static Message AddFromSystemUser(Message m)
    {
      m.SenderId = MembershipSettings.SystemUserKey;
      var mail = new Message().Load<Message>(MessageDataAdapter.Add(m));
      if (mail != null)
      {
        SendNotification(mail);
      }
      return mail;
    }

    public static Message Add(Message m)
    {
      var mail = new Message().Load<Message>(MessageDataAdapter.Add(m));
      if (mail != null)
      {
        SendNotification(mail);
      }
      return mail;
    }

    public static DataTable Search(MessageSearchFilter filter)
    {
      return MessageDataAdapter.Search(filter);
    }

    public static SortedDictionary<int, SortedList<DateTime, Message>> GetConversations(Guid user, int messageCount)
    {
      DataTable dt = MessageDataAdapter.GetConversations(user, messageCount);
      var messageComparer = new SortHelper.ComparerDesc<DateTime>();
      var conversationComparer = new SortHelper.ComparerDesc<int>();
      var conversations = new SortedDictionary<int, SortedList<DateTime, Message>>(conversationComparer);
      if (dt != null)
      {
        foreach (var dr in dt.Select())
        {
          var msg = new Message().Load<Message>(dr);
          var conversationId = TypeConverter.ToInt32(dr[MessageFields.ConversationId]);
          if (false == conversations.ContainsKey(conversationId))
          {
            conversations.Add(conversationId, new SortedList<DateTime, Message>(messageComparer));
          }
          conversations[conversationId].Add(msg.CreateDate, msg);
        }
      }
      return conversations;
    }

    public static Message[] GetConversation(Guid userX, Guid userY)
    {
      DataTable dt = MessageDataAdapter.GetConversation(userX, userY);
      if (dt != null)
      {
        return Array.ConvertAll<DataRow, Message>(dt.Select(), dr => new Message().Load<Message>(dr));
      }
      else
      {
        return new Message[] { };
      }
    }

    public static Message[] SearchAsCollection(MessageSearchFilter filter)
    {
      var dt = Search(filter);
      if (null != dt)
      {
        return Array.ConvertAll<DataRow, Message>(dt.Select(), dr => new Message().Load<Message>(dr));
      }
      else
      {
        return new Message[] { };
      }
    }

    public static void ReadAll(Guid userId)
    {
      MessageDataAdapter.ReadAll(userId);
    }

    public static Message Read(Message m)
    {
      return new Message().Load<Message>(MessageDataAdapter.Read(m));
    }

    public static Message Delete(Message m)
    {
      return new Message().Load<Message>(MessageDataAdapter.Delete(m));
    }

    [Obsolete]
    public static Message[] GetCorrespondenceAsCollection(Guid user1Id, Guid user2Id)
    {
      //var dt = GetCorrespondence(user1Id, user2Id);
      //if (dt != null)
      //{
      //  return Array.ConvertAll<DataRow, Message>(dt.Select(), dr => new Message().Load<Message>(dr));
      //}
      //else
      //{
      //  return new Message[] { };
      //}
      throw new NotImplementedException();
    }

    [Obsolete]
    public static DataTable GetCorrespondence(Guid user1Id, Guid user2Id)
    {
      //return MessageDataAdapter.GetCorrespondence(user1Id, user2Id);
      throw new NotImplementedException();
    }
  }
}
