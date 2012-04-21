<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true"
    CodeBehind="PasswordRecovery.aspx.cs" Inherits="GT.Web.Site.Authentication.PasswordRecovery" %>

<%--<%@ Register Assembly="GT.Ajax.Controls" Namespace="GT.Ajax.Controls" TagPrefix="ajax" %>--%>
<%@ Import Namespace="GT.Localization.Resources" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
<div id="recovery">
    <asp:PasswordRecovery ID="recovery" runat="server" AnswerLabelText="<%# CommonResources.RecoveryAnswer %>" 
                              AnswerRequiredErrorMessage="<%# CommonResources.SignUpErrorEmptyAnswer %>"
                              GeneralFailureText="Error general"
                              QuestionFailureText="<%# CommonResources.RecoveryQuestionInvalid %>"
                              QuestionLabelText="<%# CommonResources.RecoveryQuestion %>"
                              QuestionInstructionText="<%# CommonResources.RecoveryQuestionInstruction %>"
                              QuestionTitleText=""
                              SuccessText="<%# CommonResources.RecoveryComplete %>"
                              UserNameLabelText="<%# CommonResources.SignUpUserName %>"
                              UserNameFailureText="<%# CommonResources.RecoveyUserNameError %>"
                              UserNameInstructionText="<%# CommonResources.RecoveryUserNameInstruction %>"
                              UserNameRequiredErrorMessage="<%# CommonResources.SignUpErrorUserName %>"
                              ValidatorTextStyle-CssClass="recovery-validator"
                              FailureTextStyle-CssClass="recovery-failure"
                              UserNameTitleText = ""
                              SubmitButtonText="<%# CommonResources.Submit %>"
                              TitleTextStyle-CssClass="recoverytitle"
                              LabelStyle-CssClass="recoverylabel"
                              InstructionTextStyle-CssClass="recoveryinstructions"
                              SubmitButtonStyle-CssClass="recoverybutton"
                              TextBoxStyle-CssClass = "recoverytextbox";
                              TextLayout = "TextOnLeft">
   </asp:PasswordRecovery>
   
    </div>
</asp:Content>