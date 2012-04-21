using System;
using System.Xml.Serialization;
using GT.BO.Entities;

namespace GT.BO.Implementation.MessageSystem
{
  [XmlRoot("f")]
  public class MessageSearchFilter : BaseEntity
  {
    [XmlAttribute("rid")]
    public Guid RecipientId = Guid.Empty;

    [XmlAttribute("sid")]
    public Guid SenderId = Guid.Empty;

    [XmlAttribute("uo")]
    public bool UnreadOnly = false;

    [XmlAttribute("c")]
    public int Count = int.MaxValue;

    public MessageSearchFilter()
    { }

    public MessageSearchFilter(Guid senderId, bool unreadOnly, int count)
    {
      SenderId = senderId;
      UnreadOnly = unreadOnly;
      Count = count;
    }

    public MessageSearchFilter(Guid senderId, Guid recipientId, bool unreadOnly, int count)
    {
      SenderId = senderId;
      UnreadOnly = unreadOnly;
      RecipientId = recipientId;
      Count = count;
    }

    public MessageSearchFilter(Guid recipientId, int count)
    {
      RecipientId = recipientId;
      Count = count;
    }

    public override int Id
    {
      get
      {
        return 0;
      }
      set
      {
        ;
      }
    }
  }
}
