using System;
using System.Web;
using System.Web.UI;
using GT.Web.UI.SiteMap;

namespace GT.Web.Site.MasterPages
{
  public partial class BasePage : System.Web.UI.MasterPage
  {
    protected CustomSiteMapNode CurrentNode
    {
      get
      {
        return (SiteMap.CurrentNode ?? SiteMap.RootNode) as CustomSiteMapNode;
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      Page.Title = CurrentNode.PageTitle;
      keywords.Content = CurrentNode.KeyWords;
      description.Content = CurrentNode.Description;
    }
  }
}
