<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GT.Web.Site.Default" EnableEventValidation="false" %>

<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Resources" %>
<%@ Register TagName="FastOfferSearch" TagPrefix="gt" Src="~/Controls/FastOfferSearch.ascx" %>
<%@ Register Src="~/Controls/Box.ascx" TagName="Box" TagPrefix="gt" %>
<%@ Register Src="~/Authentication/SignInControl.ascx" TagPrefix="gt" TagName="login" %>
<%@ Register TagName="Newsletters" TagPrefix="gt" Src="~/Controls/Newsletters.ascx" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <div id="welcome">
    <%= CommonResources.Welcome %>
  </div>
  <div class="leftSide">
    <gt:Box runat="server" ID="bxPopGames" CssClass="boxPopGames boxBrown"><Title>
      <%= CommonResources.TopGames %></Title>
      <Content>
        <asp:DataList ID="dlPopGames" runat="server" RepeatColumns="1" RepeatLayout="Flow" DataSource="<%# Games %>" RepeatDirection="Vertical" HorizontalAlign="Center" CellSpacing="20">
          <ItemTemplate>
            <asp:HyperLink ID="link" runat="server" NavigateUrl='<%# String.Format("~/Offers/SellingViewer.aspx?s=true&g={0}", ((DataRow)Container.DataItem)[GameFields.GameId] ) %>' Text='<%# ((DataRow)Container.DataItem)[GameFields.LocalizedName] %>'></asp:HyperLink>
          </ItemTemplate>
          <SeparatorStyle Height="8" />
          <SeparatorTemplate>&nbsp; </SeparatorTemplate>
        </asp:DataList>
      </Content>
    </gt:Box>
  </div>
  <div class="rightSide">
    <gt:Box runat="server" ID="bxPopServers" CssClass="boxPopServers boxBrown"><Title>
      <%= CommonResources.TopServers %></Title>
      <Content>
        <asp:DataList ID="dlPopServer" runat="server" RepeatColumns="1" RepeatLayout="Flow" DataSource="<%# Servers %>" RepeatDirection="Vertical" HorizontalAlign="Center" CellSpacing="20">
          <ItemTemplate>
            <asp:HyperLink ID="link" runat="server" NavigateUrl='<%# String.Format("~/Offers/SellingViewer.aspx?s=true&g={0}&gs={1}", ((DataRow)Container.DataItem)[GameServerFields.GameId], ((DataRow)Container.DataItem)[GameServerFields.GameServerId] ) %>' Text='<%# ((DataRow)Container.DataItem)[GameServerFields.LocalizedName] %>'></asp:HyperLink>
          </ItemTemplate>
          <SeparatorStyle Height="8" />
          <SeparatorTemplate>&nbsp; </SeparatorTemplate>
        </asp:DataList>
      </Content>
    </gt:Box>
  </div>
  <div class="centerContent">
    <div class="quickActions">
      <table rules="none">
        <tr>
          <td class="buy">
            <a runat="server" href="/Offers/EditBuying.aspx?Id=0&url=%2FOffers%2FBuyingManager.aspx" id="buy"><span>
              <%= Resources.CommonResources.Default_Buy%></span> </a>
          </td>
          <td class="sell">
            <a runat="server" href="/Offers/EditSelling.aspx?Id=0&url=%2FOffers%2FSellingManager.aspx" id="sell"><span>
              <%= Resources.CommonResources.Default_Sell%></span> </a>
          </td>
        </tr>
      </table>
    </div>
    <div id="fastSearch">
      <div class="title">
        <span>
          <%= Resources.CommonResources.Default_FastSearchTitle %></span>
      </div>
      <gt:FastOfferSearch runat="server" ID="search" />
    </div>
    <div id="news">
      <gt:Newsletters runat="server" ID="newsletters" />
    </div>
  </div>

  <script type="text/javascript" language="javascript">
    //<!{CDATA[
    Sys.Application.add_load(function() {
      $addHandler($get("<%= buy.ClientID %>"), "click", buy_onClick);
      $addHandler($get("<%= sell.ClientID %>"), "click", sell_onClick);
    });

    Sys.Application.add_unload(function() {
      $clearHandlers($get("<%= sell.ClientID %>"));
      $clearHandlers($get("<%= buy.ClientID %>"));
    });

    function buy_onClick(event) {
      signInPopup.open(
        function() { //success
          PopupManager.Open(EditBuying, { Id: 0, RedirectUrl: "%2FOffers%2FBuyingManager.aspx" });
          //window.redirect("/Offers/BuyingManager.aspx");
        }
        , function() { //failure
          //debugger;
        }
      );
      window.doCancelEvent(event);
    }

    function sell_onClick(event) {
      signInPopup.open(
        function() { //success
          PopupManager.Open(EditSelling, { Id: 0, RedirectUrl: "%2FOffers%2FSellingManager.aspx" });
          //window.redirect("/Offers/SellingManager.aspx");
        }
        , function() { //failure
          //debugger;
        }
      );
      window.doCancelEvent(event);
    }
    //]]>    
  </script>

</asp:Content>
