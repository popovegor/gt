<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="UnusedFeedbacks.aspx.cs" Inherits="GT.Web.Site.UserRating.UnusedFeedbacks" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <div id="unused-feedbacks">
    <asp:GridView ID="gv" runat="server" AllowPaging="true" AutoGenerateColumns="false" GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" DataSource="<%# UserRatingFacade.GetUnusedForUser(Credentials.UserId) %>" CssClass="grid transfers" EnableViewState="false">
    <PagerStyle CssClass="pager" />
    <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
    <%--<AlternatingRowStyle CssClass="grid-alternative-row" />--%>
    <Columns>
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="grid-header-left" ItemStyle-CssClass="grid-item-left">
        <ItemTemplate><span>&nbsp;</span> </ItemTemplate>
      </asp:TemplateField>
      
      
      
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="grid-header-right" ItemStyle-CssClass="grid-item-right">
        <ItemTemplate><span>&nbsp;</span> </ItemTemplate>
      </asp:TemplateField>
    </Columns>
    <EmptyDataRowStyle CssClass="grid-empty" />
    <EmptyDataTemplate>
      <%# GT.Localization.Resources.CommonResources.UserRating_UnusedFeedbacks_NoData %>
    </EmptyDataTemplate>
      </asp:GridView>
  </div>
</asp:Content>
