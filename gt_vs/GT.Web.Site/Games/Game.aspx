<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="Game.aspx.cs" Inherits="GT.Web.Site.Games.Game" %>

<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.Web.Security" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="GT.Common.Web.WebUtils" %>
<%@ Import Namespace="GT.Web.UI.Controls" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="GT.DA" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.BO.Implementation.Statistic" %>
<%@ Import Namespace="GT.Localization" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/RoundCornerBlock.ascx" TagName="RoundCornerBlock" TagPrefix="gt" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <div id="game">
    <% if (GameInfo == null)
       {
         if (true == UserAgentUtils.IsSearchBot)
         {
           Response.Clear();
           Response.StatusCode = (int)HttpStatusCode.NotFound;
           Response.Close();
         }
         else
         {%>
    <asp:Label ID="lblInfo" runat="server" Text="<%# CommonResources.GameInfoUnavailable %>" CssClass="error" />
    <%}
       }
       else
       {
    %>
        <div class="game-desc">
          <%= GT.Common.Types.TypeConverter.ToString(GameInfo[GT.DA.Dictionaries.GameFields.LocalizedDescription])%>
        </div>
        <div class="game-stat">
          <gt:RoundCornerBlock runat="server" ID="rcbBuying" CssClass="rcb-buying"><Title><span class="gsb-title">
            <%= CommonResources.Offers_OffersToBuy%></span></Title>
            <Content>
              <%
                var gs = StatisticFacade.GetGameStatById(GameId);
              %>
              <ul>
                <li><b class="category-character">
                  <%= gs.BuyingCharacter %></b>
                  <%= string.Format(CommonResources.Offers_OffersAboutCharacters, LocalizationHelper.GetOffersName(gs.BuyingCharacter))%></li>
                <li><b class="category-currency">
                  <%= gs.BuyingCurrency %></b>
                  <%=  string.Format(CommonResources.Offers_OffersAboutCurrency, LocalizationHelper.GetOffersName(gs.BuyingCurrency))%></li>
                <li><b class="category-armory">
                  <%= gs.BuyingArmory %></b>
                  <%=  string.Format(CommonResources.Offers_OffersAboutArmory, LocalizationHelper.GetOffersName(gs.BuyingArmory))%></li>
                  <li><b class="category-misc">
                  <%= gs.BuyingMisc %></b>
                  <%=  string.Format(CommonResources.Offers_OffersFromMisc, LocalizationHelper.GetOffersName(gs.BuyingMisc))%></li>
              </ul>
              <a href='<%= string.Format("/Buying?{0}={1}", ViewFilterParams.GameId, GameId) %>' title="<%= CommonResources.Offers_ShowOffers %>"><%= CommonResources.Offers_ShowOffers %></a> </Content>
          </gt:RoundCornerBlock>
          <gt:RoundCornerBlock runat="server" ID="rcbSelling" CssClass="rcb-selling"><Title><span class="gss-title"><%= CommonResources.Offers_OffersToSell %></span></Title>
            <Content>
              <%
                var gs = StatisticFacade.GetGameStatById(GameId);
              %>
              <ul>
                <li><b class="category-character">
                  <%= gs.SellingActiveCharacter %></b>
                  <%= string.Format(CommonResources.Offers_OffersAboutCharacters, LocalizationHelper.GetOffersName(gs.SellingActiveCharacter))%> </li>
                <li><b class="category-currency">
                  <%= gs.SellingActiveCurrency%></b>
                  <%=  string.Format(CommonResources.Offers_OffersAboutCurrency, LocalizationHelper.GetOffersName(gs.SellingActiveCurrency))%> </li>
                <li><b class="category-armory">
                  <%= gs.SellingActiveArmory%></b>
                  <%=  string.Format(CommonResources.Offers_OffersAboutArmory, LocalizationHelper.GetOffersName(gs.SellingActiveArmory))%></li>
                  <li><b class="category-misc">
                  <%= gs.SellingActiveMisc %></b>
                  <%=  string.Format(CommonResources.Offers_OffersFromMisc, LocalizationHelper.GetOffersName(gs.SellingActiveMisc))%></li>
              </ul>
              <a target="_self" href='<%= string.Format("/Selling?{0}={1}", ViewFilterParams.GameId, GameId) %>' title="<%= CommonResources.Offers_ShowOffers %>"><%= CommonResources.Offers_ShowOffers %></a> </Content>
          </gt:RoundCornerBlock>
        </div>
    <% }%>
  </div>
</asp:Content>
