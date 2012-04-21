using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Pages;
using GT.BO.Implementation.MessageSystem;
using GT.Global.MessageSystem;
using GT.Common.Types;
using GT.Web.UI.Controls;
using GT.BO.Implementation.Users;

namespace GT.Web.Site.MessageSystem
{
  public partial class MessageViewer2 : BasePage
  {

    private Lazy<Message[]> _in = null;
    protected Message[] InMessages { get { return _in.Value; } }

    private Lazy<Message[]> _out = null;
    protected Message[] OutMessages { get { return _out.Value; } }
    
    public UserDynamics Dynamics
    {get;set;}

    public MessageType Direction
    {
      get
      {
        return TypeConverter.ToEnumMember<MessageType>(
          Request.QueryString[MessageFilterParams.Direction], MessageType.None);
      }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
      _in = new Lazy<Message[]>(() =>
        {
          var f = new MessageSearchFilter() { RecipientId = Credentials.UserId };
          return MessageFacade.SearchAsCollection(f);
        }
        , true);
      _out = new Lazy<Message[]>(() =>
        {
          var f = new MessageSearchFilter() { SenderId = Credentials.UserId };
          return MessageFacade.SearchAsCollection(f);
        }
      , true);
      if (Direction == MessageType.In)
      {
        MessageFacade.ReadAll(Credentials.UserId);
      } 
      
      Dynamics = UsersFacade.GetDynamicsForUser(Credentials.UserId);
      
      gv.RowDataBound += new GridViewRowEventHandler(ControlHelper.RowDataBound);
      gv.PageIndexChanging += new GridViewPageEventHandler(ControlHelper.PageIndexChanging);
    }

    protected Guid GetTargetUser(Message msg)
    {
      return Direction == MessageType.In
        ? msg.SenderId : Direction == MessageType.Out
          ? msg.RecipientId : Guid.Empty;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    /*protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      if (e != null
        && e.Row.DataItem != null
        && e.Row.RowType == DataControlRowType.DataRow)
      {
        var count = ((sender as GridView).DataSource as Message[]).Count();
        var pageSize = (sender as GridView).PageSize;
        if (e.Row.RowIndex != pageSize - 1
          && e.Row.DataItemIndex != count - 1)
        {
          e.Row.CssClass += "row separator";
        }
        e.Row.Attributes.Add("msg", string.Format("{0}", (e.Row.DataItem as Message).MessageId));
      }
    }*/

    //protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //  (sender as GridView).PageIndex = e.NewPageIndex;
    //}

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }
  }
}
