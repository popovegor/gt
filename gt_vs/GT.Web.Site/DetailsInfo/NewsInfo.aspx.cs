using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.BO.Implementation.News;
using GT.Common.Types;
using GT.Global.News;
using GT.Common.Web.WebUtils;
using System.Net;
using GT.Web.UI.Pages;
using GT.Web.Site.MasterPages;

namespace GT.Web.Site.DetailsInfo
{
  public partial class NewsInfo : BasePage
  {
    protected GT.BO.Implementation.News.News News;


    public void Page_Init(object sender, EventArgs e)
    {
      if (!this.IsPostBack)
      {
        InitInfo();
        //(Master as Base).CurrentNode.Title = News.LocalizedTitle;
        //Title = News.LocalizedTitle;
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

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

      if (UserAgentUtils.IsSearchBot)
      {
        Response.Clear();
        Response.StatusCode = (int)HttpStatusCode.NotFound;
        Response.Close();
      }
      else
      {
        err.Visible = true;
        info.Visible = false;
        err.Text = CommonResources.NewsNotFound;
      }
    }
  }
}
