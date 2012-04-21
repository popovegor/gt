using System;
using System.Data;
using GT.BO.Implementation.Statistic;
using GT.Common.Types;
using GT.DA.Dictionaries;
using Resources;

namespace GT.Web.Site.DetailsInfo
{
    public partial class GameServerInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                InitInfo();
            }
        }

        protected GameServerStatistic m_GS;
        protected DataRow m_Server;

        void InitInfo()
        {
            if (Request.QueryString["GameServerId"] != null)
            {
                int serverId = TypeConverter.ToInt32(Request.QueryString["GameServerId"]);
                m_Server = Dictionaries.Instance.GetGameServerById(serverId);
                if (m_Server != null)
                {
                    this.gameServerSiteValue.NavigateUrl = TypeConverter.ToString(m_Server[GameServerFields.Url]);
                    this.gameServerSiteValue.Text = this.gameServerSiteValue.NavigateUrl;

                    m_GS = GameServerStatistic.GetGameServerStatisticByGameServerid(serverId);
                    
                    bxPopBuyers.Visible = m_GS == null || m_GS.TopBuyers.Count > 0;
                    bxPopSellers.Visible = m_GS == null || m_GS.TopSellers.Count > 0;

                    DataBind();

                    return;
                }
            }

            err.Visible = true;
            info.Visible = false;
            err.Text = CommonResources.GameServerInfoUnavailable;
        }
    }
}
