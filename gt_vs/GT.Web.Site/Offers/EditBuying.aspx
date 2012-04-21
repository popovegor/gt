<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="EditBuying.aspx.cs" Inherits="GT.Web.Site.Offers.EditBuying" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Web.UI.Pages" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/Offers/ProductCategorySelector.ascx" TagName="ProductCategorySelector" TagPrefix="gt" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">

  <%--<asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Services>
      <asp:ServiceReference InlineScript="false" Path="~/WebServices/Ajax/BuyingService.asmx" />
    </Services>
  </asp:ScriptManagerProxy>--%>
  <div id="edit-buying" class="edit-offer">
    <table class="key-value" rules="none">
      <tbody>
        <tr>
          <td class="key">
            <%= CommonResources.Game %>
          </td>
          <td class="required">
            *
          </td>
          <td class="value">
            <asp:DropDownList runat="server" ID="ddlGame" />
            <ajaxToolkit:CascadingDropDown runat="server" ID="cddGame" TargetControlID="ddlGame" ServiceMethod="GetCascadingDropDownDictionary" Category="<%# DictionaryTypes.Game.ToString() %>" LoadingText="<%# GT.Localization.Resources.CommonResources.LoadingGameList %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" PromptText="<%# GT.Localization.Resources.CommonResources.SelectGame %>" />
            <asp:RequiredFieldValidator runat="server" Display="None" ErrorMessage="<%# GT.Localization.Resources.CommonResources.GameNotSelected %>" SetFocusOnError="true" ID="rfvGame" InitialValue="" ControlToValidate="ddlGame" />
            <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceGame" TargetControlID="rfvGame" />
          </td>
        </tr>
        <tr>
          <td class="key">
            <%= CommonResources.Server %>
          </td>
          <td class="required">
            *
          </td>
          <td>
            <asp:DropDownList runat="server" ID="ddlServer" />
            <ajaxToolkit:CascadingDropDown runat="server" ID="cddServer" Category="<%# DictionaryTypes.GameServer.ToString() %>" ParentControlID="ddlGame" TargetControlID="ddlServer" ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%# GT.Localization.Resources.CommonResources.SelectServer %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" LoadingText="<%# GT.Localization.Resources.CommonResources.LoadingServerList %>" />
            <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" Display="None" ErrorMessage="<%# GT.Localization.Resources.CommonResources.ServerNotSelected %>" ID="rfvServer" InitialValue="" ControlToValidate="ddlServer" />
            <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceServer" TargetControlID="rfvServer" />
          </td>
        </tr>
        <tr>
          <td class="key">
            <%= CommonResources.Offers_ProductCategory %>
          </td>
          <td class="required">
            <span class="required-field">*</span>
          </td>
          <td class="value">
             <gt:ProductCategorySelector runat="server" ID="category" /> 
          </td>
        </tr>
        <tr>
          <td class="key">
            <%= CommonResources.Title %>
          </td>
          <td class="required">
            *
          </td>
          <td class="value">
            <asp:TextBox runat="server" TextMode="SingleLine" MaxLength="100" Width="450" ID="txtTitle" />
            <asp:RequiredFieldValidator ControlToValidate="txtTitle" ID="rfvTitle" ErrorMessage="<%# GT.Localization.Resources.CommonResources.TitleEmpty %>" SetFocusOnError="true" Display="None" runat="server" />
            <ajaxToolkit:ValidatorCalloutExtender ID="vceTitle" TargetControlID="rfvTitle" runat="server" />
          </td>
        </tr>
        <tr>
          <td class="key" colspan="2">
            <%= CommonResources.Offers_Price %>
          </td>
          <td class="value">
            <asp:TextBox runat="server" TextMode="SingleLine" Width="50" ID="txtPrice" MaxLength="6" Text="" /> <span> <%= CommonResources.Offers_Currency %></span>
            <ajaxToolkit:FilteredTextBoxExtender FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtPrice" ID="ftbePrice" runat="server" />
          </td>
        </tr>
        <tr>
          <td class="key" colspan="2">
            <%= CommonResources.Description %>
          </td>
          <td class="value description">
            <asp:TextBox runat="server" TextMode="MultiLine" ID="txtDescription" Rows="10" />
            <p class="attention field-description">
              <%= GT.Localization.Resources.CommonResources.ContactWarning %>
            </p>
          </td>
        </tr>
        <tr style='<%= Credentials.Profile.EmailMessageNotification == true ? "display:none": string.Empty %>'>
          <td class="key" colspan="2">
            <%# CommonResources.Offers_Notification%>
          </td>
          <td class="value">
            <asp:CheckBox runat="server" Checked="<%# Credentials.Profile.EmailMessageNotification %>" ID="chkEmailNotification" AutoPostBack="false" Text='<%# CommonResources.Offers_EmailNotification + "." %>' />
            <%-- <p><i><%# string.Format(CommonResources.Offers_NotificationNote, "/PersonalAccount/Profile.aspx", "/Office")%>.</i></p>--%>
          </td>
        </tr>
        <tr>
          <td class="key" colspan="2">
          </td>
          <td class="value">
          </td>
        </tr>
      </tbody>
    </table>
    <div class="actions">
      <gt:Button CausesValidation="true" runat="server" Text='<%# EditPageMode == EditPageAction.Edit ? CommonResources.Update : CommonResources.Add %>' ID="btnEdit" OnClick="btnEdit_Click" />
      <gt:Button runat="server" Text="<%# GT.Localization.Resources.CommonResources.Cancel %>" ID="btnCancel" CausesValidation="false" UseSubmitBehavior="false" />
    </div>
    <div>
      <br />
      <asp:Label runat="server" ID="lblError" CssClass="error" EnableViewState="false" />
    </div>

    <script language="javascript" type="text/javascript">
      //<![CDATA[

      $(function() {
        var txt = $("#<%# txtDescription.ClientID %>");
        txt.textLimiter({ maxLength: 5000 });
        $("#<%# btnCancel.ClientID %>").click(function() {
          window.back();
        });
      });

      //]]>
    </script>

  </div>
</asp:Content>
