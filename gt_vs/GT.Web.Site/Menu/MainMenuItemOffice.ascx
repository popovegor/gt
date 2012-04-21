<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenuItemOffice.ascx.cs" Inherits="GT.Web.Site.Menu.MainMenuItemOffice" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Import Namespace="GT.Global.MessageSystem" %>
<%@ Import Namespace="GT.Localization" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>

<div class='<%= (IsCurrent ? "current mmi " : "mmi ") + CssClass  %>'>
  <div class="mmi-block">
  <% if (IsCurrent == true)
     { %>
  <span class="text" title="<%= SiteMapNode.Title %>"><ins></ins>
    <%= CommonResources.MainMenu_ItemOffice %>
  </span>
  <% }
     else
     {%>
     <a title="<%= SiteMapNode.Title %>" target="_self" class="link" href="<%= SiteMapNode.Url.TrimStart(new[] {'~'}) %>"><ins></ins><%= CommonResources.MainMenu_ItemOffice%></a>
<%--  <asp:HyperLink runat="server" ID="hplMainMenuItem" NavigateUrl="<%# SiteMapNode.Url %>" Text="<%# CommonResources.MainMenu_ItemOffice %>" Target="_self" CssClass="link" ToolTip="<%# SiteMapNode.Title %>"  />--%>
  <% }%>
  <div class="signin mmi-note">
    <asp:LoginView runat="server">
      <LoggedInTemplate>
        <asp:Label Text="<%#((GT.Web.UI.Pages.BasePage)this.Page).Credentials.UserName %>" runat="server" /><span class="press-word-spacing">&nbsp;/&nbsp;</span><asp:LoginStatus ID="lsStatus" runat="server" LogoutText="<%# GT.Localization.Resources.CommonResources.SignOut %>" LoginText="<%# GT.Localization.Resources.CommonResources.SignIn %>" />
      </LoggedInTemplate>
      <AnonymousTemplate><a href="/SignIn" class="sign-in" rel="nofollow">
        <%# GT.Localization.Resources.CommonResources.SignIn %></a><span class="press-word-spacing">&nbsp;/&nbsp;</span><a class="sign-up" href="/SignUp"><%# GT.Localization.Resources.CommonResources.Register%></a> </AnonymousTemplate>
    </asp:LoginView>
  </div>
  <div class="unread-messages">
    <% 
      var d = Credentials.IsLoggedIn == true ? UsersFacade.GetDynamicsForUser(Credentials.UserId) : new UserDynamics();
      var urlMessages = string.Format("/Office/Messages/{1}", MessageFilterParams.Direction, GT.BO.Implementation.MessageSystem.MessageType.In);
    if (d.MessagesUnread > 0) {%>
      <noindex>
      <a href='<%= urlMessages %>' rel="nofollow" target="_self"><%= d.MessagesUnread %>&nbsp;<%=LocalizationHelper.GetMessagesName(d.MessagesUnread) %></a></noindex>
    <%} %>
  </div>
  </div>
</div>
