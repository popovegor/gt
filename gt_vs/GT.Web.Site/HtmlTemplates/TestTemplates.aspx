<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Base.Master" AutoEventWireup="true" CodeBehind="TestTemplates.aspx.cs" Inherits="GT.Web.Site.HtmlTemplates.TestTemplates" Theme="Empty"  %>
<%@ Import Namespace="System.Linq" %>

<asp:Content ID="cntMain" ContentPlaceHolderID="cphBase" runat="server">

<h2>Change e-mail</h2>
<p>
   <% GT.Web.UI.HtmlTemplateSystem.HtmlTemplate<GT.Web.Site.HtmlTemplates.ChangeEmailConfirmation> body = new GT.Web.UI.HtmlTemplateSystem.HtmlTemplate<GT.Web.Site.HtmlTemplates.ChangeEmailConfirmation>();
      body.Template.Email = "test@mail.com";
            body.Template.Code = Guid.NewGuid().ToString();
            body.Template.Checker = GT.Common.Cryptography.Hash.ReadableHash(GT.Common.Cryptography.Hash.MD5, "test@mail.com" + body.Template.Code);
            body.Template.Host = Request.Url.Host;
            %>
            <%= body.GenerateHtml() %>
            </p>
            <h2>New message notificatoin</h2>
            <p>
              <% GT.Web.UI.HtmlTemplateSystem.HtmlTemplate<GT.Web.Site.HtmlTemplates.NewMessageNotification> message = new GT.Web.UI.HtmlTemplateSystem.HtmlTemplate<GT.Web.Site.HtmlTemplates.NewMessageNotification>();
              
      message.Template.SenderId = (Guid)(Membership.GetAllUsers().Cast<MembershipUser>().FirstOrDefault().ProviderUserKey);
      message.Template.RecipientId = Guid.NewGuid();
            
            %>
            <%= message.GenerateHtml() %>
            </p>
</asp:Content>
