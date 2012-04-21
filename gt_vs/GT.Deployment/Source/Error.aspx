<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master"
    AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="GT.Web.Site.Error" %>
<%@ Import Namespace="Resources" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
<div id="errorPage">
    <asp:Label runat="server" CssClass="errorText" Text="<%$ Resources:CommonResources,ErrorMain %>" />
</div>
</asp:Content>
