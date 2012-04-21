using System;
using GT.Web.UI.SiteMap;
using System.Web;
using GT.Web.UI.Pages;


namespace GT.Web.Site.MasterPages
{
  public partial class Popup : BaseMasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected CustomSiteMapNode CurrentNode
        {
            get
            {
                return (SiteMap.CurrentNode ?? SiteMap.RootNode) as CustomSiteMapNode;
            }
        }
    }
}
