<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="Game_old.aspx.cs" Inherits="GT.Web.Site.Games.Game_old" %>

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
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Panel.ascx" TagName="Panel" TagPrefix="gt" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <div id="game">
    <% if (Info == null)
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
    <div class="general">
      <gt:Panel runat="server" ID="pGeneral">
        <Content><span>
          <%# CommonResources.Games_Game_GeneralInfo %></span> </Content>
      </gt:Panel>
  <table class="fields" rules="none">
        <tbody>
          <tr>
            <td class="name">
              <%= CommonResources.Games_Game_GameName %>:
            </td>
            <td class="value">
            <%= GT.Common.Types.TypeConverter.ToString(Info[GT.DA.Dictionaries.GameFields.LocalizedName])%>
            </td>
            </tr>
           <tr>
            <td class="name">
            <%= CommonResources.Games_Game_GameSite%>:
            </td>
              <td class="value">
             <a class="value" href="<%=TypeConverter.ToString(Info[GT.DA.Dictionaries.GameFields.Url]) %>" target="_blank">
          <%=TypeConverter.ToString(Info[GT.DA.Dictionaries.GameFields.Url])%></a>
            </td>
           </tr>
           <tr>
           <td class="name">
            <%
            var sellingViewer = string.Format("/Selling?{0}={1}", ViewFilterParams.GameId, GameId);
            var gs = GameStatistic.GetGameStatisticByGameid(GameId);
          %>
            <%= string.Format(CommonResources.Games_Game_SalesCount, sellingViewer)%>:
           </td>
           <td class="value">
             <a class="value" href='<%= sellingViewer %>'>
            <%= gs.SellingActiveCount%></a> 
           </td>
           </tr>
            <tr>
           <td class="name">
            <%
            var buyingViewer = string.Format("/Buying?{0}={1}", ViewFilterParams.GameId, GameId);
          %>
            <%= string.Format(CommonResources.Games_Game_PurchasesCount, buyingViewer)%>:
           </td>
           <td class="value">
             <a class="value" href='<%= buyingViewer %>'>
            <%= gs.BuyingOffersCount%></a>
           </td>
           </tr>
        </tbody>
      </table>
    </div>
    <% if (gs.TopSellers.Count > 0)
       {%>
    <div class="sellers">
      <gt:Panel runat="server" ID="pnlSellers">
        <Content><span>
          <%= CommonResources.TopSellers %></span> </Content>
      </gt:Panel>
      <ul class="fields">
        <% foreach (var seller in gs.TopSellers)
           {%>
        <li>
          <%
            var user = this.LoadControl("~/Controls/User.ascx") as GT.Web.Site.Controls.User;
            user.UserId = seller.Key.UserId();
            user.ShowUserCard = true;
            user.ShowNewWindow = false;
          %>
          <%= user.GenerateHtml() %>
        </li>
        <%} %>
      </ul>
    </div>
    <%} %>
    <% if (gs.TopBuyers.Count > 0)
       {%>
    <div class="buyers">
      <gt:Panel runat="server" ID="pnlBuyers">
        <Content><span>
          <%= CommonResources.TopBuyers %></span> </Content>
      </gt:Panel>
      <ul class="fields">
        <% foreach (var buyer in gs.TopBuyers)
           {%>
        <li>
          <%
            var user = this.LoadControl("~/Controls/User.ascx") as GT.Web.Site.Controls.User;
            user.UserId = buyer.Key.UserId();
            user.ShowUserCard = true;
            user.ShowNewWindow = false;
          %>
          <%= user.GenerateHtml() %>
        </li>
        <%} %>
      </ul>
    </div>
    <%} %>
    <div class="description">
      <gt:Panel runat="server" ID="pnl">
        <Content><span>
          <%= CommonResources.Games_Game_Description %></span> </Content>
      </gt:Panel>
      <div class="text">
      <%= GT.Common.Types.TypeConverter.ToString(Info[GT.DA.Dictionaries.GameFields.LocalizedDescription]) %>
      </div>
    </div>
    <% }%>
  </div>
</asp:Content>
