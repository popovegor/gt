<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenu.ascx.cs" Inherits="GT.Web.Site.Controls.MainMenu" %>
<%@ Import Namespace="Resources" %>
<%@ Register Src="~/Controls/MainMenuItem.ascx" TagName="MainMenuItem" TagPrefix="gt" %>
<div style="display: none" id="preloadImages">
  <asp:Image SkinID="preloadMenuLeftLightSkin" ID="preloadMenuLeftLight" runat="server" />
  <asp:Image SkinID="preloadMenuCenterLightSkin" ID="preloadMenuCenterLight" runat="server" />
  <asp:Image SkinID="preloadMenuRightLightSkin" ID="preloadMenuRightLight" runat="server" />
</div>
<div id="headerMenu">
  <table id="menuConteiner">
    <tbody>
      <tr>
        <td id="menuLeftRuna">
          <span>&nbsp;</span>
        </td>
        <td id="menuLeft">
          <gt:MainMenuItem runat="server" ID="mmiHome" Url="~/Default.aspx" />
        </td>
        <td id="menuSelling" class="centerItem">
          <gt:MainMenuItem runat="server" ID="mmiSelling" Url="~/Offers/SellingViewer.aspx" />
        </td>
        <td id="menuBuying" class="centerItem">
          <gt:MainMenuItem runat="server" ID="mmiBuying" Url="~/Offers/BuyingViewer.aspx" />
        </td>
        <td id="menuOffice" class="centerItem">
          <gt:MainMenuItem runat="server" ID="mmiOffice" Url="~/PersonalAccount/Office.aspx" />
        </td>
        <td id="menuRight">
          <gt:MainMenuItem runat="server" ID="MainMenuItem1" Url="~/FAQ.aspx" />
        </td>
        <td id="menuRightRuna">
          <span>&nbsp;</span>
        </td>
      </tr>
    </tbody>
  </table>
</div>
