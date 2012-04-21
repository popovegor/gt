<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Offer.ascx.cs" Inherits="GT.Web.Site.Controls.Offer" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="Microsoft.Security.Application" %>
<%@ Import Namespace="GT.Global.Entities" %>
<%

  var urlView = string.Empty;
  switch (OfferType)
  {
    case EntityType.SellingOffer:
      urlView = string.Format("/Selling/View/{0}", OfferId);
      break;
    case EntityType.BuyingOffer:
      urlView = urlView = string.Format("/Buying/View/{0}", OfferId);
      break;
  }
  var cssCategory = GetCssClassCategory(OfferData);

  if (string.IsNullOrEmpty(Title) == false)
  {
     if (ShowProductCategory && OfferData != null && OfferData.ProductCategoryId > 0)
     {%>
  <span class='<%= "product-category " + cssCategory %>'>
    <%= OfferData != null && false == string.IsNullOrEmpty(OfferData.ProductCategoryName) ? AntiXss.HtmlEncode(OfferData.ProductCategoryName) + " >": string.Empty%></span>
  <%}
    if (ShowDetailsLink == false)
    {%>
<a href='<%= urlView %>' target="_self" class="description-short">
<%= AntiXss.HtmlEncode(Title) %></a>
<% if (ShowNewWindow)
   {%>
<a href="<%= urlView %>" target="_blank" class="new-window" title="<%= CommonResources.OpenNewWindow %>">&nbsp;</a>
<%}
    }
     else
     { %>
<%--<i>
  <%= CommonResources.Offers_Title%>:&nbsp;&nbsp;</i>--%><span class="description-short"><%= AntiXss.HtmlEncode(Title) %></span>
<p class="details">
  <% }
    

if (ShowDetailsLink == true)
{%>
  <a href="<%= urlView %>" target="_self" title="<%= CommonResources.Offers_DeatilsTooltip %>">
  <%# CommonResources.Offers_Deatils%></a>
  <% if (ShowNewWindow)
     {%>
  <a href="<%= urlView %>" target="_blank" class="new-window" title="<%= CommonResources.OpenNewWindow %>">&nbsp;</a>
  <%} %>
  <%} %>
</p>
<%} %>
