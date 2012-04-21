<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="User.ascx.cs" Inherits="GT.Web.Site.Controls.User" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<% if (IsSystemUser == true)
   {
%>
<asp:Label runat="server" Text="<%# UserName %>"/>
<%}
   else
   { %>
<a runat="server" id="user" target="_blank" class="User" href='<%# string.Format("~/UsersInfo.aspx?UserID={0}", UserId) %>' onclick='<%#  "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + UserId + "\"}); return false;} return true;"%>'>
  <%= UserName %></a>
<% } %>