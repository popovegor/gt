<%@ Page Language="C#" MasterPageFile="~/MasterPages/TwoColumns.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GT.Web.Site.Default" EnableViewState="false" %>

<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.Web.UI.Controls" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<%@ Import Namespace="GT.BO.Implementation.Offers" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="GT.Web.Site.Controls" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.Global.Entities" %>
<%@ Import Namespace="GT.BO.Implementation.Offers.SearchFilters" %>
<%@ Register Src="~/Controls/Panel.ascx" TagName="Panel" TagPrefix="gt" %>
<%@ Register Src="~/Controls/ContactInfo.ascx" TagName="ContactInfo" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Game.ascx" TagName="Game" TagPrefix="gt" %>
<%@ Register Src="~/Controls/HomeOffer.ascx" TagName="HomeOffer" TagPrefix="gt" %>
<%@ Register TagName="Newsletters" TagPrefix="gt" Src="~/Controls/Newsletters.ascx" %>
<%@ Register Src="~/Controls/NewsEntry.ascx" TagName="NewsEntry" TagPrefix="gt" %>
<asp:Content ContentPlaceHolderID="cphTitle" runat="server" ID="cntTitle"></asp:Content>
<asp:Content ContentPlaceHolderID="cphSidebar" runat="server" ID="cntSidebar">
  <div id="homeSidebar">
    <dl class="top-games">
      <dt><span class="top-games-title">
        <%= CommonResources.TopGames %></span> </dt>
      <dd>
        <ul class="top-games-items">
          <% 
            var counter = 0;
            foreach (var g in Games)
            {
              counter++;
              var ctlGame
                = (GT.Web.Site.Controls.Game)LoadControl(@"~/Controls/Game.ascx");
              ctlGame.GameId = (int)g[GameFields.GameId];
          %>
          <li>
            <%--<%= string.Format("<span class='top-games-counter'>{0}. </span>{1}", counter, ctlGame.GenerateHtml()) %>--%>
            <%= ctlGame.GenerateHtml() %>
          </li>
          <%} %>
        </ul>
      </dd>
    </dl>
    <%-- <div class="wants">
      <%= string.Format(CommonResources.Default_Wants, "/Selling/WantToSell", "/Buying/WantToBuy") %>
    </div>--%>
  </div>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <div id="home">
    <div class="left-side">
      <h1 class="title">
        <%= (SiteMap.RootNode as GT.Web.UI.SiteMap.CustomSiteMapNode).PageTitle%>
      </h1>
      <div class="site-description">
        <p>
          <%# string.Format(CommonResources.Default_SiteDescription1, string.Format("/Help/{0}", GT.Global.HelpParams.Section.General)) %>
        </p>
        <p>
          <%# CommonResources.Default_SiteDescription2 %>
        </p>
      </div>
      <div class="offers">
        <%--selling offers--%>
        <div class="selling-offers">
          
          <h2 class="so-title"><%= CommonResources.Offers_OffersToSell%></h2>
          <p class="o-items-all">
            <a href="/Selling" target="_self" title="<%= CommonResources.ShowAllOffersToSell %>" ><%= CommonResources.AllOffers %></a>
          </p>
          <div class="so-items">
            <% foreach (var s in SellingFacade.SearchOffersAsCollection(new BaseSearchFilter()).Take(7))
               { 
               var so = (HomeOffer)LoadControl("~/Controls/HomeOffer.ascx");
               so.BaseOffer = s;
               so.Entity = EntityType.SellingOffer;
               %>
                <%= so.GenerateHtml() %>
            <% } %>
          </div>
          
        </div>
        <%--buying offers--%>
        <div class="buying-offers">
          <h2 class="bo-title"><%= CommonResources.Offers_OffersToBuy%></h2>
          <p class="o-items-all">
            <a href="/Buying" target="_self" title="<%= CommonResources.ShowAllOffersToBuy %>" ><%= CommonResources.AllOffers %></a>
          </p>
          <div class="bo-items">
            <% foreach (var b in BuyingFacade.SearchOffersAsCollection(new BaseSearchFilter()).Take(7))
               { 
               var bo = (HomeOffer)LoadControl("~/Controls/HomeOffer.ascx");
               bo.BaseOffer = b;
               bo.Entity = EntityType.BuyingOffer;
               %>
                <%= bo.GenerateHtml() %>
            <% } %>
          </div>
        </div>
      </div>
    </div>
    <div class="right-side">
      <dl class="news">
        <dt><span>
          <%= CommonResources.News %></span> </dt>
        <dd>
          <ul>
            <%foreach (var n in News)
              {%>
            <li class="news-entry"><span class="news-date">
              <%= string.Format("{0:dd MMM}", n.CreateDate.UtcToLocal())%></span> <span class="news-title">
                <%= n.LocalizedTitle %></span>
              <p class="news-msg">
                <%= NewsFacade.CutNews(n)%>
                &rarr; <a href='<%= string.Format("/News/{1}", GT.Global.News.NewsInfoParams.NEWSID, n.NewsId ) %>'>
                <%= GT.Localization.Resources.CommonResources.More %></a> </p>
            </li>
            <% } %>
          </ul>
        </dd>
      </dl>
      <div class="news-archive">
        <a href="/News/NewsArchive" title="" target="_self"><%= CommonResources.News_Archive %></a>
      </div>
    </div>
  </div>
</asp:Content>
