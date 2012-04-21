<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RecoveryPassword.ascx.cs" Inherits="GT.Web.Site.HtmlTemplates.RecoveryPassword" %>
<%@ Import Namespace="GT.Localization.Resources" %>

<%# CommonResources.PasswordRecoveryMailBody %>
<br />
<br />
<table border="0">
	<tbody>
		<tr>
			<td>
				<span><%# CommonResources.Login %></span>
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