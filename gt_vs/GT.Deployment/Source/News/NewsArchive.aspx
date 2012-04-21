<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true" CodeBehind="NewsArchive.aspx.cs" Inherits="GT.Web.Site.News.NewsArchive" %>

<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Register Assembly="GT.Web.UI" Namespace="GT.Web.UI.Controls" TagPrefix="gt" %>
<%@ Register Src="~/Controls/NewsEntry.ascx" TagName="NewsEntry" TagPrefix="gt" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <div id="news">
    <gt:SEOGridView ID="gvNews" runat="server" CssClass="gridNews" GridLines="None" AllowPaging="true" AutoGenerateColumns="false" PageSize="20" DataSource="<%# News %>" PagerStyle="margin: 0 1em 0 1em;" ShowHeader="false">
      <AlternatingRowStyle CssClass="gridAlternative" />
      <PagerSettings PageButtonCount="10" />
      <Columns>
        <asp:TemplateField>
          <ItemStyle CssClass="newsEntry" />
          <ItemTemplate>
            <gt:NewsEntry runat="server" ID="ne" Entry="<%# (News)Container.DataItem %>" />
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
      <EmptyDataRowStyle CssClass="gridEmpty" />
      <EmptyDataTemplate>
        <asp:Literal runat="server" Text="<%$ Resources:CommonResources, NoNewsFound %>" ID="noOffers" />
      </EmptyDataTemplate>
    </gt:SEOGridView>
  </div>
</asp:Content>
