using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.SiteMap;

namespace GT.Web.Site.Controls
{
  public partial class MainMenuItem : System.Web.UI.UserControl
  {
    public string Url { set; get; }

    protected CustomSiteMapNode SiteMapNode
    {
      get
      {
        return (SiteMap.Provider.FindSiteMapNode(Url) ?? SiteMap.RootNode) as CustomSiteMapNode;
      }
    }

    protected CustomSiteMapNode CurrentNode
    {
      get
      {
        return (SiteMap.CurrentNode ?? SiteMap.RootNode) as CustomSiteMapNode;
      }
    }

    protected bool IsCurrent
    {
      get
      {
        return CurrentNode == SiteMapNode;
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }
  }
}