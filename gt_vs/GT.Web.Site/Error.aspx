<%@ Page Language="C#" MasterPageFile="~/MasterPages/Base.Master"
    AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="GT.Web.Site.Error" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Register Src="~/Support/Feedback.ascx" TagPrefix="gt" TagName="Feedback" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphBase" runat="server">
<div id="error-page">
  <div class="logo-gray">
    <a href="/" title="<%= SiteMap.RootNode.Title %>"></a>
  </div>
  <div class="error-sorry">
    <h1><%= CommonResources.Error_Sorry%></h1>
  </div>
  <div class="error-actions">
    <% var errorPageUrl = Request != null ? Request.QueryString["aspxerrorpath"] : string.Empty; %>
    <span><%= string.Format(CommonResources.Error_Actions, string.IsNullOrEmpty(errorPageUrl) == false ? errorPageUrl : "/") %></span>
  </div>
</div>
<gt:Feedback runat="server" ID="fdb" />
</asp:Content>
