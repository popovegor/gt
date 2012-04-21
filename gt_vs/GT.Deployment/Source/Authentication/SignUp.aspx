<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="GT.Web.Site.Authentication.SignUp" %>

<%@ Register Assembly="GT.Ajax.Controls" Namespace="GT.Ajax.Controls" TagPrefix="ajax" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Import Namespace="Resources" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Scripts>
      <asp:ScriptReference Path="~/Scripts/ControlValidator.js" />
    </Scripts>
  </asp:ScriptManagerProxy>
  <div id="signUp">
    <asp:CreateUserWizard runat="server" ID="cuwRegisterUser" DisplayCancelButton="true"  CancelButtonText="<%# CommonResources.Cancel %>" LoginCreatedUser="true">
      <WizardSteps>
        <asp:TemplatedWizardStep ID="wstConfirmation" StepType="Start" Title='<%# CommonResources.Confirmation %>' AllowReturn="false">
          <ContentTemplate>
            <div id="confirmation">
              <dl>
                <dt class="warning">
                  <%# CommonResources.SignUpActTitle %>
                </dt>
                <dd>
                  <div class="acceptment">
                    <%= CommonResources.SignUpAct %>
                  </div>
                </dd>
              </dl>
            </div>
          </ContentTemplate>
          <CustomNavigationTemplate>
            <div class="actions">
              <gt:Button runat="server" ID="StepNextButtonButton"
              CausesValidation="false" Text='<%# Resources.CommonResources.Agree %>' OnClick="cuwRegisterUser_Agree" />
              <gt:Button runat="server" ID="CancelButtonButton" OnClick="cuwRegisterUser_CancelButtonClick" Text="<%# CommonResources.Cancel %>" CausesValidation="false" />
            </div>
          </CustomNavigationTemplate>
        </asp:TemplatedWizardStep>
        <asp:CreateUserWizardStep runat="server" ID="cuwsCreation" Title="CreateUser">
          <ContentTemplate><span>
            <%= CommonResources.SignUpDescription %></span>
            <br />
            <br />
            <div id="createUser">
              <dl class="edit">
                <dt>
                  <%= CommonResources.SignUpUserName %>
                </dt>
                <dd>
                  <asp:TextBox ID="UserName" runat="server" Width="200"></asp:TextBox>
                  <span class="requiredFieldAsterisk">*</span>
                  <asp:RequiredFieldValidator ValidationGroup="CreateUser" ID="rfvUserName" runat="server" ControlToValidate="UserName" ErrorMessage="<%# CommonResources.SignUpErrorUserName %>" Text="" Display="None" SetFocusOnError="true" />
                  <ajaxToolkit:ValidatorCalloutExtender ID="vceUserName" runat="server" TargetControlID="rfvUserName" />
                </dd>
                <dt>
                  <%= CommonResources.Password %></dt>
                <dd>
                  <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="200"></asp:TextBox>
                  <span class="requiredFieldAsterisk">*</span>
                  <asp:RequiredFieldValidator ValidationGroup="CreateUser" ID="rfvPassword" runat="server" ControlToValidate="Password" ErrorMessage="<%# CommonResources.SignUpErrorEmptyPsw %>" Display="none" Text="" SetFocusOnError="true" />
                  <ajaxToolkit:ValidatorCalloutExtender ID="vcePassword" runat="server" TargetControlID="rfvPassword" />
                </dd>
                <dt>
                  <%= CommonResources.SignUpConfirm %></dt>
                <dd>
                  <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" Width="200" />
                  <span class="requiredFieldAsterisk">*</span>
                  <asp:RequiredFieldValidator ValidationGroup="CreateUser" ID="rfvConfirmPassword" runat="server" ControlToValidate="ConfirmPassword" SetFocusOnError="true" Display="none" ErrorMessage="<%# CommonResources.SignUpErrorEmptyConfirm %>" Text="" />
                  <ajaxToolkit:ValidatorCalloutExtender ID="vceConfirmPassword" runat="server" TargetControlID="rfvConfirmPassword" />
                  <asp:CompareValidator ID="cvConfirmPassword" ValidationGroup="CreateUser" ControlToValidate="ConfirmPassword" ControlToCompare="Password" ErrorMessage="<%# CommonResources.SignUpErrorConfirmPsw %>" Text="" Display="None" runat="server" SetFocusOnError="true" />
                  <ajaxToolkit:ValidatorCalloutExtender ID="vceConfirmPasswordMatch" runat="server" TargetControlID="cvConfirmPassword" />
                </dd>
                <dt>E-mail: </dt>
                <dd>
                  <asp:TextBox ID="Email" runat="server" TextMode="SingleLine" AutoCompleteType="Email" Width="200" />
                  <span class="requiredFieldAsterisk">*</span>
                  <asp:RequiredFieldValidator ValidationGroup="CreateUser" ID="rfvEmail" runat="server" ControlToValidate="Email" ErrorMessage="<%# CommonResources.SignUpErrorEmptyEmail %>" Text="" Display="none" SetFocusOnError="true" />
                  <asp:CustomValidator ValidationGroup="CreateUser" ValidateEmptyText="true" ClientValidationFunction="ControlValidator.ValidateEmail" ID="cvEmail" runat="server" ControlToValidate="Email" ErrorMessage="<%# CommonResources.SignUpErrorEmailFormat %>" Text="" Display="none" />
                  <ajaxToolkit:ValidatorCalloutExtender ID="vceEmailCustom" runat="server" TargetControlID="cvEmail" />
                  <ajaxToolkit:ValidatorCalloutExtender ID="vceEmailRequired" runat="server" TargetControlID="rfvEmail" />
                </dd>
                <dt>
                  <%= CommonResources.SignUpSecurityQuestion %></dt>
                <dd>
                  <asp:TextBox runat="server" ID="Question" Width="300" />
                  <span class="requiredFieldAsterisk">*</span>
                  <asp:RequiredFieldValidator ValidationGroup="CreateUser" Display="none" ControlToValidate="Question" ErrorMessage="<%# CommonResources.SignUpErrorEmptyQuestion %>" Text="" ID="rfvQuestion" runat="server" SetFocusOnError="true" />
                  <ajaxToolkit:ValidatorCalloutExtender ID="vceQuestion" runat="server" TargetControlID="rfvQuestion" />
                </dd>
                <dt>
                  <%= CommonResources.SignUpSecurityAnswer %></dt>
                <dd>
                  <asp:TextBox runat="server" ID="Answer" Width="300" EnableViewState="false" />
                  <span class="requiredFieldAsterisk">*</span>
                  <asp:RequiredFieldValidator ValidationGroup="CreateUser" Display="none" ControlToValidate="Answer" ErrorMessage="<%# CommonResources.SignUpErrorEmptyAnswer %>" Text="" ID="rfvAnswer" runat="server" SetFocusOnError="true" />
                  <ajaxToolkit:ValidatorCalloutExtender ID="vceAnswer" runat="server" TargetControlID="rfvAnswer" />
                </dd>
                <dt>
                  <%= CommonResources.SignUpCaptchText %></dt>
                <dd>
                  <ajax:Captcha ID="captcha" runat="server" Direction="LeftToRight"><span style="vertical-align: top; margin-right: 5px">
                    <asp:TextBox ID="CaptchaSecretCode" runat="server" Width="200"></asp:TextBox>
                  </span>
                    <asp:Image ID="CaptchaImage" runat="server" />
                    <span class="requiredFieldAsterisk" style="vertical-align: top; margin-top: 5px;">*</span>
                    <asp:CustomValidator ID="CaptchaValidator" runat="server" Display="none" ValidationGroup="CreateUser" ErrorMessage="<%# CommonResources.SignUpCaptchaError %>" SetFocusOnError="true"></asp:CustomValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="vceCaptcha" runat="server" TargetControlID="CaptchaValidator" PopupPosition="BottomLeft" />
                  </ajax:Captcha>
                </dd>
            </div>
            <div>
              <asp:Label ID="FailureText" runat="server" CssClass="error" EnableViewState="False" />
              <asp:ValidationSummary runat="server" ShowMessageBox="false" ShowSummary="false" DisplayMode="SingleParagraph" ValidationGroup="CreateUser" />
            </div>
          </ContentTemplate>
          <CustomNavigationTemplate>
            <div class="actions">
              <gt:Button runat="server" ID="StepNextButtonButton" ValidationGroup="CreateUser" CausesValidation="true" Text="<%# CommonResources.Create %>" OnClick="cuwRegisterUser_CreateButtonClick" />
              <gt:Button runat="server" ID="CancelButtonButton" Text="<%# CommonResources.Cancel %>" CausesValidation="false" OnClick="cuwRegisterUser_CancelButtonClick" />
            </div>
          </CustomNavigationTemplate>
        </asp:CreateUserWizardStep>
        <asp:CompleteWizardStep runat="server" ID="cwsCompletion">
          <ContentTemplate>
            <div>
              <dl>
                <dt>
                  <%= CommonResources.SignUpThanks %></dt>
                <dd>
                  <%= CommonResources.SignUpSending %>
                </dd>
              </dl>
            </div>
          </ContentTemplate>
        </asp:CompleteWizardStep>
      </WizardSteps>
    </asp:CreateUserWizard>
  </div>
</asp:Content>
