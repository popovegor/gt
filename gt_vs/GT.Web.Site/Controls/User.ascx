<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="User.ascx.cs" Inherits="GT.Web.Site.Controls.User" %>

<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Import Namespace="GT.Global.Users" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<% if (IsEmpty == true)
   { %>
<span></span>
<% }
   else if (IsSystemUser == true)
   {
%>
  <b class="user"><%= UserName %></b>
<%}
   else
   {
     if (ShowUserCard == true)
     {
   %>
    <span class="user-card">&nbsp;</span>   
   <%} %>
<a runat="server" id="user" target="_self" class="user" href='<%# string.Format("~/Users/User/{1}/{2}", UserCardParams.UserId, UserId, UserCardParams.Data.Info) %>' onclick='<%#  "return true; if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + UserId + "\"}); return false;} return true;"%>'>
  <%= UserName %></a>
<% if (ShowNewWindow == true)
   {%>
<a class="new-window" runat="server" href='<%# string.Format("~/Users/User/{1}", UserCardParams.UserId, UserId) %>' target="_blank" title="<%# CommonResources.OpenNewWindow %>">&nbsp;</a>
<% }%>
<% } %>