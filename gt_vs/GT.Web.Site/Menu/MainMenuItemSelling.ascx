<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenuItemSelling.ascx.cs" Inherits="GT.Web.Site.Menu.MainMenuItemSelling" %>
<%@ Import Namespace="GT.Localization" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<div class='<%# (IsCurrent ? "current mmi " : "mmi ") + CssClass  %>'>
  <div class="mmi-block">
    <% if (IsCurrent == true)
       { %>
    <span class="text" title="<%= SiteMapNode.Title %>">
      <ins></ins>
      <%# CommonResources.MainMenu_ItemSelling%></span>
    <% }
       else
       {%>
       <a title="<%= SiteMapNode.Title %>" target="_self" class="link" href="<%= SiteMapNode.Url.TrimStart(new[] {'~'}) %>"><ins></ins><%= CommonResources.MainMenu_ItemSelling %></a>
    <% }%>
    <div class="counter mmi-note">
      <span>
        <%# Number %>&nbsp;<%# Number.HasValue ? LocalizationHelper.GetOffersName(Number.Value) : string.Empty%></span>
    </div>
  </div>
</div>
