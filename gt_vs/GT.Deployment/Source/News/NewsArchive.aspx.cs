using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.News;

namespace GT.Web.Site.News
{
    public partial class NewsArchive : GT.Web.UI.Pages.BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataBind();
        }

        protected GT.BO.Implementation.News.News[] News
        {
            get
            {
                return NewsFacade.GetAll();
            }
        }
    }
}
