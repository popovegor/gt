using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.MessageSystem;
using GT.Web.UI.Controls;
using GT.Web.Site.WebServices.Ajax;

namespace GT.Web.Site.Users
{
  public partial class UserConversation : BaseControl
  {
    public Guid UserId
    { get; set; }

    private Lazy<Message[]> _msgs = new Lazy<Message[]>(() => new Message[] { }, true);
    protected Message[] Messages
    {
      get
      {
        return _msgs.Value;
      }
    }

    protected static class ValidationGroupNames
    {
      public const string NewMessage = "NewMessage";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected override void Page_Init(object sender, EventArgs e)
    {
      _msgs = new Lazy<Message[]>(()
       => MessageFacade.GetConversation(UserId, Credentials.UserId));
       base.Page_Init(sender, e);
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
      var text = txtBody.Text;
      Page.Validate(ValidationGroupNames.NewMessage);
      if (Page.IsValid)
      {
        var srv = new MessageSystemService();
        srv.AddMessage(UserId, text);
        txtBody.Text = string.Empty;
        Response.Redirect(Request.RawUrl, true);
      }
    }

    protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      (sender as GridView).PageIndex = e.NewPageIndex;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      if (e != null
        && e.Row.DataItem != null
        && e.Row.RowType == DataControlRowType.DataRow)
      {
        var count = ((sender as GridView).DataSource as Message[]).Count();
        var pageSize = (sender as GridView).PageSize;
        /*if (e.Row.RowIndex != pageSize - 1
          && e.Row.DataItemIndex != count - 1)
        {
          e.Row.CssClass += "row separator";
        }*/
        e.Row.Attributes.Add("msg", string.Format("{0}", (e.Row.DataItem as Message).MessageId));
      }
    }
  }
}