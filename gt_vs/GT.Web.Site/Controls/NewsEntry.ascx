<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsEntry.ascx.cs" Inherits="GT.Web.Site.Controls.NewsEntry" %>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Common.Types" %>

<table class="newsEntry" rules="none">
  <tbody>
    <tr>
      <td class="date">
        <span>
          <%# Entry.CreateDate.UtcToLocal("dd MMM yyyy")%>
        </span>
      </td>
      <td class="header">
        <asp:HyperLink ID="hpHeader" CssClass="header" runat="server" Text='<%# Entry.LocalizedTitle %>' NavigateUrl='<%# string.Format("~/News/{1}", GT.Global.News.NewsInfoParams.NEWSID, Entry.NewsId ) %>' />
      </td>
    </tr>
    <tr>
      <td>
        &nbsp;
      </td>
      <td class="body">
        <%# NewsFacade.CutNews(Entry)%>
        <asp:HyperLink ID="next" CssClass="more" runat="server" Text="<%# GT.Localization.Resources.CommonResources.More %>" NavigateUrl='<%# string.Format("~/News/{1}", GT.Global.News.NewsInfoParams.NEWSID, Entry.NewsId ) %>'  />
      </td>
    </tr>
  </tbody>
</table>
