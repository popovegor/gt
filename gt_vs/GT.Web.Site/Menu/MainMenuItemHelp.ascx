<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenuItemHelp.ascx.cs" Inherits="GT.Web.Site.Menu.MainMenuItemHelp" %>
<%@ Import Namespace="GT.Global" %>
<%@ Import Namespace="GT.Localization.Resources" %>

<div id="mmi" class='<%= (IsCurrent ? "current mmi " : "mmi ") + CssClass  %>'>
  <div class="mmi-block">
  <% if (IsCurrent == true)
     { %>
  <span class="text" title="<%= SiteMapNode.Title  %>">
    <ins></ins><%= CommonResources.MainMenu_ItemHelp%></span>
  <% }
     else
     {%>
      <a title="<%= SiteMapNode.Title %>" target="_self" class="link" href="<%= SiteMapNode.Url.TrimStart(new[] {'~'}) %>"><ins></ins><%= CommonResources.MainMenu_ItemHelp%></a>
  <%--<asp:HyperLink runat="server" ID="hplMainMenuItem" NavigateUrl="<%# SiteMapNode.Url %>" Text="<%# CommonResources.MainMenu_ItemHelp %>" Target="_self" CssClass="link" ToolTip="<%# SiteMapNode.Title %>"></asp:HyperLink>--%>
  <% }%>
  <div class="how mmi-note">
      <%= string.Format(CommonResources.MainMenu_How, string.Format("/Help/{1}", HelpParams.SectionType, HelpParams.Section.HowBuy), string.Format("/Help/{1}", HelpParams.SectionType, HelpParams.Section.HowSell))%>
    </div>
    </div>
</div>