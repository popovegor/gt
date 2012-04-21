<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true"
  CodeBehind="SellingViewer.aspx.cs" Inherits="GT.Web.Site.Offers.SellingViewer"
  EnableEventValidation="false" %>

<%@ Register Src="~/Offers/ViewFilter.ascx" TagName="ViewFilter" TagPrefix="gt" %>
<%@ Register Assembly="GT.Web.UI" Namespace="GT.Web.UI.Controls" TagPrefix="gt" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy runat="server" ID="smpMain" />
  <gt:ViewFilter runat="server" ID="gtViewFilter" />
  <div id="offers">
    <gt:SEOGridView runat="server" ID="dgOffers" AllowPaging="true" AutoGenerateColumns="false"
      GridLines="None" PageSize="30" PagerStyle="margin: 0 1em 0 1em;"
      CssClass="grid offers">
      <PagerSettings PageButtonCount="10" />
      <AlternatingRowStyle CssClass="gridAlternative" />
      <Columns>
        <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderLeft" ItemStyle-CssClass="gridItemLeft">
        <ItemStyle CssClass="gridItemLeft" />
          <ItemTemplate>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Game %>">
          <HeaderStyle CssClass="game" />
          <ItemTemplate>
            <asp:HyperLink ID="hplGame" runat="server" Text="<%# Dictionaries.Instance.GetGameNameByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId])) %>"
              NavigateUrl='<%# string.Concat("~/DetailsInfo/GameInfo.aspx?GameID=",Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]))) %>'
              onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewGameInfo, {GameID : " + TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]))) + "}); return false;} return true;" %>'>
            </asp:HyperLink>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Server %>">
          <HeaderStyle CssClass="server" />
          <ItemTemplate>
            <asp:HyperLink ID="hplGameServer" runat="server" Text="<%# Dictionaries.Instance.GetGameServerNameById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId])) %>"
              NavigateUrl='<%# string.Concat("~/DetailsInfo/GameServerInfo.aspx?GameServerId=",(Container.DataItem as DataRow)[SellingOfferFields.GameServerId] ) %>'
              onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameServerInfo, {GameServerID : ", TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]), "}); return false;} return true;") %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Title %>">
          <HeaderStyle CssClass="title" />
          <ItemTemplate>
            <asp:HyperLink ID="hplOffer" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.Title]) %>"
              NavigateUrl='<%# string.Concat("~/DetailsInfo/OfferInfo.aspx?id=",(Container.DataItem as DataRow)[SellingOfferFields.SellingId] ) %>'
              onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewOfferInfo, {OfferID : ", TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId]), "}); return false;} return true;") %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Seller %>">
          <HeaderStyle CssClass="seller" />
          <ItemTemplate>
            <asp:HyperLink runat="server" ID="hplSeller" NavigateUrl='<%# string.Concat("~/DetailsInfo/UserInfo.aspx?UserId=", (Container.DataItem as DataRow)[SellingOfferFields.SellerId]) %>'
              Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellerName]) %>"
              onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + (Container.DataItem as DataRow)[SellingOfferFields.SellerId].ToString() + "\"}); return false;} return true;" %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Price %>">
          <HeaderStyle CssClass="price" />
          <ItemTemplate>
            <asp:Label runat="server" ID="lblPrice" Text='<%# string.Format("{0:0.##}", TypeConverter.ToDecimal((Container.DataItem as DataRow)[SellingOfferFields.Price])) %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Delivery %>">
          <HeaderStyle CssClass="delivery" />
          <ItemTemplate>
            <asp:Label runat="server" ID="lblDeliveryTime" Text='<%# string.Format(Resources.CommonResources.DeliveryTemplate, TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.DeliveryTime], SellingOfferParams.DefaultDeliveryTime)) %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, UpdatedOn %>">
          <HeaderStyle CssClass="right date" />
          <ItemTemplate>
            <asp:Label runat="server" ID="lblUpdate" Text='<%# string.Format("{0:f}", ((DateTime)(Container.DataItem as DataRow)[SellingOfferFields.CreateDate]).UtcToLocal()) %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderRight" ItemStyle-CssClass="gridItemRight">
          <ItemStyle CssClass="gridItemRight" />
          <ItemTemplate>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
      <EmptyDataRowStyle CssClass="gridEmpty" />
      <EmptyDataTemplate>
        <asp:Literal runat="server" Text="<%$ Resources:CommonResources, NoOffersFound %>"
          ID="noOffers" />
      </EmptyDataTemplate>
    </gt:SEOGridView>
  </div>
</asp:Content>
