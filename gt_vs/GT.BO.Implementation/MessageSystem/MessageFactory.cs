using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.Global.MessageSystem;
using System.Data;
using GT.DA.Dictionaries;
using GT.Common.Text;
using GT.Common.Types;

namespace GT.BO.Implementation.MessageSystem
{
  public static class MessageFactory
  {
    public static Message CreateByTemplate(MessageTemplate template
      , Guid recipient, string[] subjectParams, string[] bodyParams)
    {
      return CreateByTemplate(template, Guid.Empty, recipient, subjectParams, bodyParams);
    }

    public static Message CreateByTemplate(MessageTemplate template, Guid sender
      , Guid recipient, string[] subjectParams, string[] bodyParams)
    {
      Message msg = new Message
      {
        SenderId = sender,
        RecipientId = recipient,
        Unread = true,
        CreateDate = DateTime.Now
      };
      var t = Dictionaries.Instance.GetMessageTemplate(template);
      msg.Body = StringUtils.Format(TypeConverter.ToString(t[MessageTemplateFields.Body]), bodyParams);
      msg.BodyRu = StringUtils.Format(TypeConverter.ToString(t[MessageTemplateFields.BodyRu]), bodyParams);
      return msg;
    }

    public static Message Create(Guid sender, Guid recipient, string subject, string body)
    {
      Message msg = new Message
      {
        SenderId = sender,
        RecipientId = recipient,
        Body = body,
        CreateDate = DateTime.Now,
        Unread = true
      };
      return msg;
    }
  }
}
