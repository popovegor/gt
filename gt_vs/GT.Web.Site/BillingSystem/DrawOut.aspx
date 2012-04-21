<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="DrawOut.aspx.cs" Inherits="GT.Web.Site.BillingSystem.DrawOut" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/BillingSystem/WMCertificate.ascx" TagName="WMCertificate" TagPrefix="gt" %>
<%@ Import Namespace="GT.Localization.Resources" %>   
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <div id="drawout">
    <script type="text/javascript">
        //<! [CDATA[

        function CalcFactAmount() {
            var amount = document.getElementById('<%= txtAmount.ClientID %>');
            var ourpercent = parseFloat('<%= GT.DA.Dictionaries.Dictionaries.Instance.GetRealMoneySourceOurCommissionById((int)GT.Global.BillingSystem.RealMoneySourceType.WebMoney) %>'.replace(',', '.'));
            var percent = parseFloat('<%= GT.DA.Dictionaries.Dictionaries.Instance.GetRealMoneySourceCommissionById((int)GT.Global.BillingSystem.RealMoneySourceType.WebMoney) %>'.replace(',', '.'));
            var fact = document.getElementById('<%= factAmount.ClientID %>'); 
            
            var val = amount.value * (1 - ourpercent)  / (1 + percent);
            fact.innerHTML = '<%= CommonResources.DrawOutFact %>'.replace('{0}', val.toFixed(2)).replace('{1}', (percent * 100).toFixed(2));
        }
        
        //]]>
    </script>
   
        <%--<h2><%= CommonResources.DrawOutTitle %></h2>--%>
        
        <dl class="edit">
            <dt><%= CommonResources.Purse %>:</dt>
            <dd>
                <asp:TextBox runat="server" ID="purse" Width="200" MaxLength="12" />
                <ajaxToolkit:MaskedEditExtender ID="maskedValidator" runat="server" Mask="\R999999999999" MaskType="None" TargetControlID="purse" AutoComplete="false" ></ajaxToolkit:MaskedEditExtender>
                <ajaxToolkit:MaskedEditValidator runat="server" ID="mev" ControlExtender="maskedValidator" ControlToValidate="purse" IsValidEmpty="False" EmptyValueMessage="<%# GT.Localization.Resources.CommonResources.PurseEmpty %>" SetFocusOnError="true"
                             InvalidValueMessage="<%# GT.Localization.Resources.CommonResources.PurseInvalid %>" Display="Dynamic" ValidationExpression="^\d{12}$" ValidationGroup="drawOutGroup" />
                             <%--<ajaxToolkit:ValidatorCalloutExtender TargetControlID="mev" runat="server" PopupPosition="TopLeft" />--%>
            </dd>
            <dt>
                <%= CommonResources.Amount %>:
            </dt>
            <dd>
                <asp:TextBox runat="server" Text="" ID="txtAmount" Width="200" />
                <asp:Label ID="factAmount" runat="server"></asp:Label>
                <ajaxToolkit:FilteredTextBoxExtender runat="server" ID="ftbeAmount" TargetControlID="txtAmount" FilterMode="ValidChars" FilterType="Numbers" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAmount" ErrorMessage="<%# GT.Localization.Resources.CommonResources.AmountEmpty %>" Text="" SetFocusOnError="true" Display="None" ID="rfvAmount" ValidationGroup="drawOutGroup"  />
                <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceAmount" TargetControlID="rfvAmount" PopupPosition="TopLeft" />
                
            </dd>
        </dl>
        
        <p class="drawout">
            <gt:Button runat="server" ID="btnDrawOut" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Office_DrawOut %>" CausesValidation="true"
                        OnClick="btnDrawOut_Click" OnClientClick='<%# "if ( Page_ClientValidate(&#39;drawOutGroup&#39;) ) { return confirm(&#39;" + CommonResources.DrawOutConfirmation + "&#39;.replace(&#39;{0}&#39;, document.getElementById(&#39;" + txtAmount.ClientID + "&#39;).value).replace(&#39;{1}&#39;, document.getElementById(&#39;" + purse.ClientID + "&#39;).value));}" %>' />
        </p>
        
         <p class="description"><%= CommonResources.DrawOutDescription %></p>
         <p class="description"><%= CommonResources.BillingSystem_Transfer_Attention %></p>
        <br />
        <p>
            <asp:Label runat="server" ID="lblError" CssClass="error" Text="" EnableViewState="false" />
        </p>
        <gt:WMCertificate runat="server" ID="wm" />
    </div>
</asp:Content>
