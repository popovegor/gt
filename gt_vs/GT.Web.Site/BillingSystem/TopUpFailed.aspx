<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="TopUpFailed.aspx.cs" Inherits="GT.Web.Site.BillingSystem.TopUpFailed" EnableViewStateMac="false" %>
<%@ Import Namespace="GT.Localization" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
    <p>
      <asp:Label runat="server" ID="lblError" CssClass="error" Text="<%# GT.Localization.Resources.CommonResources.PaymentFail %>" EnableViewState="false" Visible="false" />
    </p>
</asp:Content>
