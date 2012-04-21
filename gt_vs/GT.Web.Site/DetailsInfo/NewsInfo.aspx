<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="NewsInfo.aspx.cs" Inherits="GT.Web.Site.DetailsInfo.NewsInfo" %>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>

<%@ Register Src="~/Controls/NewsEntry.ascx" TagName="NewsEntry" TagPrefix="gt" %>

<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
    <asp:Label ID="err" runat="server" Visible="false" CssClass="error"></asp:Label>
    <asp:panel ID="info" runat="server">
<%--    
        <table class="detailView">
          <tr>
            <td><%# News.CreateDate.UtcToLocal().ToString("dd MMMM") %></td>
          </tr>
          <tr>
            <td><b><%# News.LocalizedTitle %></b></td>
          </tr>
          <tr>
            <td>
            <td><%# News.LocalizedBody %></td>
          </tr>
        </table>--%>
        
        <table class="newsEntry" rules="none">
  <tbody>
    <tr>
      <td class="date">
        <span>
          <%# News.CreateDate.UtcToLocal("dd MMM yyyy")%>
        </span>
      </td>
      <td class="header">
        <b><%# News.LocalizedTitle %></b>
      </td>
    </tr>
    <tr>
      <td>
        &nbsp;
      </td>
      <td class="body">
        <%# News.LocalizedBody %>
       <%-- <asp:HyperLink ID="next" CssClass="more" runat="server" Text="<%# GT.Localization.Resources.CommonResources.More %>" NavigateUrl='<%# string.Format("~/News/{1}", GT.Global.News.NewsInfoParams.NEWSID, Entry.NewsId ) %>'  />--%>
      </td>
    </tr>
  </tbody>
</table>
        <%--<gt:NewsEntry Entry="<%# News %>" runat="server" />--%>
   </asp:panel>
</asp:Content>
