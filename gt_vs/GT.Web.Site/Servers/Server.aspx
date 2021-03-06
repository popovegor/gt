<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" 
    CodeBehind="Server.aspx.cs" Inherits="GT.Web.Site.Servers.Server" EnableViewState="true"
%>
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
<%@ Register Src="~/Controls/Game.ascx" TagName="Game" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Panel.ascx" TagName="Panel" TagPrefix="gt" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">


    <div id="server">
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
    <asp:Label ID="lblInfo" runat="server" Text="<%# CommonResources.GameServerInfoUnavailable %>" CssClass="error" />
    <%}
       }
       else
       {
    %>
    <div class="general">
      <gt:Panel runat="server" ID="pGeneral">
        <Content><span>
          <%# CommonResources.Servers_Server_GeneralInfo %></span> </Content>
      </gt:Panel>
      
      
       <table class="fields" rules="none">
        <tbody>
          <tr>
            <td class="name">
              <%= CommonResources.Servers_Server_ServerName %>:
            </td>
            <td class="value">
            <%= GT.Common.Types.TypeConverter.ToString(Info[GT.DA.Dictionaries.GameServerFields.LocalizedName])%>
            </td>
            </tr>
           <tr>
            <td class="name">
           <%= CommonResources.Servers_Server_ServerSite%>:
            </td>
              <td class="value">
             <a class="value" href="<%=TypeConverter.ToString(Info[GT.DA.Dictionaries.GameServerFields.Url]) %>" target="_blank">
          <%=TypeConverter.ToString(Info[GT.DA.Dictionaries.GameServerFields.Url])%></a>
            </td>
           </tr>
           <tr>
            <td class="name">
            <%= CommonResources.Servers_Server_GameName %>:
            </td>
            <td class="value">
              <% var g = this.LoadControl("~/Controls/Game.ascx") as GT.Web.Site.Controls.Game;
          g.GameId = GameId;
       %>
          <span class="value"><%= g.GenerateHtml() %></span>
            </td>
           </tr>
           <tr>
           <td class="name">
           <%
            var sellingViewer = string.Format("/Selling?{0}={1}&{2}={3}", ViewFilterParams.GameId, GameId, ViewFilterParams.GameServerId, ServerId);
            var gs = GameServerStatistic.GetGameServerStatisticByGameServerid(ServerId);
          %>
            <%= string.Format(CommonResources.Servers_Server_SalesCount, sellingViewer)%>:
           </td>
           <td class="value">
            <a class="value" href='<%= sellingViewer %>'>
            <%= gs.SellingActiveCount%></a> 
           </td>
           </tr>
            <tr>
           <td class="name">
            <%
            var buyingViewer = string.Format("/Buying?{0}={1}&{2}={3}", ViewFilterParams.GameId, GameId, ViewFilterParams.GameServerId, ServerId);
          %>
            <%= string.Format(CommonResources.Servers_Server_PurchasesCount, buyingViewer)%>:
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
              user.ShowNewWindow = true;
            
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
            user.ShowNewWindow = true;
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
          <%= CommonResources.Servers_Server_Description %></span> </Content>
      </gt:Panel>
      <div class="text">
      <%= GT.Common.Types.TypeConverter.ToString(Info[GT.DA.Dictionaries.GameServerFields.LocalizedDescription]) %>
      </div>
    </div>
    <% }%>
      
    </div>

</asp:Content>