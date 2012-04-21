using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Support;

namespace GT.Web.Site.Support
{
  public partial class Feedback : System.Web.UI.UserControl
  {
    protected string ValidationGroupName = "SupportFeedback";

    protected void Page_Load(object sender, EventArgs e)
    {
      this.DataBind();
    }
    
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
      Page.Validate(ValidationGroupName);
      if (Page.IsValid == true)
      {
        var fb = new SupportFeedback()
        {
          UserEmail = txtEmail.Text,
          UserName = txtName.Text,
          Message = txtFeedback.Text
        };
        SupportFacade.AddFeedback(fb);
      }
    }
  }
}