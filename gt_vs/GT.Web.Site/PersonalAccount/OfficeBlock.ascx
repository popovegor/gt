<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OfficeBlock.ascx.cs" Inherits="GT.Web.Site.PersonalAccount.OfficeBlock" %>
<%@ Import Namespace="GT.Global.MessageSystem" %>
<%@ Import Namespace="GT.Web.Security" %>
<%@ Import Namespace="GT.DA.UserRating" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Import Namespace="GT.DA.MessageSystem" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Web.UI.Controls" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<table rules="none" class="office-block">
  <tbody>
    <tr>
      <td class="title-img" rowspan="2">
        <a href='<%= Url %>' class="<%= TitleImgClass %>">&nbsp;</a>
      </td>
      <td class="title">
        <% if (AsLink)
           {%>
        <a href='<%= Url %>' class="<%= TitleClass %>">
          <%= Title %></a>
        <%}
           else
           { %>
        <span class="<%= TitleClass %>">
          <%= Title %></span>
        <%} %>
      </td>
    </tr>
    <tr>
      <td class="content">
        <asp:PlaceHolder ID="phContent" runat="server"></asp:PlaceHolder>
      </td>
    </tr>
  </tbody>
</table>
