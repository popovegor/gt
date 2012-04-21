<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LanguageSwitcher.ascx.cs" Inherits="GT.Web.Site.Controls.LanguageSwitcher" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.Global.Localization" %>

<% if (Localizator.CurrentLauguage == Languages.En)
   {%>
<b title="<%= CommonResources.EnglishVersion %>">
  <%# GT.Localization.Resources.CommonResources.English %></b>
<% }
   else
   { %>
<a href="<%= GetLanguageUrl("com") %>" target="_self" title="<%= CommonResources.EnglishVersion %>"><span><%= GT.Localization.Resources.CommonResources.English %></span></a>
<%}
   if (Localizator.CurrentLauguage == Languages.Ru)
   { %>
&nbsp;<b title="<%= CommonResources.RussianVersion %>"><%= GT.Localization.Resources.CommonResources.Russian %></b>
<%}
   else
   { %>
&nbsp;<a href="<%= GetLanguageUrl("ru") %>" target="_self" title="<%= CommonResources.RussianVersion %>"><span><%= GT.Localization.Resources.CommonResources.Russian %></span></a>
<%} %>