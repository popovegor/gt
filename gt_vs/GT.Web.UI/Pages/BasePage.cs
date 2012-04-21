using System.Web.UI;
using GT.Common.Types;
using GT.Web.Security;
using System.Threading;
using System.Globalization;
using GT.Global.Localization;
using System;

namespace GT.Web.UI.Pages
{
  public class BasePage : Page
  {
    private Lazy<CredentialsInformation> _credentials = new Lazy<CredentialsInformation>(() => new CredentialsInformation());
    public CredentialsInformation Credentials
    {
      get { return _credentials.Value; }
    }

    protected override void OnPreInit(System.EventArgs e)
    {
      /*if (OpenMode != PageOpenMode.Popup)
      {
        base.MasterPageFile = "~/MasterPages/Standard.Master";
      }*/
      base.OnPreInit(e);
    }

    public BasePage()
    {
    }

    public PageOpenMode OpenMode
    {
      get
      {
        return TypeConverter.ToEnumMember<PageOpenMode>(Request.QueryString["om"], PageOpenMode.None);
      }
    }

    protected override void OnPreRender(System.EventArgs e)
    {
      base.OnPreRender(e);
    }
  }
}
