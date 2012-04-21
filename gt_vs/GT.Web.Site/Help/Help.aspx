<%@ Page Language="C#" MasterPageFile="~/MasterPages/TwoColumns.Master" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="GT.Web.Site.Help.Help" %>

<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.Global" %>
<%@ Register Src="~/Controls/ContactInfo.ascx" TagName="ContactInfo" TagPrefix="gt" %>
<%@ Register Src="~/Help/About.ascx" TagName="About" TagPrefix="gt" %>
<%@ Register Src="~/Help/HowToSell.ascx" TagName="HowToSell" TagPrefix="gt" %>
<%@ Register Src="~/Help/HowToBuy.ascx" TagName="HowToBuy" TagPrefix="gt" %>
<%@ Register Src="~/Help/Rules.ascx" TagName="Rules" TagPrefix="gt" %>
<%@ Register Src="~/Help/Billing.ascx" TagName="Billing" TagPrefix="gt" %>
<%@ Register Src="~/Menu/Submenu.ascx" TagName="Submenu" TagPrefix="gt" %>
<%@ Register Src="~/Menu/SubmenuItem.ascx" TagName="SubmenuItem" TagPrefix="gt" %>
<asp:Content ID="cntSidebar" ContentPlaceHolderID="cphSidebar" runat="server">
  <div class="help-menu">
    <gt:Submenu runat="server" ID="sm">
      <Content>
        <gt:SubmenuItem runat="server" ID="smiGeneral" NavigateUrl="<%# GetUrlForSection(HelpParams.Section.General) %>" Text="<%# CommonResources.Help_AboutSite %>" />
        <gt:SubmenuItem runat="server" ID="smiHowBuy" NavigateUrl="<%# GetUrlForSection(HelpParams.Section.HowBuy) %>" Text="<%# CommonResources.Help_HowBuy %>" />
        <gt:SubmenuItem runat="server" ID="smiHowSell" NavigateUrl="<%# GetUrlForSection(HelpParams.Section.HowSell) %>" Text="<%# CommonResources.Help_HowSell %>" />
        <gt:SubmenuItem runat="server" ID="smiBilling" NavigateUrl="<%# GetUrlForSection(HelpParams.Section.Billing) %>" Text="<%# CommonResources.Help_Billing %>" />
        <gt:SubmenuItem runat="server" ID="smiRules" NavigateUrl="<%# GetUrlForSection(HelpParams.Section.Rules) %>" Text="<%# CommonResources.Help_Rules %>" />
      </Content>
    </gt:Submenu>
  </div>
</asp:Content>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <div id="help">
    <div class="help-text">
      <asp:MultiView runat="server" ID="mv" ActiveViewIndex="<%# (int)SectionType %>">
        <asp:View runat="server" ID="vGeneral">
          <gt:About runat="server" ID="a" HowSellUrl="<%# GetUrlForSection(HelpParams.Section.HowSell) %>" HowBuyUrl="<%# GetUrlForSection(HelpParams.Section.HowBuy) %>" BillingUrl="<%# GetUrlForSection(HelpParams.Section.Billing) %>" />
        </asp:View>
        <asp:View runat="server" ID="vHowBuy">
          <gt:HowToBuy runat="server" ID="buy" />
        </asp:View>
        <asp:View runat="server" ID="vHowSell">
          <gt:HowToSell runat="server" ID="sell" />
        </asp:View>
        <asp:View runat="server" ID="vBilling">
          <gt:Billing runat="server" ID="billing" />
        </asp:View>
        <asp:View runat="server" ID="vRules">
          <gt:Rules runat="server" ID="rules" />
        </asp:View>
      </asp:MultiView>
    </div>
    <div class="help-contacts">
      <gt:ContactInfo runat="server" ID="ci" />
    </div>
  </div>
</asp:Content>
