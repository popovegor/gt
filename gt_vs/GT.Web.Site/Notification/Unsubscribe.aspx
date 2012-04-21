<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="Unsubscribe.aspx.cs" Inherits="GT.Web.Site.Notification.Unsubscribe" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <div id="unsubscibe">
    <p><%=CommonResources.Notification_Unsubscibe%></p>
    <p><%=string.Format(CommonResources.Notification_Resubscribe, "/PersonalAccount/Profile.aspx")%></p>
  </div>
</asp:Content>
