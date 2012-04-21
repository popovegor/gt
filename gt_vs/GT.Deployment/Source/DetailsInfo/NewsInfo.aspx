<%@ Page Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="NewsInfo.aspx.cs" Inherits="GT.Web.Site.DetailsInfo.NewsInfo" %>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
    <asp:Label ID="err" runat="server" Visible="false" CssClass="error"></asp:Label>
    <asp:panel ID="info" runat="server">
        <table class="detailView">
          <tr>
            <td><i><%# News.CreateDate.ToString("dd MMMM") %></i></td>
          </tr>
          <tr>
            <td><b><%# News.LocalizedTitle %></b></td>
          </tr>
          <tr>
            <td><%# News.LocalizedBody %></td>
          </tr>
        </table>
   </asp:panel>
</asp:Content>
