<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="BuyingViewer.aspx.cs" Inherits="GT.Web.Site.Offers.BuyingViewer" EnableViewState="false" EnableEventValidation="false" %>

<%@ Register Src="~/Offers/Filter.ascx" TagName="ViewFilter" TagPrefix="gt" %>
<%@ Register Assembly="GT.Web.UI" Namespace="GT.Web.UI.Controls" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Game.ascx" TagName="Game" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Server.ascx" TagName="Server" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Offer.ascx" TagName="Offer" TagPrefix="gt" %>

<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.Global.Entities" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.BO.Implementation.Offers" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy runat="server" ID="smpMain" />
  <div id="buying" class="offers">
  <gt:ViewFilter runat="server" ID="gtViewFilter" Entity="<%# EntityType.BuyingOffer %>" />
     <gt:SEOGridView runat="server" ID="gv" AllowPaging="true" AutoGenerateColumns="false" GridLines="None" PageSize="20" CssClass="grid entries" DataSource="<%# BuyingFacade.SearchOffersAsCollection(gtViewFilter.SearchFilter) %>" PagerStyle-CssClass="pager" PagerCss="pager">
      <PagerSettings PageButtonCount="10" />
      <%--<PagerStyle CssClass="pager" />--%>
      <%--<AlternatingRowStyle CssClass="grid-alternative-row" />--%>
      <Columns>
        <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-left" ItemStyle-CssClass="grid-item-left">
          <ItemStyle CssClass="grid-item-left" />
          <ItemTemplate>&nbsp;</ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="game" />
          <HeaderTemplate>
            <%#  GT.Localization.Resources.CommonResources.Game %>
          </HeaderTemplate>
          <ItemTemplate>
            <gt:Game runat="server" ID="g" ServerId="<%# (int)Eval(BuyingOfferFields.GameServerId) %>" ShowNewWindow="false" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="server" />
          <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.Server %>
          </HeaderTemplate>
          <ItemTemplate>
          <gt:Server runat="server" ID="s" ServerId="<%# (int)Eval(BuyingOfferFields.GameServerId) %>" ShowNewWindow="false" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="title" />
          <HeaderTemplate>
            <%#  GT.Localization.Resources.CommonResources.Offers_BuyingViewer_Title %>
          </HeaderTemplate>
          <ItemTemplate>
             <gt:Offer runat="server" OfferType="BuyingOffer" OfferId="<%# (int)Eval(BuyingOfferFields.BuyingOfferId) %>" Title="<%# (string)Eval(BuyingOfferFields.Title)  %>" ID="buy" ShowNewWindow="true" ShowProductCategory="true" OfferData="<%# Container.DataItem %>" ShowDetailsLink="true" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="buyer" />
           <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.Buyer %>
          </HeaderTemplate>
          <ItemTemplate>
                <gt:User runat="server" ShowUserCard="true" ID="uSeller" UserId="<%# Eval(BuyingOfferFields.BuyerId) %>" ShowNewWindow="false" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="price" />
          <ItemStyle CssClass="price" />
           <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.Price %>
          </HeaderTemplate>
          <ItemTemplate>
             <asp:Label runat="server" ID="lblPrice" Text='<%# TypeConverter.ToDecimal(Eval(BuyingOfferFields.Price)) > 0 ? string.Format("{0:0.##}", TypeConverter.ToDecimal(Eval(BuyingOfferFields.Price))) : CommonResources.Offers_NoPrice %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
          <HeaderStyle CssClass="date" />
           <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.UpdatedOn %>
          </HeaderTemplate>
          <ItemTemplate>
            <asp:Label runat="server" ID="lblUpdate" Text='<%# ((DateTime)Eval(BuyingOfferFields.ModifyDate)).UtcToLocal(CommonResources.Offers_BuyingViewer_DateFormat) %>' />
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
