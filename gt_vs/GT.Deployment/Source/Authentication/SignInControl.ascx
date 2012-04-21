<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SignInControl.ascx.cs" Inherits="GT.Web.Site.Authentication.SignInControl" %>
<%@ Register TagPrefix="gt" Namespace="GT.Web.UI.Controls" Assembly="GT.Web.UI" %>
<%@ Register TagPrefix="gt" Src="~/Controls/Button.ascx" TagName="Button" %>
<%@ Import Namespace="Resources" %>
<div id="signIn" class="<%= CssClass %>">
  <asp:LoginView ID="lvLogin" runat="server">
    <AnonymousTemplate>
      <div id="headerSignIn">
        <p><a title="<%= CommonResources.CreateNewAccount %>" href="/Authentication/SignUp.aspx">
          <%= CommonResources.SignInWelcome %></a>
          <%= CommonResources.SignInSignIn %>
          <a href="/Authentication/PasswordRecovery.aspx">
            <%= CommonResources.SignInForgot %></a> </p>
      </div>
      <div id="alternativeHeaderSignIn">
        <a href="/Authentication/SignUp.aspx" title="<%= CommonResources.Register %>">
          <%= CommonResources.Register %></a> <a href="/Authentication/PasswordRecovery.aspx" title="<%= CommonResources.Forgot %>">
            <%= CommonResources.Forgot %></a>
      </div>
      <gt:CssLogin runat="server" ID="lgnAnonymousUser" BorderStyle="None" RenderOuterTable="False">
        <LayoutTemplate>
          <div id="login" onkeypress='javascript:return WebForm_FireDefaultButton(event, $("#btn").find(":input")[0].id)'>
            <div class="label">
              <%= CommonResources.SignUpUserName %>
            </div>
            <div class="textbox">
              <asp:TextBox ID="UserName" runat="server" ToolTip="<%$ Resources:CommonResources, UserName %>" />
              <span class="requiredFieldAsterisk">*</span>
              <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="UserName" ValidationGroup="loginCtrl" ErrorMessage="<%$ Resources:CommonResources, SignUpErrorUserName %>" Display="None" Text=""></asp:RequiredFieldValidator>
              <ajaxToolkit:ValidatorCalloutExtender ID="vceUserName" TargetControlID="rfvUserName" runat="server" />
            </div>
            <div class="label">
              <%= CommonResources.Password %>
            </div>
            <div class="textbox">
              <asp:TextBox ID="Password" runat="server" ToolTip="<%$ Resources:CommonResources, Psw %>" TextMode="Password" />
              <span class="requiredFieldAsterisk">*</span>
              <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="Password" ValidationGroup="loginCtrl" ErrorMessage="<%$ Resources:CommonResources, SignUpErrorEmptyPsw %>" Display="None" Text=""></asp:RequiredFieldValidator>
              <ajaxToolkit:ValidatorCalloutExtender ID="vcePassword" TargetControlID="rfvPassword" runat="server" />
            </div>
            <div id="btn">
              <gt:Button runat="server" ID="Loggin" Text="<%$ Resources:CommonResources, SignIn %>" CommandName="Login" ValidationGroup="loginCtrl" ToolTip="<%$ Resources:CommonResources, SignIn %>" UseSubmitBehavior="false"  />
            </div>
            <div id="remember">
              <p>
                <asp:CheckBox ID="RememberMe" Text="<%$ Resources:CommonResources, RememberMe %>" runat="server" ToolTip="<%$ Resources:CommonResources, RememberMe %>" />
              </p>
            </div>
            <div id="err">
              <asp:Label ID="FailureText" runat="server" EnableViewState="False" />
            </div>
          </div>
        </LayoutTemplate>
      </gt:CssLogin>
    </AnonymousTemplate>
    <LoggedInTemplate>
      <div id="signOut">
        <p>
          <%= CommonResources.SignedIn %><a href="/PersonalAccount/Office.aspx" class="user">
            <%= ((GT.Web.UI.Pages.BasePage)this.Page).Credentials.UserName %></a>.
          <asp:LoginStatus ID="lsStatus" runat="server" LogoutText="<%$ Resources:CommonResources, SignOut %>" LoginText="<%$ Resources:CommonResources, SignIn %>" />
        </p>
      </div>
    </LoggedInTemplate>
  </asp:LoginView>
</div>
