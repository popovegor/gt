using System;
using System.ComponentModel;
using System.Xml.Serialization;
using GT.BO.Entities;
using GT.DA.MessageSystem;
using GT.Global.MessageSystem;
using GT.Global.Localization;
using GT.DA.MessageSystemystem;

namespace GT.BO.Implementation.MessageSystem
{
  [XmlRoot("m")]
  public class Message : BaseEntity
  {
    [XmlAttribute("mid")]
    [BaseSourceMapping(MessageFields.MessageId)]
    [DefaultValue(0)]
    public int MessageId
    {
      get;
      set;
    }

    [XmlAttribute("sid")]
    [BaseSourceMapping(MessageFields.SenderId)]
    [BaseComparable]
    public Guid SenderId
    {
      get;
      set;
    }

    [BaseSourceMapping(MessageFields.RecipientId)]
    [XmlAttribute("rid")]
    [BaseComparable]
    public Guid RecipientId
    {
      get;
      set;
    }

    [XmlAttribute("b")]
    [BaseSourceMapping(MessageFields.Body)]
    [DefaultValue("")]
    [BaseComparable]
    public string Body
    {
      get;
      set;
    }

    [XmlAttribute("bru")]
    [BaseSourceMapping(MessageFields.BodyRu)]
    [DefaultValue("")]
    [BaseComparable]
    public string BodyRu
    {
      get;
      set;
    }

    [XmlIgnore]
    [BaseComparable]
    public string LocalizedBody
    {
      get
      {
        return Localizator.GetLocalizedProperty(Body, BodyRu, string.Empty);
      }
    }

    [XmlAttribute("cd")]
    [BaseSourceMapping(MessageFields.CreateDate)]
    public DateTime CreateDate
    {
      get;
      set;
    }

    [XmlAttribute("ur")]
    [BaseSourceMapping(MessageFields.Unread)]
    [DefaultValue(true)]
    [BaseComparable]
    public bool Unread
    {
      get;
      set;
    }

    [XmlAttribute("del")]
    [BaseSourceMapping(MessageFields.Deleted)]
    [DefaultValue(false)]
    [BaseComparable]
    public bool Deleted
    {
      get;
      set;
    }

    public override int Id
    {
      get { return MessageId; }
      set { MessageId = value; }
    }

    public Message()
    { }
  }
}
