<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SignInPopup.ascx.cs" Inherits="GT.Web.Site.Controls.SignInPopup" %>
<%@ Register TagName="Button" TagPrefix="gt" Src="~/Controls/Button.ascx" %>
<%@ Import Namespace="GT.Web.Security" %>
<% if(AuthenticationHelper.IsLoggedInUser(Page.User) == false ) {%>
<%--if current user is logged in --%>
<div runat="server" id="signInPopup" class="signInPopup">
  <dl>
    <dt class="username">
      <asp:Label ID="lblUserName" runat="server" Text="<%# Resources.CommonResources.SignUpUserName %>" />
    </dt>
    <dd class="username">
      <asp:TextBox ID="txtUserName" runat="server" />
      <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="txtUserName" ValidationGroup="SignInPopup" ErrorMessage="<%$ Resources:CommonResources, SignUpErrorUserName %>" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
      <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceUserName" TargetControlID="rfvUserName" runat="server" PopupPosition="Left" CssClass="validatorCalloutExtender" />--%>
    </dd>
    <dt class="password">
      <asp:Label ID="lblPassword" runat="server" Text="<%# Resources.CommonResources.Password %>" />
    </dt>
    <dd class="password">
      <asp:TextBox ID="txtPassword" runat="server" />
      <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ValidationGroup="SignInPopup" ErrorMessage="<%$ Resources:CommonResources, SignUpErrorEmptyPsw %>" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
      <%--<ajaxToolkit:ValidatorCalloutExtender ID="vcePassword" TargetControlID="rfvPassword" runat="server" PopupPosition="Left" />--%>
    </dd>
    <dt class="signIn">
      <gt:Button runat="server" ID="btnSignIn" OnClientClick="javascript:btnSignIn_onClick(event); return false;" Text="<%# Resources.CommonResources.SignIn %>" CausesValidation="true" ValidationGroup="SignInPopup" UseSubmitBehavior="false" />
    </dt>
    <dd class="remember">
      <asp:CheckBox runat="server" ID="chkRemember" Text="<%# Resources.CommonResources.RememberMe %>" onkeypress='javascript:return WebForm_FireDefaultButton(event, "<%# btnSignIn.ClientID %>")' />
    </dd>
  </dl>
  <div class="errorMessage" runat="server" id="errorMessage">
    <asp:Label runat="server" ID="lblErrorMessage" Text="<%# Resources.CommonResources.SignInFailure %>" />
  </div>
</div>

<script language="javascript" type="text/javascript">
  //<![CDATA[

  var signInPopup = null;

  Sys.Application.add_load(function() {

    signInPopup = new GT.Ajax.Scripts.SignInPopup(
      "<%= signInPopup.ClientID %>"
      , "<%= Resources.CommonResources.Controls_SignIn %>"
      , signInPopup_onSignInSuccess
      , signInPopup_onSignInFailure);

    raiseSignIn = function(event) { WebForm_FireDefaultButton(event.rawEvent, "<%= btnSignIn.ClientID %>"); }
    $addHandler($get("<%=signInPopup.ClientID %>"), "keypress", raiseSignIn);
  });

  Sys.Application.add_unload(function() {
    //$clearHandlers($get("<%=signInPopup.ClientID %>"));
  });

  function btnSignIn_onClick(event) {
    $("#<%= errorMessage.ClientID %>").hide();
    if (window.Page_ClientValidate && Page_ClientValidate("SignInPopup")) {
      signInPopup.signIn($get("<%= txtUserName.ClientID %>").value
      , $get("<%= txtPassword.ClientID %>").value
      , $get("<%= chkRemember.ClientID %>").checked);
    }
  };

  function signInPopup_onSignInSuccess(result) {
    if (result) {
      signInPopup.raise_onSuccess();
      signInPopup.close();
    } else {
      $("#<%= errorMessage.ClientID %>").show();
    }
  };

  function signInPopup_onSignInFailure(error) {
    signInPopup.raise_onFailure();
  };
  //]]>
</script>

<% } else { %>
<%--if current user is not logged in --%>
<script language="javascript" type="text/javascript">
  //<![CDATA[
  var signInPopup = null;

  Sys.Application.add_load(function() {
    signInPopup = new GT.Ajax.Scripts.SignInPopup();
  });
  //]]>
</script>

<% } %> 