using System;
using System.Web.UI.WebControls;
using GT.BO.Implementation.MessageSystem;
using GT.Common.Types;
using GT.Global.MessageSystem;
using GT.Web.Site.WebServices.Ajax;
using GT.Web.UI.Pages;
using System.Data;

namespace GT.Web.Site.MessageSystem
{
  public partial class MessageViewer : BasePage
  {
    protected const string DateFormat = "yyyy.MMMM.dd";

    protected const int DefaultCount = 50;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void gvMessages_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      if (e != null && e.Row.DataItem != null && e.Row.RowType == DataControlRowType.DataRow)
      {
        var m = e.Row.DataItem as Message;
        if (m != null)
        {
          e.Row.Attributes["id"] = string.Format("message{0}", m.MessageId);
        }
      }
    }

    protected void gvMessages_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      gvMessages.PageIndex = e.NewPageIndex;
    }

    protected Message[] Messages
    {
      get
      {
        var filter = new MessageSearchFilter(FromSender, Credentials.UserId, UnreadOnly, Count);
        return MessageFacade.SearchAsCollection(filter);
      }
    }

    protected int Count
    {
      get
      {
        return TypeConverter.ToInt32(Request.QueryString[MessageFilterParams.Count], DefaultCount);
      }
    }

    protected bool UnreadOnly
    {
      get
      {
        return TypeConverter.ToBool(Request.QueryString[MessageFilterParams.UnreadOnly]);
      }
    }

    protected Guid FromSender
    {
      get
      {
        if (Request.QueryString[MessageFilterParams.FromSender] is string)
        {
          string fromSender = Request.QueryString[MessageFilterParams.FromSender];
          return true == string.IsNullOrEmpty(fromSender)
              ? MessageSenders.DefaultListItem.Key
              : new Guid(fromSender);
        }
        else
        {
          return MessageSenders.DefaultListItem.Key;
        }
      }
    }

    protected override void OnPreRender(EventArgs e)
    {
      base.OnPreRender(e);

      DataBind();

      //select sender
      ddlSenderList.Items.Add(new ListItem(string.Concat("[", Resources.CommonResources.All, "]"), Guid.Empty.ToString()));
      ddlSenderList.ClearSelection();
      foreach (ListItem s in ddlSenderList.Items)
      {
        if (TypeConverter.ToString(FromSender).Equals(s.Value, StringComparison.InvariantCultureIgnoreCase))
        {
          s.Selected = true;
          break;
        }
      }

      //select last
      ddlCount.ClearSelection();
      foreach (ListItem s in ddlCount.Items)
      {
        if (TypeConverter.ToString(Count).Equals(s.Value, StringComparison.InvariantCultureIgnoreCase))
        {
          s.Selected = true;
          break;
        }
      }
    }
  }
}
