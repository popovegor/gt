<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenuItemHome.ascx.cs" Inherits="GT.Web.Site.Menu.MainMenuItemHome" %>
<%@ Import Namespace="GT.Global.Localization" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<div id="mmi" class='<%= (IsCurrent ? "current mmi " : "mmi ") + CssClass  %>'>
  <div  class="mmi-block">
  <% if (IsCurrent == true)
     { %>
  <span class="text" title="<%= SiteMapNode.Title %>">
    <%= SiteMapNode.Title %></span>
  <% }
     else
     {%>
  <asp:HyperLink runat="server" ID="hplMainMenuItem" NavigateUrl="<%# SiteMapNode.Url %>" Text="<%# SiteMapNode.Title %>" Target="_self" CssClass="link" ToolTip="<%# SiteMapNode.Title %>" />
  <% }%>
  <div class="languages mmi-note">
    <% if (Localizator.CurrentLauguage == Languages.En)
       {%>
    <span title="<%= CommonResources.EnglishVersion %>">
      <%# GT.Localization.Resources.CommonResources.English %></span>
    <% }
       else
       { %>
    <a href="<%= GetLanguageUrl("com") %>" target="_self" title="<%= CommonResources.EnglishVersion %>">
    <%# GT.Localization.Resources.CommonResources.English %></a>
    <%}
       if (Localizator.CurrentLauguage == Languages.Ru)
       { %>
    <span title="<%= CommonResources.RussianVersion %>">
      <%# GT.Localization.Resources.CommonResources.Russian %></span>
    <%}
       else
       { %>
    <a href="<%= GetLanguageUrl("ru") %>" target="_self" title="<%= CommonResources.RussianVersion %>">
    <%# GT.Localization.Resources.CommonResources.Russian %></a>
    <%} %>
    </div>
    </div>
</div>
