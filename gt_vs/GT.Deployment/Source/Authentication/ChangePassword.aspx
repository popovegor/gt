<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true"
     CodeBehind="ChangePassword.aspx.cs" Inherits="GT.Web.Site.Authentication.ChangePassword" %>
<%@ Register Assembly="GT.Ajax.Controls" Namespace="GT.Ajax.Controls" TagPrefix="ajax" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Import Namespace="Resources" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
    <asp:Panel ID="panel" runat="server">
        <div>
            <dl class="edit">
                <dt>
                    <b><%= CommonResources.ChangePasswordOldPsw %></b>
                </dt>
                <dd>
                    <asp:TextBox ID="OldPassword" runat="server" TextMode="Password" Width="200"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="ChangePassword" ID="rfvOldPassword" runat="server"
                      ControlToValidate="OldPassword" ErrorMessage="<%# CommonResources.SignUpErrorEmptyPsw %>" Display="none"
                                            Text="" SetFocusOnError="true" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="vceOldPassword" runat="server" TargetControlID="rfvOldPassword" />
                </dd>
                <dt><b><%= CommonResources.ChangePasswordNewPsw %></b></dt>
                <dd>
                    <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="200"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="ChangePassword" ID="rfvPassword" runat="server"
                                                ControlToValidate="Password" ErrorMessage="<%# CommonResources.SignUpErrorEmptyPsw %>" Display="none"
                                                Text="" SetFocusOnError="true" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="vcePassword" runat="server" TargetControlID="rfvPassword" />
                    <asp:CompareValidator ID="cvPassword" ValidationGroup="ChangePassword" ControlToValidate="Password" Operator="NotEqual"
                                        ControlToCompare="OldPassword" ErrorMessage="<%# CommonResources.ChangePasswordDupError %>"
                                        Text="" Display="None" runat="server" SetFocusOnError="true" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" TargetControlID="cvPassword" />
                 </dd>
                 <dt><b><%= CommonResources.SignUpConfirm %></b></dt>
                 <dd>
                     <asp:TextBox ID="ConfirmPassword" runat="server"  TextMode="Password" Width="200" />
                     <asp:RequiredFieldValidator ValidationGroup="ChangePassword" ID="rfvConfirmPassword"
                                        runat="server" ControlToValidate="ConfirmPassword" SetFocusOnError="true" Display="none"
                                        ErrorMessage="<%# CommonResources.SignUpErrorEmptyConfirm %>" Text="" />
                     <ajaxToolkit:ValidatorCalloutExtender ID="vceConfirmPassword" runat="server" TargetControlID="rfvConfirmPassword" />
                     <asp:CompareValidator ID="cvConfirmPassword" ValidationGroup="ChangePassword" ControlToValidate="Password"
                                        ControlToCompare="ConfirmPassword" ErrorMessage="<%# CommonResources.SignUpErrorConfirmPsw %>"
                                        Text="" Display="None" runat="server" SetFocusOnError="true" />
                     <ajaxToolkit:ValidatorCalloutExtender ID="vceConfirmPasswordMatch" runat="server"
                                        TargetControlID="cvConfirmPassword" />
                 </dd>
            </dl>
        </div>
        <div>
            <asp:Label ID="FailureText" runat="server" CssClass="error" EnableViewState="False" />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="false" ShowSummary="false"
                                    DisplayMode="SingleParagraph" ValidationGroup="ChangePassword" />
        </div>
        <div>
            <dl>
                <dt>
                    <gt:Button ID="confirmBtn" runat="server" Text="<%# CommonResources.Change %>" 
                        OnClick="confirmBtn_Click" />
                </dt>
            </dl>
        </div>
    </asp:Panel>
    <div>
        <asp:Label ID="CompleteText" runat="server" CssClass="warning" Text="<%# CommonResources.ChangePasswordComplete %>"
                    Visible="false"></asp:Label>
    </div>
</asp:Content>
