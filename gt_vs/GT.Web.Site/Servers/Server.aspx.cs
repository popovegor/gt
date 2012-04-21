using System;
using System.Data;
using GT.BO.Implementation.Statistic;
using GT.Common.Types;
using GT.DA.Dictionaries;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Web.UI.Pages;
using GT.Common.Web.WebUtils;
using System.Net;

namespace GT.Web.Site.Servers
{
  public partial class Server : BasePage
  {

    protected int ServerId
    {
      get
      {
        return TypeConverter.ToInt32(Request.QueryString["id"], -1);
      }
    }
    
    protected int GameId
    {
      get
      {
        return TypeConverter.ToInt32(Info[GT.DA.Dictionaries.GameServerFields.GameId]);
      }
    }

    private Lazy<DataRow> _server = null;

    public DataRow Info { get { return _server.Value; } }

    protected void Page_Init(object sender, EventArgs e)
    {
      _server = new Lazy<DataRow>(()
        => Dictionaries.Instance.GetGameServerById(ServerId), true);
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }
    

    //protected GameServerStatistic m_GS;
    //protected DataRow m_Server;

    //void InitInfo()
    //{
    //  if (Request.QueryString["Id"] != null)
    //  {
    //    int serverId = TypeConverter.ToInt32(Request.QueryString["Id"]);
    //    m_Server = Dictionaries.Instance.GetGameServerById(serverId);
    //    if (m_Server != null)
    //    {
    //      this.gameServerSiteValue.NavigateUrl = TypeConverter.ToString(m_Server[GameServerFields.Url]);
    //      this.gameServerSiteValue.Text = this.gameServerSiteValue.NavigateUrl;

    //      m_GS = GameServerStatistic.GetGameServerStatisticByGameServerid(serverId);

    //      bxPopBuyers.Visible = m_GS == null || m_GS.TopBuyers.Count > 0;
    //      bxPopSellers.Visible = m_GS == null || m_GS.TopSellers.Count > 0;

    //      DataBind();

    //      return;
    //    }
    //  }

    //  if (UserAgentUtils.IsSearchBot)
    //  {
    //    Response.Clear();
    //    Response.StatusCode = (int)HttpStatusCode.NotFound;
    //    Response.Close();
    //  }
    //  else
    //  {
    //    err.Visible = true;
    //    info.Visible = false;
    //    err.Text = CommonResources.GameServerInfoUnavailable;
    //  }
    //}
  }
}
