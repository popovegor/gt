<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenu.ascx.cs" Inherits="GT.Web.Site.Menu.MainMenu" %>
<%@ Register Src="~/Menu/MainMenuItem.ascx" TagName="MainMenuItem" TagPrefix="gt" %>
<%@ Register Src="~/Menu/MainMenuItemOffice.ascx" TagName="MainMenuItemOffice" TagPrefix="gt" %>
<%@ Register Src="~/Menu/MainMenuItemSelling.ascx" TagName="MainMenuItemSelling" TagPrefix="gt" %>
<%@ Register Src="~/Menu/MainMenuItemBuying.ascx" TagName="MainMenuItemBuying" TagPrefix="gt" %>
<%@ Register Src="~/Menu/MainMenuItemHome.ascx" TagName="MainMenuItemHome" TagPrefix="gt" %>
<%@ Register Src="~/Menu/MainMenuItemHelp.ascx" TagName="MainMenuItemHelp" TagPrefix="gt" %>
<div id="menu">
 <%-- <gt:MainMenuItemHome runat="server" ID="mmiHome" Url="~/" CssClass="home" />--%>
  <gt:MainMenuItemBuying runat="server" ID="mmiBuying" Url="~/Buying" CssClass="buying" />
  <gt:MainMenuItemSelling runat="server" ID="mmiSelling" Url="~/Selling" CssClass="selling" />
  <gt:MainMenuItemHelp runat="server" ID="mmiHelp" Url="~/Help/General" CssClass="faq" />
  <noindex>
  <gt:MainMenuItemOffice runat="server" ID="mmiOffice" Url="~/Office" CssClass=
  "office" />
  </noindex>
</div>
