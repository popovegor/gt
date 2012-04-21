<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomeOffer.ascx.cs" Inherits="GT.Web.Site.Controls.HomeOffer" %>
<%@ Import Namespace="GT.Web.Site.Controls" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.BO.Implementation.Offers.SearchFilters" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Web.UI.Controls" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation.News" %>
<%@ Import Namespace="GT.BO.Implementation.Offers" %>
<%@ Import Namespace="GT.Global.Entities" %>
<div class="o-item">
  <table style="width: 100%;">
    <tbody>
      <tr>
        <td class="o-item-game-category">
          <a href='<%= string.Format("/Games/Game/{0}", Dictionaries.Instance.GetGameIdByGameServerId(BaseOffer.GameServerId)) %>' title="" target="_self" class="o-item-game">
          <%= Dictionaries.Instance.GetGameNameByGameServerId(BaseOffer.GameServerId) %>
          </a><span>> </span><a class="<%--<%= Offer.GetCssClassCategory(s) %>--%>" href='<%= string.Format("/{0}?{1}={2}&{3}={4}", Entity == EntityType.BuyingOffer ? "Buying" : "Selling", ViewFilterParams.ProductCategoryId, BaseOffer.ProductCategoryId, ViewFilterParams.GameId, Dictionaries.Instance.GetGameIdByGameServerId(BaseOffer.GameServerId)) %>' target="_self" title='<%= string.Format(CommonResources.Show_Category_Offers, BaseOffer.ProductCategoryName, Dictionaries.Instance.GetGameNameByGameServerId(BaseOffer.GameServerId)) %>'>
          <%= string.Format("{0}", BaseOffer.ProductCategoryName)%></a>
        </td>
        <td style="width: 7em;">
          &nbsp;
        </td>
        <td class="o-item-more">
          <a href='<%= string.Format("/{0}/View/{1}", Entity == EntityType.BuyingOffer ? "Buying" : "Selling",BaseOffer.Id) %>' target="_self" title="<%= CommonResources.Offer_More %>"><%= CommonResources.More %></a>
        </td>
      </tr>
      <tr>
        <td class="o-item-desc">
          <span>
            <%= string.Concat("", BaseOffer.Title) %></span>
        </td>
        <td class='<%= Entity == EntityType.BuyingOffer ? "bo-item-price" : "so-item-price"  %>'>
          <% if(BaseOffer.Price > 0) {%>
          <%= string.Format("{0:## ## ##0.##}", BaseOffer.Price) %><span class="o-item-currency">&nbsp;&nbsp;<%= CommonResources.Currency %></span>
          <% } else { %>
          <span class="o-item-currency"><%= CommonResources.NoPrice%></span>
          <% }%>
        </td>
        <td class="o-item-date">
          <%= BaseOffer.ModifyDate.UtcToLocal(CommonResources.DateFormat) %>
        </td>
      </tr>
    </tbody>
  </table>
</div>
