using System;
using GT.Web.UI.Pages;
using GT.Global.MessageSystem;

namespace GT.Web.Site.MessageSystem
{
    public partial class AddMessage : BaseEditPage
    {
        protected Guid RecipientId
        {
          get
          {
            return new Guid(Request.QueryString[AddMessageParams.Recipient]);
          }
        }
    
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected override void OnPreRender(EventArgs e)
        {
          base.OnPreRender(e);
          DataBind();
        }
    }
}
