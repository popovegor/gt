using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Resources;
using GT.BO.Implementation.News;
using GT.Common.Types;
using GT.Global.News;

namespace GT.Web.Site.DetailsInfo
{
    public partial class NewsInfo : System.Web.UI.Page
    {
        protected GT.BO.Implementation.News.News News;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                InitInfo();
            }
        }

        void InitInfo()
        {
            if (Request.QueryString[NewsInfoParams.NEWSID] != null)
            {
                int newsId = TypeConverter.ToInt32(Request.QueryString[NewsInfoParams.NEWSID]);
                News = NewsFacade.GetById(newsId);
                if (News != null)
                {
                    DataBind();
                    return;
                }
            }

            err.Visible = true;
            info.Visible = false;
            err.Text = CommonResources.NewsNotFound;
        }
    }
}
