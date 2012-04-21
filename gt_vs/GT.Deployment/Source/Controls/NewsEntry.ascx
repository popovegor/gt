<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsEntry.ascx.cs" Inherits="GT.Web.Site.Controls.NewsEntry" %>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Common.Types" %>
<table class="newsEntry" rules="none">
  <tbody>
    <tr>
      <td class="date">
        <span>
          <%# string.Format("{0:dd MMM}", Entry.CreateDate.UtcToLocal())%>
        </span>
      </td>
      <td class="header">
        <asp:HyperLink ID="hpHeader" CssClass="header" runat="server" Text='<%# Entry.LocalizedTitle %>' NavigateUrl='<%# string.Format("~/DetailsInfo/NewsInfo.aspx?{0}={1}", GT.Global.News.NewsInfoParams.NEWSID, Entry.NewsId ) %>' onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewNewsInfo, {NewsID : ", TypeConverter.ToString(Entry.NewsId), "}); return false;} return true;") %>' />
      </td>
    </tr>
    <tr>
      <td>
        &nbsp;
      </td>
      <td class="body">
        <%# NewsFacade.CutNews(Entry)%>
        <asp:HyperLink ID="next" CssClass="more" runat="server" Text="<%$ Resources:CommonResources, More %>" NavigateUrl='<%# string.Format("~/DetailsInfo/NewsInfo.aspx?{0}={1}", GT.Global.News.NewsInfoParams.NEWSID, Entry.NewsId ) %>' onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewNewsInfo, {NewsID : ", TypeConverter.ToString(Entry.NewsId), "}); return false;} return true;") %>' />
      </td>
    </tr>
  </tbody>
</table>
