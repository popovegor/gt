<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true"
    Codebehind="SignIn.aspx.cs" Inherits="GT.Web.Site.Authentication.SignIn" %>
<%@ Register Src="~/Authentication/SignInControl.ascx" TagPrefix="gt" TagName="login" %>

<%@ Import Namespace="System.Web.Security" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
   <gt:login ID="login" runat="server" CssClass="page" />
</asp:Content>
