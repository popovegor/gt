<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Newsletters.ascx.cs" Inherits="GT.Web.Site.Controls.Newsletters" %>
<%--<%@ OutputCache Duration="600" Shared="true" VaryByParam="none" VaryByCustom="culture" %>--%>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Register Src="~/Controls/Panel.ascx" TagName="Panel" TagPrefix="gt" %>
<%@ Register Src="~/Controls/NewsEntry.ascx" TagName="NewsEntry" TagPrefix="gt" %>
<div class="newsletters">
  <gt:Panel runat="server" ID="newsBox">
    <Content>
      <asp:Label runat="server" CssClass="news-title" Text="<%# CommonResources.News %>" />
      <asp:HyperLink ID="archiveLink" runat="server" NavigateUrl="~/News/NewsArchive" CssClass="archive-title" Text="<%# GT.Localization.Resources.CommonResources.Archive %>" />
    </Content>
  </gt:Panel>
  <asp:GridView ID="gvNews" runat="server" CssClass="gridNews" GridLines="None" AllowPaging="false" AllowSorting="false" AutoGenerateColumns="false" PageSize="10000" DataSource="<%# News %>" ShowFooter="false" ShowHeader="false" Width="100%">
    <AlternatingRowStyle CssClass="grid-alternative-row" />
    <Columns>
      <asp:TemplateField>
        <ItemStyle CssClass="newsEntry" />
        <ItemTemplate>
          <gt:NewsEntry runat="server" ID="ne" Entry="<%# (News)Container.DataItem %>" />
        </ItemTemplate>
      </asp:TemplateField>
    </Columns>
  </asp:GridView>
</div>
