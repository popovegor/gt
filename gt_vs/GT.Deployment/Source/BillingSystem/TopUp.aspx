<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true" CodeBehind="TopUp.aspx.cs" Inherits="GT.Web.Site.BillingSystem.TopUp" Title="Untitled Page" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Import Namespace="Resources" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
    <div id="topUp">
        <h2><%= CommonResources.TopUpTitle %></h2>
        <p><%= CommonResources.TopUpDescription %></p>
        <dl class="edit">
            <dt>
                <%= CommonResources.Amount %>:
            </dt>
            <dd>
                <asp:TextBox runat="server" Text="" ID="txtAmount" Width="200" />
                <ajaxToolkit:FilteredTextBoxExtender runat="server" ID="ftbeAmount" TargetControlID="txtAmount" FilterMode="ValidChars" FilterType="Numbers" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAmount" ErrorMessage="<%$ Resources:CommonResources, AmountEmpty %>" Text="" SetFocusOnError="true" Display="None" ID="rfvAmount" />
                <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceAmount" TargetControlID="rfvAmount" />
            </dd>
        </dl>
        <p>
                <input type="hidden" name="LMI_PAYMENT_AMOUNT" id="amount" />
                <input type="hidden" name="LMI_PAYMENT_DESC" id="description" />
                <input type="hidden" name="LMI_PAYMENT_NO" id="number" />
                <input type="hidden" name="LMI_PAYEE_PURSE" id="purse" />
                <input type="hidden" name="LMI_SIM_MODE" value="0" />
                <gt:Button runat="server" ID="btnTopUp" Text="<%$ Resources:CommonResources, PersonalAccount_Office_TopUp %>" CausesValidation="true" OnClick="btnTopUp_Click"  />
        </p>
        <br />
        <p>
            <asp:Label runat="server" ID="lblError" CssClass="error" Text="" EnableViewState="false" Visible="false" />
        </p>
    </div>
</asp:Content>
