<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true"
    CodeBehind="PasswordRecovery.aspx.cs" Inherits="GT.Web.Site.Authentication.PasswordRecovery" %>

<%--<%@ Register Assembly="GT.Ajax.Controls" Namespace="GT.Ajax.Controls" TagPrefix="ajax" %>--%>
<%@ Import Namespace="Resources" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">

    <%--<asp:ScriptManagerProxy ID="smpMain" runat="server">
            <Scripts>
                <asp:ScriptReference Path="~/Scripts/ControlValidator.js" />
            </Scripts>
    </asp:ScriptManagerProxy>   --%>
    <asp:PasswordRecovery ID="recovery" runat="server" AnswerLabelText="<%# CommonResources.RecoveryAnswer %>" 
                              AnswerRequiredErrorMessage="<%# CommonResources.SignUpErrorEmptyAnswer %>"
                              GeneralFailureText="Error general"
                              QuestionFailureText="<%# CommonResources.RecoveryQuestionInvalid %>"
                              QuestionLabelText="<%# CommonResources.RecoveryQuestion %>"
                              QuestionInstructionText="<%# CommonResources.RecoveryQuestionInstruction %>"
                              QuestionTitleText="<%# CommonResources.RecoveryQuestionTitle %>"
                              SuccessText="<%# CommonResources.RecoveryComplete %>"
                              UserNameLabelText="<%# CommonResources.SignUpUserName %>"
                              UserNameFailureText="<%# CommonResources.RecoveyUserNameError %>"
                              UserNameInstructionText="<%# CommonResources.RecoveryUserNameInstruction %>"
                              UserNameRequiredErrorMessage="<%# CommonResources.SignUpErrorUserName %>"
                              UserNameTitleText = "<%# CommonResources.RecoveryUserNameTitle %>"
                              SubmitButtonText="<%# CommonResources.Submit %>"
                              TitleTextStyle-CssClass="recoverytitle"
                              LabelStyle-CssClass="recoverylabel"
                              InstructionTextStyle-CssClass="recoveryinstructions"
                              SubmitButtonStyle-CssClass="recoverybutton"
                              TextBoxStyle-CssClass = "recoverytextbox";
                              TextLayout = "TextOnLeft">
   </asp:PasswordRecovery>
    
    <%--<asp:Panel ID="panel" runat="server">
        <div>
            <dl>
                <dt>
                    <%= CommonResources.RecoveryMail %>
                </dt>
                <dd>
                    <asp:TextBox ID="Email" runat="server" TextMode="SingleLine" AutoCompleteType="Email" Width="200" />
                    <asp:RequiredFieldValidator ValidationGroup="Recovery" ID="rfvEmail" runat="server"
                                            ControlToValidate="Email" ErrorMessage="<%# CommonResources.SignUpErrorEmptyEmail %>" Text=""
                                            Display="none" SetFocusOnError="true" />
                    <asp:CustomValidator ValidationGroup="Recovery" ValidateEmptyText="true" ClientValidationFunction="ControlValidator.ValidateEmail"
                                            ID="cvEmail" runat="server" ControlToValidate="Email" ErrorMessage="<%# CommonResources.SignUpErrorEmailFormat %>"
                                            Text="" Display="none" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="vceEmailCustom" runat="server" TargetControlID="cvEmail" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="vceEmailRequired" runat="server" TargetControlID="rfvEmail" />
                </dd>
            </dl>
        </div>
        <div>
            <dl>
                <dt>
                    <asp:Button ID="confirmBtn" runat="server" Text="<%# CommonResources.Recovery %>" 
                        onclick="confirmBtn_Click" />
                </dt>
            </dl>
        </div>
    </asp:Panel>
    <div>
        <asp:Label ID="CompleteText" runat="server" CssClass="warning" Text="<%# CommonResources.RecoveryComplete %>"
                    Visible="false"></asp:Label>
    </div>--%>
</asp:Content>