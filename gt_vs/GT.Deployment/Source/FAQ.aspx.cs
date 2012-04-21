using System;
using GT.Web.UI.Pages;

namespace GT.Web.Site
{
    public partial class FAQ : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataBind();
        }
    }
}
