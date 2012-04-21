using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.MessageSystem;
using System.Web.Security;

namespace GT.Web.Site.HtmlTemplates
{
  public partial class NewMessageNotification : System.Web.UI.UserControl
  {
  
    public string SenderName
    {
      get
      {
        var u =  Membership.GetUser(SenderId);
        return u != null ? u.UserName : string.Empty;
      }
    }
  
    public Guid SenderId {get; set;}
    
    public Guid RecipientId {get; set;}
  
    protected void Page_Load(object sender, EventArgs e)
    {
    }
  }
}