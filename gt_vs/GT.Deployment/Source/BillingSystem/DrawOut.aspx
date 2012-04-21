<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true" CodeBehind="DrawOut.aspx.cs" Inherits="GT.Web.Site.BillingSystem.DrawOut" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Import Namespace="Resources" %>    
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
    <script type="text/javascript">
        //<! [CDATA[

        function CalcFactAmount() {
            var amount = document.getElementById('<%= txtAmount.ClientID %>');
            var ourpercent = parseFloat('<%= GT.DA.Dictionaries.Dictionaries.Instance.GetRealMoneySourceOurCommissionById((int)GT.Global.BillingSystem.RealMoneySourceType.WebMoney) %>'.replace(',', '.'));
            var percent = parseFloat('<%= GT.DA.Dictionaries.Dictionaries.Instance.GetRealMoneySourceCommissionById((int)GT.Global.BillingSystem.RealMoneySourceType.WebMoney) %>'.replace(',', '.'));
            var fact = document.getElementById('<%= factAmount.ClientID %>'); 
            
            var val = amount.value * (1 - ourpercent)  / (1 + percent);
            fact.innerHTML= '<%= CommonResources.DrawOutFact %>'.replace('{0}',  val.toFixed(2)).replace('{1}', percent * 100);
        }
        
        //]]>
    </script>
    <div id="drawOut">
        <h2><%= CommonResources.DrawOutTitle %></h2>
        <p><%= CommonResources.DrawOutDescription %></p>
        <dl class="edit">
            <dt><%= CommonResources.Purse %>:</dt>
            <dd>
                <asp:TextBox runat="server" ID="purse" Width="200" MaxLength="12" />
                <ajaxToolkit:MaskedEditExtender ID="maskedValidator" runat="server" Mask="\R999999999999" MaskType="None" TargetControlID="purse" AutoComplete="false" ></ajaxToolkit:MaskedEditExtender>
                <ajaxToolkit:MaskedEditValidator runat="server" ID="mev" ControlExtender="maskedValidator" ControlToValidate="purse" IsValidEmpty="False" EmptyValueMessage="<%$ Resources:CommonResources, PurseEmpty %>"
                             InvalidValueMessage="<%$ Resources:CommonResources, PurseInvalid %>" Display="Dynamic" ValidationExpression="^\d{12}$" ValidationGroup="drawOutGroup" />
            </dd>
            <dt>
                <%= CommonResources.Amount %>:
            </dt>
            <dd>
                <asp:TextBox runat="server" Text="" ID="txtAmount" Width="200" />
                <asp:Label ID="factAmount" runat="server"></asp:Label>
                <ajaxToolkit:FilteredTextBoxExtender runat="server" ID="ftbeAmount" TargetControlID="txtAmount" FilterMode="ValidChars" FilterType="Numbers" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAmount" ErrorMessage="<%$ Resources:CommonResources, AmountEmpty %>" Text="" SetFocusOnError="true" Display="None" ID="rfvAmount" ValidationGroup="drawOutGroup" />
                <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceAmount" TargetControlID="rfvAmount" />
            </dd>
        </dl>
        <p>
            <gt:Button runat="server" ID="btnDrawOut" Text="<%$ Resources:CommonResources, PersonalAccount_Office_DrawOut %>" CausesValidation="true"
                        OnClick="btnDrawOut_Click" OnClientClick='<%# "if ( Page_ClientValidate(&#39;drawOutGroup&#39;) ) { return confirm(&#39;" + CommonResources.DrawOutConfirmation + "&#39;.replace(&#39;{0}&#39;, document.getElementById(&#39;" + txtAmount.ClientID + "&#39;).value).replace(&#39;{1}&#39;, document.getElementById(&#39;" + purse.ClientID + "&#39;).value));}" %>' />
        </p>
        <br />
        <p>
            <asp:Label runat="server" ID="lblError" CssClass="error" Text="" EnableViewState="false" />
        </p>
    </div>
</asp:Content>
