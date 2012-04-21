using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.SiteMap;

namespace GT.Web.UI.Controls
{
  public class BaseMainMenuItem : BaseControl
  {
    public string CssClass { get; set; }

    public string Url { set; get; }

    protected CustomSiteMapNode SiteMapNode
    {
      get
      {
        return (System.Web.SiteMap.Provider.FindSiteMapNode(Url) ?? System.Web.SiteMap.RootNode) as CustomSiteMapNode;
      }
    }

    protected CustomSiteMapNode CurrentNode
    {
      get
      {
        return (System.Web.SiteMap.CurrentNode ?? System.Web.SiteMap.RootNode) as CustomSiteMapNode;
      }
    }

    protected bool IsCurrent
    {
      get
      {
        return CurrentNode == SiteMapNode;
      }
    }
  }
}
