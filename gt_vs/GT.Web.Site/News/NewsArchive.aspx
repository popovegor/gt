<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="NewsArchive.aspx.cs" Inherits="GT.Web.Site.News.NewsArchive" %>

<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Register Assembly="GT.Web.UI" Namespace="GT.Web.UI.Controls" TagPrefix="gt" %>
<%@ Register Src="~/Controls/NewsEntry.ascx" TagName="NewsEntry" TagPrefix="gt" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <div id="news">
    <gt:SEOGridView ID="gvNews" runat="server" CssClass="gridNews" GridLines="None" AllowPaging="true" AutoGenerateColumns="false" PageSize="20" DataSource="<%# News %>" PagerStyle="margin: 0 1em 0 1em;" ShowHeader="false">
      <AlternatingRowStyle CssClass="grid-alternative-row" />
      <PagerSettings PageButtonCount="10" />
      <Columns>
        <asp:TemplateField>
          <ItemStyle CssClass="newsEntry" />
          <ItemTemplate>
            <gt:NewsEntry runat="server" ID="ne" Entry="<%# (News)Container.DataItem %>" />
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
      <EmptyDataRowStyle CssClass="grid-empty" />
      <EmptyDataTemplate>
        <asp:Literal runat="server" Text="<%# GT.Localization.Resources.CommonResources.NoNewsFound %>" ID="noOffers" />
      </EmptyDataTemplate>
    </gt:SEOGridView>
  </div>
</asp:Content>
