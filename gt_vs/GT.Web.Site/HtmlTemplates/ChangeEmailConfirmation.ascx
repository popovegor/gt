<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangeEmailConfirmation.ascx.cs"
 Inherits="GT.Web.Site.HtmlTemplates.ChangeEmailConfirmation" %>
<%@ Import Namespace="GT.Localization.Resources" %>

<%= CommonResources.ChangeEmailTemplateBody %>
<a target="_blank" href='<%# String.Format("http://{0}/Confirm?code={1}&email={2}&checker={3}", Host ,Code, Email, Checker ) %>'><%# CommonResources.RegistrationEmailLink  %></a>
