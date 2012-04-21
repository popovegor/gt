﻿<%@ Control Language="C#" AutoEventWireup="true" Codebehind="CompleteRegistration.ascx.cs"
	Inherits="GT.Web.Site.HtmlTemplates.CompleteRegistration" %>
<%@ Import Namespace="GT.Localization.Resources" %>
	
<%# CommonResources.RegistrationEmailBody %>
<a target="_blank" href='<%# String.Format("http://{0}/Confirm?code={1}", Host, Code ) %>'><%# CommonResources.RegistrationEmailLink  %></a>
<br /><br />
<strong><%# CommonResources.RegistrationInfo %></strong>
<br />
<table border="0" rules="none">
	<tbody>
		<tr>
			<td>
				<span><%# CommonResources.Login %>:</span>
			</td>
			<td>
				<span><%# Login %></span>
			</td>
		</tr>
		<tr>
			<td>
				<span><%# CommonResources.Password %></span>
			</td>
			<td>
				<span><%# Password %></span>
			</td>
		</tr>
	</tbody>
</table>