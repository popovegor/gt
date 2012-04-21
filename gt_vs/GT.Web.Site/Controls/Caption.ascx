<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Caption.ascx.cs" Inherits="GT.Web.Site.Controls.Caption" %>
<div id="caption">
  <div class="title">
    <h1>
      <asp:SiteMapPath ID="smpCaption" ParentLevelsDisplayed="0" runat="server" SkipLinkText="" />
    </h1>
  </div>
  <div class="breadcrumbs">
    <asp:SiteMapPath ID="smpBreadcrumbs" PathSeparator=" > " PathSeparatorStyle-CssClass="breadcrumbs-separator" SkipLinkText="" ParentLevelsDisplayed="1" runat="server">
      <CurrentNodeStyle CssClass="currentNode" />
    </asp:SiteMapPath>
  </div>
</div>
