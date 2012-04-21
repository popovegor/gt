<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Newsletters.ascx.cs" Inherits="GT.Web.Site.Controls.Newsletters" %>
<%@ OutputCache Duration="600" Shared="true" VaryByParam="none" VaryByCustom="culture" %>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Register Src="~/Controls/Box.ascx" TagName="Box" TagPrefix="gt" %>
<%@ Register Src="~/Controls/NewsEntry.ascx" TagName="NewsEntry" TagPrefix="gt" %>
<div class="newsletters">
  <gt:Box runat="server" ID="newsBox" CssClass="boxNewsletter boxBrown"><Title>
    <asp:Label runat="server" CssClass="newsTitle" Text="<%# CommonResources.News %>" />
    <asp:HyperLink ID="archiveLink" runat="server" NavigateUrl="~/News/NewsArchive.aspx" CssClass="archiveTitle" Text="<%$ Resources:CommonResources, Archive %>" />
  </Title>
    <Content>
      <asp:GridView ID="gvNews" runat="server" CssClass="gridNews" GridLines="None" AllowPaging="false" AllowSorting="false" AutoGenerateColumns="false" PageSize="10000" DataSource="<%# News %>" ShowFooter="false" ShowHeader="false" Width="100%">
        <AlternatingRowStyle CssClass="gridAlternative" />
        <Columns>
          <asp:TemplateField>
            <ItemStyle CssClass="newsEntry"/>
            <ItemTemplate>
              <gt:NewsEntry runat="server" ID="ne" Entry="<%# (News)Container.DataItem %>" />
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </Content>
  </gt:Box>
</div>
