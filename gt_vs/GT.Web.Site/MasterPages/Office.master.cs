using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Users;
using GT.Web.UI.Pages;

namespace GT.Web.Site.MasterPages
{
  public partial class Office : BaseEditMasterPage
  {
    public UserDynamics Dynamics { get; set; }

    protected void Page_Init(object sender, EventArgs e)
    {
      Dynamics = UsersFacade.GetDynamicsForUser(Credentials.UserId);
    }
  }
}
