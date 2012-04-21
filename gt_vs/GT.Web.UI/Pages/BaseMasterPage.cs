using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.Web.Security;
using System.Web.UI;

namespace GT.Web.UI.Pages
{
  public class BaseMasterPage : MasterPage
  {
    private Lazy<CredentialsInformation> _credentials = new Lazy<CredentialsInformation>(
      () => new CredentialsInformation());
    public CredentialsInformation Credentials
    {
      get { return _credentials.Value; }
    }
  }
}
