using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using GT.BO.Implementation.MessageSystem;
using GT.BO.Implementation.Test.Users;
using GT.BO.Implementation.Users;
using GT.Global.Security;
using NUnit.Framework;
using GT.Global.MessageSystem;
using GT.Web.Security.Test;
using System.Web.Security;
using GT.Web.Security;

namespace GT.BO.Implementation.Test.MessageSystem
{
  [TestFixture]
  public class MessageFacadeTestFixture
  {
    [TestAttribute]
    [Explicit]
    public void TestGetCorrespondence()
    {
      var user1Id = (Guid)CustomMembershipProviderTestFixture.CreateRandomUser().ProviderUserKey;
      var user2Id = (Guid)CustomMembershipProviderTestFixture.CreateRandomUser().ProviderUserKey;

      for (int i = 0; i < 5; i++)
      {
        var m1to2 = CreateMessage(user1Id, user2Id);
        MessageFacade.Add(m1to2);
      }
      for (int i = 0; i < 10; i++)
      {
        var m2to1 = CreateMessage(user2Id, user1Id);
        MessageFacade.Add(m2to1);
      }
      Message[] cor = MessageFacade.GetCorrespondenceAsCollection(user1Id, user2Id);
      Assert.AreEqual(15, cor.Length);
      var prevMessageData = DateTime.MaxValue;
      foreach (var m in cor)
      {
        Assert.GreaterOrEqual(prevMessageData, m.CreateDate);
        Assert.IsTrue(m.SenderId == user1Id || m.RecipientId == user1Id);
        Assert.IsTrue(m.SenderId == user2Id || m.RecipientId == user2Id);
        Assert.IsTrue(m.Unread);
        Assert.IsFalse(m.Deleted);
        prevMessageData = m.CreateDate;
      }
    }

    [TestAttribute]
    public void TestSearchUnreadMessages()
    {
      MessageSearchFilter msf = new MessageSearchFilter();
      msf.UnreadOnly = true;
      msf.Count = 2;
      DataTable messages = MessageFacade.Search(msf);
      Assert.IsNotNull(messages);
      Assert.GreaterOrEqual(messages.Rows.Count, 1);
      Assert.LessOrEqual(messages.Rows.Count, msf.Count);
      foreach (DataRow dr in messages.Rows)
      {
        Message m = new Message();
        m.Load<Message>(dr);
        Assert.IsTrue(m.Unread);
      }
    }

    [TestAttribute]
    public void TestSearchSystemUserMessages()
    {
      MessageSearchFilter msf = new MessageSearchFilter();
      msf.SenderId = MembershipSettings.SystemUserKey;
      msf.Count = 5;
      DataTable messages = MessageFacade.Search(msf);
      Assert.IsNotNull(messages);
      Assert.GreaterOrEqual(messages.Rows.Count, 1);
      Assert.LessOrEqual(messages.Rows.Count, msf.Count);
      foreach (DataRow dr in messages.Rows)
      {
        Message m = new Message();
        m.Load<Message>(dr);
        Assert.AreEqual(MembershipSettings.SystemUserKey, m.SenderId);
      }
    }

    //[TestAttribute]
    //public void TestSearchDeletedMessages()
    //{
    //    MessageSearchFilter msf = new MessageSearchFilter();
    //    msf.DeletedOnly = true;
    //    DataTable messages = MessageManager.Search(msf);
    //    Assert.IsNotNull(messages);
    //    Assert.GreaterOrEqual(messages.Rows.Count, 1);
    //    foreach (DataRow dr in messages.Rows)
    //    {
    //        Message m = new Message();
    //        m.Load<Message>(dr);
    //        Assert.IsTrue(m.Deleted);
    //    }
    //}

    [TestAttribute]
    public void TestReadMessage()
    {
      MessageSearchFilter msf = new MessageSearchFilter();
      msf.UnreadOnly = true;
      Message m = CreateMessage();
      MessageFacade.Add(m);
      DataTable messages = MessageFacade.Search(msf);
      Assert.IsNotNull(messages);
      Assert.GreaterOrEqual(messages.Rows.Count, 1);

      m = new Message();
      m.Load(messages.Rows[0]);

      Message newNessage = MessageFacade.Read(m);
      Assert.AreEqual(newNessage.MessageId, m.MessageId);

      Trace.WriteLine(m.ToXmlString());

    }

    [TestAttribute]
    public void TestDelete()
    {
      Message m = CreateMessage();
      Message newMessage = MessageFacade.AddFromSystemUser(m);
      Message delMessage = MessageFacade.Delete(newMessage);
      Assert.IsTrue(delMessage.Deleted);
      Trace.WriteLine(string.Format("The deleted message ID : {0}", delMessage.MessageId));
    }

    [TestAttribute]
    public void TestAddFromSystemUser()
    {
      Message m = CreateMessage();
      Message newMessage = MessageFacade.AddFromSystemUser(m);
      Assert.GreaterOrEqual(newMessage.MessageId, 0);
      Assert.AreEqual(MembershipSettings.SystemUserKey, newMessage.SenderId);
      Trace.WriteLine(string.Format("The added system message ID : {0}", newMessage.MessageId));
    }

    [TestAttribute]
    public void TestAddMessage()
    {
      Message m = CreateMessage();
      Message newMessage = MessageFacade.Add(m);
      Assert.GreaterOrEqual(newMessage.MessageId, 0);
      Trace.WriteLine(string.Format("The added message ID : {0}", newMessage.MessageId));
    }

    [TestAttribute]
    public void TestAddTemplateMessage()
    {
      var m = CreateTemplateMessage();
      var nm = MessageFacade.Add(m);
      Assert.GreaterOrEqual(nm.MessageId, 0);
      Assert.IsTrue(m.Compare(nm));
    }

    private Message CreateTemplateMessage()
    {
      var users = UsersFacadeHelper.GetPairRandomUsers();
      return MessageFactory.CreateByTemplate(MessageTemplate.SellingAccepted,
        users.Key.UserId(), users.Value.UserId(), null, new[] { "test user", "test offer" });
    }

    public static Message CreateMessage()
    {
      var users = UsersFacadeHelper.GetPairRandomUsers();
      return CreateMessage(users.Key.UserId(), users.Value.UserId());
    }

    private static Message CreateMessage(Guid senderId, Guid recipientId)
    {
      Guid messageUniqueId = Guid.NewGuid();
      Message m = new Message();
      m.SenderId = senderId;
      m.RecipientId = recipientId;
      //m.Subject = string.Format("test message {0}", messageUniqueId);
      m.Body = string.Format("test body {0}", messageUniqueId);
      m.CreateDate = DateTime.Now;
      m.Unread = true;
      return m;
    }
  }
}
