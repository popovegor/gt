<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Server.ascx.cs" Inherits="GT.Web.Site.Controls.Server" %>
<%@ Import Namespace="GT.Localization.Resources" %>


<a target="_self" href='<%= string.Format("/Servers/Server/{0}", ServerId) %>' title="<%= Name %>" ><%= Name %></a>
<% if(ShowNewWindow) {%>
  <a href="<%= string.Format("/Servers/Server/{0}", ServerId) %>" target="_blank"  class="new-window" title="<%= CommonResources.OpenNewWindow %>">&nbsp;</a>
<%} %>

