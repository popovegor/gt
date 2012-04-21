<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SignInControl.ascx.cs" Inherits="GT.Web.Site.Authentication.SignInControl" %>
<%@ Register TagPrefix="gt" Namespace="GT.Web.UI.Controls" Assembly="GT.Web.UI" %>
<%@ Register TagPrefix="gt" Src="~/Controls/Button.ascx" TagName="Button" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<div id="sign-in" class="sign-in">
  <div class="sign-in-cnt">
    <%--<i class="rc1 rc1-lt"></i><i class="rc1 rc1-rt"></i><i class="rc1 rc1-lb"></i><i class="rc1 rc1-rb"></i>--%>
    <asp:LoginView ID="lvLogin" runat="server">
      <AnonymousTemplate>
        <table class="key-value" rules="none">
          <tbody>
            <tr>
              <td class="key">
                <%= CommonResources.SignUpUserName %>
              </td>
              <td class="value">
                <asp:TextBox ID="UserName" runat="server" ToolTip="<%# GT.Localization.Resources.CommonResources.UserName %>" />
                <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="UserName" ValidationGroup="loginCtrl" ErrorMessage="<%# GT.Localization.Resources.CommonResources.SignUpErrorUserName %>" Display="None" Text=""></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="vceUserName" TargetControlID="rfvUserName" runat="server" />
              </td>
            </tr>
            <tr>
              <td class="key">
                <%= CommonResources.Password %>
              </td>
              <td class="value">
                <asp:TextBox ID="Password" runat="server" ToolTip="<%# GT.Localization.Resources.CommonResources.Psw %>" TextMode="Password" />
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="Password" ValidationGroup="loginCtrl" ErrorMessage="<%# GT.Localization.Resources.CommonResources.SignUpErrorEmptyPsw %>" Display="None" Text=""></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="vcePassword" TargetControlID="rfvPassword" runat="server" />
              </td>
            </tr>
            <tr>
              <td class="remember">
                <asp:CheckBox ID="RememberMe" Text="<%# GT.Localization.Resources.CommonResources.RememberMe %>" runat="server" ToolTip="<%# GT.Localization.Resources.CommonResources.RememberMe %>" Checked="true" />
              </td>
              <td class="login">
                <gt:Button runat="server" ID="btnSignIn" Text="<%# GT.Localization.Resources.CommonResources.SignIn %>" CommandName="Login" ValidationGroup="loginCtrl" ToolTip="<%# GT.Localization.Resources.CommonResources.SignIn %>" UseSubmitBehavior="true" OnClick="btnSignIn_OnClick" />
              </td>
            </tr>
          </tbody>
        </table>
        <p class="failure"><asp:Label ID="FailureText" runat="server" EnableViewState="False" Text="<%# CommonResources.Authentication_SignIn_Failure %>" Visible="false" />
        </p>
        <p class="register"><a title="<%= CommonResources.CreateNewAccount %>" href="/SignUp">
        <%= CommonResources.SignInWelcome %></a> </p>
        <p class="recovery"><a href="/Recovery">
        <%= CommonResources.SignInForgot %></a> </p>
      </AnonymousTemplate>
      <LoggedInTemplate>
        <div id="signOut">
          <p>
            <%= CommonResources.SignedIn %>
            <gt:User runat="server" ID="uSeller" UserId="<%# ((GT.Web.UI.Pages.BasePage)this.Page).Credentials.UserId %>" UserName="<%# ((GT.Web.UI.Pages.BasePage)this.Page).Credentials.UserName %>" />
            .
            <asp:LoginStatus ID="lsStatus" runat="server" LogoutText="<%# GT.Localization.Resources.CommonResources.SignOut %>" LoginText="<%# GT.Localization.Resources.CommonResources.SignIn %>" />
          </p>
        </div>
      </LoggedInTemplate>
    </asp:LoginView>
  </div>
</div>
