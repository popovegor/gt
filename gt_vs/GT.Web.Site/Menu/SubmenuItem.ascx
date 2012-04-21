<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubmenuItem.ascx.cs" Inherits="GT.Web.Site.Menu.SubmenuItem" %>
<% 
//var node = SiteMap.Provider.FindSiteMapNode(NavigateUrl);
//if(node != SiteMap.CurrentNode) {
var cur = Request.RawUrl;
if(cur != NavigateUrl) {
%>
<li class="<%= CssClass %>"><a href='<%= NavigateUrl %>'><span><%= Text %></span></a></li>
<%} else {%>
<li class="<%= CssClass %> current"><span><%= Text %></span>
<%--<i class="rc1 rc1-lt"></i>
              <i class="rc1 rc1-rt"></i>
              <i class="rc1 rc1-lb"></i>
              <i class="rc1 rc1-rb"></i>--%></li>
<%} %>
