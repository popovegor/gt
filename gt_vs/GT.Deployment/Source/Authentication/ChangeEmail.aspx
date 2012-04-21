<%@ Page Language="C#"  MasterPageFile="~/MasterPages/StandardPage.Master"
         AutoEventWireup="true" CodeBehind="ChangeEmail.aspx.cs" 
         Inherits="GT.Web.Site.Authentication.ChangeEmail" %>
<%@ Register Assembly="GT.Ajax.Controls" Namespace="GT.Ajax.Controls" TagPrefix="ajax" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Import Namespace="Resources" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
    <asp:ScriptManagerProxy ID="smpMain" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Scripts/ControlValidator.js" />
        </Scripts>
    </asp:ScriptManagerProxy>
    <asp:Panel ID="panel" runat="server">
        <div>
            <dl class="edit">
                <dt>
                    <b><%= CommonResources.ChangeEmailOldMail%></b>
                </dt>
                <dd>
                    <asp:TextBox ID="Email" runat="server" TextMode="SingleLine" AutoCompleteType="Email" Width="200" />
                    <asp:RequiredFieldValidator ValidationGroup="ChangeMail" ID="rfvEmail" runat="server"
                                            ControlToValidate="Email" ErrorMessage="<%# CommonResources.SignUpErrorEmptyEmail %>" Text=""
                                            Display="none" SetFocusOnError="true" />
                    <asp:CustomValidator ValidationGroup="ChangeMail" ValidateEmptyText="true" ClientValidationFunction="ControlValidator.ValidateEmail"
                                            ID="cvEmail" runat="server" ControlToValidate="Email" ErrorMessage="<%# CommonResources.SignUpErrorEmailFormat %>"
                                            Text="" Display="none" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="vceEmailCustom" runat="server" TargetControlID="cvEmail" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="vceEmailRequired" runat="server" TargetControlID="rfvEmail" />
                </dd>
                <dt>
                    <b><%= CommonResources.ChangeEmailNewMail%></b>
                </dt>
                <dd>
                    <asp:TextBox ID="NewEmail" runat="server" TextMode="SingleLine" AutoCompleteType="Email" Width="200" />
                    <asp:RequiredFieldValidator ValidationGroup="ChangeMail" ID="rfvNewEmail" runat="server"
                                            ControlToValidate="NewEmail" ErrorMessage="<%# CommonResources.SignUpErrorEmptyEmail %>" Text=""
                                            Display="none" SetFocusOnError="true" />
                    <asp:CustomValidator ValidationGroup="ChangeMail" ValidateEmptyText="true" ClientValidationFunction="ControlValidator.ValidateEmail"
                                            ID="cvNewEmail" runat="server" ControlToValidate="NewEmail" ErrorMessage="<%# CommonResources.SignUpErrorEmailFormat %>"
                                            Text="" Display="none" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="vceNewEmailCustom" runat="server" TargetControlID="cvNewEmail" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="vceNewEmailRequired" runat="server" TargetControlID="rfvNewEmail" />
                    <asp:CompareValidator ID="cvDupEmail" ValidationGroup="ChangeMail" ControlToValidate="NewEmail" Operator="NotEqual"
                                        ControlToCompare="Email" ErrorMessage="<%# CommonResources.ChangeEmailDupError %>"
                                        Text="" Display="None" runat="server" SetFocusOnError="true" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" TargetControlID="cvDupEmail" />
                </dd>
                <dt>
                    <b><%= CommonResources.Password %></b>
                </dt>
                <dd>
                    <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="200"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="ChangeMail" ID="rfvPassword" runat="server"
                      ControlToValidate="Password" ErrorMessage="<%# CommonResources.SignUpErrorEmptyPsw %>" Display="none"
                                            Text="" SetFocusOnError="true" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="vcePassword" runat="server" TargetControlID="rfvPassword" />
                </dd>
            </dl>
        </div>
        <div>
            <asp:Label ID="FailureText" runat="server" CssClass="error" EnableViewState="False" />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="false" ShowSummary="false"
                                    DisplayMode="SingleParagraph" ValidationGroup="ChangeMail" />
        </div>
        <div>
            <dl>
                <dt>
                    <gt:Button ID="confirmBtn" runat="server" Text="<%# CommonResources.Change %>" 
                        onclick="confirmBtn_Click" />
                </dt>
            </dl>
        </div>
    </asp:Panel>
    <div>
        <asp:Label ID="CompleteText" runat="server" CssClass="warning" Text="<%# CommonResources.ChangeEmailComplete %>"
                    Visible="false"></asp:Label>
    </div>
</asp:Content>
