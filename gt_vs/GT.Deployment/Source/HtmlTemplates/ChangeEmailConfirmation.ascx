<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangeEmailConfirmation.ascx.cs"
 Inherits="GT.Web.Site.HtmlTemplates.ChangeEmailConfirmation" %>
<%@ Import Namespace="Resources" %>

<%= CommonResources.ChangeEmailTemplateBody %>
<a target="_blank" href='<%# String.Format("http://{0}/Authentication/Confirmation.aspx?code={1}&mail={2}&checker={3}", Host ,Code, Email, Checker ) %>'><%# CommonResources.RegistrationEmailLink  %></a>
