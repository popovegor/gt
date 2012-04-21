using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Controls;
using GT.Global.Localization;
using System.Text.RegularExpressions;

namespace GT.Web.Site.Menu
{
  public partial class MainMenuItemHome : BaseMainMenuItem
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected string GetLanguageUrl(string domain)
    {
      if (Request.Url.HostNameType == UriHostNameType.Dns)
      {
        /*int index = Request.Url.Host.LastIndexOf('.');
        if (index > 0 && index < Request.Url.Host.Length - 1)
        {
          return Request.RawUrl.ToString().Replace(Request.Url.Host, string.Concat(Request.Url.Host.Substring(0, index + 1), domain));
        }*/
        var domainName = Request.Url.GetComponents(UriComponents.Host, UriFormat.UriEscaped);
        var localizedDomainName = Regex.Replace(domainName, @"\.[a-z,A-Z]{2,3}$","." + domain, RegexOptions.IgnoreCase);
        return Request.Url.GetComponents(UriComponents.SchemeAndServer, UriFormat.UriEscaped).Replace(domainName, localizedDomainName) + Request.RawUrl;
      }

      return Request.RawUrl.ToString();
    }
  }
}