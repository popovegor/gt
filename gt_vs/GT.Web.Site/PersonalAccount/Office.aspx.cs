using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Pages;
using GT.BO.Implementation.Users;

namespace GT.Web.Site.PersonalAccount
{
  public partial class Office : BaseEditPage
  {

    protected UserDynamics Dynamics
    {
      get
      {
        return (Master as MasterPages.Office).Dynamics;
      }
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }
  }
}
