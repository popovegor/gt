<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewMessageNotification.ascx.cs" Inherits="GT.Web.Site.HtmlTemplates.NewMessageNotification" %>

<%@ Register TagName="User" TagPrefix="gt" Src="~/Controls/User.ascx" %>
<%@ Import Namespace="GT.Global.Notification" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.Global.Users" %>

<p>
  <%= string.Format(CommonResources.HtmlTemplates_NewMessageNotification_Body1, string.Format("http://{0}/Office/Messages/{2}", HttpContext.Current.Request.Url.GetComponents(UriComponents.Host | UriComponents.Port,UriFormat.UriEscaped),  GT.Global.MessageSystem.MessageFilterParams.Direction, GT.BO.Implementation.MessageSystem.MessageType.In)) %>
</p>
<p>
  <%= string.Format(CommonResources.HtmlTemplates_Unsubscribe, string.Format("http://{0}/Unsubscribe?{1}={2}&{3}={4}", HttpContext.Current.Request.Url.GetComponents(UriComponents.Host | UriComponents.Port,UriFormat.UriEscaped), UnsubscribeParams.UserId, RecipientId, UnsubscribeParams.NotificationType, UnsubscribeParams.Notification.Email)) %>
</p>
<p>
  <i><%= CommonResources.HtmlTemplates_NoReply%></i>
</p>