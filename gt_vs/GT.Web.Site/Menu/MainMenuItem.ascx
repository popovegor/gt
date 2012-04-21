<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenuItem.ascx.cs" Inherits="GT.Web.Site.Menu.MainMenuItem" %>
<div class='<%= (IsCurrent ? "current mmi " : "mmi ") + CssClass  %>'>
  <div class="mmi-block">
  <% if (IsCurrent == true)
     { %>
  <span class="text" title="<%= SiteMapNode.Title %>">
    <%= SiteMapNode.Title %></span>
  <% }
     else
     {%>
  <asp:HyperLink runat="server" ID="hplMainMenuItem" NavigateUrl="<%# SiteMapNode.Url %>" Text="<%# SiteMapNode.Title %>" Target="_self" CssClass="link" ToolTip="<%# SiteMapNode.Title %>" />
  <% }%>
  </div>
</div>
