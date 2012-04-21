<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="SellingViewer.aspx.cs" Inherits="GT.Web.Site.Offers.SellingViewer" EnableViewState="false" EnableEventValidation="false"%>


<%@ Register Src="~/Offers/Filter.ascx" TagName="ViewFilter" TagPrefix="gt" %>
<%@ Register Assembly="GT.Web.UI" Namespace="GT.Web.UI.Controls" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Game.ascx" TagName="Game" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Server.ascx" TagName="Server" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Offer.ascx" TagName="Offer" TagPrefix="gt" %>


<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.Global.Entities" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.BO.Implementation.Offers" %>
<%@ Import Namespace="GT.Localization.Resources" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy runat="server" ID="smpMain" />
  <div id="selling" class="offers">
  <gt:ViewFilter runat="server" ID="gtViewFilter" Entity="<%# EntityType.SellingOffer %>" />
    <gt:SEOGridView runat="server" ID="gv" AllowPaging="true" AutoGenerateColumns="false" GridLines="None" PageSize="20" CssClass="grid entries" DataSource="<%# SellingFacade.SearchOffersAsCollection(gtViewFilter.SearchFilter) %>" PagerStyle-CssClass="pager" PagerCss="pager">
      <PagerSettings PageButtonCount="10" />
      <%--<AlternatingRowStyle CssClass="grid-alternative-row" />--%>
      <Columns>
        <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-left" ItemStyle-CssClass="grid-item-left">
          <ItemStyle CssClass="grid-item-left" />
          <ItemTemplate>&nbsp;</ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="game" />
          <ItemStyle CssClass="" />
          <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.Game %>
          </HeaderTemplate>
          <ItemTemplate>
            <gt:Game runat="server" ID="g" ServerId="<%# (int)Eval(SellingOfferFields.GameServerId) %>" ShowNewWindow="false" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="server" />
          <ItemStyle CssClass="" />
          <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.Server %>
          </HeaderTemplate>
          <ItemTemplate>
             <gt:Server runat="server" ID="s" ServerId="<%# (int)Eval(SellingOfferFields.GameServerId) %>" ShowNewWindow="false" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="title" />
          <ItemStyle CssClass="title" />
          <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.Offers_SellingViewer_Title %>
          </HeaderTemplate>
          <ItemTemplate>
            <gt:Offer runat="server" ID="sel" OfferId="<%# (int)Eval(SellingOfferFields.SellingId) %>" Title="<%#  (string)Eval(SellingOfferFields.Title) %>" ShowNewWindow="true" OfferData="<%# Container.DataItem %>" ShowProductCategory="true" ShowDetailsLink="true" OfferType="SellingOffer" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="seller" />
          <ItemStyle CssClass="" />
          <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.Seller %>
          </HeaderTemplate>
          <ItemTemplate>
            <gt:User runat="server" ShowUserCard="true" ID="uSeller" UserId="<%# Eval(SellingOfferFields.SellerId) %>" ShowNewWindow="false" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="price" />
          <ItemStyle CssClass="price" />
          <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.Price %>
          </HeaderTemplate>
          <ItemTemplate>
            <asp:Label runat="server" ID="lblPrice" Text='<%# string.Format("{0:0.##}", TypeConverter.ToDecimal(Eval(SellingOfferFields.Price))) %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <%-- <asp:TemplateField>
          <HeaderStyle CssClass="delivery" />
          <ItemTemplate>
            <asp:Label runat="server" ID="lblDeliveryTime" Text='<%# string.Format(Resources.CommonResources.DeliveryTemplate, TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.DeliveryTime], SellingOfferParams.DefaultDeliveryTime)) %>' />
          </ItemTemplate>
        </asp:TemplateField>--%>
        <asp:TemplateField>
          <HeaderStyle CssClass="date" />
          <ItemStyle CssClass="" />
          <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.UpdatedOn %>
          </HeaderTemplate>
          <ItemTemplate>
            <asp:Label runat="server" ID="lblUpdate" Text='<%# ((DateTime)Eval(SellingOfferFields.ModifyDate)).UtcToLocal(CommonResources.Offers_SellingViewer_DateFormat) %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-right" ItemStyle-CssClass="grid-item-right">
          <ItemStyle CssClass="grid-item-right" />
          <ItemTemplate>&nbsp;</ItemTemplate>
        </asp:TemplateField>
      </Columns>
      <EmptyDataRowStyle CssClass="grid-empty" />
      <EmptyDataTemplate>
        <asp:Literal runat="server" Text="<%# GT.Localization.Resources.CommonResources.NoOffersFound %>" ID="noOffers" />
      </EmptyDataTemplate>
    </gt:SEOGridView>
  </div>

</asp:Content>
