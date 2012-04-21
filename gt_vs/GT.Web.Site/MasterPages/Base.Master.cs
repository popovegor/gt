using System;
using System.Web;
using System.Web.UI;
using GT.Web.UI.SiteMap;
using GT.Web.UI.Pages;

namespace GT.Web.Site.MasterPages
{
  public partial class Base : BaseMasterPage
  {
    public CustomSiteMapNode CurrentNode
    {
      get
      {
        return (SiteMap.CurrentNode ?? SiteMap.RootNode) as CustomSiteMapNode;
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      frmBasePage.Action = Request.RawUrl;
      Page.Title = CurrentNode.PageTitle;
      keywords.Content = CurrentNode.KeyWords;
      description.Content = CurrentNode.Description;
    }
  }
}
