using System;
using GT.Web.UI.SiteMap;
using System.Web;


namespace GT.Web.Site.MasterPages
{
    public partial class PopupPage : System.Web.UI.MasterPage
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
