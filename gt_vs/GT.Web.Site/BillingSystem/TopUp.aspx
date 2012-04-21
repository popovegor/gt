<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="TopUp.aspx.cs" Inherits="GT.Web.Site.BillingSystem.TopUp" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/BillingSystem/WMCertificate.ascx" TagName="WMCertificate" TagPrefix="gt" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
    <div id="topup">
       <%-- <h2><%= CommonResources.TopUpTitle %></h2>--%>
        <dl class="edit">
            <dt>
               <%-- <%= CommonResources.Amount %>:--%>
               <%= CommonResources.BillingSystem_TopUp_Amount%>:
            </dt>
            <dd>
                <asp:TextBox runat="server" Text="" ID="txtAmount" Width="150" /> <span class="currency"><%= CommonResources.Currency%></span>
                <ajaxToolkit:FilteredTextBoxExtender runat="server" ID="ftbeAmount" TargetControlID="txtAmount" FilterMode="ValidChars" FilterType="Numbers" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAmount" ErrorMessage="<%# GT.Localization.Resources.CommonResources.AmountEmpty %>" Text="" SetFocusOnError="true" Display="None" ID="rfvAmount" />
                <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceAmount" TargetControlID="rfvAmount" PopupPosition="TopLeft" />
                <span class="topup">
                  <gt:Button runat="server" ID="btnTopUp" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Office_TopUp %>" CausesValidation="true" OnClick="btnTopUp_Click"  />              
               </span> 
            </dd>
        </dl>
        <p class="description"><%= CommonResources.TopUpDescription %></p>
        <p class="description"><%= CommonResources.BillingSystem_Transfer_Attention %></p>
        <p>
                <input type="hidden" name="LMI_PAYMENT_AMOUNT" id="amount" />
                <input type="hidden" name="LMI_PAYMENT_DESC" id="description" />
                <input type="hidden" name="LMI_PAYMENT_NO" id="number" />
                <input type="hidden" name="LMI_PAYEE_PURSE" id="purse" />
                
        </p>
        <br />
        <p>
            <asp:Label runat="server" ID="lblError" CssClass="error" Text="" EnableViewState="false" Visible="false" />
        </p>
       <gt:WMCertificate runat="server" ID="wm" />
    </div>
</asp:Content>
