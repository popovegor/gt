using System;
using System.Data;
using GT.BO.Implementation.Statistic;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Web.UI.Pages;
using Resources;

namespace GT.Web.Site.DetailsInfo
{
    public partial class GameInfo : GT.Web.UI.Pages.BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                InitInfo();
            }
        }

        protected GameStatistic m_GS;
        protected DataRow m_Game;

        void InitInfo()
        {
            if (this.Request.QueryString["GameID"] != null)
            {
                int gameId = TypeConverter.ToInt32(Request.QueryString["GameID"]);

                m_Game = Dictionaries.Instance.GetGameById(gameId);
                if (m_Game != null)
                {
                    this.gameSiteValue.NavigateUrl = TypeConverter.ToString(m_Game[GameFields.Url]);
                    this.gameSiteValue.Text = this.gameSiteValue.NavigateUrl;

                    m_GS = GameStatistic.GetGameStatisticByGameid(gameId);

                    bxPopBuyers.Visible = m_GS == null || m_GS.TopBuyers.Count > 0;
                    bxPopSellers.Visible = m_GS == null || m_GS.TopSellers.Count > 0;

                    DataBind();

                    return;
                }
            }

            info.Visible = false;
            err.Visible = true;
            err.Text = CommonResources.GameInfoUnavailable;
        }
    }
}
