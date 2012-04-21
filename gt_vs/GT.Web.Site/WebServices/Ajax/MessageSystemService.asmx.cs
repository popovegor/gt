
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;
using System.Xml;
using GT.BO.Implementation.MessageSystem;
using GT.BO.Implementation.Users;
using GT.Common;
using GT.Common.Exceptions;
using GT.Common.Xml.Xsl;
using GT.DA.MessageSystem;
using GT.Global.MessageSystem;
using GT.Global.Security;
using GT.Web.Services;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.DA.MessageSystemystem;
using GT.Web.Security;
using GT.Web.Site.HtmlTemplates;
using GT.Web.UI.HtmlTemplateSystem;
using System.Net.Mail;
using GT.Common.Net.Mail;

namespace GT.Web.Site.WebServices.Ajax
{
  /// <summary>
  /// Summary description for Messages
  /// </summary>
  [WebService(Namespace = "http://gameismoney.ru/")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [ToolboxItem(false)]
  [ScriptService]
  [GenerateScriptType(typeof(MessageSearchFilter))]
  [GenerateScriptType(typeof(Message))]
  public class MessageSystemService : BaseWebService
  {

    [WebMethod]
    [ScriptMethod]
    public string DeleteMessage(Message message)
    {
      string result = string.Empty;
      if (null != message)
      {
        try
        {
          message.RecipientId = Credentials.UserId;
          MessageFacade.Delete(message);
          result = string.Empty;
        }
        catch (Exception e)
        {
          throw e;
        }
      }
      else
      {
        throw new NullReferenceException();
      }
      return result;
    }

    [WebMethod]
    [ScriptMethod]
    public string ReadMessage(Message message)
    {
      string result = string.Empty;
      if (null != message)
      {
        try
        {
          message.RecipientId = Credentials.UserId;
          MessageFacade.Read(message);
          result = string.Empty;
          //TODO: return more readable information about execution of this operation, since the empty string is not good result
        }
        catch (Exception e)
        {
          throw e;
        }
      }
      else
      {
        throw new NullReferenceException();
      }
      return result;
    }

    [WebMethod]
    [ScriptMethod]
    public Message AddMessage(Guid recipient, string body)
    {
      var result = new Message();
      try
      {
        if (recipient != Guid.Empty
            && false == string.IsNullOrEmpty(body))
        {
          var r = UsersFacade.GetUser(recipient);
          if (r != null)
          {
            try
            {
              Message m = new Message();
              m.RecipientId = r.UserId();
              m.SenderId = Credentials.UserId;
              m.Body = body;
              result = MessageFacade.Add(m);
              //result = CommonResources.AddMessageSuccess;
            }
            catch (Exception e)
            {
              throw AssistLogger.Log<ExceptionHolder>(e);
            }
          }
          else
          {
            throw AssistLogger.Log<ExceptionHolder>(new Exception(
                string.Format(CommonResources.AddMessageNoRecipient, recipient)));
          }
        }
        else
        {
          throw AssistLogger.Log<ExceptionHolder>(new Exception(CommonResources.AddMessageFieldParams));
        }
      }
      catch (Exception)
      {
        //result = CommonResources.ActionFailure;
      }
      return result;
    }

    [WebMethod]
    [ScriptMethod]
    public string GetMessages(MessageSearchFilter contextKey, out int count)
    {
      count = 0;
      string result = CommonResources.NoMessages;
      if (contextKey != null)
      {
        contextKey.RecipientId = Credentials.UserId;
        DataTable messages = MessageFacade.Search(contextKey);
        if (messages != null && messages.Rows.Count > 0)
        {
          count = messages.Rows.Count;
          messages.TableName = "Message";
          XmlDocument xml = new XmlDocument();
          using (XmlReader xr = XmlReader.Create(Server.MapPath("~/XsltTemplates/Messages/View.xslt")))
          {
            xml.Load(xr);
          }
          result = XslTransformationHelper.Transform(messages, null, xml);
        }
      }
      return result;
    }

    [WebMethod]
    [ScriptMethod]
    public Dictionary<Guid, string> GetSenderList()
    {
      Dictionary<Guid, string> senders = new Dictionary<Guid, string>();
      DataTable dt = MessageDataAdapter.GetSenders(Credentials.UserId);
      //dt.Rows.Add(MessageSenders.DefaultListItem.Key, MessageSenders.DefaultListItem.Value);
      foreach (DataRow sender in dt.Select(string.Empty, string.Format("{0} asc", MessageFields.SenderName)))
      {
        if ((Guid)sender[MessageFields.SenderId] != MembershipSettings.SystemUserKey)
        {
          senders.Add((Guid)sender[MessageFields.SenderId], sender[MessageFields.SenderName].ToString());
        }
      }
      return senders;
    }

    [WebMethod]
    [ScriptMethod]
    public SortedDictionary<string, Guid> GetRecipientList(Guid[] excludeUserIds)
    {
      SortedDictionary<string, Guid> recipients = new SortedDictionary<string, Guid>();
      foreach (MembershipUser u in Membership.GetAllUsers())
      {
        Guid userId = (Guid)u.ProviderUserKey;
        if (excludeUserIds != null
            && false == Array.Exists<Guid>(excludeUserIds, delegate(Guid id) { return id == userId; }))
        {
          recipients.Add(u.UserName, userId);
        }
      }
      return recipients;
    }

    [WebMethod(CacheDuration = 0)]
    public string[] GetRecipientList(string prefixText, int count)
    {
      string currentUserName = Credentials.UserName;
      List<string> result = new List<string>();
      foreach (var u in UsersFacade.GetAllUsers())
      {
        if (currentUserName != u.UserName
            && u.UserName.StartsWith(prefixText, StringComparison.InvariantCultureIgnoreCase))
        {
          result.Add(u.UserName);
          if (--count <= 0)
          {
            break;
          }
        }
      }
      return result.Count > 0 ? result.ToArray() : new string[] { CommonResources.NoRecipientsFound };
    }

    [WebMethod]
    [ScriptMethod]
    public string GetUnreadMessages(MessageSearchFilter contextKey)
    {
      string result = CommonResources.NoUnreadMessages;
      if (contextKey != null)
      {
        contextKey.RecipientId = Credentials.UserId;
        contextKey.UnreadOnly = true;
        DataTable messages = MessageFacade.Search(contextKey);
        if (messages != null && messages.Rows.Count > 0)
        {
          messages.TableName = "Message";
          XmlDocument xml = new XmlDocument();
          using (XmlReader xr
              = XmlReader.Create(Server.MapPath("~/XsltTemplates/Messages/Unread.xslt")))
          {
            xml.Load(xr);
          }
          result = XslTransformationHelper.Transform(messages, null, xml);
        }
      }
      return result;
    }
  }
}
