<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="GT.Web.Site.Authentication.SignIn" %>

<%@ Register Src="~/Authentication/SignInControl.ascx" TagPrefix="gt" TagName="login" %>
<%@ Import Namespace="GT.Global.Security" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="GT.Localization.Resources" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <div class="signIn">
    <gt:login ID="login" runat="server" CssClass="page" />
    <div class="accessDenied">
      <asp:Label runat="server" ID="lblDenied" Text='<%# CommonResources.Authentication_SignIn_AccessDenied %>' Visible="<%# Credentials.IsInRole(RolesSettings.NonactivatedUser) %>" />
    </div>
  </div>
</asp:Content>
