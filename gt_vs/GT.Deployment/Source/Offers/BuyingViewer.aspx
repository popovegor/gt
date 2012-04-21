<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master"
    AutoEventWireup="true" CodeBehind="BuyingViewer.aspx.cs" Inherits="GT.Web.Site.Offers.BuyingViewer" EnableEventValidation="false" %>

<%@ Register Src="~/Offers/ViewFilter.ascx" TagName="ViewFilter" TagPrefix="gt" %>
<%@ Register Assembly="GT.Web.UI" Namespace="GT.Web.UI.Controls" TagPrefix="gt" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
    <asp:ScriptManagerProxy runat="server" ID="smpMain" />
    <gt:ViewFilter runat="server" ID="gtViewFilter" />
    <div id="offers">
       <gt:SEOGridView runat="server" ID="dgOffers" AllowPaging="true" AutoGenerateColumns="false"
          GridLines="None" PageSize="30" CssClass="grid offers" PagerStyle="margin: 0 1em 0 1em;">
            <PagerSettings PageButtonCount="10" />
            <AlternatingRowStyle CssClass="gridAlternative" />
            <Columns>
                <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderLeft" ItemStyle-CssClass="gridItemLeft">
                  <ItemTemplate>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$  Resources:CommonResources, Game %>">
                    <HeaderStyle CssClass="game" />
                    <ItemTemplate>
                        <asp:HyperLink ID="hplGame" runat="server" Text="<%# Dictionaries.Instance.GetGameNameByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId])) %>"
                             NavigateUrl='<%# string.Concat("~/DetailsInfo/GameInfo.aspx?GameID=",Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId]))) %>'
                             onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewGameInfo, {GameID : " + TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId]))) + "}); return false;} return true;" %>'>
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Server %>">
                    <HeaderStyle CssClass="server" />
                    <ItemTemplate>
                         <asp:HyperLink ID="hplGameServer" runat="server" Text="<%# Dictionaries.Instance.GetGameServerNameById(TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId])) %>"
                             NavigateUrl='<%# string.Concat("~/DetailsInfo/GameServerInfo.aspx?GameServerId=",(Container.DataItem as DataRow)[BuyingOfferFields.GameServerId] ) %>'
                             onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameServerInfo, {GameServerID : ", TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId]), "}); return false;} return true;") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$  Resources:CommonResources, Title %>">
                    <HeaderStyle CssClass="title" />
                    <ItemTemplate>
                         <asp:HyperLink ID="hplOffer" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.Title]) %>"
                              NavigateUrl='<%# string.Concat("~/DetailsInfo/BuyingOfferInfo.aspx?id=",(Container.DataItem as DataRow)[BuyingOfferFields.BuyingOfferId] ) %>'
                              onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewBuyingOfferInfo, {BuyingOfferID : ", TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.BuyingOfferId]), "}); return false;} return true;") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Buyer %>">
                    <HeaderStyle CssClass="buyer" />
                    <ItemTemplate>
                         <asp:HyperLink runat="server" ID="hplSeller" NavigateUrl='<%# string.Concat("~/DetailsInfo/UserInfo.aspx?UserId=", (Container.DataItem as DataRow)[BuyingOfferFields.BuyerId]) %>'
                              Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.BuyerName]) %>"
                              onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + (Container.DataItem as DataRow)[BuyingOfferFields.BuyerId].ToString() + "\"}); return false;} return true;" %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$  Resources:CommonResources, Price %>">
                    <HeaderStyle CssClass="price" />
                    <ItemTemplate>
                         <asp:Label runat="server" ID="lblPrice" Text='<%# string.Format("{0:0.##}", TypeConverter.ToDecimal((Container.DataItem as DataRow)[BuyingOfferFields.Price])) %>' Visible="<%# TypeConverter.ToDecimal((Container.DataItem as DataRow)[BuyingOfferFields.Price]) > 0 %>" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$  Resources:CommonResources, UpdatedOn %>">
                    <HeaderStyle CssClass="date" />
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblUpdate" Text='<%# string.Format("{0:f}", ((DateTime)(Container.DataItem as DataRow)[BuyingOfferFields.CreateDate]).UtcToLocal() ) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderRight" ItemStyle-CssClass="gridItemRight">
                  <ItemTemplate>
                  </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataRowStyle CssClass="gridEmpty" />
            <EmptyDataTemplate>
                <asp:Literal runat="server" Text="<%$ Resources:CommonResources, NoBuyingOffersFound %>"
                  ID="noOffers" />
             </EmptyDataTemplate>
        </gt:SEOGridView>
    </div>
</asp:Content>
