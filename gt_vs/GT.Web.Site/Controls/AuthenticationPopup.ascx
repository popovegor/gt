<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AuthenticationPopup.ascx.cs" Inherits="GT.Web.Site.Controls.AuthenticationPopup" %>
<%@ Register TagName="Button" TagPrefix="gt" Src="~/Controls/Button.ascx" %>
<%@ Import Namespace="GT.Web.Security" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<% if (AuthenticationHelper.IsLoggedInUser(Page.User) == false)
   {%>
<%--if current user is logged in --%>
<div class="authenticationPopup" id="authenticationPopup" runat="server">
  <div class="sign" runat="server" id="sign">
    <div runat="server" id="signIn" class="signIn">
      <dl>
        <dt class="username">
          <asp:Label ID="lblUserName" runat="server" Text="<%# GT.Localization.Resources.CommonResources.SignUpUserName %>" />
        </dt>
        <dd class="username">
          <asp:TextBox ID="txtUserName" runat="server" />
          <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="txtUserName" ValidationGroup="SignIn" ErrorMessage="<%# GT.Localization.Resources.CommonResources.SignUpErrorUserName %>" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
          <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceUserName" TargetControlID="rfvUserName" runat="server" PopupPosition="Left" CssClass="validatorCalloutExtender" />--%>
        </dd>
        <dt class="password">
          <asp:Label ID="lblPassword" runat="server" Text="<%# GT.Localization.Resources.CommonResources.Password %>" />
        </dt>
        <dd class="password">
          <asp:TextBox ID="txtPassword" runat="server" />
          <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ValidationGroup="SignIn" ErrorMessage="<%# GT.Localization.Resources.CommonResources.SignUpErrorEmptyPsw %>" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
          <%--<ajaxToolkit:ValidatorCalloutExtender ID="vcePassword" TargetControlID="rfvPassword" runat="server" PopupPosition="Left" />--%>
        </dd>
        <dt class="signIn">
          <gt:Button runat="server" ID="btnSignIn" OnClientClick="javascript:btnSignIn_onClick(event); return false;" Text="<%# GT.Localization.Resources.CommonResources.SignIn %>" CausesValidation="true" ValidationGroup="SignIn" UseSubmitBehavior="false" />
        </dt>
        <dd class="remember">
          <asp:CheckBox runat="server" ID="chkRemember" Text="<%# GT.Localization.Resources.CommonResources.RememberMe %>" onkeypress='javascript:return WebForm_FireDefaultButton(event, "<%# btnSignIn.ClientID %>")' />
        </dd>
      </dl>
      <div class="error" runat="server" id="signInError">
        <asp:Label runat="server" ID="lblErrorMessage" Text="<%# GT.Localization.Resources.CommonResources.SignInFailure %>" />
      </div>
    </div>
    <div class="signUp" id="signUp" runat="server">
      <dl>
        <dt class="username">
          <%= CommonResources.SignUpUserName %>
        </dt>
        <dd class="username">
          <asp:TextBox ID="SignUpUserName" runat="server"></asp:TextBox>
          <asp:RequiredFieldValidator ValidationGroup="SignUp" ID="rfvSignUpUserName" runat="server" ControlToValidate="SignUpUserName" ErrorMessage="" Text="*" Display="Dynamic" SetFocusOnError="true" />
          <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceSignUpUserName" runat="server" TargetControlID="rfvSignUpUserName" SkinID="ValidatorCalloutExtenderSkin" />--%>
        </dd>
        <dt class="password">
          <%= CommonResources.Password %>
        </dt>
        <dd class="password">
          <asp:TextBox ID="SignUpPassword" runat="server" TextMode="Password"></asp:TextBox>
          <asp:RequiredFieldValidator ValidationGroup="SignUp" ID="rfvSignUpPassword" runat="server" ControlToValidate="SignUpPassword" ErrorMessage="" Display="Dynamic" Text="*" SetFocusOnError="true" />
          <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceSignUpPassword" runat="server" TargetControlID="rfvSignUpPassword" />--%>
        </dd>
        <%--<dt class="confirmPassword">
        <%= CommonResources.SignUpConfirm %>
      </dt>
      <dd class="confirmPassword">
        <asp:TextBox ID="SignUpConfirmPassword" runat="server" TextMode="Password" />
        <asp:RequiredFieldValidator ValidationGroup="SignUp" ID="rfvSignUpConfirmPassword" runat="server" ControlToValidate="SignUpConfirmPassword" SetFocusOnError="true" Display="Dynamic" ErrorMessage="" Text="*" />--%>
        <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceSignUpConfirmPassword" runat="server" TargetControlID="rfvSignUpConfirmPassword" />--%>
        <%--<asp:CompareValidator ID="cvSignUpConfirmPassword" ValidationGroup="SignUp" ControlToValidate="SignUpPassword" ControlToCompare="SignUpConfirmPassword" ErrorMessage="" Text="*" Display="Dynamic" runat="server" SetFocusOnError="true" />--%>
        <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceSignUpConfirmPasswordMatch" runat="server" TargetControlID="cvSignUpConfirmPassword" />--%>
        <%--</dd>--%>
        <dt class="email">
          <%= CommonResources.Email %>: </dt>
        <dd class="email">
          <asp:TextBox ID="SignUpEmail" runat="server" TextMode="SingleLine" AutoCompleteType="Email" />
          <asp:RequiredFieldValidator ValidationGroup="SignUp" ID="rfvSignUpEmail" runat="server" ControlToValidate="SignUpEmail" ErrorMessage="<%# CommonResources.SignUpErrorEmptyEmail %>" Text="*" Display="Dynamic" SetFocusOnError="true" />
          <asp:CustomValidator ValidationGroup="SignUp" ValidateEmptyText="true" ClientValidationFunction="ControlValidator.ValidateEmail" ID="cvSignUpEmail" runat="server" ControlToValidate="SignUpEmail" ErrorMessage="" Text="*" Display="Dynamic" />
          <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceSignUpEmailCustom" runat="server" TargetControlID="cvSignUpEmail" />--%>
          <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceSignUpEmailRequired" runat="server" TargetControlID="rfvSignUpEmail" />--%>
        </dd>
        <dt class="question">
          <%= CommonResources.SignUpSecurityQuestion %>
        </dt>
        <dd class="question">
          <asp:TextBox runat="server" ID="SignUpQuestion" />
          <asp:RequiredFieldValidator ValidationGroup="SignUp" Display="Dynamic" ControlToValidate="SignUpQuestion" ErrorMessage="" Text="*" ID="rfvSignUpQuestion" runat="server" SetFocusOnError="true" />
          <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceQuestion" runat="server" TargetControlID="rfvQuestion" />--%>
        </dd>
        <dt class="answer">
          <%= CommonResources.SignUpSecurityAnswer %>
        </dt>
        <dd class="answer">
          <asp:TextBox runat="server" ID="SignUpAnswer" EnableViewState="false" />
          <asp:RequiredFieldValidator ValidationGroup="SignUp" Display="Dynamic" ControlToValidate="SignUpAnswer" ErrorMessage="" Text="*" ID="rfvSignUpAnswer" runat="server" SetFocusOnError="true" />
          <%--<ajaxToolkit:ValidatorCalloutExtender ID="vceAnswer" runat="server" TargetControlID="rfvAnswer" />--%>
        </dd>
        <%--<dt class="agreement">
      <%= CommonResources. %>: 
      </dt>
      <dd>
        <asp:CheckBox runat="server" ID="SignUpAgreement" Text="" />
      </dd>--%>
      </dl>
      <div>
        <gt:Button runat="server" ID="btnSignUp" Text="<%# CommonResources.SignUp %>" CausesValidation="true" ValidationGroup="SignUp" UseSubmitBehavior="false" OnClientClick="javascript:btnSignUp_onClick(event); return false;" />
      </div>
      <div class="error" runat="server" id="signUpError">
        <asp:Label runat="server" Text="" ID="SignUpErrorMessage" />
      </div>
    </div>
    <div class="toggle">
      <asp:Label runat="server" ID="lblToggle" Text="<%# CommonResources.AuthenticationPopup_lblToggle_SignUp %>" />
      <asp:HyperLink NavigateUrl='<%# Request.Url.AbsoluteUri  + "#" %>' ID="hplToggle" runat="server" Text="<%# CommonResources.AuthenticationPopup_hplToggle_SignUp %>" />
    </div>
  </div>
  <div class="waiting" runat="server" id="waiting">
    <asp:Image ImageUrl="~/App_Themes/Tutynin/Images/waiting.gif" runat="server" ID="imgWaiting" />
  </div>
</div>

<script language="javascript" type="text/javascript">
  //<![CDATA[

  var authenticationPopup = null;

  Sys.Application.add_load(function() {

    authenticationPopup = new GT.Ajax.Scripts.AuthenticationPopup(
      "<%= authenticationPopup.ClientID %>"
      , "<%= GT.Localization.Resources.CommonResources.Controls_SignIn %>"
      , authenticationPopup_onSignInSuccess
      , authenticationPopup_onSignInFailure
      , authenticationPopup_onSignUpSuccess
      , authenticationPopup_onSignUpFailure
      );

    raiseSignIn = function(event) { WebForm_FireDefaultButton(event.rawEvent, "<%= btnSignIn.ClientID %>"); }
    raiseSignUp = function(event) { WebForm_FireDefaultButton(event.rawEvent, "<%= btnSignUp.ClientID %>"); }
    $addHandler($get("<%= signIn.ClientID %>"), "keypress", raiseSignIn);
    $addHandler($get("<%= signUp.ClientID %>"), "keypress", raiseSignUp);

    $("#<%= hplToggle.ClientID %>").toggle(function() {
      $("#<%=signIn.ClientID %>").hide("slow");
      $("#<%=signUp.ClientID %>").show();
      $("#<%= lblToggle.ClientID %>").text("<%# CommonResources.AuthenticationPopup_lblToggle_SignIn %>");
      $(this).text("<%# CommonResources.AuthenticationPopup_hplToggle_SignIn %>");
    },
    function() {
      $("#<%=signUp.ClientID %>").hide("slow");
      $("#<%=signIn.ClientID %>").show();
      $("#<%= lblToggle.ClientID %>").text("<%# CommonResources.AuthenticationPopup_lblToggle_SignUp %>");
      $(this).text("<%# CommonResources.AuthenticationPopup_hplToggle_SignUp %>");
    });
  });

  Sys.Application.add_unload(function() {
    $clearHandlers($get("<%=signIn.ClientID %>"));
    //$clearHandlers($get("<%=hplToggle.ClientID %>"));
  });


  function btnSignUp_onClick(event) {
    $("#<%= signUpError.ClientID %>").hide();
    if (window.Page_ClientValidate && Page_ClientValidate("SignUp")) {
      $("#<%= sign.ClientID %>").hide();
      $("#<%= waiting.ClientID %>").show();
      var userName = $get("<%= SignUpUserName.ClientID %>").value;
      var password = $get("<%= SignUpPassword.ClientID %>").value;
      var email = $get("<%= SignUpEmail.ClientID %>").value;
      var question = $get("<%= SignUpQuestion.ClientID %>").value;
      var answer = $get("<%= SignUpAnswer.ClientID %>").value;
      var key = "<%= Key %>";
      authenticationPopup.signUp(userName, password, email, question, answer, key);
    }
  };

  function btnSignIn_onClick(event) {
    $("#<%= signInError.ClientID %>").hide();
    if (window.Page_ClientValidate && Page_ClientValidate("SignIn")) {
      $("#<%= sign.ClientID %>").hide();
      $("#<%= waiting.ClientID %>").show();
      authenticationPopup.signIn($get("<%= txtUserName.ClientID %>").value
      , $get("<%= txtPassword.ClientID %>").value
      , $get("<%= chkRemember.ClientID %>").checked);
    }
  };

  function authenticationPopup_onSignInSuccess(result) {
    if (result) {
      authenticationPopup.close();
      authenticationPopup.raise_onSuccess();
    } else {
      $("#<%= waiting.ClientID %>").hide();
      $("#<%= sign.ClientID %>").show();
      $("#<%= signInError.ClientID %>").show();
    }
  };

  function authenticationPopup_onSignInFailure(error) {
    $("#<%= waiting.ClientID %>").hide();
    $("#<%= sign.ClientID %>").show();
    authenticationPopup.raise_onFailure();
  };

  function authenticationPopup_onSignUpSuccess(result) {
    if (String.isNullOrEmpty(result) == true) {
      /*authenticationPopup.raise_onSuccess();*/
      /*authenticationPopup.close();*/
      var password = $get("<%= SignUpPassword.ClientID %>").value;
      var userName = $get("<%= SignUpUserName.ClientID %>").value;
      authenticationPopup.signIn(userName, password, true);
    } else {
      $("#<%= waiting.ClientID %>").hide();
      $("#<%= sign.ClientID %>").show();
      $("#<%= SignUpErrorMessage.ClientID %>").text(result); //error message
      $("#<%= signUpError.ClientID %>").show(); //error block
    }
  };

  function authenticationPopup_onSignUpFailure(error) {
    $("#<%= waiting.ClientID %>").hide();
    $("#<%= sign.ClientID %>").show();
    authenticationPopup.raise_onFailure();
  };
  //]]>
</script>

<% }
   else
   { %>
<%--if current user is not logged in --%>

<script language="javascript" type="text/javascript">
  //<![CDATA[
  var authenticationPopup = null;

  Sys.Application.add_load(function() {
    authenticationPopup = new GT.Ajax.Scripts.AuthenticationPopup();
  });
  //]]>
</script>

<% } %>
