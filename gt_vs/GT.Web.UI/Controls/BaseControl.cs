using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.Web.Security;
using GT.BO.Implementation.Users;
using System.Web;

namespace GT.Web.UI.Controls
{
  public class BaseControl : System.Web.UI.UserControl
  {
    private Lazy<CredentialsInformation> _credentials = new Lazy<CredentialsInformation>(() => new CredentialsInformation());
    public CredentialsInformation Credentials
    {
      get { return _credentials.Value; }
    }

    //private Lazy<UserDynamics> _dynamics = null;
    
    //public UserDynamics Dynamics
    //{
    //  get
    //  {
    //    return _dynamics.Value;
    //  }
    //}
    
    public string GenerateHtml()
    {
      return ControlHelper.GenerateHtml(this);
    }

    protected virtual void Page_Init(object sender, EventArgs e)
    {
      //_dynamics = new Lazy<UserDynamics>(()
      //  => Credentials.IsLoggedIn 
      //    ? UsersFacade.GetDynamicsForUser(Credentials.UserId) 
      //    : new UserDynamics());
    }
  }
}
