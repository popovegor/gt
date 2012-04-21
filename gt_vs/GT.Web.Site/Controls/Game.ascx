<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Game.ascx.cs" Inherits="GT.Web.Site.Controls.Game" %>
<%@ Import Namespace="GT.Localization.Resources" %>

<a target="_self" href='<%# string.Format("/Games/Game/{0}", GameId) %>' title="<%= Name %>" ><%= Name %> 
</a>

<% if(ShowNewWindow) {%>
<a href="<%= string.Format("/Games/Game/{0}", GameId) %>" target="_blank"  class="new-window" title="<%= CommonResources.OpenNewWindow %>">&nbsp;</a>
<%} %>


