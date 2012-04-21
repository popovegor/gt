<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="EditBuying.aspx.cs" Inherits="GT.Web.Site.Offers.EditBuying" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Web.UI.Pages" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.BO.Implementation" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Services>
      <asp:ServiceReference InlineScript="false" Path="~/WebServices/Ajax/BuyingService.asmx" />
    </Services>
  </asp:ScriptManagerProxy>
  <div runat="server" id="editBuying">
    <dl class="edit">
      <dt>
        <%= CommonResources.Game %>: </dt>
      <dd>
        <asp:DropDownList runat="server" ID="ddlGame" />
        <span class="requiredFieldAsterisk">*</span>
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddGame" TargetControlID="ddlGame" ServiceMethod="GetCascadingDropDownDictionary" Category="<%# DictionaryTypes.Game.ToString() %>" LoadingText="<%$ Resources:CommonResources, LoadingGameList %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" PromptText="<%$ Resources:CommonResources, SelectGame %>" />
        <asp:RequiredFieldValidator runat="server" Display="None" ErrorMessage="<%$ Resources:CommonResources, GameNotSelected %>" SetFocusOnError="true" ID="rfvGame" InitialValue="" ControlToValidate="ddlGame" />
        <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceGame" TargetControlID="rfvGame" />
      </dd>
      <dt>
        <%= CommonResources.Server %>: </dt>
      <dd>
        <asp:DropDownList runat="server" ID="ddlServer" />
        <span class="requiredFieldAsterisk">*</span>
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddServer" Category="<%# DictionaryTypes.GameServer.ToString() %>" ParentControlID="ddlGame" TargetControlID="ddlServer" ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%$ Resources:CommonResources, SelectServer %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" LoadingText="<%$ Resources:CommonResources, LoadingServerList %>" />
        <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" Display="None" ErrorMessage="<%$ Resources:CommonResources, ServerNotSelected %>" ID="rfvServer" InitialValue="" ControlToValidate="ddlServer" />
        <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceServer" TargetControlID="rfvServer" />
      </dd>
      <dt>
        <%= CommonResources.Price %>: </dt>
      <dd>
        <asp:TextBox runat="server" TextMode="SingleLine" Width="50" ID="txtPrice" MaxLength="4" Text="" />
        <ajaxToolkit:FilteredTextBoxExtender FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtPrice" ID="ftbePrice" runat="server" />
      </dd>
      <dt>
        <%= CommonResources.Title %>: </dt>
      <dd>
        <asp:TextBox runat="server" TextMode="SingleLine" Width="250" ID="txtTitle" />
        <span class="requiredFieldAsterisk">*</span>
        <asp:RequiredFieldValidator ControlToValidate="txtTitle" ID="rfvTitle" ErrorMessage="<%$ Resources:CommonResources, TitleEmpty %>" SetFocusOnError="true" Display="None" runat="server" />
        <ajaxToolkit:ValidatorCalloutExtender ID="vceTitle" TargetControlID="rfvTitle" runat="server" />
      </dd>
      <dt>
        <%= CommonResources.Description %>: </dt>
      <dd>
        <asp:TextBox runat="server" TextMode="MultiLine" Width="100%" ID="txtDescription" Rows="5" />
      </dd>
    </dl>
  </div>
  <div class="actions">
    <gt:Button CausesValidation="true" runat="server" Text='<%# EditPageMode == EditPageAction.Edit ? CommonResources.Update : CommonResources.Add %>' ID="btnEdit" />
    <gt:Button runat="server" Text="<%$ Resources:CommonResources, Close %>" ID="btnClose" CausesValidation="false" UseSubmitBehavior="false" />
  </div>

  <script language="javascript" type="text/javascript">
    //<![CDATA[

    var _buying = new GT.BO.Implementation.Offers.Buying();
    _buying.BuyingOfferId = parseInt("<%= Id %>");

    Sys.Application.add_load(function() {
      $addHandler($get("<%= btnEdit.ClientID %>"), "click", btnEdit_onClick);
      $addHandler($get("<%= btnClose.ClientID %>"), "click", btnClose_onClick);
      $addHandler($get("<%=editBuying.ClientID %>"), "keypress", function(event) {
        WebForm_FireDefaultButton(event.rawEvent, "<%= btnEdit.ClientID %>");
      });
    });

    Sys.Application.add_unload(function() {
      $clearHandlers($get("<%= btnEdit.ClientID %>"));
      $clearHandlers($get("<%= btnClose.ClientID %>"));
      $clearHandlers($get("<%=editBuying.ClientID %>"));
    });

    function btnClose_onClick(domEvent) {
      if (window.confirm("<%= CommonResources.WindowCloseConfirmation %>")) {
        window.close();
      }
      window.doCancelEvent(domEvent);
    }

    function btnEdit_onClick(domEvent) {
      if (Page_IsValid) {
        DomManager.disable($get("<%= btnEdit.ClientID %>"));
        _buying.GameServerId = $get("<%= ddlServer.ClientID %>").value;
        _buying.Title = $get("<%= txtTitle.ClientID %>").value;
        _buying.Price = $get("<%= txtPrice.ClientID %>").value;
        if (String.isNullOrEmpty(_buying.Price) == true) {
          _buying.Price = 0;
        }
        _buying.Description = $get("<%= txtDescription.ClientID %>").value;
        GT.Web.Site.WebServices.Ajax.BuyingService.Upsert(
                    _buying
                    , offer_onOperationSuccess
                    , offer_onOperationFailure);
      }
      window.doCancelEvent(domEvent);
    }

    function offer_onOperationSuccess(result, context, methodName) {
      alert(result);
      var redirectUrl = "<%= RedirectUrl %>"
      if (String.isNullOrEmpty(redirectUrl) == false) {
        PopupManager.close(true, redirectUrl);
      }
      else {
        window.close();
      }
    }

    function offer_onOperationFailure(error, context, methodName) {
      alert(error.get_message());
      DomManager.enable($get("<%= btnEdit.ClientID %>"));
    }

    //]]>
  </script>

</asp:Content>
